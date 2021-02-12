#include <iostream>
#include "func.hpp"

int main()
{
    std::cout << "Enter x and y (space separated): ";
    double x, y;
    std::cin >> x >> y;
    std::cout << '\n' << x << " + " << y << " = " << simpleMath::add(x, y);
    std::cout << '\n' << x << " * " << y << " = " << simpleMath::mul(x, y) << '\n';
    std::cout << "haaaaaa\n";
}