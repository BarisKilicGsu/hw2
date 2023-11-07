
#include "Base.h"

namespace kiraz {
std::vector<std::unique_ptr<Token>> Token::s_tokens;
int Token::char_pos = 0;
Token::~Token() {}
}
