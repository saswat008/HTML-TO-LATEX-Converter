#include<iostream>
#include<vector>
#include<string>
#include<cstdio>
#include"AST.h"

using namespace std;

bool title = false;
int columns = 0;
bool thead = false;
int firstRow = 0;
int fr = 0;
bool fcol = true;
int col = 0;

astNode* newAst(string nType)	{
					astNode* node = new astNode;
					node->nodeType = nType;
					return node;
				}


latexNode* convert (astNode* node)			{
                                                        	if (node == NULL)
                                                                	return NULL;
                                                        	else
                                                        	{
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
												if(temph->value == "1")
												{
													latexNode* att = createLatexNode("scriptsize");
													temp->attribute.push_back(att);
												}
												if(temph->value == "2")
												{
													latexNode* att = createLatexNode("footnotesize");
													temp->attribute.push_back(att);
												}
												if(temph->value == "3")
												{
													latexNode* att = createLatexNode("small");
													temp->attribute.push_back(att);
												}
												if(temph->value == "4")
												{
													latexNode* att = createLatexNode("normalsize");
													temp->attribute.push_back(att);
												}
												if(temph->value == "5")
												{
													latexNode* att = createLatexNode("large");
													temp->attribute.push_back(att);
												}
												if(temph->value == "6")
												{
													latexNode* att = createLatexNode("Large");
													temp->attribute.push_back(att);
												}
												if(temph->value == "7")
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
										firstRow = 0; fr = 0;
										temp->value = to_string(columns);
										columns = 0;
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

									else if(node->nodeType == "SYMBOL")
									{
										latexNode* temp = createLatexNode("symbol");
										temp->value = node->value;
                                                                                return temp;
									}

									else if(node->nodeType == "SPECIAL")
									{
										latexNode* temp = createLatexNode("special");
										temp->value = node->value;
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

void produceLatexCode(latexNode* node, FILE *fpO)	{
								if (node->nodeType == "docClass")
								{
									fprintf(fpO,"%s\n","\\documentclass{article}");
									fprintf(fpO,"%s\n","\\usepackage{hyperref}");
									fprintf(fpO,"%s\n","\\usepackage{graphicx}");
									produceChildren(node,fpO);
								}

								else if(node->nodeType == "title")
								{
									title = true;
									fprintf(fpO,"%s%s%s\n","\\title{",node->value.c_str(),"}");
								}

								else if(node->nodeType == "document")
								{
									fprintf(fpO,"%s\n","\\begin{document}");
									if(title == true)
										fprintf(fpO,"%s\n","\\maketitle ");
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n","\\end{document}");
								}

								else if(node->nodeType == "para")
								{
									fprintf(fpO,"%s","\n\n");
									produceChildren(node,fpO);
								}

								else if(node->nodeType == "content")
								{
									fprintf(fpO,"%s",node->value.c_str());
								}

								else if(node->nodeType == "itemize")
								{
									fprintf(fpO,"\n%s\n","\\begin{itemize}");
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n","\\end{itemize}");
								}

								else if(node->nodeType == "enumerate")
								{
									fprintf(fpO,"\n%s\n","\\begin{enumerate}");
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n","\\end{enumerate}");
								}

								else if(node->nodeType == "item")
								{
									fprintf(fpO,"\n%s","\\item ");
									produceChildren(node,fpO);
								}

								else if(node->nodeType == "linebreak")
								{
									fprintf(fpO,"%s","\\\\");
								}

								else if(node->nodeType == "centering")
								{
									fprintf(fpO,"%s","\\centering ");
									produceChildren(node,fpO);
									fprintf(fpO,"%s","\\raggedright ");
								}

								else if(node->nodeType == "section*")
								{
									fprintf(fpO,"\n%s","\\section*{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "subsection*")
								{
									fprintf(fpO,"\n%s","\\subsection*{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "subsubsection*")
								{
									fprintf(fpO,"\n%s","\\subsubsection*{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "uLine")
								{
									fprintf(fpO,"%s","\\underline{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "textbf")
								{
									fprintf(fpO,"%s","\\textbf{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "textit")
								{
									fprintf(fpO,"%s","\\textit{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "texttt")
								{
									fprintf(fpO,"%s","\\texttt{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "emph")
								{
									fprintf(fpO,"%s","\\emph{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "small")
								{
									fprintf(fpO,"%s","\\small{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "subscript")
								{
									fprintf(fpO,"%s","\\textsubscript{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node-> nodeType == "superscript")
								{
									fprintf(fpO,"%s","\\textsuperscript{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");	
								}

								else if(node->nodeType == "font")
								{
									if(!node->attribute.empty())
									{
										latexNode* temp = node->attribute.front();
										if(temp->nodeType == "scriptsize")
											fprintf(fpO,"%s","\\scriptsize ");
										else if(temp->nodeType == "footnotesize")
											fprintf(fpO,"%s","\\footnotesize ");
										else if(temp->nodeType == "small")
											fprintf(fpO,"%s","\\small ");
										else if(temp->nodeType == "normalsize")
											fprintf(fpO,"%s","\\normalsize");
										else if(temp->nodeType == "large")
											fprintf(fpO,"%s","\\large ");
										else if(temp->nodeType == "Large")
											fprintf(fpO,"%s","\\Large ");
										else if(temp->nodeType == "LARGE")
											fprintf(fpO,"%s","\\LARGE ");
									}
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","\\normalsize ");
								}

								else if(node->nodeType == "A")
								{
									if(!node->attribute.empty())
									{
										latexNode* temp = node->attribute.front();
										if(temp->nodeType == "HREF")
										{
											fprintf(fpO,"%s%s%s","\\href{",temp->value.c_str(),"}{");
											produceChildren(node,fpO);
											fprintf(fpO,"%s","} ");
										}
									}
									else
										produceChildren(node,fpO);
								}

								else if(node->nodeType == "descList")
								{
									fprintf(fpO,"\n%s\n","\\begin{description}");
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n","\\end{description}");
								}

								else if(node->nodeType == "descItem")
								{
									fprintf(fpO,"%s","\\item[");
									produceChildren(node,fpO);
								}

								else if(node->nodeType == "descData")
								{
									fprintf(fpO,"%s","] \\hfill \\\\ ");
									produceChildren(node,fpO);
									fprintf(fpO,"%s","\n");
								}

								else if(node->nodeType == "img")
								{
									fprintf(fpO,"%s","\\includegraphics[");
									vector <latexNode*>::iterator ptr;
                                                                                for(ptr = node->attribute.begin(); ptr!=node->attribute.end(); ptr++)
                                                                                {
                                                                                        if((*ptr)->nodeType == "height")
                                                                                        {
                                                                                                fprintf(fpO,"%s%s%s","height=",(*ptr)->value.c_str(),"mm,");
                                                                                        }
                                                                                        else if((*ptr)->nodeType == "width")
                                                                                        {
                                                                                                fprintf(fpO,"%s%s%s","width=",(*ptr)->value.c_str(),"mm,");
                                                                                        }
                                                                                        else if((*ptr)->nodeType == "src")
                                                                                        {
												fprintf(fpO,"%s%s%s","]{",(*ptr)->value.c_str(),"} ");
                                                                                        }

                                                                                }
										fprintf(fpO,"%s","\n");
								}

								else if(node->nodeType == "figure")
								{
									fprintf(fpO,"\n%s\n","\\begin{figure}[h!]");
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n","\\end{figure}");
								}

								else if(node->nodeType == "fcaption")
								{
									fprintf(fpO,"%s","\\caption{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","} ");
								}

								else if(node->nodeType == "div")
								{
									fprintf(fpO,"%s","\n");
									produceChildren(node,fpO);
								}

								else if(node->nodeType == "table")
								{
									fprintf(fpO,"\n\n%s\n","\\begin{table}");
									col = stoi(node->value);
									produceChildren(node,fpO);
									fprintf(fpO,"\n%s\n%s","\\end{tabular}","\\end{table}");
									firstRow = 0;
									fcol = true;
								}

								else if(node->nodeType == "tcaption")
								{
									fprintf(fpO,"%s","\\caption{");
									produceChildren(node,fpO);
									fprintf(fpO,"%s\n","}");
								}

								else if(node->nodeType == "trow")
								{
									if(firstRow == 0)
									{
										firstRow = 1;
										fprintf(fpO,"%s","\\begin{tabular}{");
										for(int i=1;i<=col;i++)
										{
											fprintf(fpO,"%s","|c");
										}
										col = 0;
										fprintf(fpO,"%s\n","|}");
										produceChildren(node,fpO);
										fcol = true;
									}
									else
									{
										fprintf(fpO,"%s\n"," \\\\");
										produceChildren(node,fpO);
										fcol = true;
									}
								}

								else if(node->nodeType == "thead")
								{
									if(fcol == true)
									{
										produceChildren(node,fpO);
										fcol = false;
									}
									else
									{
										fprintf(fpO,"%s"," & ");
										produceChildren(node,fpO);
										fcol = true;
									}
								}

								else if(node->nodeType == "tdata")
								{
									if(fcol == true)
									{
										produceChildren(node,fpO);
										fcol = false;
									}
									else
									{
										fprintf(fpO,"%s"," & ");
										produceChildren(node,fpO);
									}
								}

								else if(node->nodeType == "symbol")
								{
									if(node->value == "Alpha")
										fprintf(fpO,"%s ","A");
									else
										fprintf(fpO,"%s%s%s","$\\",node->value.c_str(),"$ ");
								}

								else if(node->nodeType == "special")
								{
									fprintf(fpO,"%s%s%s","\\",node->value.c_str()," ");
								}


							}

void produceChildren(latexNode* nodel, FILE *fpO)	{
								if(nodel != NULL)
								{
									vector<latexNode*>::iterator ptr;
									for(ptr = nodel->child.begin(); ptr!=nodel->child.end(); ptr++)
									{
										produceLatexCode(*ptr,fpO);
									}
								}
							}




