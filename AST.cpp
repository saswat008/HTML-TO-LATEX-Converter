#include<iostream>
#include<vector>
#include<string>
#include"AST.h"

using namespace std;

astNode* newAst(string nType)	{
					astNode* node = new astNode;
					node->nodeType = nType;
					return node;
				}

void traverse (astNode* node,string parent)     {
                                                        if (node == NULL)
                                                                cout<<"Empty";
                                                        else
                                                        {
                                                                cout<<node->nodeType<<"\t \t"<<parent<<"\n \n";
                                                                vector<astNode*>::iterator ptr;
                                                                int i;
                                                                for (i=1, ptr = node->child.begin(); ptr!= node->child.end(); i++,ptr++)
                                                                {
                                                                        cout<<"child"<<i<<endl;
                                                                        traverse(*ptr, node->nodeType);
                                                                }
                                                        }

                                                }
