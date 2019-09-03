%{
#include"string.h"
#include"stdlib.h"
#include<fstream>
#include"AST.h"
int yywrap(void);
int yylineno;
extern int yylex();
extern FILE *yyin;
extern void yyerror (char const* st);
FILE *fpO;
%}

%define parse.error verbose

%token  DOCTYP HTMLO HTMLC HEADO HEADC TITLEO TITLEC BODYO BODYC PARAGRAPHO PARAGRAPHC STR FONTOFIRST FONTOMIDDLE FONTOEND FONTO FONTC AHOFIRST AHOMIDDLE AHOEND AO AHC 
%token	HEADER1O HEADER1C HEADER2O HEADER2C HEADER3O HEADER3C HEADER4O HEADER4C HEADER5O HEADER5C HEADER6O HEADER6C DIVISIONO DIVISIONC TLTYPO TLTYPC CENTERO CENTERC BREAKLINE
%token	UNORDLISTO UNORDLISTC ORDLISTO ORDLISTC LISTO LISTC DESCLISTO DESCLISTC DEFTERMO DEFTERMC DESCTERMO DESCTERMC UNDERLINEO UNDERLINEC BOLDO BOLDC ITALICO ITALICC EMPHO EMPHC
%token	STRONGO STRONGC SMALLO SMALLC SUBO SUBC SUPO SUPC TABLEO TABLEC TABLEHEADO TABLEHEADC TABLEROWO TABLEROWC TABLEDATAO TABLEDATAC CAPTIONO CAPTIONC FIGUREO FIGUREC FIGCAPTIONO FIGCAPTIONC
%token	IMGO SRCFIRST SRCPATH SRCEND HFIRST HSIZE HEND WFIRST WSIZE WEND IMGEND SYMBOLS SYMBOLM SYMBOLE SPECIAL

%union{
        char* tag;
	char* v;
        astNode* s;
	vector<astNode*>* t;
}

%type <tag> DOCTYP HTMLO HTMLC HEADO HEADC TITLEO TITLEC BODYO BODYC PARAGRAPHO PARAGRAPHC FONTOFIRST FONTOEND FONTO FONTC AHOFIRST AHOEND AO AHC 
%type <tag> HEADER1O HEADER1C HEADER2O HEADER2C HEADER3O HEADER3C HEADER4O HEADER4C HEADER5O HEADER5C HEADER6O HEADER6C DIVISIONO DIVISIONC TLTYPO TLTYPC CENTERO CENTERC BREAKLINE
%type <tag> UNORDLISTO UNORDLISTC ORDLISTO ORDLISTC LISTO LISTC DESCLISTO DESCLISTC DEFTERMO DEFTERMC DESCTERMO DESCTERMC UNDERLINEO UNDERLINEC BOLDO BOLDC ITALICO ITALICC EMPHO EMPHC
%type <tag> STRONGO STRONGC SMALLO SMALLC SUBO SUBC SUPO SUPC TABLEO TABLEC TABLEHEADO TABLEHEADC TABLEROWO TABLEROWC TABLEDATAO TABLEDATAC CAPTIONO CAPTIONC 
%type <tag> IMGO SRCFIRST SRCPATH SRCEND HFIRST HSIZE HEND WFIRST WSIZE WEND IMGEND FIGUREO FIGUREC FIGCAPTIONO FIGCAPTIONC
%type <s>   start mainBody head headFollow htmlFollow title body bodyFollow para paraFollow font ah div divFollow 
%type <s>   header1 header1Follow header2 header2Follow header3 header3Follow header4 header4Follow header5 header5Follow header6 header6Follow uList uListFollow oList oListFollow list listFollow
%type <s>   center centerFollow tType tTypeFollow bold boldFollow uLine uLineFollow italic italicFollow emph emphFollow strong strongFollow small smallFollow sup supFollow sub subFollow
%type <s>   pContent fContent dl dlFollow dt dtFollow dd ddFollow table tableFollow tr trFollow th thFollow td tdFollow caption
%type <s>   figure figcaption figFollow figcapFollow figContent img imgFollow src height width content tCont aCont symbol special
%type <v>   STR FONTOMIDDLE AHOMIDDLE SYMBOLS SYMBOLM SYMBOLE SPECIAL
%type <t>   flowContent lists dtList phraseContent divList tContent aContent trList thList tdList

