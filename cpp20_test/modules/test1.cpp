// func.cxx
module;

import <iostream>;

export module mod1;

import mod2;

export void func1() {
    std::cout << "hello, world!" << func2(8) << std::endl;
}


export
template< typename T >
void show_val(T val)
{
	std::cout << val << std::endl;
}