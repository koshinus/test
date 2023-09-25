// func.cxx
module;

import <iostream>;

export module mod2;

import mod1;

export void func2() {
    std::cout << "hello, world!" << func1(8) << std::endl;
}


export
template< typename T >
void show_val(T val)
{
	std::cout << val << std::endl;
}
