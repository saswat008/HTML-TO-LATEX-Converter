%{
#include"string.h"
#include"stdlib.h"
int yywrap(void);
int yylineno;
extern int yylex();
extern FILE *yyin;
extern void yyerror (char const* st);
%}

%define parse.error verbose

%token  DOCTYP HTMLO HTMLC HEADO HEADC TITLEO TITLEC BODYO BODYC PARAGRAPHO PARAGRAPHC STR FONTOFIRST FONTOMIDDLE FONTOEND FONTO FONTC AHOFIRST AHOMIDDLE AHOEND AO AHC 
%token	HEADER1O HEADER1C HEADER2O HEADER2C HEADER3O HEADER3C HEADER4O HEADER4C HEADER5O HEADER5C HEADER6O HEADER6C DIVISIONO DIVISIONC TLTYPO TLTYPC CENTERO CENTERC BREAKLINE
%token	UNORDLISTO UNORDLISTC ORDLISTO ORDLISTC LISTO LISTC DESCLISTO DESCLISTC DEFTERMO DEFTERMC DESCTERMO DESCTERMC UNDERLINEO UNDERLINEC BOLDO BOLDC ITALICO ITALICC EMPHO EMPHC
%token	STRONGO STRONGC SMALLO SMALLC SUBO SUBC SUPO SUPC TABLEO TABLEC TABLEHEADO TABLEHEADC TABLEROWO TABLEROWC TABLEDATAO TABLEDATAC CAPTIONO CAPTIONC FIGUREO FIGUREC FIGCAPTIONO FIGCAPTIONC
%token	IMGO SRCFIRST SRCPATH SRCEND HFIRST HSIZE HEND WFIRST WSIZE WEND IMGEND

%union{
        char* tag;
        char* s;
}

%type <tag> DOCTYP HTMLO HTMLC HEADO HEADC TITLEO TITLEC BODYO BODYC PARAGRAPHO PARAGRAPHC FONTOFIRST FONTOEND FONTO FONTC AHOFIRST AHOEND AO AHC 
%type <tag> HEADER1O HEADER1C HEADER2O HEADER2C HEADER3O HEADER3C HEADER4O HEADER4C HEADER5O HEADER5C HEADER6O HEADER6C DIVISIONO DIVISIONC TLTYPO TLTYPC CENTERO CENTERC BREAKLINE
%type <tag> UNORDLISTO UNORDLISTC ORDLISTO ORDLISTC LISTO LISTC DESCLISTO DESCLISTC DEFTERMO DEFTERMC DESCTERMO DESCTERMC UNDERLINEO UNDERLINEC BOLDO BOLDC ITALICO ITALICC EMPHO EMPHC
%type <tag> STRONGO STRONGC SMALLO SMALLC SUBO SUBC SUPO SUPC TABLEO TABLEC TABLEHEADO TABLEHEADC TABLEROWO TABLEROWC TABLEDATAO TABLEDATAC CAPTIONO CAPTIONC 
%type <tag> IMGO SRCFIRST SRCPATH SRCEND HFIRST HSIZE HEND WFIRST WSIZE WEND IMGEND FIGUREO FIGUREC FIGCAPTIONO FIGCAPTIONC
%type <s>   STR mainBody head headFollow htmlFollow body bodyFollow para paraFollow font ah ahFollow fontFollow div divFollow FONTOMIDDLE AHOMIDDLE 
%type <s>   header1 header1Follow header2 header2Follow header3 header3Follow header4 header4Follow header5 header5Follow header6 header6Follow uList uListFollow oList oListFollow lists list listFollow
%type <s>   center centerFollow tType tTypeFollow bold boldFollow uLine uLineFollow italic italicFollow emph emphFollow strong strongFollow small smallFollow sup supFollow sub subFollow
%type <s>   phraseContent pContent flowContent fContent dl dlFollow dtList dt dtFollow dd ddFollow table tableFollow tFollow tr trFollow trList th thFollow thList td tdFollow tdList caption
%type <s>   figure figcaption figFollow figcapFollow figContent figC img imgFollow src height width
%%

START:          DOCTYP {printf("%s",$1);} mainBody {printf("\n %s\n",$3);}
     		|mainBody {printf("\n %s\n",$1);};

