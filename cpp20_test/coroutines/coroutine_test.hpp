#pragma once

#include <exception>
#include <coroutine>

template<typename T>
struct generator
{
    struct promise_type;
    using handle_type = std::coroutine_handle<promise_type>;
    struct promise_type
    {
        T value_;

        generator get_return_object()
        {
            return generator(handle_type::from_promise(*this));
        }
        auto initial_suspend() { return std::suspend_always(); }
        auto final_suspend() noexcept { return std::suspend_always(); }
        void unhandled_exception() { std::terminate(); }
        auto yield_value(T value)
        {
            value_ = value;
            return std::suspend_always();
        }
        void return_void() {}
    };

    generator(handle_type h) : h_(h) {}
    generator(const generator &) = delete;
    ~generator() { h_.destroy(); }
    T cur_val() { return h_.promise().value_; }

private:
    handle_type h_;
};

generator<int> f();
int f1();
