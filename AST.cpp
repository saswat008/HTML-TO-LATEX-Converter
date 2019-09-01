#include<iostream>
#include<vector>
#include<string>
#include"AST.h"

using namespace std;

int columns = 0;
bool thead = false;
bool title = false;
int firstRow = 0;
int fr = 0;
bool fcol = true;

astNode* newAst(string nType)	{
					astNode* node = new astNode;
					node->nodeType = nType;
					return node;
				}

/*void traverse (astNode* node,string parent)     {
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
*/

void traverse (latexNode* node,string parent)     	{
                                                        	if (node == NULL)
                                                                	cout<<"Empty";
                                                        	else
                                                        	{
                                                                	cout<<node->nodeType<<"\t \t"<<parent<<"\n \n";
                                                                	vector<latexNode*>::iterator ptr;
                                                                	int i;
                                                                	for (i=1, ptr = node->child.begin(); ptr!= node->child.end(); i++,ptr++)
                                                                	{
                                                                        	cout<<"child"<<i<<endl;
                                                                        	traverse(*ptr, node->nodeType);
                                                                	}
                                                        	}
                                                	}

latexNode* convert (astNode* node)			{
                                                        	if (node == NULL)
                                                                	return NULL;
                                                        	else
                                                        	{
									//cout<<node->nodeType<<"\t \t"<<parent<<"\n \n";
                                                                	if(node->nodeType == "HTML")
									{
										latexNode* temp = createLatexNode("docClass");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "HEAD")
									{
										vector <astNode*>::iterator ptr;
      										for(ptr = node->child.begin(); ptr!= node->child.end(); ptr++)
        									{
       											latexNode* newChild = convert(*ptr);
                									if(newChild != NULL)
                										return newChild;
       										}
										return NULL;
									}

									else if(node->nodeType == "TITLE")
									{
										latexNode* temp = createLatexNode("title");
										temp->value = node->value;
										return temp;
									}

									else if(node->nodeType == "BODY")
									{
										latexNode* temp = createLatexNode("document");
                                                                                addChildren(temp, node);
                                                                                return temp;
									}

									else if(node->nodeType == "P")
									{
										latexNode* temp = createLatexNode("para");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "UL")
									{
										latexNode* temp = createLatexNode("itemize");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "OL")
									{
										latexNode* temp = createLatexNode("enumerate");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "LI")
									{
										latexNode* temp = createLatexNode("item");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "BR")
									{
										latexNode* temp = createLatexNode("linebreak");
										return temp;
									}

									else if(node->nodeType == "CENTER")
									{
										latexNode* temp = createLatexNode("centering");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "H1")
									{
										latexNode* temp = createLatexNode("section*");
										addChildren(temp, node);
										return temp;
									}
									
									else if(node->nodeType == "H2")
									{
										latexNode* temp = createLatexNode("subsection*");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "H3"|| node->nodeType =="H4"|| node->nodeType =="H5"|| node->nodeType =="H6")
									{
										latexNode* temp = createLatexNode("subsubsection*");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "U")
									{
										latexNode* temp = createLatexNode("uLine");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "B")
									{
										latexNode* temp = createLatexNode("textbf");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "I")
									{
										latexNode* temp = createLatexNode("textit");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "EM")
									{
										latexNode* temp = createLatexNode("emph");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "TT")
									{
										latexNode* temp = createLatexNode("texttt");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "STRONG")
									{
										latexNode* temp = createLatexNode("textbf");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "SMALL")
									{
										latexNode* temp = createLatexNode("small");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "SUB")
									{
										latexNode* temp = createLatexNode("subscript");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "SUP")
									{
										latexNode* temp = createLatexNode("superscript");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "FONT")
									{
										latexNode* temp = createLatexNode("font");
										if(!node->attribute.empty())
										{
											astNode* temph = node->attribute.front();
											if(temph->nodeType == "SIZE")
											{
												if(temph->nodeType == "1")
												{
													latexNode* att = createLatexNode("scriptsize");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "2")
												{
													latexNode* att = createLatexNode("footnotesize");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "3")
												{
													latexNode* att = createLatexNode("small");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "4")
												{
													latexNode* att = createLatexNode("normalsize");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "5")
												{
													latexNode* att = createLatexNode("large");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "6")
												{
													latexNode* att = createLatexNode("Large");
													temp->attribute.push_back(att);
												}
												if(temph->nodeType == "7")
												{
													latexNode* att = createLatexNode("LARGE");
													temp->attribute.push_back(att);
												}
											}
										}
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "A")
									{
										latexNode* temp = createLatexNode("A");
										if(!node->attribute.empty())
										{
											astNode* temph = node->attribute.front();
											if(temph->nodeType == "HREF")
											{
												latexNode* att = createLatexNode("HREF");
												att->value = temph->value;
												temp->attribute.push_back(att);
											}
										}
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "DL")
									{
										latexNode* temp = createLatexNode("descList");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "DT")
									{
										latexNode* temp = createLatexNode("descItem");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "DD")
									{
										latexNode* temp = createLatexNode("descData");
										addChildren(temp, node);
										return temp;	
									}

									else if(node->nodeType == "IMG")
									{
										latexNode* temp = createLatexNode("img");
										vector <astNode*>::iterator ptr;
										for(ptr = node->attribute.begin(); ptr!=node->attribute.end(); ptr++)
										{
											if((*ptr)->nodeType == "HEIGHT")
											{
												latexNode* att = createLatexNode("height");
												att->value = (*ptr)->value;
												temp->attribute.push_back(att);
											}
											else if((*ptr)->nodeType == "WIDTH")
											{
												latexNode* att = createLatexNode("width");
												att->value = (*ptr)->value;
												temp->attribute.push_back(att);
											}
											else if((*ptr)->nodeType == "SRC")
											{
												latexNode* att = createLatexNode("src");
												att->value = (*ptr)->value;
												temp->attribute.push_back(att);
											}

										}
										return temp;
									}

									else if(node->nodeType == "FIGURE")
									{
										latexNode* temp = createLatexNode("figure");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "FIGCAPTION")
									{
										latexNode* temp = createLatexNode("fcaption");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "STRING")
									{
										latexNode* temp = createLatexNode("content");
										temp->value = node->value;
										return temp;	
									}
									
									else if(node->nodeType == "DIV")
									{
										latexNode* temp = createLatexNode("div");
										addChildren(temp, node);
										return temp;
									}

									else if(node->nodeType == "TABLE")
									{
										latexNode* temp = createLatexNode("table");
                                                                                addChildren(temp, node);
                                                                                return temp;
									}

									else if(node->nodeType == "CAPTION")
									{
										latexNode* temp = createLatexNode("tcaption");
                                                                                addChildren(temp, node);
                                                                                return temp;
									}

									else if(node->nodeType == "TR")
									{
										if(firstRow == 0 && fr == 0)
										{
											firstRow = 1; fr = 1;
										}
										latexNode* temp = createLatexNode("trow");
                                                                                addChildren(temp, node);
										firstRow = 0;
                                                                                return temp;	
									}

									else if(node->nodeType == "TH")
									{
										++columns;
										thead = true;
										latexNode* temp = createLatexNode("thead");
                                                                                addChildren(temp, node);
                                                                                return temp;
									}

									else if(node->nodeType == "TD")
									{	
										if(thead == false && firstRow == 1)
											++columns;
										latexNode*temp = createLatexNode("tdata");
                                                                                addChildren(temp, node);
                                                                                return temp;
									}
                                                        	}
                                                	}

