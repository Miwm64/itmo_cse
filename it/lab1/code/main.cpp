#include <iostream>

const int MAX_FIBONACCI_FOR_INT64 = 90;


template <std::size_t N>
constexpr std::array<int64_t, N> generate_fibonacci_numbers() {
    std::array<int64_t, N> fibonacci_numbers{};
    fibonacci_numbers[0] = 1;
    fibonacci_numbers[1] = 2;

    for (auto i = 2; i < N; ++i) {
        fibonacci_numbers[i] = fibonacci_numbers[i - 1] + fibonacci_numbers[i - 2];
    }

    return fibonacci_numbers;
}


std::string convert(int64_t n) {
    auto arr = generate_fibonacci_numbers<MAX_FIBONACCI_FOR_INT64-1>();
    if (n == 0) {
        throw std::runtime_error("n must not be equal to 0");
    }
    bool negative;
    if (n < 0)
    {
        negative = n < 0;
        n *= -1;
    }


    std::string ans;
    for (auto i = 0; arr[i] <= n; ++i)
    {
        ans += "0";
    }

    for (int i = static_cast<int>(ans.size() - 1); i >= 0; --i) {
        if (arr[i] <= n) {
            ans[i] = '1';
            n -= arr[i];
        }
        if (n == 0) {
            break;
        }
    }

    std::reverse(ans.begin(), ans.end());

    if (negative)
    {
        ans = "-"+ans;
    }
    return ans;
}


int main() {
    int64_t n;
    std::cout << "Enter an integer number not equal to 0: ";
    std::cin >> n;

    std::string ans = convert(n);
    std::cout << ans << std::endl;

    return 0;
}