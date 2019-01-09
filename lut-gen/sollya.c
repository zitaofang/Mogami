// WARNING: When I am running this program, it gave a negative c1, but
// the calculation yields correct result if I use positive c1. DO NOT
// NEGATE C1!
#include <stdio.h>
#include <sollya.h>

// The constant to clear mantissa bit in double
#define MANTISSA_MASK 0xFFF0000000000000
#define C2_MASK 0xFFE0000000000
#define C1_MASK 0xFFFFE00000000
#define C0_MASK 0xFFFFFFF800000
#define SET_MSB_MASK 0x8000000000000000

// To calculate inverse, remove "sqrt" after "1/"
#define CURRENT_VALUE_SNIPPET "(1 + current_value + x)"
#define CURRENT_VALUE_SNIPPET_SQRT "(1 + current_value + sqrt(x))"
#define DIV_SCRIPT_SNIPPET(value) value
#define SQRT_SCRIPT_SNIPPET(value) "sqrt("value")"
#define SQRT_2_SCRIPT_SNIPPET(value) "sqrt(2*"value")"

#define SCRIPT(snippet, snippet_sqrt) \
"proc(){\n" \
"	c0_list := [| |];\n" \
"	c1_list := [| |];\n" \
"	c2_list := [| |];\n" \
"	c0_pre := 30;\n" \
"	c1_pre := 20;\n" \
"	c2_pre := 12;\n" \
"	in_pre := 9;\n" \
"	max_error := 0;\n" \
"	for i from 0 to (2 ^ in_pre - 1) do {\n" \
"		current_value := 2 ^ (-in_pre) * i;\n" \
"		p1 := remez(1/" snippet ", 2, [0;2 ^ (-in_pre)]);\n" \
"		c1 := round(coeff(p1, 1), c1_pre, RN);\n" \
"		p2 := remez(1/" snippet_sqrt " - sqrt(x) * c1, 1, [0;(2 ^ (-in_pre))^2]);\n" \
"		c2 := round(coeff(p2, 1), c2_pre, RN);\n" \
"		p3 := remez(1/" snippet " - c1 * x - c2 * x ^ 2, 0, [0;2 ^ (-in_pre)]);\n" \
"		c0 := round(coeff(p3, 0), c0_pre, RN);\n" \
"		err := dirtyinfnorm(1/" snippet " - (c2 * x ^ 2 + c1 * x + c0), [0;2 ^ (-in_pre)]);\n" \
"		if (err > max_error) then max_error := err;\n" \
"		c0_list = c0_list:.c0;\n" \
"		c1_list = c1_list:.c1;\n" \
"		c2_list = c2_list:.c2;\n" \
"	};\n" \
"	print(max_error);\n" \
"	res.c0 := c0_list;\n" \
"	res.c1 := c1_list;\n" \
"	res.c2 := c2_list;\n" \
"	return res;\n" \
"}\n"

const char* script_str[] = {
  SCRIPT(DIV_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET),
    DIV_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET_SQRT)),
  SCRIPT(SQRT_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET),
    SQRT_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET_SQRT)),
  SCRIPT(SQRT_2_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET),
    SQRT_2_SCRIPT_SNIPPET(CURRENT_VALUE_SNIPPET_SQRT)),
};

const char* file_name[] = {
  "div_lut.mem",
  "sqrt_lut.mem",
  "sqrt_2_lut.mem"
};

// Function used to disable warning
int hide_everything(sollya_msg_t msg, void *data) {
  return 0;
}

// Encode the exponents.
// Exponents have five combinations for inverse (another five for inverse square
// root), and the first combination only occurs when x_1 is exactly 1.
// It is easy to detect that case, so we encodes the rest of the combinations
// with unused two bits.
typedef struct {
  unsigned long long exp_encode;
  long long current_c0_exp;
  long long current_c1_exp;
  long long current_c2_exp;
  long long init_flag;
} encoding_state;