%%

start:		DOCTYP mainBody		{
						$$ = newAst("ROOT");
						$$->child.push_back($2);
					}
		|mainBody		{
						$$ = newAst("ROOT");
						$$->child.push_back($1);
					};
mainBody:       HTMLO htmlFollow	{
						$$ = $2;
						latexNode* node = new latexNode;
						node = convert($$);
						produceLatexCode(node,fpO);
					};

htmlFollow:     head body HTMLC		{
						$$ = newAst("HTML");
						$$->child.push_back($1);
						$$->child.push_back($2);
                                        }
                |head HTMLC 		{
                                                $$ = newAst("HTML");
						$$->child.push_back($1);
                                        }
                |body HTMLC		{
                                                $$ = newAst("HTML");
						$$->child.push_back($1);
                                        }
                |HTMLC                  {
						$$ = newAst("HTML")
					}
;
head:           HEADO headFollow  	{
                                                $$ = $2;
                                        }
;

headFollow:     title HEADC 		{
                                                $$ = newAst("HEAD");
						$$->child.push_back($1);
                                        } 
                |HEADC                  {
                                                $$ = newAst("HEAD");
                                        };

title:		TITLEO STR TITLEC	{
     						$$ = newAst("TITLE");
						$$->value = $2;
					}
     		|TITLEO TITLEC		{
						$$ = newAst("TITLE");
					}
;

body:           BODYO bodyFollow       	{
                                                $$ = $2;
                                        };

bodyFollow:     flowContent BODYC       {
                                                $$ = newAst("BODY");
						$$->child = *$1;
                                        }
                |BODYC                  {
                                                $$ = newAst("BODY");
                                        };

flowContent:	flowContent fContent	{
                                                $1->push_back($2);
                                                $$ = $1;
                                        }
	   	|fContent		{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

fContent:	ah			{
                                                $$ = $1;
                                        }		
		|img			{
                                                $$ = $1;
                                        }
		|header1		{
                                                $$ = $1;
                                        }
		|header2		{
                                                $$ = $1;
                                        }
		|header3		{
                                                $$ = $1;
                                        }
		|header4		{
                                                $$ = $1;
                                        }
		|header5		{
                                                $$ = $1;
                                        }
		|header6		{
                                                $$ = $1;
                                        }
		|content		{
                                                $$ = $1;
                                        }
;

content:	italic			{
                                                $$ = $1;
                                        }
		|uLine			{
                                                $$ = $1;
                                        }
		|para			{
                                                $$ = $1;
                                        }
		|small			{
                                                $$ = $1;
                                        }
		|strong			{
                                                $$ = $1;
                                        }
		|sub			{
                                                $$ = $1;
                                        }
		|sup			{
                                                $$ = $1;
                                        }
		|STR			{
                                                $$ = newAst("STRING");
						$$->value = $1;
                                        }		
		|BREAKLINE		{
						$$ = newAst("BR");
					}
		|div			{
                                                $$ = $1;
                                        }
		|dl			{
                                                $$ = $1;
                                        }
		|table			{
                                                $$ = $1;
                                        }
		|figure			{
                                                $$ = $1;
                                        }
		|uList			{
                                                $$ = $1;
                                        }
		|oList			{
                                                $$ = $1;
                                        }
		|center			{
                                                $$ = $1;
                                        }
		|tType			{
                                                $$ = $1;
                                        }
		|font			{
                                                $$ = $1;
                                        }
		
	   	|bold			{
                                                $$ = $1;
                                        }
		|emph			{
                                                $$ = $1;
                                        }
		|symbol			{
						$$ = $1;
					}
		|special		{
						$$ = $1;
					}
;

aContent:	aContent aCont		{
						$1->push_back($2);
                                                $$ = $1;
					}
		|aCont			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
					};

aCont:		header1			{
                                                $$ = $1;
                                        }
		|header2		{
                                                $$ = $1;
                                        }
		|header3		{
                                                $$ = $1;
                                        }
		|header4		{
                                                $$ = $1;
                                        }
		|header5		{
                                                $$ = $1;
                                        }
		|header6		{
                                                $$ = $1;
                                        }
		|content		{
                                                $$ = $1;
                                        };

