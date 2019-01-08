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
const char* script_str =
"proc(){"
"	c0_list := [| |];"
"	c1_list := [| |];"
"	c2_list := [| |];"
"	c0_pre := 30;"
"	c1_pre := 20;"
"	c2_pre := 12;"
"	in_pre := 9;"
"	max_error := 0;"
"	for i from 0 to (2 ^ in_pre - 1) do {"
"		current_value := 2 ^ (-in_pre) * i;"
"		p1 := remez(1/sqrt(1 + current_value + x), 2, [0;2 ^ (-in_pre)]);"
"		c1 := round(coeff(p1, 1), c1_pre, RN);"
"		p2 := remez(1/sqrt(1 + current_value + sqrt(x)) - sqrt(x) * c1, 1, [0;(2 ^ (-in_pre))^2]);"
"		c2 := round(coeff(p2, 1), c2_pre, RN);"
"		p3 := remez(1/sqrt(1 + current_value + x) - c1 * x - c2 * x ^ 2, 0, [0;2 ^ (-in_pre)]);"
"		c0 := round(coeff(p3, 0), c0_pre, RN);"
"		err := dirtyinfnorm(1/sqrt(1 + current_value + x) - (c2 * x ^ 2 + c1 * x + c0), [0;2 ^ (-in_pre)]);"
"		if (err > max_error) then max_error := err;"
"		c0_list = c0_list:.c0;"
"		c1_list = c1_list:.c1;"
"		c2_list = c2_list:.c2;"
"	};"
"	print(max_error);"
//" print(c0_list[65]);"
"	res.c0 := c0_list;"
"	res.c1 := c1_list;"
"	res.c2 := c2_list;"
"	return res;"
"}";

int hide_everything(sollya_msg_t msg, void *data) {
  return 0;
}

unsigned long encoding(double c2, double c1, double c0) {
	unsigned long c2_l = *((unsigned long*) &c2);
	unsigned long c1_l = *((unsigned long*) &c1);
	unsigned long c0_l = *((unsigned long*) &c0);
  // Encode the exponents.
  // Exponents have five combinations for inverse (another five for inverse square
  // root), and the first combination only occurs when x_1 is exactly 1.
  // It is easy to detect that case, so we encodes the rest of the combinations
  // with unused two bits.
  static unsigned long long exp_encode = 0;
  static long long current_c0_exp = 0;
  static long long current_c1_exp = 0;
  static long long  current_c2_exp = 0;
  static long long  init_flag = 0;
  // Skip special case (mantissa = 1)
  if (!init_flag)
    init_flag = 1;
  else if (current_c0_exp == 0) { // enough to test if this is the initial case
    current_c0_exp = c0_l & MANTISSA_MASK;
    current_c1_exp = c1_l & MANTISSA_MASK;
    current_c2_exp = c2_l & MANTISSA_MASK;
  } else if ((current_c0_exp != (c0_l & MANTISSA_MASK)) ||
    (current_c1_exp != (c1_l & MANTISSA_MASK)) ||
    (current_c2_exp != (c2_l & MANTISSA_MASK))) {
    exp_encode++;
    current_c0_exp = c0_l & MANTISSA_MASK;
    current_c1_exp = c1_l & MANTISSA_MASK;
    current_c2_exp = c2_l & MANTISSA_MASK;
  }

  // Remove signs and exponents, and insert a leading one; then move them into their
  // slots
	unsigned long res = (((c2_l & C2_MASK) << 11) | SET_MSB_MASK) >> 2;
	res |= (((c1_l & C1_MASK) << 11) | SET_MSB_MASK) >> 14;
	res |= (((c0_l & C0_MASK) << 11) | SET_MSB_MASK) >> 34;
  res |= exp_encode << 62;
	return res;
}

int main() {
  union {
    unsigned long d_value;
    struct {
      unsigned long rest : 22;
      unsigned long bit_value : 30;
      unsigned long header : 12;
    } c0_extractor;
    struct {
      unsigned long rest : 32;
      unsigned long bit_value : 20;
      unsigned long header : 12;
    } c1_extractor;
    struct {
      unsigned long rest : 40;
      unsigned long bit_value : 12;
      unsigned long header : 12;
    } c2_extractor;
  } bit_extractor;

  union {
    unsigned long store_value;
    struct {
      unsigned int offset:2;
      unsigned int c2:12;
      unsigned int c1:20;
      unsigned int c0:30;
    } input_value;
  } lut_encoder;

  lut_encoder.input_value.offset = 0;

  FILE* result_file = fopen("result.txt", "w");

  sollya_lib_init();
  sollya_lib_install_msg_callback(hide_everything, NULL);

  sollya_obj_t script = sollya_lib_string(script_str);
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

    fprintf(result_file, "%.16lX,\n", encoding(c2_buf_d, c1_buf_d, c0_buf_d));
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
  sollya_lib_close();
  fclose(result_file);
}
