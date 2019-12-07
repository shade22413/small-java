grammar Small_Java;

r : import_bib class_declare;
import_bib : (IMPORT_KW bibs SEMICOLON)*;

class_declare : modif CLASS_KW idf=IDF ACC_B class_content ACC_E;
class_content : vars_declare main;
vars_declare : var_declare*;
main : MAIN_KW ACC_B instruction* ACC_E;
instruction : assign | if_cond | read | write;

assign : idf=IDF ASSIGN (exp_b | string) SEMICOLON;
if_cond : IF_KW PAR_B exp_b PAR_E THEN_KW ACC_B instruction* ACC_E (ELSE_KW ACC_B instruction* ACC_E)?;
read : IN_KW PAR_B format COMMA idf=IDF PAR_E SEMICOLON;
write : OUT_KW PAR_B string (COMMA exp_b)* PAR_E SEMICOLON;


exp : factor
	(PLUS factor | MINUS factor)*;

factor  : v
	(MUL v  | div_v )*;
div_v : DIV val=v;

v : (INT | FLOAT)
    | idf=IDF
	| PAR_B exp PAR_E;

exp_b : factor_b (OR factor_b)*;
factor_b : literal (AND literal)*;
literal : NOT? atom;
atom : exp (op_compare exp)* | PAR_B exp_b PAR_E;


var_declare : t=type idf=IDF (var_dec_idf_comma)* SEMICOLON;
var_dec_idf_comma : COMMA idf=IDF;
bibs : (BIB_IO | BIB_LANG);
type : (TYPE_INT | TYPE_FLOAT | TYPE_STRING);
modif : (MODIF_PUBLIC | MODIF_PROTECTED) | ;
format : FORMAT_INT | FORMAT_FLOAT | FORMAT_STRING;
string : STRING;

op_compare : G | GE | L | LE | E | NE;


IMPORT_KW : 'import';
CLASS_KW : 'class_SJ';
MAIN_KW : 'main_SJ';

IN_KW : 'In_SJ';
OUT_KW : 'Out_SJ';

IF_KW : 'if';
ELSE_KW : 'else';
THEN_KW : 'then';

PLUS : '+';
MINUS : '-';
MUL : '*';
DIV : '/';

G : '>';
GE : '>=';
L : '<';
LE : '<=';
E : '=';
NE : '!=';
NOT : '!';
AND : '&';
OR : '|';

ASSIGN : ':=';

PAR_B : '(';
PAR_E : ')';

ACC_B : '{';
ACC_E : '}';

COMMA : ',';
SEMICOLON : ';';

FORMAT_INT : '%d';
FORMAT_FLOAT : '%f';
FORMAT_STRING : '%s';

MODIF_PUBLIC : 'public';
MODIF_PROTECTED : 'protected';

BIB_LANG : 'Small_Java.lang';
BIB_IO : 'Small_Java.io';

TYPE_INT : 'int_SJ';
TYPE_FLOAT : 'float_SJ';
TYPE_STRING : 'string_SJ';



INT : [0-9]+;
FLOAT : [0-9]+'.'[0-9]+;

IDF : [A-Za-z][A-Za-z0-9]*;

STRING : '"'.*?'"';
WS : [ \r\t\n] -> skip;