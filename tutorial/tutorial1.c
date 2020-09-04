#include <stdio.h>
#include <string.h>
#include <s2e/s2e.h>

int mul(int end) {
  int result = 1;
  for (int i = 1; i < end; i += 10) {
    result = result * i;
  }
  return result;
}

int sum(int end) {
  int result = 0;
  for (int i = 0; i < end; i++) {
    result += i;
  }
  if (result < 100) {
    result += mul(end);
  }
  return result;
}

int main(void) {
  //s2e_printf("Tutorial on Violet\n");

  char str[3] = { 0 };
  //char* str;
  int test = 0;

  // printf("Enter two characters: ");
  // if (!fgets(str, sizeof(str), stdin)) {
  //     return 1;
  // }
  s2e_printf("Test........");
  s2e_make_symbolic(str, 2, "str");
  s2e_printf("make symbolic\n");
  s2e_invoke_plugin("LatencyTracker", &test, sizeof(test));
  if (str[0] == '\n' || str[1] == '\n') {
    sum(5);
    printf("Not enough characters\n");
  } else {
    sum(100);
    if (str[0] >= 'a' && str[0] <= 'z') {
      printf("First char is lowercase\n");
    } else {
      printf("First char is not lowercase\n");
    }

    if (str[0] >= '0' && str[0] <= '9') {
      printf("First char is a digit\n");
    } else {
      printf("First char is not a digit\n");
    }

    if (str[0] == str[1]) {
      printf("First and second chars are the same\n");
    } else {
      printf("First and second chars are not the same\n");
    }
  }
  test = 1;
  s2e_invoke_plugin("LatencyTracker", &test, sizeof(test));
  s2e_get_example(str, 2);
  printf("'%c%c' %02x %02x\n", str[0], str[1],
      (unsigned char) str[0], (unsigned char) str[1]);
  s2e_kill_state(0, "program terminated");
  return 0;
}
