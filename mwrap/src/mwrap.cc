/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NON_C_LINE = 258,
     NEW = 259,
     TYPEDEF = 260,
     CLASS = 261,
     FORTRAN = 262,
     ID = 263,
     NUMBER = 264,
     STRING = 265,
     INPUT = 266,
     OUTPUT = 267,
     INOUT = 268
   };
#endif
/* Tokens.  */
#define NON_C_LINE 258
#define NEW 259
#define TYPEDEF 260
#define CLASS 261
#define FORTRAN 262
#define ID 263
#define NUMBER 264
#define STRING 265
#define INPUT 266
#define OUTPUT 267
#define INOUT 268




/* Copy the first part of user declarations.  */
#line 1 "mwrap.y"

/*
 * mwrap.y
 *   Parser for mwrap.
 *
 * Copyright (c) 2007  David Bindel
 * See the file COPYING for copying permissions
 */

#include <stdlib.h>
#include <string.h>
#include <string>
#include "mwrap-ast.h"

extern "C" {
    int yylex();
    int yywrap();
    int yyerror(char* s);
}

using std::string;

bool  mw_generate_catch = false;  // Catch C++ exceptions?
bool  mw_use_cpp_complex = false; // Use C++ complex types?
bool  mw_use_c99_complex = false; // Use C99 complex types?
int   listing_flag = 0;           // Output filenames from @ commands?
int   mbatching_flag = 0;         // Output on @ commands?
int   linenum = 0;                // Lexer line number
FILE* outfp   = 0;                // MATLAB output file
FILE* outcfp  = 0;                // C output file

static int    type_errs = 0;            // Number of typecheck errors
static int    func_id = 0;              // Assign stub numbers
static Func*  funcs   = 0;              // AST - linked list of functions
static Func*  lastfunc = 0;             // Last link in funcs list
static char*  mexfunc = "mexfunction";  // Name of mex function
static string current_ifname;           // Current input file name


#define MAX_INCLUDE_DEPTH 10
static string include_stack_names[MAX_INCLUDE_DEPTH];
extern int include_stack_ptr;

extern "C" void set_include_name(const char* s)
{
    include_stack_names[include_stack_ptr] = current_ifname;
    current_ifname = s;
}

extern "C" void get_include_name()
{
    current_ifname = include_stack_names[include_stack_ptr].c_str();
}


