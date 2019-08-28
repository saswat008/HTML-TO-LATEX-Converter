%{
#include"string.h"
#include"cop1.tab.h"
%}

%x fontStart fontMiddle ahStart ahMiddle srcStart srcPath hStart hSize wStart wSize comStart comEnd
%option caseless
wSpaceChars	[ \t\n]+
strChars	[a-zA-Z0-9/.:_ ,;\\?'"]+
specialChars	[{}_\^@\$\\%~#&]+
stringChars	({specialChars}|{strChars})({wSpaceChars}({strChars}|specialChars))*


%%
"<!--"									{BEGIN comStart;}

<comStart>[^-]								;

<comStart>"--"								{BEGIN comEnd;}

<comEnd>">"								{BEGIN INITIAL;}

<comEnd>[^>]								{BEGIN comStart;}


">"									{yylval.tag = ">";
                                        				return IMGEND;}

"<!DOCTYPE "[ \t]*"html".*">"           				{yylval.tag = "<!DOCTYPE html>";
                                        				return DOCTYP;}

"<HTML"[ \t]*">"|"<html"[ \t]*">"           				{yylval.tag = "<HTML>";
                                        				return HTMLO;}

"</HTML"[ \t]*">"|"</html"[ \t]*">"         				{yylval.tag = "</HTML>";
                                        				return HTMLC;}

"<HEAD"[ \t]*">"|"<head"[ \t]*">"           				{yylval.tag = "<HEAD>";
                                        				return HEADO;}

"</HEAD"[ \t]*">"|"</head"[ \t]*">"         				{yylval.tag = "</HEAD>";
                                        				return HEADC;}

"<TITLE"[ \t]*">"|"<title"[ \t]*">"         				{yylval.tag = "<TITLE>";
                                        				return TITLEO;}

"</TITLE"[ \t]*">"|"</title"[ \t]*">"       				{yylval.tag = "</TITLE>";
                                        				return TITLEC;}

"<BODY"[ \t]*">"|"<body"[ \t]*">"           				{yylval.tag = "<BODY>";
                                        				return BODYO;}

"</BODY"[ \t]*">"|"</body"[ \t]*">"         				{yylval.tag = "</BODY>";
                                        				return BODYC;}

"<P"[ \t]*">"|"<p"[ \t]*">"                 				{yylval.tag = "<P>";
                                        				return PARAGRAPHO;}

"</P"[ \t]*">"|"</p"[ \t]*">"               				{yylval.tag = "</P>";
                                        				return PARAGRAPHC;}

"<font "[ \t]*"size"[ \t]*"="[ \t]*"\""					{yylval.tag = "<FONT SIZE=\"";
									BEGIN fontStart;
									return FONTOFIRST;}

<fontStart>[0-7]							{yylval.s = strdup(yytext);
									BEGIN fontMiddle;
									return FONTOMIDDLE;}

<fontMiddle>"\""[ \t]*">"						{yylval.tag = "\">";
									BEGIN INITIAL;
									return FONTOEND;}

"</font"[ \t]*">"|"</FONT"[ \t]*">"         				{yylval.tag = "</FONT>";
                                        				return FONTC;}

"<font"[ \t]*">"|"<FONT"[ \t]*">"         				{yylval.tag = "<FONT>";
                                        				return FONTO;}

"<a "[ \t]*"href"[ \t]*"="[ \t]*"\""					{yylval.tag = "<A HREF=\"";
									BEGIN ahStart;
									return AHOFIRST;}

<ahStart>[a-zA-Z0-9/.:_~ ,;\\?#]+						{yylval.s = strdup(yytext);
									BEGIN ahMiddle;
									return AHOMIDDLE;}

<ahMiddle>"\""[ \t]*">"							{yylval.tag = "\">";
									BEGIN INITIAL;
									return AHOEND;}

"</a"[ \t]*">"|"</A"[ \t]*">"         					{yylval.tag = "</A>";
                                        				return AHC;}

"<a"[ \t]*">"|"<A"[ \t]*">"         					{yylval.tag = "<A>";
                                        				return AO;}

"<img "[ \t]*								{yylval.tag = "<IMG ";
                                        				return IMGO;}

"src"[ \t]*"="[ \t]*"\""						{yylval.tag = "SRC =\"";
									BEGIN srcStart;
									return SRCFIRST;}

<srcStart>[a-zA-Z0-9/.:_~ ,;\\?#]+					{yylval.s = strdup(yytext);
									BEGIN srcPath;
									return SRCPATH;}

<srcPath>"\""[ \t]*							{yylval.tag = "\" ";
									BEGIN INITIAL;
									return SRCEND;}

"height"[ \t]*"="[ \t]*"\""						{yylval.tag = "HEIGHT =\"";
									BEGIN hStart;
									return HFIRST;}

<hStart>[0-9]+								{yylval.s = strdup(yytext);
									BEGIN hSize;
									return HSIZE;}

<hSize>"\""[ \t]*							{yylval.tag = "\" ";
									BEGIN INITIAL;
									return HEND;}

"width"[ \t]*"="[ \t]*"\""						{yylval.tag = "WIDTH =\"";
									BEGIN wStart;
									return WFIRST;}

<wStart>[0-9]+								{yylval.s = strdup(yytext);
									BEGIN wSize;
									return WSIZE;}

<wSize>"\""[ \t]*							{yylval.tag = "\" ";
									BEGIN INITIAL;
									return WEND;}

{stringChars}								{yylval.s = strdup(yytext);
                                        				return STR;}

{wSpaceChars}               						;

"<h1"[ \t]*">"|"<H1"[ \t]*">"						{yylval.tag = "<H1>";
									return HEADER1O;}

"<h2"[ \t]*">"|"<H2"[ \t]*">"						{yylval.tag = "<H2>";
									return HEADER2O;}

"<h3"[ \t]*">"|"<H3"[ \t]*">"						{yylval.tag = "<H3>";
									return HEADER3O;}

"<h4"[ \t]*">"|"<H4"[ \t]*">"						{yylval.tag = "<H4>";
									return HEADER4O;}

"<h5"[ \t]*">"|"<H5"[ \t]*">"						{yylval.tag = "<H5>";
									return HEADER5O;}

"<h6"[ \t]*">"|"<H6"[ \t]*">"						{yylval.tag = "<H6>";
									return HEADER6O;}

"</h1"[ \t]*">"|"</H1"[ \t]*">"						{yylval.tag = "</H1>";
									return HEADER1C;}

"</h2"[ \t]*">"|"</H2"[ \t]*">"						{yylval.tag = "</H2>";
									return HEADER2C;}

"</h3"[ \t]*">"|"</H3"[ \t]*">"						{yylval.tag = "</H3>";
									return HEADER3C;}

"</h4"[ \t]*">"|"</H4"[ \t]*">"						{yylval.tag = "</H4>";
									return HEADER4C;}

"</h5"[ \t]*">"|"</H5"[ \t]*">"						{yylval.tag = "</H5>";
									return HEADER5C;}

"</h6"[ \t]*">"|"</H6"[ \t]*">"						{yylval.tag = "</H6>";
									return HEADER6C;}

"<div"[ \t]*">"|"<DIV"[ \t]*">"						{yylval.tag = "<DIV>";
									return DIVISIONO;}

"</div"[ \t]*">"|"</DIV"[ \t]*">"					{yylval.tag = "</DIV>";
									return DIVISIONC;}

"<tt"[ \t]*">"|"<TT"[ \t]*">"						{yylval.tag = "<TT>";
									return TLTYPO;}

"</tt"[ \t]*">"|"</TT"[ \t]*">"						{yylval.tag = "</TT>";
									return TLTYPC;}

"<center"[ \t]*">"|"<CENTER"[ \t]*">"					{yylval.tag = "<CENTER>";
									return CENTERO;}

"</center"[ \t]*">"|"</CENTER"[ \t]*">"					{yylval.tag = "</CENTER>";
									return CENTERC;}

"<br"[ \t]*">"|"<BR"[ \t]*">"						{yylval.tag = "<BR>";
									return BREAKLINE;}

"<ul"[ \t]*">"|"<UL"[ \t]*">"						{yylval.tag = "<UL>";
									return UNORDLISTO;}

"</ul"[ \t]*">"|"</UL"[ \t]*">"						{yylval.tag = "</UL>";
									return UNORDLISTC;}

"<ol"[ \t]*">"|"<OL"[ \t]*">"						{yylval.tag = "<OL>";
									return ORDLISTO;}

"</ol"[ \t]*">"|"</OL"[ \t]*">"						{yylval.tag = "</OL>";
									return ORDLISTC;}

"<li"[ \t]*">"|"<LI"[ \t]*">"						{yylval.tag = "<LI>";
									return LISTO;}

"</li"[ \t]*">"|"</LI"[ \t]*">"						{yylval.tag = "</LI>";
									return LISTC;}

"<dl"[ \t]*">"|"<DL"[ \t]*">"						{yylval.tag = "<DL>";
									return DESCLISTO;}

"</dl"[ \t]*">"|"</DL"[ \t]*">"						{yylval.tag = "</DL>";
									return DESCLISTC;}

"<dt"[ \t]*">"|"<DT"[ \t]*">"						{yylval.tag = "<DT>";
									return DEFTERMO;}

"</dt"[ \t]*">"|"</DT"[ \t]*">"						{yylval.tag = "</DT>";
									return DEFTERMC;}

"<dd"[ \t]*">"|"<DD"[ \t]*">"						{yylval.tag = "<DD>";
									return DESCTERMO;}

"</dd"[ \t]*">"|"</DD"[ \t]*">"						{yylval.tag = "</DD>";
									return DESCTERMC;}

"<u"[ \t]*">"|"<U"[ \t]*">"						{yylval.tag = "<U>";
									return UNDERLINEO;}

"</u"[ \t]*">"|"</U"[ \t]*">"						{yylval.tag = "</U>";
									return UNDERLINEC;}

"<b"[ \t]*">"|"<B"[ \t]*">"						{yylval.tag = "<B>";
									return BOLDO;}

"</b"[ \t]*">"|"</B"[ \t]*">"						{yylval.tag = "</B>";
									return BOLDC;}

"<i"[ \t]*">"|"<I"[ \t]*">"						{yylval.tag = "<I>";
									return ITALICO;}

"</i"[ \t]*">"|"</I"[ \t]*">"						{yylval.tag = "</I>";
									return ITALICC;}

"<em"[ \t]*">"|"<EM"[ \t]*">"						{yylval.tag = "<EM>";
									return EMPHO;}

"</em"[ \t]*">"|"</EM"[ \t]*">"						{yylval.tag = "</EM>";
									return EMPHC;}

"<strong"[ \t]*">"|"<STRONG"[ \t]*">"					{yylval.tag = "<STRONG>";
									return STRONGO;}

"</strong"[ \t]*">"|"</STRONG"[ \t]*">"					{yylval.tag = "</STRONG>";
									return STRONGC;}

"<small"[ \t]*">"|"<SMALL"[ \t]*">"					{yylval.tag = "<SMALL>";
									return SMALLO;}

"</small"[ \t]*">"|"</SMALL"[ \t]*">"					{yylval.tag = "</SMALL>";
									return SMALLC;}

"<sub"[ \t]*">"|"<SUB"[ \t]*">"						{yylval.tag = "<SUB>";
									return SUBO;}

"</sub"[ \t]*">"|"</SUB"[ \t]*">"					{yylval.tag = "</SUB>";
									return SUBC;}

"<sup"[ \t]*">"|"<SUP"[ \t]*">"						{yylval.tag = "<SUP>";
									return SUPO;}

"</sup"[ \t]*">"|"</SUP"[ \t]*">"					{yylval.tag = "</SUP>";
									return SUPC;}

"<table"[ \t]*">"|"<TABLE"[ \t]*">"					{yylval.tag = "<TABLE>";
									return TABLEO;}

"</table"[ \t]*">"|"</TABLE"[ \t]*">"					{yylval.tag = "</TABLE>";
									return TABLEC;}

"<th"[ \t]*">"|"<TH"[ \t]*">"						{yylval.tag = "<TH>";
									return TABLEHEADO;}

"</th"[ \t]*">"|"</TH"[ \t]*">"						{yylval.tag = "</TH>";
									return TABLEHEADC;}

"<tr"[ \t]*">"|"<TR"[ \t]*">"						{yylval.tag = "<TR>";
									return TABLEROWO;}

"</tr"[ \t]*">"|"</TR"[ \t]*">"						{yylval.tag = "</TR>";
									return TABLEROWC;}

"<td"[ \t]*">"|"<TD"[ \t]*">"						{yylval.tag = "<TD>";
									return TABLEDATAO;}

"</td"[ \t]*">"|"</TD"[ \t]*">"						{yylval.tag = "</TD>";
									return TABLEDATAC;}

"<caption"[ \t]*">"|"<CAPTION"[ \t]*">"					{yylval.tag = "<CAPTION>";
									return CAPTIONO;}

"</caption"[ \t]*">"|"</CAPTION"[ \t]*">"				{yylval.tag = "</CAPTION>";
									return CAPTIONC;}

"<figcaption"[ \t]*">"|"<FIGCAPTION"[ \t]*">"				{yylval.tag = "<FIGCAPTION>";
									return FIGCAPTIONO;}

"</figcaption"[ \t]*">"|"</FIGCAPTION"[ \t]*">"				{yylval.tag = "</FIGCAPTION>";
									return FIGCAPTIONC;}

"<figure"[ \t]*">"|"<FIGURE"[ \t]*">"					{yylval.tag = "<FIGURE>";
									return FIGUREO;}

"</figure"[ \t]*">"|"</FIGURE"[ \t]*">"					{yylval.tag = "</FIGURE>";
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
