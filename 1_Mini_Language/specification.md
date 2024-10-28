Part A: MiniLang Specification based on C

Language Elements

Data Types:
int: Integer type.
float: Floating-point number type.
struct: User-defined data type for creating custom structures.

Reserved Words:
int, float, struct
if, else
while, for
return
input, print

Operators:
Arithmetic operators: +, -, *, /, %
Relational operators: ==, !=, <, <=, >, >=
Logical operators: &&, ||, !
Assignment operator: =

Separators:
; (statement terminator)
{, } (block delimiters)
(, ) (expression delimiters)
, (separator in argument lists)

Identifiers:
Must start with a letter or underscore, followed by letters, digits, or underscores.
Case-sensitive.
Examples: sum, _counter, is_prime

Constants:
Integer constants: 0, 1, 10, 100, etc.
Float constants: 3.14, 0.01, 2.718

Syntax definition (BNF):
<program> ::= <statement_list>

<statement_list> ::= <statement> ";" <statement_list> | <statement> ";"

<statement> ::= <declaration> | <assignment> | <input_output> | <conditional> | <loop>

<declaration> ::= <type> <identifier> | <type> <identifier> "=" <expression>
<type> ::= "int" | "float" | "struct" <identifier>

<assignment> ::= <identifier> "=" <expression>

<input_output> ::= "input" "(" <identifier> ")" | "print" "(" <expression> ")"

<conditional> ::= "if" "(" <expression> ")" "{" <statement_list> "}" ["else" "{" <statement_list> "}"]

<loop> ::= "while" "(" <expression> ")" "{" <statement_list> "}" 
         | "for" "(" <assignment> ";" <expression> ";" <assignment> ")" "{" <statement_list> "}"

<expression> ::= <term> | <term> <operator> <expression>
<term> ::= <identifier> | <constant> | "(" <expression> ")"
<operator> ::= "+" | "-" | "*" | "/" | "%" | "==" | "!=" | "<" | "<=" | ">" | ">=" | "&&" | "||"

<identifier> ::= <letter> {<letter> | <digit> | "_"}
<constant> ::= <integer_constant> | <float_constant>
<integer_constant> ::= <digit> {<digit>}
<float_constant> ::= <digit> {<digit>} "." <digit> {<digit>}
<letter> ::= "a" | "b" | ... | "z" | "A" | "B" | ... | "Z" | "_"
<digit> ::= "0" | "1" | ... | "9"

