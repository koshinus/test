#include <optional>
#include <string>
#include <iostream>

#include "coroutine_test.hpp"

int main()
{
    std::optional< int > a(5);
    std::optional< std::string > b("ddd");
    std::cout << sizeof(a) << " " << sizeof(b);
    std::cout << std::endl;
    int n;
    std::cin >> n;
    auto num_gen = f();
    for( int j = 0; j < n; j++ )
        std::cout << num_gen.cur_val() << " ";
    for( int j = 0; j < n; j++ )
        std::cout << f1() << " ";
}
