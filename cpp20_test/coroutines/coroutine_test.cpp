#include "coroutine_test.hpp"

// -------------------
generator<int> f()
{
    int num = 1;
    while( true ) {
        co_yield num;
        num++;
    }
}

// -------------------
static int i = 0;
int f1()
{
    i++;
    return i;
}
