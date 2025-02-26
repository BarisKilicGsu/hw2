#ifndef KIRAZ_TOKEN_INTEGER_H
#define KIRAZ_TOKEN_INTEGER_H

#include <kiraz/token/Base.h>

namespace kiraz {
namespace token {

class Integer : public Token {
public:
    static Integer createDecimalInteger(const std::string &value) { return Integer(10, value); }
    static Integer createHexadecimalInteger(const std::string &value) { return Integer(15, value); }

    auto get_value() const { return m_value; }
    auto get_base() const { return m_base; }

    // Token interface
    token::Id get_id() const override { return L_INTEGER; }
    std::string get_repr() const override {
        return fmt::format("{}({}, {})", get_id(), get_value(), get_base());
    }

protected:
    Integer(int base, const std::string &value) : m_base(base), m_value(value) {}

private:
    int m_base;
    std::string m_value;
};

} // namespace kiraz::token
} // namespace kiraz
#endif