tContent:	tContent tCont		{
						$1->push_back($2);
                                                $$ = $1;
					}
		| tCont			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
					};

tCont:		ah			{
                                                $$ = $1;
                                        }		
		|img			{
                                                $$ = $1;
                                        }
		|content		{
                                                $$ = $1;
                                        }
;

phraseContent:	phraseContent pContent	{
	     					$1->push_back($2);
                                                $$ = $1;
                                        }
	     	|pContent		{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

pContent:	ah			{
                                               	$$ = $1;
                                        }
	     	|bold			{
                                                $$ = $1;
                                        }
		|emph			{
                                                $$ = $1;
                                        }
		|italic			{
                                                $$ = $1;
                                        }
		|uLine			{
                                                $$ = $1;
                                        }
		|small			{
                                                $$ = $1;
                                        }
		|strong			{
                                                $$ = $1;
                                        }
		|sup			{
                                                $$ = $1;
                                        }
		|sub			{
                                                $$ = $1;
                                        }
		|STR			{
                                                $$ = newAst("STRING");
						$$->value = $1;
                                        }
		
		|BREAKLINE		{
						$$ = newAst("BR");
					}
		|img			{
                                                $$ = $1;
                                        }
		|center			{
                                                $$ = $1;
                                        }
		|tType			{
                                                $$ = $1;
                                        }
		|font			{
                                                $$ = $1;
                                        }
		|symbol			{
						$$ = $1;
					}
		|special		{
						$$ = $1;
					}
;

symbol:		SYMBOLS SYMBOLM SYMBOLE	{
      					 	$$ = newAst("SYMBOL");
						$$->value = $2;
					};

special:	SPECIAL			{
       						$$ = newAst("SPECIAL");
						$$->value = $1;
					};


uList:		UNORDLISTO uListFollow	{
                                                $$ = $2;
                                        };

uListFollow:	lists UNORDLISTC	{
	   					$$ = newAst("UL");
                                                $$->child = *$1;
                                        }	
	   	| UNORDLISTC		{
						$$ = newAst("UL");
					};

oList:		ORDLISTO oListFollow	{
     						$$ = $2;
                                        };

oListFollow:	lists ORDLISTC		{
   						$$ = newAst("OL");
                                                $$->child = *$1;	   
                                        }	
	   	| ORDLISTC		{
						$$ = newAst("OL");
					};

lists:		lists list		{
     						$1->push_back($2);
                                                $$ = $1;
                                        }
     		|list			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

list:		LISTO listFollow	{
    						$$ = $2;
                                        };

listFollow:	flowContent LISTC	{
	  					$$ = newAst("LI");
                                                $$->child = *$1;
					}	
	  	|LISTC			{
						$$ = newAst("LI");
                                        };	

div:		DIVISIONO divFollow	{
                                                $$ = $2;
                                        };

divFollow:	flowContent DIVISIONC	{
	 					$$ = newAst("DIV");
                                                $$->child = *$1;
                                        }
		| dtList DIVISIONC	{
						$$ = newAst("DIV");
                                                $$->child = *$1;
                                        }
		| DIVISIONC		{
						$$ = newAst("DIV");
                                        };

para:           PARAGRAPHO  paraFollow  {
                                               	$$ = $2;
                                        };               

paraFollow:     phraseContent PARAGRAPHC{
	  					$$ = newAst("P");
                                                $$->child = *$1;
                                        }                                                       
                |PARAGRAPHC             {
						$$ = newAst("P");
                                        };


center:		CENTERO centerFollow	{
                                                $$ = $2;
                                        };

centerFollow:	flowContent CENTERC	{
	    					$$ = newAst("CENTER");
                                                $$->child = *$1;
                                        }
	    	|CENTERC		{
						$$ = newAst("CENTER");
                                        };

header1:	HEADER1O header1Follow	{
                                                $$ = $2;
                                        };

header1Follow:	phraseContent HEADER1C	{
	     					$$ = newAst("H1");
                                                $$->child = *$1;
                                        }
	    	|HEADER1C		{
						$$ = newAst("H1");
                                        };

header2:	HEADER2O header2Follow	{
                                                $$ = $2;
                                        };

header2Follow:	phraseContent HEADER2C	{
	     					$$ = newAst("H2");
                                                $$->child = *$1;
                                        }
	    	|HEADER2C		{
						$$ = newAst("H2");
                                        };

header3:	HEADER3O header3Follow	{
                                                $$ = $2;
                                        };

header3Follow:	phraseContent HEADER3C	{
	     					$$ = newAst("H3");
                                                $$->child = *$1;
                                        }
	    	|HEADER3C		{
						$$ = newAst("H3");
                                        };

header4:	HEADER4O header4Follow	{
                                                $$ = $2;
                                        };

header4Follow:	phraseContent HEADER4C	{
	     					$$ = newAst("H4");
                                                $$->child = *$1;
                                        }
	    	|HEADER4C		{
						$$ = newAst("H4");
                                        };

header5:	HEADER5O header5Follow	{
                                                $$ = $2;
                                        };

header5Follow:	phraseContent HEADER5C	{
	     					$$ = newAst("H5");
                                                $$->child = *$1;
                                        }
	    	|HEADER5C		{
						$$ = newAst("H5");
                                        };

header6:	HEADER6O header6Follow	{
                                                $$ = $2;
                                        };

header6Follow:	phraseContent HEADER6C	{
	     					$$ = newAst("H6");
                                                $$->child = *$1;
                                        }
	    	|HEADER6C		{
						$$ = newAst("H6");
                                        };

tType:		TLTYPO tTypeFollow	{
                                                $$ = $2;
                                        };

tTypeFollow:	flowContent TLTYPC	{
	   					$$ = newAst("TT");
                                                $$->child = *$1;
                                        }
	    	|TLTYPC			{
						$$ = newAst("TT");
                                        };

bold:		BOLDO boldFollow	{
                                                $$ = $2;
                                        };

boldFollow:	phraseContent BOLDC	{
	  					$$ = newAst("B");
                                                $$->child = *$1;
                                        }
	    	|BOLDC			{
						$$ = newAst("B");
                                        };

uLine:		UNDERLINEO uLineFollow	{
                                                $$ = $2;
                                        };

uLineFollow:	phraseContent UNDERLINEC{
	   					$$ = newAst("U");
                                                $$->child = *$1;
                                        }
	    	|UNDERLINEC		{
						$$ = newAst("U");
                                        };

italic:		ITALICO italicFollow	{
                                                $$ = $2;
                                        };

italicFollow:	phraseContent ITALICC	{
	    					$$ = newAst("I");
                                                $$->child = *$1;
                                        }
	    	|ITALICC		{
                                             	$$ = newAst("I");
                                        };

emph:		EMPHO emphFollow	{
                                                $$ = $2;
                                        };

emphFollow:	phraseContent EMPHC	{
	  					$$ = newAst("EM");
                                                $$->child = *$1;
                                        }
	    	|EMPHC			{
						$$ = newAst("EM");
                                        };

strong:		STRONGO strongFollow	{
                                                $$ = $2;
                                        };

strongFollow:	phraseContent STRONGC	{
	    					$$ = newAst("STRONG");
                                                $$->child = *$1;
                                        }
	    	|STRONGC		{
						$$ = newAst("STRONG");
                                        };

small:		SMALLO smallFollow	{
                                                $$ = $2;
                                        };

smallFollow:	phraseContent SMALLC	{
	   					$$ = newAst("SMALL");
                                                $$->child = *$1;
                                        }
	    	|SMALLC			{
						$$ = newAst("SMALL");
                                        };

sup:		SUPO supFollow		{
                                                $$ = $2;
                                        };

supFollow:	phraseContent SUPC	{
	 					$$ = newAst("SUP");
                                                $$->child = *$1;
                                        }
	    	|SUPC			{
						$$ = newAst("SUP");
                                        };

sub:		SUBO subFollow		{
                                                $$ = $2;
                                        };

subFollow:	phraseContent SUBC	{
	 					$$ = newAst("SUB");
                                                $$->child = *$1;
                                        }
	    	|SUBC			{
						$$ = newAst("SUB");
                                        };

dl:		DESCLISTO dlFollow	{
                                                $$ = $2;
                                        };

dlFollow:	dtList DESCLISTC	{
						$$ = newAst("DL");
                                                $$->child = *$1;
                                        }
		|divList DESCLISTC	{
						$$ = newAst("DL");
                                                $$->child = *$1;
                                        }
		| DESCLISTC		{
						$$ = newAst("DL");
                                        };

divList:	divList div		{
       						$1->push_back($2);
                                                $$ = $1;
                                        }
		|div			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

dtList:		dtList dt		{
      						$1->push_back($2);
                                                $$ = $1;
                                        }
       		|dt			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
                                        };

