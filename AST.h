#include<iostream>
#include<vector>
#include<string>
using namespace std;

/*enum NodeType	{ 
	ROOT,DOCTYPE, HTML, HEAD, TITLE, BODY, ULIST, OLIST, LIST, B, U, I, EM, SMALL, STRONG, SUP, SUB, BR, CENTER, TT, H1, H2, H3, H4, H5, H6, P, DIV, DL, DT, DD, TABLE, FIGURE, CAPTION, TR, TH, TD, FIGCAP, IMG, SRC, HEIGHT, WIDTH, A, HREF, FONT, SIZE 
};*/


struct astNode	{
			string nodeType;
			vector<astNode*> attribute;
			string value;
			vector<astNode*> child;
		};

//astNode* newAst();
astNode* newAst(string);

void traverse(astNode*,string);
