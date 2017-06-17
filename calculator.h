extern int yylineno;
void yyerror (char *s, ...);

/* symbol table */
struct symbol {
	char *name;
	double value;
	struct ast *func;
	struct symlist *syms;
};

#define NHASH 9996
struct symbol symtab[NHASH];

struct symlist {
	struct symbol *sym;
	struct symlist *next;
};

struct symlist *newsymlist(struct symbol *s, struct symlist *next);
void symlistfree(struct symlist *sl);
struct symbol *lookup(char *);

enum bifs {	// built-in functions
	B_sqrt = 1,
	B_exp,
	B_log,
	B_print
};

struct ast {
	int nodetype;
	struct ast *l;
	struct ast *r;
};

struct fncall {
	int nodetype;
	struct ast *l;
	enum bifs functype;
};

struct ufncall {
	int nodetype;
	struct ast *l;
	struct symbol *s;
};

struct loop {
	int nodetype;
	struct ast *cond;
	struct ast *list;
};

struct flow {
	int nodetype;
	struct ast *cond;
	struct ast *then;
	struct ast *el;
};

struct numval {
	int nodetype;
	double number;
};

struct symref {
	int nodetype;
	struct symbol *s;
};

struct symasgn {
	int nodetype;
	struct symbol *s;
	struct ast *v;
};

 /* constructors */
struct ast *newast(int nodetype, struct ast *l, struct ast *r);
struct ast *newcmp(int cmptype, struct ast *l, struct ast *r);
struct ast *newfunc(int functype, struct ast *l);
struct ast *newcall(struct symbol *s, struct ast *l);
struct ast *newref(struct symbol *s);
struct ast *newasgn(struct symbol *s, struct ast *v);
struct ast *newnum(double d);
struct ast *newflow(int nodetype, struct ast *cond, struct ast *then, struct ast *el);
struct ast *newloop(int nodetype, struct ast *cond, struct ast *list);

 /* define a function */
void dodef(struct symbol *s, struct symlist *sl, struct ast *stms);

double eval(struct ast *a);

void treefree(struct ast *s);