dt:		DEFTERMO dtFollow	{
                                                $$ = $2;
                                        };

dtFollow:	tContent DEFTERMC dd	{
						$$ = newAst("DT");
                                                $$->child = *$1;
						$$->child.push_back($3);
                                        }	
		|tContent DEFTERMC	{
						$$ = newAst("DT");
                                                $$->child = *$1;
                                        }
		|DEFTERMC		{
						$$ = newAst("DT");
                                        };

dd:		DESCTERMO ddFollow	{
                                                $$ = $2;
                                        };

ddFollow:	flowContent DESCTERMC	{
						$$ = newAst("DD");
                                                $$->child = *$1;
                                        }
		|DESCTERMC		{
						$$ = newAst("DD");
                                        };

table:		TABLEO tableFollow 	{
     						$$ = $2;
                                        };

tableFollow :	caption trList TABLEC	{
	    					$$ = newAst("TABLE");
                                                $$->child.push_back($1);
						$$->child.insert($$->child.end(),$2->begin(),$2->end());
                                        }
		|trList TABLEC		{
						$$ = newAst("TABLE");
                                                $$->child = *$1;
                                        }
		|TABLEC			{
						$$ = newAst("TABLE");
					};

caption:	CAPTIONO flowContent CAPTIONC		{
       								$$ = newAst("CAPTION");
                                                		$$->child = *$2;
                                        		}
		|CAPTIONO CAPTIONC	{
						$$ = newAst("CAPTION");
                                        };