mainBody:       HTMLO htmlFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

htmlFollow:     head body HTMLC		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        }
                |head HTMLC 		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
                |body HTMLC		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
                |HTMLC                  {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

head:           HEADO headFollow  	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

headFollow:     TITLEO STR TITLEC HEADC {
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        } 
                |HEADC                  {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s = strcpy(s,$1);
                                                $$ = s;
                                        };

body:           BODYO bodyFollow       	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

bodyFollow:     flowContent BODYC       {
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
                |BODYC                  {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };


uList:		UNORDLISTO uListFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

uListFollow:	lists UNORDLISTC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }	
	   	| UNORDLISTC		{
						char *s = (char*)malloc(strlen($1)+1);
						s=strcpy(s,$1);
						$$ = s;
					};

oList:		ORDLISTO oListFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

oListFollow:	lists ORDLISTC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }	
	   	| ORDLISTC		{
						char *s = (char*)malloc(strlen($1)+1);
						s=strcpy(s,$1);
						$$ = s;
					};

lists:		lists list		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
     		|list			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

list:		LISTO listFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

listFollow:	flowContent LISTC	{
						char *s = (char*)malloc(strlen($1)+strlen($2)+1);
						s=strcpy(s,$1); s = strcat(s,$2);
						$$ = s;
					}	
	  	|LISTC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };	

phraseContent:	phraseContent pContent	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	     	|pContent		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

pContent:	ah			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
	     	|bold			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|emph			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|italic			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|uLine			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|small			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|strong			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|sup			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|sub			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|STR			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		
		|BREAKLINE		{
						char *s = (char*)malloc(strlen($1)+strlen("\n")+1);
						s = strcpy(s,$1); s = strcat(s,"\n");
						$$ = s;
					}
		|img			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|center			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|tType			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|font			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
;

flowContent:	flowContent fContent	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	   	|fContent		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

fContent:	ah			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
	   	|bold			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|emph			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header1		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header2		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header3		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header4		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header5		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|header6		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|italic			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|uLine			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|para			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|small			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|strong			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|sub			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|sup			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|STR			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }		
		|BREAKLINE		{
						char *s = (char*)malloc(strlen($1)+strlen("\n")+1);
						s = strcpy(s,$1); s = strcat(s,"\n");
						$$ = s;
					}
		|div			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|dl			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|table			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|figure			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|uList			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|oList			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|img			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|center			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|tType			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		|font			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
;

div:		DIVISIONO divFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

divFollow:	flowContent DIVISIONC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		| DIVISIONC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

para:           PARAGRAPHO  paraFollow  {
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };               

