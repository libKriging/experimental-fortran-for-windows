#include <cmath>
#include <iostream>
#include "flib/flib.h"

int main() {
  double t0 = 1;
  double t1 = 2;
  addone(&t0);

  double x = 1;
  for (int i = 0; i < 100; ++i) {
    x = std::cos(std::exp(x));
  }

  std::cout << x << std::endl;

  addone(&t1);
  std::cout << (t1 - t0) << std::endl;
}