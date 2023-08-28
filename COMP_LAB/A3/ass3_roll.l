%{
#include "stdio.h"
#define key 300
#define id 301
#define PUNCTUATORS 302
#define STRING_LITERAL 303
#define INT_CONST 304
#define FLOAT_CONST 305
#define CHAR_CONSTANT 306
#define MULTI_COMMENT 307
#define SINGLE_COMMENT 308
#define WS 309
#define MULTI_COMMENT_START 310
#define MULTI_COMMENT_END 311
#define SINGLE_COMMENT_START 312
#define SINGLE_COMMENT_END 313
#define ESCAPE_SEQUENCE 314
%}

%x  s1   
%x   s2   
PUNCTUATORS            "("|"]"|"["|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
ESCAPE_SEQUENCE       "\\'"|"\\""|"\\?"|"\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
DIGIT         [0-9]
NONZERO_DIGIT   [1-9]
IDENTIFIER    [a-zA-Z_][a-zA-Z0-9_]*
ENUMERATION_CONSTANT   {IDENTIFIER}
S_CHAR             [^\"\n\\]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE         {S_CHAR}*
STRING_LITERAL        \"({S_CHAR_SEQUENCE})\"
INTEGER_CONSTANT       {NONZERO_DIGIT}|{INTEGER_CONSTANT}{DIGIT}
C_CHAR                      [^\'\n\\]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE             ({C_CHAR})+
CHAR_CONSTANT             \'({C_CHAR_SEQUENCE})\'        
DIGIT_SEQUENCE         {DIGIT}|({DIGIT_SEQUENCE}{DIGIT})
SIGN           "+"|"-"
EXPONENT_PART        ([Ee]({SIGN}?)({DIGIT_SEQUENCE}))
FRAC_CONSTANT       {DIGIT_SEQUENCE}\.|{DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE}
FLOAT_CONST            ({DIGIT_SEQUENCE}{EXPONENT_PART})|({FRAC_CONSTANT}{EXPONENT_PART}?)
CONST             {INTEGER_CONSTANT}|{CHAR_CONSTANT}|{FLOAT_CONST}|{ENUMERATION_CONSTANT}


%%
{IDENTIFIER}             { return id;}
{PUNCTUATORS}           { return PUNCTUATORS;                                      }
{STRING_LITERAL}            { return STRING_LITERAL;                                       }
{INTEGER_CONSTANT}         { return INT_CONST;                                            }
{FLOAT_CONST}          { return FLOAT_CONST;                                        }
{CHAR_CONSTANT}          { return CHAR_CONSTANT;                                         }
{ESCAPE_SEQUENCE}      { return ESCAPE_SEQUENCE;            }             
" "

"/*"                        { BEGIN(s1); return MULTI_COMMENT_START;                       }
<s1>"*/"               { BEGIN(INITIAL); return MULTI_COMMENT_END;                         }
<s1>.                  { return MULTI_COMMENT;                                             }
<s1>"\n"               { return MULTI_COMMENT;                                             }

"//"                        { BEGIN(s2); return SINGLE_COMMENT_START;          }
<s2>"\n"   { BEGIN(INITIAL); return SINGLE_COMMENT_END;                        }
<s2>.      { return SINGLE_COMMENT;                                            }    

%%


int main()
{
    int token;
    while(token = yylex())
    {
        switch(token) 
        {
            case key: printf("<KEYWORD, %d, %s>\n", token, yytext); break;
            case id: printf("<IDENTIFIER, %d, %s>\n", token, yytext); break;
            case PUNCTUATORS: printf("<PUNCTUATOR, %d, %s>\n", token, yytext); break;
            case STRING_LITERAL: printf("<STRING_LITERAL, %d, %s>\n", token, yytext); break;
            case INT_CONST: printf("<INTEGER_CONST, %d, %s>\n", token, yytext); break;
            case FLOAT_CONST: printf("<FLOAT_CONST, %d, %s>\n", token, yytext); break;
            case CHAR_CONSTANT: printf("<CHARACTER_CONST, %d, %s>\n", token, yytext); break;
            case MULTI_COMMENT_START: printf("<MULTI_LINE_COMMENT_BEGINS, %d, %s>\n", token, yytext); break;
            case MULTI_COMMENT_END: printf("<MULTI_LINE_COMMENT_ENDS, %d, %s>\n", token, yytext); break;
            case MULTI_COMMENT: printf("%s", yytext); break;
            case SINGLE_COMMENT_START: printf("<SINGLE_LINE_COMMENT_BEGINS, %d, %s>\n", token, yytext); break;
            case SINGLE_COMMENT_END: printf("<SINGLE_LINE_COMMENT_ENDS, %d, %s>\n", token, yytext); break;
            case SINGLE_COMMENT: printf("%s", yytext); break;
			case ESCAPE_SEQUENCE: printf("<ESCAPE_SEQUENCE, %d, %s>", token, yytext); break;
            default: break;
        }
    }
    return 0;
}