paraFollow:     phraseContent PARAGRAPHC{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }                                                       
                |PARAGRAPHC             {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

font:           FONTOFIRST FONTOMIDDLE FONTOEND fontFollow		{
                                                				char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                				s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                				$$ = s;
                                        				}
                |FONTO fontFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

fontFollow:     flowContent FONTC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
                |FONTC                  {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

ah:             AHOFIRST AHOMIDDLE AHOEND ahFollow	{
                                                		char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                		s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                		$$ = s;
                                        		}
                |AO  ahFollow		{
                                                	char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                	s=strcpy(s,$1); s = strcat(s,$2);
                                                	$$ = s;
                                        };

ahFollow:       flowContent AHC   	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
                |AHC                    {
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

center:		CENTERO centerFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

centerFollow:	flowContent CENTERC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|CENTERC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header1:	HEADER1O header1Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header1Follow:	phraseContent HEADER1C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER1C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header2:	HEADER2O header2Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header2Follow:	phraseContent HEADER2C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER2C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header3:	HEADER3O header3Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header3Follow:	phraseContent HEADER3C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER3C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header4:	HEADER4O header4Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header4Follow:	phraseContent HEADER4C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER4C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header5:	HEADER5O header5Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header5Follow:	phraseContent HEADER5C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER5C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

header6:	HEADER6O header6Follow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

header6Follow:	phraseContent HEADER6C	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|HEADER6C		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

tType:		TLTYPO tTypeFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

tTypeFollow:	flowContent TLTYPC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|TLTYPC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

bold:		BOLDO boldFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

boldFollow:	phraseContent BOLDC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|BOLDC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

uLine:		UNDERLINEO uLineFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

uLineFollow:	phraseContent UNDERLINEC{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|UNDERLINEC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

italic:		ITALICO italicFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

italicFollow:	phraseContent ITALICC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|ITALICC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

emph:		EMPHO emphFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

emphFollow:	phraseContent EMPHC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|EMPHC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

strong:		STRONGO strongFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

strongFollow:	phraseContent STRONGC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|STRONGC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

small:		SMALLO smallFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

smallFollow:	phraseContent SMALLC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|SMALLC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

sup:		SUPO supFollow		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

supFollow:	phraseContent SUPC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|SUPC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

sub:		SUBO subFollow		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

subFollow:	phraseContent SUBC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
	    	|SUBC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

dl:		DESCLISTO dlFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

dlFollow:	dtList DESCLISTC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		| DESCLISTC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

dtList:		dtList dt		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
       		|dt			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

dt:		DEFTERMO dtFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

dtFollow:	flowContent DEFTERMC dd	{
                                                		char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);/*STR*/
                                                		s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                		$$ = s;
                                        }	
		|flowContent DEFTERMC	{
                                                		char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                		s=strcpy(s,$1); s = strcat(s,$2);
                                                		$$ = s;
                                        }
		|DEFTERMC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

dd:		DESCTERMO ddFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

ddFollow:	flowContent DESCTERMC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|DESCTERMC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

table:		TABLEO tableFollow 	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

tableFollow :	caption tFollow 	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|tFollow		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

caption:	CAPTIONO flowContent CAPTIONC		{
                                                		char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);/*STR*/
                                                		s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                		$$ = s;
                                        		}
		|CAPTIONO CAPTIONC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

tFollow:	trList TABLEC		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|TABLEC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

trList:		trList tr		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|tr			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

tr:		TABLEROWO trFollow 	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

trFollow:	thList TABLEROWC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|tdList TABLEROWC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|TABLEROWC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

thList:		thList th		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|th			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

th:		TABLEHEADO thFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

thFollow:	flowContent TABLEHEADC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|TABLEHEADC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

tdList:		tdList td		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|td			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

td:		TABLEDATAO tdFollow 	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

tdFollow:	flowContent TABLEDATAC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|TABLEDATAC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

figure:		FIGUREO figFollow	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

figFollow:	figContent FIGUREC	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|FIGUREC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

figContent:	figContent figC		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|figC			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

figC:		figcaption		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
		img			{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        }
;

figcaption:	FIGCAPTIONO figcapFollow{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

figcapFollow:	flowContent FIGCAPTIONC	{
                                              	char *s = (char*)malloc(strlen($1)+strlen($2)+1);/*STR*/
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|FIGCAPTIONC		{
                                                char *s = (char*)malloc(strlen($1)+1);
                                                s=strcpy(s,$1);
                                                $$ = s;
                                        };

img:		IMGO imgFollow		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        };

imgFollow:	src IMGEND		{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+1);
                                                s=strcpy(s,$1); s = strcat(s,$2);
                                                $$ = s;
                                        }
		|src height IMGEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        }
		|src width IMGEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        }
		|src height width IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
		|src width height IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
		|height src IMGEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        }
		|height src width IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
		|height width src IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
		|width src IMGEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        }
		|width src height IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
		|width height src IMGEND{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+strlen($4)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(strcat(s,$2),$3),$4);
                                                $$ = s;
                                        }
;

src:		SRCFIRST SRCPATH SRCEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        };	

height:		HFIRST HSIZE HEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        };

width:		WFIRST WSIZE WEND	{
                                                char *s = (char*)malloc(strlen($1)+strlen($2)+strlen($3)+1);
                                                s=strcpy(s,$1); s = strcat(strcat(s,$2),$3);
                                                $$ = s;
                                        };
%%

int yywrap(){}

void yyerror(char const* st) {
    fprintf(stderr, "line %d: %s\n", yylineno, st);
}

int main()
{
        char* fname;
        FILE *fp;
        printf("Enter a filename \n");
        scanf("%s",fname);
        fp = fopen(fname,"r");
        yyin = fp;
        yyparse();
}
