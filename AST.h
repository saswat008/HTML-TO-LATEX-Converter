#include<iostream>
#include<vector>
#include<string>
#include<fstream>
using namespace std;

struct astNode	{
			string nodeType;
			vector<astNode*> attribute;
			string value;
			vector<astNode*> child;
		};

struct latexNode{
			string nodeType;
			vector<latexNode*> attribute;
			string value;
			vector<latexNode*> child;
		};

astNode* newAst(string);

latexNode* convert(astNode*);

latexNode* createLatexNode(string);

void addChildren(latexNode*,astNode*);

void produceLatexCode(latexNode*, FILE*);

void produceChildren(latexNode*, FILE*);
