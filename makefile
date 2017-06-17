calculator: calculator.l calculator.y calculator.h
	bison -d calculator.y
	flex -ocalculator.lex.c calculator.l
	clang -o $@ calculator.tab.c calculator.lex.c calculator.c

clean:
	rm calculator calculator.lex.c calculator.tab.h calculator.tab.c
