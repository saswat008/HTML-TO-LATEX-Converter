%{
#include"string.h"
#include "AST.h"
#include"cop1.tab.h"
%}

%x fontStart fontMiddle ahStart ahMiddle srcStart srcPath hStart hSize wStart wSize comStart comEnd
%option caseless
wSpaceChars	[ \t\n]+
strChars	[a-zA-Z0-9/.:_ ,;\\?'"!*\-|]+
specialChars	[(){}_\^@\$\\%~#&]+
stringChars	({specialChars}|{strChars})({wSpaceChars}({strChars}|specialChars))*


%%
"<!--"									{BEGIN comStart;}

<comStart>[^-]								;

<comStart>"--"								{BEGIN comEnd;}

<comEnd>">"								{BEGIN INITIAL;}

<comEnd>[^>]								{BEGIN comStart;}


">"|"/>"								{yylval.tag = strdup(">");
                                        				return IMGEND;}

"<!DOCTYPE "[ \t]*"html".*">"           				{yylval.tag = strdup("<!DOCTYPE html>");
                                        				return DOCTYP;}

"<HTML"[ \t]*">"|"<html"[ \t]*">"           				{yylval.tag = strdup("<HTML>");
                                        				return HTMLO;}

"</HTML"[ \t]*">"|"</html"[ \t]*">"         				{yylval.tag = strdup("</HTML>");
                                        				return HTMLC;}

"<HEAD"[ \t]*">"|"<head"[ \t]*">"           				{yylval.tag = strdup("<HEAD>");
                                        				return HEADO;}

"</HEAD"[ \t]*">"|"</head"[ \t]*">"         				{yylval.tag = strdup("</HEAD>");
                                        				return HEADC;}

"<TITLE"[ \t]*">"|"<title"[ \t]*">"         				{yylval.tag = strdup("<TITLE>");
                                        				return TITLEO;}

"</TITLE"[ \t]*">"|"</title"[ \t]*">"       				{yylval.tag = strdup("</TITLE>");
                                        				return TITLEC;}

"<BODY"[ \t]*">"|"<body"[ \t]*">"           				{yylval.tag = strdup("<BODY>");
                                        				return BODYO;}

"</BODY"[ \t]*">"|"</body"[ \t]*">"         				{yylval.tag = strdup("</BODY>");
                                        				return BODYC;}

"<P"[ \t]*">"|"<p"[ \t]*">"                 				{yylval.tag = strdup("<P>");
                                        				return PARAGRAPHO;}

"</P"[ \t]*">"|"</p"[ \t]*">"               				{yylval.tag = strdup("</P>");
                                        				return PARAGRAPHC;}

"<font "[ \t]*"size"[ \t]*"="[ \t]*"\""					{yylval.tag = strdup("<FONT SIZE=\"");
									BEGIN fontStart;
									return FONTOFIRST;}

"<font "[ \t]*"size"[ \t]*"="[ \t]*[']					{yylval.tag = strdup("<FONT SIZE=\"");
									BEGIN fontStart;
									return FONTOFIRST;}

<fontStart>[0-7]							{yylval.v = strdup(yytext);
									BEGIN fontMiddle;
									return FONTOMIDDLE;}

<fontMiddle>"\""[ \t]*">"						{yylval.tag = strdup("\">");
									BEGIN INITIAL;
									return FONTOEND;}

<fontMiddle>['][ \t]*">"						{yylval.tag = strdup("\">");
									BEGIN INITIAL;
									return FONTOEND;}

"</font"[ \t]*">"|"</FONT"[ \t]*">"         				{yylval.tag = strdup("</FONT>");
                                        				return FONTC;}

"<font"[ \t]*">"|"<FONT"[ \t]*">"         				{yylval.tag = strdup("<FONT>");
                                        				return FONTO;}

"<a "[ \t]*"href"[ \t]*"="[ \t]*"\""					{yylval.tag = strdup("<A HREF=\"");
									BEGIN ahStart;
									return AHOFIRST;}

"<a "[ \t]*"href"[ \t]*"="[ \t]*[']					{yylval.tag = strdup("<A HREF=\"");
									BEGIN ahStart;
									return AHOFIRST;}

<ahStart>[a-zA-Z0-9/.:_~ ,;\\?#]+					{yylval.v = strdup(yytext);
									BEGIN ahMiddle;
									return AHOMIDDLE;}

<ahMiddle>"\""[ \t]*">"							{yylval.tag = strdup("\">");
									BEGIN INITIAL;
									return AHOEND;}

<ahMiddle>['][ \t]*">"							{yylval.tag = strdup("\">");
									BEGIN INITIAL;
									return AHOEND;}

"</a"[ \t]*">"|"</A"[ \t]*">"         					{yylval.tag = strdup("</A>");
                                        				return AHC;}

"<a"[ \t]*">"|"<A"[ \t]*">"         					{yylval.tag = strdup("<A>");
                                        				return AO;}

"<img "[ \t]*								{yylval.tag = strdup("<IMG ");
                                        				return IMGO;}

"src"[ \t]*"="[ \t]*"\""						{yylval.tag = strdup("SRC =\"");
									BEGIN srcStart;
									return SRCFIRST;}

"src"[ \t]*"="[ \t]*[']							{yylval.tag = strdup("SRC =\"");
									BEGIN srcStart;
									return SRCFIRST;}

<srcStart>[a-zA-Z0-9/.:_~ ,;\\?#]+					{yylval.v = strdup(yytext);
									BEGIN srcPath;
									return SRCPATH;}

<srcPath>"\""[ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return SRCEND;}

<srcPath>['][ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return SRCEND;}

"height"[ \t]*"="[ \t]*"\""						{yylval.tag = strdup("HEIGHT =\"");
									BEGIN hStart;
									return HFIRST;}

"height"[ \t]*"="[ \t]*[']						{yylval.tag = strdup("HEIGHT =\"");
									BEGIN hStart;
									return HFIRST;}

<hStart>[0-9]+								{yylval.v = strdup(yytext);
									BEGIN hSize;
									return HSIZE;}

<hSize>"\""[ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return HEND;}

<hSize>['][ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return HEND;}

"width"[ \t]*"="[ \t]*"\""						{yylval.tag = strdup("WIDTH =\"");
									BEGIN wStart;
									return WFIRST;}

"width"[ \t]*"="[ \t]*[']						{yylval.tag = strdup("WIDTH =\"");
									BEGIN wStart;
									return WFIRST;}

<wStart>[0-9]+								{yylval.v = strdup(yytext);
									BEGIN wSize;
									return WSIZE;}

<wSize>"\""[ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return WEND;}

<wSize>['][ \t]*							{yylval.tag = strdup("\" ");
									BEGIN INITIAL;
									return WEND;}

{stringChars}								{yylval.v = strdup(yytext);
                                        				return STR;}

{wSpaceChars}               						;

"<h1"[ \t]*">"|"<H1"[ \t]*">"						{yylval.tag = strdup("<H1>");
									return HEADER1O;}

"<h2"[ \t]*">"|"<H2"[ \t]*">"						{yylval.tag = strdup("<H2>");
									return HEADER2O;}

"<h3"[ \t]*">"|"<H3"[ \t]*">"						{yylval.tag = strdup("<H3>");
									return HEADER3O;}

"<h4"[ \t]*">"|"<H4"[ \t]*">"						{yylval.tag = strdup("<H4>");
									return HEADER4O;}

"<h5"[ \t]*">"|"<H5"[ \t]*">"						{yylval.tag = strdup("<H5>");
									return HEADER5O;}

"<h6"[ \t]*">"|"<H6"[ \t]*">"						{yylval.tag = strdup("<H6>");
									return HEADER6O;}

"</h1"[ \t]*">"|"</H1"[ \t]*">"						{yylval.tag = strdup("</H1>");
									return HEADER1C;}

"</h2"[ \t]*">"|"</H2"[ \t]*">"						{yylval.tag = strdup("</H2>");
									return HEADER2C;}

"</h3"[ \t]*">"|"</H3"[ \t]*">"						{yylval.tag = strdup("</H3>");
									return HEADER3C;}

"</h4"[ \t]*">"|"</H4"[ \t]*">"						{yylval.tag = strdup("</H4>");
									return HEADER4C;}

"</h5"[ \t]*">"|"</H5"[ \t]*">"						{yylval.tag = strdup("</H5>");
									return HEADER5C;}

"</h6"[ \t]*">"|"</H6"[ \t]*">"						{yylval.tag = strdup("</H6>");
									return HEADER6C;}

"<div"[ \t]*">"|"<DIV"[ \t]*">"						{yylval.tag = strdup("<DIV>");
									return DIVISIONO;}

"</div"[ \t]*">"|"</DIV"[ \t]*">"					{yylval.tag = strdup("</DIV>");
									return DIVISIONC;}

"<tt"[ \t]*">"|"<TT"[ \t]*">"						{yylval.tag = strdup("<TT>");
									return TLTYPO;}

"</tt"[ \t]*">"|"</TT"[ \t]*">"						{yylval.tag = strdup("</TT>");
									return TLTYPC;}

"<center"[ \t]*">"|"<CENTER"[ \t]*">"					{yylval.tag = strdup("<CENTER>");
									return CENTERO;}

"</center"[ \t]*">"|"</CENTER"[ \t]*">"					{yylval.tag = strdup("</CENTER>");
									return CENTERC;}

"<br"[ \t]*">"|"<BR"[ \t]*">"						{yylval.tag = strdup("<BR>");
									return BREAKLINE;}

"<ul"[ \t]*">"|"<UL"[ \t]*">"						{yylval.tag = strdup("<UL>");
									return UNORDLISTO;}

"</ul"[ \t]*">"|"</UL"[ \t]*">"						{yylval.tag = strdup("</UL>");
									return UNORDLISTC;}

"<ol"[ \t]*">"|"<OL"[ \t]*">"						{yylval.tag = strdup("<OL>");
									return ORDLISTO;}

"</ol"[ \t]*">"|"</OL"[ \t]*">"						{yylval.tag = strdup("</OL>");
									return ORDLISTC;}

"<li"[ \t]*">"|"<LI"[ \t]*">"						{yylval.tag = strdup("<LI>");
									return LISTO;}

"</li"[ \t]*">"|"</LI"[ \t]*">"						{yylval.tag = strdup("</LI>");
									return LISTC;}

"<dl"[ \t]*">"|"<DL"[ \t]*">"						{yylval.tag = strdup("<DL>");
									return DESCLISTO;}

"</dl"[ \t]*">"|"</DL"[ \t]*">"						{yylval.tag = strdup("</DL>");
									return DESCLISTC;}

"<dt"[ \t]*">"|"<DT"[ \t]*">"						{yylval.tag = strdup("<DT>");
									return DEFTERMO;}

"</dt"[ \t]*">"|"</DT"[ \t]*">"						{yylval.tag = strdup("</DT>");
									return DEFTERMC;}

"<dd"[ \t]*">"|"<DD"[ \t]*">"						{yylval.tag = strdup("<DD>");
									return DESCTERMO;}

"</dd"[ \t]*">"|"</DD"[ \t]*">"						{yylval.tag = strdup("</DD>");
									return DESCTERMC;}

"<u"[ \t]*">"|"<U"[ \t]*">"						{yylval.tag = strdup("<U>");
									return UNDERLINEO;}

"</u"[ \t]*">"|"</U"[ \t]*">"						{yylval.tag = strdup("</U>");
									return UNDERLINEC;}

"<b"[ \t]*">"|"<B"[ \t]*">"						{yylval.tag = strdup("<B>");
									return BOLDO;}

"</b"[ \t]*">"|"</B"[ \t]*">"						{yylval.tag = strdup("</B>");
									return BOLDC;}

"<i"[ \t]*">"|"<I"[ \t]*">"						{yylval.tag = strdup("<I>");
									return ITALICO;}

"</i"[ \t]*">"|"</I"[ \t]*">"						{yylval.tag = strdup("</I>");
									return ITALICC;}

"<em"[ \t]*">"|"<EM"[ \t]*">"						{yylval.tag = strdup("<EM>");
									return EMPHO;}

"</em"[ \t]*">"|"</EM"[ \t]*">"						{yylval.tag = strdup("</EM>");
									return EMPHC;}

"<strong"[ \t]*">"|"<STRONG"[ \t]*">"					{yylval.tag = strdup("<STRONG>");
									return STRONGO;}

"</strong"[ \t]*">"|"</STRONG"[ \t]*">"					{yylval.tag = strdup("</STRONG>");
									return STRONGC;}

"<small"[ \t]*">"|"<SMALL"[ \t]*">"					{yylval.tag = strdup("<SMALL>");
									return SMALLO;}

"</small"[ \t]*">"|"</SMALL"[ \t]*">"					{yylval.tag = strdup("</SMALL>");
									return SMALLC;}

"<sub"[ \t]*">"|"<SUB"[ \t]*">"						{yylval.tag = strdup("<SUB>");
									return SUBO;}

"</sub"[ \t]*">"|"</SUB"[ \t]*">"					{yylval.tag = strdup("</SUB>");
									return SUBC;}

"<sup"[ \t]*">"|"<SUP"[ \t]*">"						{yylval.tag = strdup("<SUP>");
									return SUPO;}

"</sup"[ \t]*">"|"</SUP"[ \t]*">"					{yylval.tag = strdup("</SUP>");
									return SUPC;}

"<table"[ \t]*">"|"<TABLE"[ \t]*">"					{yylval.tag = strdup("<TABLE>");
									return TABLEO;}

"</table"[ \t]*">"|"</TABLE"[ \t]*">"					{yylval.tag = strdup("</TABLE>");
									return TABLEC;}

"<th"[ \t]*">"|"<TH"[ \t]*">"						{yylval.tag = strdup("<TH>");
									return TABLEHEADO;}

"</th"[ \t]*">"|"</TH"[ \t]*">"						{yylval.tag = strdup("</TH>");
									return TABLEHEADC;}

"<tr"[ \t]*">"|"<TR"[ \t]*">"						{yylval.tag = strdup("<TR>");
									return TABLEROWO;}

"</tr"[ \t]*">"|"</TR"[ \t]*">"						{yylval.tag = strdup("</TR>");
									return TABLEROWC;}

"<td"[ \t]*">"|"<TD"[ \t]*">"						{yylval.tag = strdup("<TD>");
									return TABLEDATAO;}

"</td"[ \t]*">"|"</TD"[ \t]*">"						{yylval.tag = strdup("</TD>");
									return TABLEDATAC;}

"<caption"[ \t]*">"|"<CAPTION"[ \t]*">"					{yylval.tag = strdup("<CAPTION>");
									return CAPTIONO;}

"</caption"[ \t]*">"|"</CAPTION"[ \t]*">"				{yylval.tag = strdup("</CAPTION>");
									return CAPTIONC;}

"<figcaption"[ \t]*">"|"<FIGCAPTION"[ \t]*">"				{yylval.tag = strdup("<FIGCAPTION>");
									return FIGCAPTIONO;}

"</figcaption"[ \t]*">"|"</FIGCAPTION"[ \t]*">"				{yylval.tag = strdup("</FIGCAPTION>");
									return FIGCAPTIONC;}

"<figure"[ \t]*">"|"<FIGURE"[ \t]*">"					{yylval.tag = strdup("<FIGURE>");
									return FIGUREO;}

"</figure"[ \t]*">"|"</FIGURE"[ \t]*">"					{yylval.tag = strdup("</FIGURE>");
									return FIGUREC;}

%%



/*{strChars}[{strChars}{wSpaceChars}]*					{yylval.s = strdup(yytext);
                                        				return STR;}

{wSpaceChars}               						;


[A-Z0-9a-z,.;/ ]+							{yylval.s = strdup(yytext);
                                        				return STR;}

"\n"|"\t"								;


{strChars}[{strChars}{wSpaceChars}]*					{yylval.s = strdup(yytext);
                                        				return STR;}

{wSpaceChars}               						;

wSpaceChars	[ \t\n]+	
strChars	[A-Z0-9a-z,.;/]+
*/
