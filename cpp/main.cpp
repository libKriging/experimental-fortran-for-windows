#include <cmath>
#include <iostream>
#include "flib/flib.h"
#include <cstring>

extern "C" {
int strncmp0(const char* s1, const char* s2, int n) {
  std::cout << "Print from strcmp0\n";
  std::cout << "  arg1: " << s1 << "\n";
  std::cout << "  arg2: " << s2 << "\n";
  std::cout << "  arg3: " << n << "\n";
  return strncmp(s1, s2, n);
}
}

int main() {
  int has_str_condition = 0;
  int has_strncmp = 0;
  int has_write = 0;
  double time = 0;
  test(&has_str_condition, &has_strncmp, &has_write, &time);
  std::cout << "has_str_condition: " << has_str_condition << "\n";
  std::cout << "has_strncmp: " << has_strncmp << "\n";
  std::cout << "has_write: " << has_write << "\n";
  std::cout << "time: " << time << std::endl;
}