trList:		trList tr		{
      						$1->push_back($2);
                                                $$ = $1;
                                        }
		|tr			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

tr:		TABLEROWO trFollow 	{
                                                $$ = $2;
                                        };

trFollow:	thList TABLEROWC	{
						$$ = newAst("TR");
                                                $$->child = *$1;
                                        }
		|tdList TABLEROWC	{
						$$ = newAst("TR");
                                                $$->child = *$1;
                                        }
		|TABLEROWC		{
						$$ = newAst("TR");
                                        };

thList:		thList th		{
      						$1->push_back($2);
                                                $$ = $1;
                                        }
		|th			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

th:		TABLEHEADO thFollow	{
                                                $$ = $2;
                                        };

thFollow:	tContent TABLEHEADC	{
						$$ = newAst("TH");
                                                $$->child = *$1;
                                        }
		|TABLEHEADC		{
						$$ = newAst("TH");
                                        };

tdList:		tdList td		{
      						$1->push_back($2);
                                                $$ = $1;
                                        }
		|td			{
						vector<astNode*>* vec = new vector<astNode*> ();
                                                vec->push_back($1);
                                                $$ = vec;
						vec = NULL;
                                        };

td:		TABLEDATAO tdFollow 	{
                                                $$ = $2;
                                        };

tdFollow:	flowContent TABLEDATAC	{
						$$ = newAst("TD");
                                                $$->child = *$1;	
                                        }
		|TABLEDATAC		{
						$$ = newAst("TD");
                                        };

figure:		FIGUREO figFollow	{
                                                $$ = $2;
                                        };

figFollow:	figContent FIGUREC	{
	 					$$ = newAst("FIGURE");
                                                $$ = $1;
                                        }
		|FIGUREC		{
						$$ = newAst("FIGURE");
                                        };