inline void add_func(Func* func)
{
    static std::map<string,Func*> func_lookup;
    if (!funcs) {
        funcs = func;
        lastfunc = func;
        return;
    } 

    Func*& func_ptr = func_lookup[id_string(func)];
    if (func_ptr) {
        func_ptr->same_next = func;
    } else {
        lastfunc->next = func;
        lastfunc = func;
    }
    func_ptr = func;
}



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 77 "mwrap.y"
{
    char* string;
    struct Func* func;
    struct Var* var;
    struct TypeQual* qual;
    struct Expr* expr;
    struct InheritsDecl* inherits;
    char c;
}
/* Line 193 of yacc.c.  */
#line 208 "mwrap.cc"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 221 "mwrap.cc"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  28
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   75

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  27
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  20
/* YYNRULES -- Number of rules.  */
#define YYNRULES  49
/* YYNRULES -- Number of states.  */
#define YYNSTATES  81

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   268

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    21,     2,
      18,    19,    20,     2,    17,    24,    26,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    16,    15,
       2,    14,    25,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    22,     2,    23,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     6,     7,    11,    13,    15,    17,    19,
      22,    27,    33,    36,    40,    41,    47,    50,    51,    55,
      56,    59,    63,    67,    71,    76,    81,    85,    90,    94,
      99,   101,   103,   105,   106,   108,   110,   112,   114,   117,
     121,   124,   125,   129,   130,   132,   134,   141,   143,   146
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      28,     0,    -1,    29,    28,    -1,    -1,    37,    14,    34,
      -1,    34,    -1,    30,    -1,    31,    -1,     3,    -1,     1,
      15,    -1,     5,     8,     8,    15,    -1,     6,     8,    16,
      32,    15,    -1,     8,    33,    -1,    17,     8,    33,    -1,
      -1,    46,    18,    35,    19,    15,    -1,    38,    36,    -1,
      -1,    17,    38,    36,    -1,    -1,     8,     8,    -1,     8,
      40,     8,    -1,     8,     8,    41,    -1,    39,     8,     8,
      -1,    39,     8,    40,     8,    -1,    39,     8,     8,    41,
      -1,    39,     8,     9,    -1,    39,     8,    40,     9,    -1,
      39,     8,    10,    -1,    39,     8,    40,    10,    -1,    11,
      -1,    12,    -1,    13,    -1,    -1,    20,    -1,    21,    -1,
      41,    -1,    42,    -1,    42,    21,    -1,    22,    43,    23,
      -1,    45,    44,    -1,    -1,    17,    45,    44,    -1,    -1,
       8,    -1,     9,    -1,     8,    24,    25,     8,    26,     8,
      -1,     8,    -1,     7,     8,    -1,     4,     8,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,   103,   103,   103,   106,   114,   121,   122,   123,   124,
     127,   145,   152,   155,   156,   158,   161,   162,   165,   166,
     168,   169,   170,   172,   173,   174,   176,   177,   179,   180,
     183,   184,   185,   186,   189,   190,   191,   194,   195,   197,
     200,   201,   204,   205,   208,   209,   212,   213,   214,   217
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "NON_C_LINE", "NEW", "TYPEDEF", "CLASS",
  "FORTRAN", "ID", "NUMBER", "STRING", "INPUT", "OUTPUT", "INOUT", "'='",
  "';'", "':'", "','", "'('", "')'", "'*'", "'&'", "'['", "']'", "'-'",
  "'>'", "'.'", "$accept", "statements", "statement", "tdef", "classdef",
  "inheritslist", "inheritsrest", "funcall", "args", "argsrest", "basevar",
  "var", "iospec", "quals", "aqual", "arrayspec", "exprs", "exprrest",
  "expr", "func", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,    61,    59,    58,    44,    40,    41,
      42,    38,    91,    93,    45,    62,    46
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    27,    28,    28,    29,    29,    29,    29,    29,    29,
      30,    31,    32,    33,    33,    34,    35,    35,    36,    36,
      37,    37,    37,    38,    38,    38,    38,    38,    38,    38,
      39,    39,    39,    39,    40,    40,    40,    41,    41,    42,
      43,    43,    44,    44,    45,    45,    46,    46,    46,    46
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     2,     0,     3,     1,     1,     1,     1,     2,
       4,     5,     2,     3,     0,     5,     2,     0,     3,     0,
       2,     3,     3,     3,     4,     4,     3,     4,     3,     4,
       1,     1,     1,     0,     1,     1,     1,     1,     2,     3,
       2,     0,     3,     0,     1,     1,     6,     1,     2,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     8,     0,     0,     0,     0,    47,     0,     0,
       6,     7,     5,     0,     0,     9,    49,     0,     0,    48,
      20,    34,    35,    41,     0,     0,    36,    37,     1,     2,
       0,    17,     0,     0,    22,    44,    45,     0,    43,     0,
      21,    38,    47,     4,    30,    31,    32,     0,    19,     0,
      10,    14,     0,    39,     0,    40,     0,     0,    33,    16,
       0,     0,    12,    11,    43,     0,    15,    19,    23,    26,
      28,     0,    14,    42,    46,    18,    25,    24,    27,    29,
      13
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     8,     9,    10,    11,    52,    62,    12,    47,    59,
      13,    48,    49,    25,    26,    27,    37,    55,    38,    14
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -21
static const yytype_int8 yypact[] =
{
      21,   -10,   -21,     4,     8,    15,    29,    -7,    38,    21,
     -21,   -21,   -21,    27,    24,   -21,   -21,    35,    28,   -21,
      25,   -21,   -21,    23,    20,    41,   -21,    30,   -21,   -21,
      32,    22,    31,    42,   -21,   -21,   -21,    33,    36,    44,
     -21,   -21,    34,   -21,   -21,   -21,   -21,    40,    37,    47,
     -21,    43,    46,   -21,    23,   -21,    39,    48,    -9,   -21,
      -2,    49,   -21,   -21,    36,    54,   -21,    37,    25,   -21,
     -21,     1,    43,   -21,   -21,   -21,   -21,   -21,   -21,   -21,
     -21
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -21,    55,   -21,   -21,   -21,   -21,    -6,    45,   -21,     0,
     -21,    10,   -21,     9,   -20,   -21,   -21,     6,    17,   -21
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -34
static const yytype_int8 yytable[] =
{
      34,    20,    44,    45,    46,    15,    68,    69,    70,    77,
      78,    79,    16,    21,    22,    23,    17,    24,    21,    22,
      23,    -3,     1,    18,     2,     3,     4,     5,     6,     7,
     -33,    35,    36,    44,    45,    46,     3,    19,    28,     6,
      42,    30,    31,    32,    33,    39,    50,    23,    76,    40,
      51,    41,    56,    54,    58,    60,    53,    72,    24,    57,
      61,    63,    74,    66,    29,    65,    80,    75,    67,    71,
      73,    64,     0,     0,     0,    43
};

static const yytype_int8 yycheck[] =
{
      20,     8,    11,    12,    13,    15,     8,     9,    10,     8,
       9,    10,     8,    20,    21,    22,     8,    24,    20,    21,
      22,     0,     1,     8,     3,     4,     5,     6,     7,     8,
       8,     8,     9,    11,    12,    13,     4,     8,     0,     7,
       8,    14,    18,     8,    16,    25,    15,    22,    68,     8,
       8,    21,     8,    17,    17,     8,    23,     8,    24,    19,
      17,    15,     8,    15,     9,    26,    72,    67,    58,    60,
      64,    54,    -1,    -1,    -1,    30
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     1,     3,     4,     5,     6,     7,     8,    28,    29,
      30,    31,    34,    37,    46,    15,     8,     8,     8,     8,
       8,    20,    21,    22,    24,    40,    41,    42,     0,    28,
      14,    18,     8,    16,    41,     8,     9,    43,    45,    25,
       8,    21,     8,    34,    11,    12,    13,    35,    38,    39,
      15,     8,    32,    23,    17,    44,     8,    19,    17,    36,
       8,    17,    33,    15,    45,    26,    15,    38,     8,     9,
      10,    40,     8,    44,     8,    36,    41,     8,     9,    10,
      33
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 4:
#line 106 "mwrap.y"
    { 
      (yyvsp[(3) - (3)].func)->ret = (yyvsp[(1) - (3)].var); 
      (yyvsp[(3) - (3)].func)->id = ++func_id;
      type_errs += typecheck((yyvsp[(3) - (3)].func), linenum);
      if (outfp)
          print_matlab_call(outfp, (yyvsp[(3) - (3)].func), mexfunc); 
      add_func((yyvsp[(3) - (3)].func));
  ;}
    break;

  case 5:
#line 114 "mwrap.y"
    { 
      (yyvsp[(1) - (1)].func)->id = ++func_id;
      type_errs += typecheck((yyvsp[(1) - (1)].func), linenum);
      if (outfp)
          print_matlab_call(outfp, (yyvsp[(1) - (1)].func), mexfunc); 
      add_func((yyvsp[(1) - (1)].func));
  ;}
    break;

  case 9:
#line 124 "mwrap.y"
    { yyerrok; ;}
    break;

  case 10:
#line 127 "mwrap.y"
    { 
      if (strcmp((yyvsp[(2) - (4)].string), "numeric") == 0) {
          add_scalar_type((yyvsp[(3) - (4)].string));
      } else if (strcmp((yyvsp[(2) - (4)].string), "dcomplex") == 0) {
          add_zscalar_type((yyvsp[(3) - (4)].string));
      } else if (strcmp((yyvsp[(2) - (4)].string), "fcomplex") == 0) {
          add_cscalar_type((yyvsp[(3) - (4)].string));
      } else if (strcmp((yyvsp[(2) - (4)].string), "mxArray") == 0) {
          add_mxarray_type((yyvsp[(3) - (4)].string));
      } else {
          fprintf(stderr, "Unrecognized typespace: %s\n", (yyvsp[(2) - (4)].string));
          ++type_errs;
      }
      delete[] (yyvsp[(2) - (4)].string);
      delete[] (yyvsp[(3) - (4)].string);
  ;}
    break;

  case 11:
#line 145 "mwrap.y"
    {
      add_inherits((yyvsp[(2) - (5)].string), (yyvsp[(4) - (5)].inherits));
      delete[] (yyvsp[(2) - (5)].string);
      destroy((yyvsp[(4) - (5)].inherits));
  ;}
    break;

  case 12:
#line 152 "mwrap.y"
    { (yyval.inherits) = new InheritsDecl((yyvsp[(1) - (2)].string), (yyvsp[(2) - (2)].inherits)); ;}
    break;

  case 13:
#line 155 "mwrap.y"
    { (yyval.inherits) = new InheritsDecl((yyvsp[(2) - (3)].string), (yyvsp[(3) - (3)].inherits)); ;}
    break;

  case 14:
#line 156 "mwrap.y"
    { (yyval.inherits) = NULL; ;}
    break;

  case 15:
#line 158 "mwrap.y"
    { (yyval.func) = (yyvsp[(1) - (5)].func); (yyval.func)->args = (yyvsp[(3) - (5)].var); ;}
    break;

  case 16:
#line 161 "mwrap.y"
    { (yyval.var) = (yyvsp[(1) - (2)].var); (yyval.var)->next = (yyvsp[(2) - (2)].var); ;}
    break;

  case 17:
#line 162 "mwrap.y"
    { (yyval.var) = NULL; ;}
    break;

  case 18:
#line 165 "mwrap.y"
    {(yyval.var) = (yyvsp[(2) - (3)].var); (yyval.var)->next = (yyvsp[(3) - (3)].var); ;}
    break;

  case 19:
#line 166 "mwrap.y"
    { (yyval.var) = NULL; ;}
    break;

  case 20:
#line 168 "mwrap.y"
    { (yyval.var) = new Var('o', (yyvsp[(1) - (2)].string), NULL, (yyvsp[(2) - (2)].string)); ;}
    break;

  case 21:
#line 169 "mwrap.y"
    { (yyval.var) = new Var('o', (yyvsp[(1) - (3)].string), (yyvsp[(2) - (3)].qual),   (yyvsp[(3) - (3)].string)); ;}
    break;

  case 22:
#line 170 "mwrap.y"
    { (yyval.var) = new Var('o', (yyvsp[(1) - (3)].string), (yyvsp[(3) - (3)].qual),   (yyvsp[(2) - (3)].string)); ;}
    break;

  case 23:
#line 172 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (3)].c),  (yyvsp[(2) - (3)].string), NULL, (yyvsp[(3) - (3)].string)); ;}
    break;

  case 24:
#line 173 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (4)].c),  (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].qual),   (yyvsp[(4) - (4)].string)); ;}
    break;

  case 25:
#line 174 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (4)].c),  (yyvsp[(2) - (4)].string), (yyvsp[(4) - (4)].qual),   (yyvsp[(3) - (4)].string)); ;}
    break;

  case 26:
#line 176 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (3)].c),  (yyvsp[(2) - (3)].string), NULL, (yyvsp[(3) - (3)].string)); ;}
    break;

  case 27:
#line 177 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (4)].c),  (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].qual),   (yyvsp[(4) - (4)].string)); ;}
    break;

  case 28:
#line 179 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (3)].c),  (yyvsp[(2) - (3)].string), NULL, (yyvsp[(3) - (3)].string)); ;}
    break;

  case 29:
#line 180 "mwrap.y"
    { (yyval.var) = new Var((yyvsp[(1) - (4)].c),  (yyvsp[(2) - (4)].string), (yyvsp[(3) - (4)].qual),   (yyvsp[(4) - (4)].string)); ;}
    break;

  case 30:
#line 183 "mwrap.y"
    { (yyval.c) = 'i'; ;}
    break;

  case 31:
#line 184 "mwrap.y"
    { (yyval.c) = 'o'; ;}
    break;

  case 32:
#line 185 "mwrap.y"
    { (yyval.c) = 'b'; ;}
    break;

  case 33:
#line 186 "mwrap.y"
    { (yyval.c) = 'i'; ;}
    break;

  case 34:
#line 189 "mwrap.y"
    { (yyval.qual) = new TypeQual('*', NULL); ;}
    break;

  case 35:
#line 190 "mwrap.y"
    { (yyval.qual) = new TypeQual('&', NULL); ;}
    break;

  case 36:
#line 191 "mwrap.y"
    { (yyval.qual) = (yyvsp[(1) - (1)].qual); ;}
    break;

  case 37:
#line 194 "mwrap.y"
    { (yyval.qual) = new TypeQual('a', (yyvsp[(1) - (1)].expr)); ;}
    break;

  case 38:
#line 195 "mwrap.y"
    { (yyval.qual) = new TypeQual('r', (yyvsp[(1) - (2)].expr)); ;}
    break;

  case 39:
#line 197 "mwrap.y"
    { (yyval.expr) = (yyvsp[(2) - (3)].expr); ;}
    break;

  case 40:
#line 200 "mwrap.y"
    { (yyval.expr) = (yyvsp[(1) - (2)].expr); (yyval.expr)->next = (yyvsp[(2) - (2)].expr); ;}
    break;

  case 41:
#line 201 "mwrap.y"
    { (yyval.expr) = NULL; ;}
    break;

  case 42:
#line 204 "mwrap.y"
    { (yyval.expr) = (yyvsp[(2) - (3)].expr); (yyval.expr)->next = (yyvsp[(3) - (3)].expr); ;}
    break;

  case 43:
#line 205 "mwrap.y"
    { (yyval.expr) = NULL; ;}
    break;

  case 44:
#line 208 "mwrap.y"
    { (yyval.expr) = new Expr((yyvsp[(1) - (1)].string)); ;}
    break;

  case 45:
#line 209 "mwrap.y"
    { (yyval.expr) = new Expr((yyvsp[(1) - (1)].string)); ;}
    break;

  case 46:
#line 212 "mwrap.y"
    { (yyval.func) = new Func((yyvsp[(1) - (6)].string), (yyvsp[(4) - (6)].string), (yyvsp[(6) - (6)].string), current_ifname, linenum); ;}
    break;

  case 47:
#line 213 "mwrap.y"
    { (yyval.func) = new Func(NULL, NULL, (yyvsp[(1) - (1)].string), current_ifname, linenum); ;}
    break;

  case 48:
#line 214 "mwrap.y"
    { (yyval.func) = new Func(NULL, NULL, (yyvsp[(2) - (2)].string), current_ifname, linenum); 
                  (yyval.func)->fort = true;
                ;}
    break;

  case 49:
#line 217 "mwrap.y"
    { (yyval.func) = new Func(NULL, (yyvsp[(2) - (2)].string), mwrap_strdup("new"), 
                          current_ifname, linenum); 
            ;}
    break;


/* Line 1267 of yacc.c.  */
#line 1729 "mwrap.cc"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 222 "mwrap.y"

#include <stdio.h>
#include <string.h>

extern FILE* yyin;

int yywrap()
{
    return 1;
}

int yyerror(char* s)
{
    fprintf(stderr, "Parse error (%s:%d): %s\n", current_ifname.c_str(),
            linenum, s);
}

char* mwrap_strdup(const char* s)
{
    char* result = new char[strlen(s)+1];
    strcpy(result, s);
    return result;
}

const char* help_string = 
"Syntax:\n"
"  mwrap [-mex outputmex] [-m output.m] [-c outputmex.c] [-mb]\n"
"        [-list] [-catch] infile1 infile2 ...\n"
"\n"
"  -mex outputmex -- specify the MATLAB mex function name\n"
"  -m output.m    -- generate the MATLAB stub called output.m\n"
"  -c outputmex.c -- generate the C file outputmex.c\n"
"  -mb            -- generate .m files specified with @ redirections\n"
"  -list          -- list files specified with @ redirections\n"
"  -catch         -- generate C++ exception handling code\n"
"  -c99complex    -- add support code for C99 complex types\n"
"  -cppcomplex    -- add support code for C++ complex types\n"
"\n";

int main(int argc, char** argv)
{
    int j;
    int err_flag = 0;
    init_scalar_types();

    if (argc == 1) {
        fprintf(stderr, help_string);
        return 0;
    } else {
        for (j = 1; j < argc; ++j) {
            if (strcmp(argv[j], "-m") == 0 && j+1 < argc)
                outfp = fopen(argv[j+1], "w+");
            if (strcmp(argv[j], "-c") == 0 && j+1 < argc)
                outcfp = fopen(argv[j+1], "w+");
            if (strcmp(argv[j], "-mex") == 0 && j+1 < argc)
                mexfunc = argv[j+1];
            if (strcmp(argv[j], "-mb") == 0)
                mbatching_flag = 1;
            if (strcmp(argv[j], "-list") == 0)
                listing_flag = 1;
            if (strcmp(argv[j], "-catch") == 0)
                mw_generate_catch = true;
            if (strcmp(argv[j], "-c99complex") == 0) 
                mw_use_c99_complex = true;
            if (strcmp(argv[j], "-cppcomplex") == 0) 
                mw_use_cpp_complex = true;
        }

        if (mw_use_c99_complex || mw_use_cpp_complex) {
            add_zscalar_type("dcomplex");
            add_cscalar_type("fcomplex");
        }

        for (j = 1; j < argc; ++j) {
            if (strcmp(argv[j], "-m") == 0 ||
                strcmp(argv[j], "-c") == 0 ||
                strcmp(argv[j], "-mex") == 0)
                ++j;
            else if (strcmp(argv[j], "-mb") == 0 ||
                     strcmp(argv[j], "-list") == 0 ||
                     strcmp(argv[j], "-catch") == 0 ||
                     strcmp(argv[j], "-c99complex") == 0 ||
                     strcmp(argv[j], "-cppcomplex") == 0);
            else {
                linenum = 1;
                type_errs = 0;
                yyin = fopen(argv[j], "r");
                if (yyin) {
                    current_ifname = argv[j];
                    err_flag += yyparse();
                    fclose(yyin);
                } else {
                    fprintf(stderr, "Could not read %s\n", argv[j]);
                }
                if (type_errs)
                    fprintf(stderr, "%s: %d type errors detected\n", 
                            argv[j], type_errs);
                err_flag += type_errs;
            }
        }
    }
    if (!err_flag && outcfp)
        print_mex_file(outcfp, funcs);
    destroy(funcs);
    destroy_inherits();
    if (outfp)
        fclose(outfp);
    if (outcfp)
        fclose(outcfp);
    return err_flag;
}