latexNode* createLatexNode(string Type)			{
								latexNode* temp = new latexNode;
								temp->nodeType = Type;
								return temp;
							}

void addChildren(latexNode* templ, astNode* nodeh)	{
								vector <astNode*>::iterator ptr;
      								for(ptr = nodeh->child.begin(); ptr!= nodeh->child.end(); ptr++)
        							{
       									latexNode* newChild = convert(*ptr);
                							if(newChild != NULL)
                								templ->child.push_back(newChild);
       								}
							}

void produceLatexCode(latexNode* node)			{
								if (node->nodeType == "docClass")
								{
									cout<<"\\documentclass{article}"<<endl;
									cout<<"\\usepackage{hyperref}"<<endl;
									cout<<"\\usepackage{graphicx}"<<endl;
									produceChildren(node);
								}

								else if(node->nodeType == "title")
								{
									title = true;
									cout<<"\\title{"<<node->value<<"}"<<endl;
								}

								else if(node->nodeType == "document")
								{
									cout<<"\\begin{document}"<<endl;
									if(title == true)
										cout<<"\\maketitle"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{document}"<<endl;
								}

								else if(node->nodeType == "para")
								{
									cout<<"\n \n";
									produceChildren(node);
								}

								else if(node->nodeType == "content")
								{
									cout<<node->value<<" ";
								}

								else if(node->nodeType == "itemize")
								{
									cout<<endl<<"\\begin{itemize}"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{itemize}"<<endl;
								}

								else if(node->nodeType == "enumerate")
								{
									cout<<endl<<"\\begin{enumerate}"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{enumerate}"<<endl;
								}

								else if(node->nodeType == "item")
								{
									cout<<endl<<"\\item ";
									produceChildren(node);
								}

								else if(node->nodeType == "linebreak")
								{
									cout<<"\\linebreak ";
								}

								else if(node->nodeType == "centering")
								{
									cout<<"\\centering ";
									produceChildren(node);
									cout<<"\\raggedright ";
								}

								else if(node->nodeType == "section*")
								{
									cout<<endl<<"\\section*{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "subsection*")
								{
									cout<<endl<<"\\subsection*{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "subsubsection*")
								{
									cout<<endl<<"\\subsubsection*{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "uLine")
								{
									cout<<"\\underline{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "textbf")
								{
									cout<<"\\textbf{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "textit")
								{
									cout<<"\\textit{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "texttt")
								{
									cout<<"\\texttt{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "emph")
								{
									cout<<"\\emph{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "small")
								{
									cout<<"\\small{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "subscript")
								{
									cout<<"\\textsubscript{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node-> nodeType == "superscript")
								{
									cout<<"\\textsuperscript{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "font")
								{
									if(!node->attribute.empty())
									{
										latexNode* temp = node->attribute.front();
										if(temp->nodeType == "scriptsize")
											cout<<"\\scriptsize ";
										else if(temp->nodeType == "footnotesize")
											cout<<"\\footnotesize ";
										else if(temp->nodeType == "small")
											cout<<"\\small ";
										else if(temp->nodeType == "normalsize")
											cout<<"\\normalsize";
										else if(temp->nodeType == "large")
											cout<<"\\large ";
										else if(temp->nodeType == "Large")
											cout<<"\\Large ";
										else if(temp->nodeType == "LARGE")
											cout<<"\\LARGE ";
									}
									produceChildren(node);
									cout<<"\\normalsize "<<endl;
								}

								else if(node->nodeType == "A")
								{
									if(!node->attribute.empty())
									{
										latexNode* temp = node->attribute.front();
										if(temp->nodeType == "HREF")
										{
											cout<<"\\href{"<<temp->value<<"}{";
											produceChildren(node);
											cout<<"} ";
										}
									}
									else
										produceChildren(node);
								}

								else if(node->nodeType == "descList")
								{
									cout<<endl<<"\\begin{description}"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{description}"<<endl;
								}

								else if(node->nodeType == "descItem")
								{
									cout<<"\\item[";
									produceChildren(node);
								}

								else if(node->nodeType == "descData")
								{
									cout<<"] \\hfill \\\\ ";
									produceChildren(node);
									cout<<endl;
								}

								else if(node->nodeType == "img")
								{
									cout<<"\\includegraphics[";
									vector <latexNode*>::iterator ptr;
                                                                                for(ptr = node->attribute.begin(); ptr!=node->attribute.end(); ptr++)
                                                                                {
                                                                                        if((*ptr)->nodeType == "height")
                                                                                        {
                                                                                                cout<<"height="<<(*ptr)->value<<",";
                                                                                        }
                                                                                        else if((*ptr)->nodeType == "width")
                                                                                        {
                                                                                                cout<<"width="<<(*ptr)->value<<",";
                                                                                        }
                                                                                        else if((*ptr)->nodeType == "src")
                                                                                        {
												cout<<"]{"<<(*ptr)->value<<"} ";
                                                                                        }

                                                                                }
										cout<<endl;
								}

								else if(node->nodeType == "figure")
								{
									cout<<endl<<"\\begin{figure}[h!]"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{figure}"<<endl;
								}

								else if(node->nodeType == "fcaption")
								{
									cout<<"\\caption{";
									produceChildren(node);
									cout<<"} "<<endl;
								}

								else if(node->nodeType == "div")
								{
									cout<<"\n";
									produceChildren(node);
								}

								else if(node->nodeType == "table")
								{
									cout<<endl<<"\\begin{table}[!ht]"<<endl;
									produceChildren(node);
									cout<<endl<<"\\end{tabular}"<<endl<<"\\end{table}"<<endl;
								}

								else if(node->nodeType == "tcaption")
								{
									cout<<"\\caption{";
									produceChildren(node);
									cout<<"}"<<endl;
								}

								else if(node->nodeType == "trow")
								{
									if(firstRow == 0)
									{
										firstRow = 1;
										cout<<"\\begin{tabular}{";
										int i;
										for(i=1;i<=columns;i++)
										{
											cout<<"|c";
										}
										cout<<"|}"<<endl;
										produceChildren(node);
										fcol = true;
									}
									else
									{
										cout<<" \\\\"<<endl;
										produceChildren(node);
									}
								}

								else if(node->nodeType == "thead")
								{
									if(fcol == true)
									{
										produceChildren(node);
										fcol = false;
									}
									else
									{
										cout<<" & ";
										produceChildren(node);
									}
								}

								else if(node->nodeType == "tdata")
								{
									if(fcol == true)
									{
										produceChildren(node);
										fcol = false;
									}
									else
									{
										cout<<" & ";
										produceChildren(node);
									}
								}

							}

void produceChildren(latexNode* nodel)		{
								if(nodel != NULL)
								{
									vector<latexNode*>::iterator ptr;
									for(ptr = nodel->child.begin(); ptr!=nodel->child.end(); ptr++)
									{
										produceLatexCode(*ptr);
									}
								}
							}




/*vector <astNode*>::iterator ptr;
	for(ptr = node->child.begin(); ptr!= node->child.end(); ptr++)
	{
		latexNode* newChild = traverse(*ptr,"HTML");
		if(newChild != NULL)
			temp->child.push_back(newChild);
	}*/
