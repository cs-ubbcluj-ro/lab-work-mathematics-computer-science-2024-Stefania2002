%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SYMBOLS 100
#define MAX_LENGTH 256

typedef struct {
    char symbol[MAX_LENGTH];
    int type;
} Symbol;

typedef struct {
    int code;
    char value[MAX_LENGTH];
} PIF;

Symbol symbolTable[MAX_SYMBOLS];
PIF pif[MAX_SYMBOLS];
int symbolCount = 0;
int pifCount = 0;

void addSymbol(char *symbol, int type);
int lookupSymbol(char *symbol);
void addPIF(int code, char *value);
%}

%%
[ \t\n\r]+              /* Ignore whitespace */
[A-Za-z][A-Za-z0-9]*    { 
    if (strcmp(yytext, "VAR") == 0 || strcmp(yytext, "BEGIN") == 0 || strcmp(yytext, "END") == 0 || strcmp(yytext, "IF") == 0 || strcmp(yytext, "THEN") == 0 || strcmp(yytext, "ELSE") == 0 || strcmp(yytext, "WHILE") == 0 || strcmp(yytext, "DO") == 0 || strcmp(yytext, "READ") == 0 || strcmp(yytext, "WRITE") == 0 || strcmp(yytext, "BOOLEAN") == 0 || strcmp(yytext, "CHAR") == 0 || strcmp(yytext, "INTEGER") == 0 || strcmp(yytext, "REAL") == 0 || strcmp(yytext, "ARRAY") == 0 || strcmp(yytext, "OF") == 0) {
        addPIF(12, yytext);
        printf("RESERVED WORD: %s\n", yytext);
    } else {
        addSymbol(yytext, 1);
        addPIF(1, yytext);
        printf("IDENTIFIER: %s\n", yytext);
    }
}
[0-9]+                  { addPIF(2, yytext); printf("CONSTANT: %s\n", yytext); }
\"[^\"]*\"              { addPIF(3, yytext); printf("STRING: %s\n", yytext); }
":="                    { addPIF(4, yytext); printf("OPERATOR: %s\n", yytext); }
"+"|"-"|"*"|"/"         { addPIF(5, yytext); printf("OPERATOR: %s\n", yytext); }
"<="|"<"|">="|">"|"="   { addPIF(6, yytext); printf("OPERATOR: %s\n", yytext); }
"["|"]"|"{"|"}"|":"|";" { addPIF(7, yytext); printf("SEPARATOR: %s\n", yytext); }
","                     { addPIF(8, yytext); printf("SEPARATOR: ,\n"); }
"("                     { addPIF(9, yytext); printf("SEPARATOR: (\n"); }
")"                     { addPIF(10, yytext); printf("SEPARATOR: )\n"); }
"."                     { addPIF(11, yytext); printf("SEPARATOR: .\n"); }
.                       { printf("UNKNOWN: %s\n", yytext); }
%%

void addSymbol(char *symbol, int type) {
    if (lookupSymbol(symbol) == -1) {
        strcpy(symbolTable[symbolCount].symbol, symbol);
        symbolTable[symbolCount].type = type;
        symbolCount++;
    }
}

int lookupSymbol(char *symbol) {
    for (int i = 0; i < symbolCount; i++) {
        if (strcmp(symbolTable[i].symbol, symbol) == 0) {
            return i;
        }
    }
    return -1;
}

void addPIF(int code, char *value) {
    pif[pifCount].code = code;
    strcpy(pif[pifCount].value, value);
    pifCount++;
}

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <inputfile>\n", argv[0]);
        exit(1);
    }

    FILE *input = fopen(argv[1], "r");
    if (!input) {
        perror(argv[1]);
        exit(1);
    }

    yyin = input;
    yylex();

    printf("\nSymbol Table:\n");
    for (int i = 0; i < symbolCount; i++) {
        printf("%d: %s\n", i, symbolTable[i].symbol);
    }

    printf("\nProgram Internal Form:\n");
    for (int i = 0; i < pifCount; i++) {
        printf("%d: %s\n", pif[i].code, pif[i].value);
    }

    return 0;
}