figContent:	figcaption flowContent	{
	  					$$ = newAst("FIGCONTENT");
                                                $$->child.push_back($1);
						$$->child.insert($$->child.end(),$2->begin(),$2->end());
                                        }
	  	|flowContent figcaption	{
						$$ = newAst("FIGCONTENT");
                                                $$->child = *$1;
						$$->child.push_back($2);
                                        }
		|flowContent		{
						$$ = newAst("FIGCONTENT");
                                                $$->child = *$1;
                                        };

figcaption:	FIGCAPTIONO figcapFollow{
                                                $$ = $2;
                                        };

figcapFollow:	flowContent FIGCAPTIONC	{
	    					$$ = newAst("FIGCAPTION");
                                                $$->child = *$1;
                                        }
		|FIGCAPTIONC		{
						$$ = newAst("FIGCAPTION");
                                        };

img:		IMGO imgFollow		{
                                                $$ = $2;
                                        };

imgFollow:	src IMGEND		{
	 					$$ = newAst("IMG");
                                                $$->attribute.push_back($1);
                                        }
		|src height IMGEND	{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($2);
						$$->attribute.push_back($1);
                                        }
		|src width IMGEND	{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($2);
						$$->attribute.push_back($1);
                                        }
		|src height width IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($3);
						$$->attribute.push_back($2);
						$$->attribute.push_back($1);
                                        }
		|src width height IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($3);
						$$->attribute.push_back($2);
						$$->attribute.push_back($1);
                                        }
		|height src IMGEND	{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($2);
						$$->attribute.push_back($1);
                                        }
		|height src width IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($1);
						$$->attribute.push_back($3);
						$$->attribute.push_back($2);
                                        }
		|height width src IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($1);
						$$->attribute.push_back($2);
						$$->attribute.push_back($3);
                                        }
		|width src IMGEND	{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($1);
						$$->attribute.push_back($2);		
                                        }
		|width src height IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($1);
						$$->attribute.push_back($3);
						$$->attribute.push_back($2);
                                        }
		|width height src IMGEND{
                                                $$ = newAst("IMG");
                                                $$->attribute.push_back($1);
						$$->attribute.push_back($2);
						$$->attribute.push_back($3);
                                        }
;

src:		SRCFIRST SRCPATH SRCEND	{
   						$$ = newAst("SRC");
						$$->value = $2;
                                        };	

height:		HFIRST HSIZE HEND	{
                                                $$ = newAst("HEIGHT");
						$$->value = $2;
                                        };

width:		WFIRST WSIZE WEND	{
     						$$ = newAst("WIDTH");
						$$->value = $2;
                                        };

font:           FONTOFIRST FONTOMIDDLE FONTOEND flowContent FONTC{
    									$$ = newAst("FONT");
									astNode* node = newAst("SIZE");
									node->value = $2;
									$$->attribute.push_back(node);
									$$->child = *$4;
                                        			 }
		|FONTOFIRST FONTOMIDDLE FONTOEND FONTC		 {
                                                                        $$ = newAst("FONT");
                                                                        astNode* node = newAst("SIZE");
                                                                        node->value = $2;
                                                                        $$->attribute.push_back(node);
                                                                 }
                |FONTO flowContent FONTC{
						$$ = newAst("FONT");
                                                $$->child = *$2;
                                        }
		|FONTO FONTC		{
						$$ = newAst("FONT");
					};

ah:             AHOFIRST AHOMIDDLE AHOEND aContent AHC	{
  								$$ = newAst("A");
                                                                astNode* node = newAst("HREF");
                                                                node->value = $2;
                                                                $$->attribute.push_back(node);
                                                                $$->child = *$4;
                                        		}
		|AHOFIRST AHOMIDDLE AHOEND AHC		{
  								$$ = newAst("A");
                                                                astNode* node = newAst("HREF");
                                                                node->value = $2;
                                                                $$->attribute.push_back(node);
                                        		}
                |AO  aContent AHC	{
						$$ = newAst("A");
                                                $$->child = *$2;
                                        }
		|AO AHC			{
						$$ = newAst("A");
					};

%%

int yywrap(){}

void yyerror(char const* st) {
    fprintf(stderr, "line %d: %s\n", yylineno, st);
}

int main(int argc, char** argv)
{
        FILE *fpI;
        fpI = fopen(argv[1],"r");
        yyin = fpI;
	fpO = fopen(argv[2],"w");
        yyparse();
}
