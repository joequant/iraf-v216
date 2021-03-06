%{

#include <ctype.h>

/*
 * GENERIC -- This filter takes a file containing a generic operator as input
 * and generates as output either a set of files, one for each of the data
 * types in the generic family, or a single file wherein the generic section
 * has been duplicated for each case.
 */

#undef	output
extern	char	*type_string;
extern	char	xtype_string[];
extern	char	type_char;

extern void  copy_line (void);
extern void  copy_string (void);
extern void  copy_comment (void);
extern void  make_float (char type_ch);
extern void  pass_through (void);
extern void  do_for (void);
extern void  do_endfor (void);
extern void  do_if (void);
extern void  do_else (void);
extern void  do_endif (void);

extern void  output_indef (char ch);
extern void  output_upper (char *s);
extern void  output (char ch);
extern void  outstr (char *s);
extern int   getc (FILE *cx_i);	  /* NOTE: lex.sed changes this to k_getc() */



%}

W	[ \t]

%%

PIXEL				outstr (type_string);
XPIXEL				outstr (xtype_string);
INDEF				output_indef (type_char);
INDEF(S|I|L|R|D|X)		ECHO;
SZ_PIXEL			output_upper ("SZ_");
TY_PIXEL			output_upper ("TY_");
$PIXEL				outstr ("PIXEL");
$INDEF				outstr ("INDEF");

[A-Z][A-Z_]*PIXEL		{
					yytext[strlen(yytext)-5] = '\0';
					output_upper (yytext);
				}

"$t"				{	if (isupper (type_char))
					    output (tolower (type_char));
					else
					    output (type_char);
				}
"$T"				{	if (islower (type_char))
					    output (toupper (type_char));
					else
					    output (type_char);
				}

"$/"				pass_through();
[0-9]+("$f"|"$F")		make_float (type_char);

{W}*"$if"			do_if();
{W}*"$else"			do_else();
{W}*"$endif"			do_endif(); 
{W}*"$for"			do_for(); 
{W}*"$endfor"			do_endfor(); 
{W}*"$IF"			do_if();
{W}*"$ELSE"			do_else();
{W}*"$ENDIF"			do_endif(); 
{W}*"$FOR"			do_for(); 
{W}*"$ENDFOR"			do_endfor(); 

"$$"				output ('$');
"/*"				copy_comment();
\"				copy_string();

^\#if				ECHO;
^\#else				ECHO;
^\#endif			ECHO;
^\#include			ECHO;

\#				copy_line();
^\%				copy_line();

%%


/* LEX_INPUT -- Make input() callable as a function from the .c code.
 */
int
lex_input (void)
{
	return (input());
}


/* LEX_UNPUT -- Make unput() callable as a function from the .c code.
 */
void
lex_unput (int ch)
{
	unput (ch);
}