unsigned long encoding(double c2, double c1, double c0, encoding_state* state) {
	unsigned long c2_l = *((unsigned long*) &c2);
	unsigned long c1_l = *((unsigned long*) &c1);
	unsigned long c0_l = *((unsigned long*) &c0);
  // Skip special case (mantissa = 1)
  if (!state->init_flag)
    state->init_flag = 1;
  else if (state->current_c0_exp == 0) { // sufficient to test if this is the initial case
    state->current_c0_exp = c0_l & MANTISSA_MASK;
    state->current_c1_exp = c1_l & MANTISSA_MASK;
    state->current_c2_exp = c2_l & MANTISSA_MASK;
  } else if ((state->current_c0_exp != (c0_l & MANTISSA_MASK)) ||
    (state->current_c1_exp != (c1_l & MANTISSA_MASK)) ||
    (state->current_c2_exp != (c2_l & MANTISSA_MASK))) {
    state->exp_encode++;
    state->current_c0_exp = c0_l & MANTISSA_MASK;
    state->current_c1_exp = c1_l & MANTISSA_MASK;
    state->current_c2_exp = c2_l & MANTISSA_MASK;
  }

  // Remove signs and exponents, and insert a leading one; then move them into their
  // slots
	unsigned long res = (((c2_l & C2_MASK) << 11) | SET_MSB_MASK) >> 2;
	res |= (((c1_l & C1_MASK) << 11) | SET_MSB_MASK) >> 14;
	res |= (((c0_l & C0_MASK) << 11) | SET_MSB_MASK) >> 34;
  res |= state->exp_encode << 62;
	return res;
}

int main() {
  sollya_lib_init();
  sollya_lib_install_msg_callback(hide_everything, NULL);

  for (int i = 0; i < 3; i++) {
    printf("Start writing to %s\n", file_name[i]);
    encoding_state state = {0};
    FILE* result_file = fopen(file_name[i], "w");

    sollya_obj_t script = sollya_lib_string(script_str[i]);
    sollya_obj_t proc = sollya_lib_parse(script);
    sollya_obj_t result = sollya_lib_execute_procedure(proc);

    sollya_obj_t* c0_list = sollya_lib_malloc(sizeof(sollya_obj_t));
    sollya_obj_t* c1_list = sollya_lib_malloc(sizeof(sollya_obj_t));
    sollya_obj_t* c2_list = sollya_lib_malloc(sizeof(sollya_obj_t));
    sollya_lib_get_element_in_structure(c0_list, "c0", result);
    sollya_lib_get_element_in_structure(c1_list, "c1", result);
    sollya_lib_get_element_in_structure(c2_list, "c2", result);

    sollya_obj_t* c0_buf = sollya_lib_malloc(sizeof(sollya_obj_t));
    sollya_obj_t* c1_buf = sollya_lib_malloc(sizeof(sollya_obj_t));
    sollya_obj_t* c2_buf = sollya_lib_malloc(sizeof(sollya_obj_t));
    double c0_buf_d, c1_buf_d, c2_buf_d;
    int c2_positive = 1;
    int c1_negative = 1;
    int c0_positive = 1;
    int current_c0_exp = 0;
    int current_c1_exp = 0;
    int current_c2_exp = 0;
    for (int i = 0; i < 512; i++) {
      sollya_lib_get_element_in_list(c2_buf, *c2_list, i);
      sollya_lib_get_element_in_list(c1_buf, *c1_list, i);
      sollya_lib_get_element_in_list(c0_buf, *c0_list, i);

      sollya_lib_get_constant_as_double((double*)&c2_buf_d, *c2_buf);
      sollya_lib_get_constant_as_double((double*)&c1_buf_d, *c1_buf);
      sollya_lib_get_constant_as_double((double*)&c0_buf_d, *c0_buf);

      if (c2_positive)
        c2_positive = c2_buf_d >= 0;
      if (c1_negative)
        c1_negative = c1_buf_d < 0;
      if (c0_positive)
        c0_positive = c0_buf_d >= 0;
      int tmp;
      if ((tmp = *((long*)&c2_buf_d) >> 52) != current_c2_exp) {
        printf("C2 coefficient changes at %d, to %X\n", i, tmp);
        current_c2_exp = tmp;
      }
      if ((tmp = *((long*)&c1_buf_d) >> 52) != current_c1_exp) {
        printf("C1 coefficient changes at %d, to %X\n", i, tmp);
        current_c1_exp = tmp;
      }
      if ((tmp = *((long*)&c0_buf_d) >> 52) != current_c0_exp) {
        printf("C0 coefficient changes at %d, to %X\n", i, tmp);
        current_c0_exp = tmp;
      }
      if (!c2_buf_d || !c1_buf_d || !c0_buf_d) {
        printf("Something is zero\n");
      }

      fprintf(result_file, "%.16lX\n",
        encoding(c2_buf_d, c1_buf_d, c0_buf_d, state));
    }

    printf("c2 pos: %d\n", c2_positive);
    printf("c1 neg: %d\n", c1_negative);
    printf("c0 pos: %d\n", c0_positive);

    sollya_lib_free(c0_list);
    sollya_lib_free(c1_list);
    sollya_lib_free(c2_list);
    sollya_lib_free(c0_buf);
    sollya_lib_free(c1_buf);
    sollya_lib_free(c2_buf);

    fclose(result_file);
  }

  sollya_lib_close();
}
