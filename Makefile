cop1:     	lex.yy.c cop1.tab.c
		gcc lex.yy.c cop1.tab.c -lfl -o cop1

lex.yy.c:       cop1.tab.h cop1.lex
		flex cop1.lex

cop1.tab.c cop1.tab.h:	cop1.y
			bison -dv cop1.y
