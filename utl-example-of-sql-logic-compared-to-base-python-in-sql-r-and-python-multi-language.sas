%let pgm=utl-example-of-sql-logic-compared-to-base-python-in-sql-r-and-python-multi-language;

%stop_submission;

Example of sql logic compared to base python in sql r and python

   SOLUTIONS

        1 sas sql
        2 r sql
        3 python sql
        4 python base


/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                 |                                                        |                             */
/*            INPUT                |         PROCESS                                        |    OUTPUT                   */
/*            =====                |         =======                                        |    ======                   */
/*                                 | If Ingredient=Apple then only keep Dish=Pie Juice      |                             */
/*                                 |                                                        |                             */
/*                                 |                                                        |                             */
/*  REC    INGREDIENT    DISH      | 1 SQS SQL                                              | REC    INGREDIENT    DISH   */
/*                                 | SELF EXPLANATORY                                       |                             */
/*   1       Potato      Pie       | =================                                      |  1       Potato      Pie    */
/*   2       Potato      Juice     |                                                        |  2       Potato      Juice  */
/*   3       Potato      Fries     |  select                                                |  3       Potato      Fries  */
/*   4       Potato      Pure      |     rec                                                |  4       Potato      Pure   */
/*   5       Apple       Pie       |    ,ingredient                                         |  5       Apple       Pie    */
/*   6       Apple       Juice     |    ,dish                                               |  6       Apple       Juice  */
/*   7       Apple       Fries     |  from                                                  |                             */
/*   8       Apple       Pure      |     sd1.have                                           |                             */
/*                                 |  where                                                 |                             */
/*  options validvarname=upcase;   |    (ingredient='Apple' and dish in ('Pie','Juice'))    |                             */
/*  libname sd1 "d:/sd1";          |     or ingredient ne 'Apple'                           |                             */
/*  data sd1.have;                 |                                                        |                             */
/*    input rec ingredient$ dish$; |  2-3 r and sql same code as sas                        |                             */
/*  cards4;                        |  ===============================                       |                             */
/*  1 Potato Pie                   |                                                        |                             */
/*  2 Potato Juice                 |  4 PYTHON BASE                                         |                             */
/*  3 Potato Fries                 |  ==============                                        |                             */
/*  4 Potato Pure                  |                                                        |                             */
/*  5 Apple Pie                    |  want = df[ ~(df['INGREDIENT'].eq('Apple')  \          |                             */
/*  6 Apple Juice                  |   & ~df['DISH'].isin(['Pie','Juice']))]                |                             */
/*  7 Apple Fries                  |  print(want);                                          |                             */
/*  8 Apple Pure                   |                                                        |                             */
/*  ;;;;                           |                                                        |                             */
/*  run;quit;                      |                                                        |                             */
/*                                 |                                                        |                             */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/


options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.have;
  input rec ingredient$ dish$;
cards4;
1 Potato Pie
2 Potato Juice
3 Potato Fries
4 Potato Pure
5 Apple Pie
6 Apple Juice
7 Apple Fries
8 Apple Pure
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  REC    INGREDIENT    DISH                                                                                             */
/*                                                                                                                        */
/*   1       Potato      Pie                                                                                              */
/*   2       Potato      Juice                                                                                            */
/*   3       Potato      Fries                                                                                            */
/*   4       Potato      Pure                                                                                             */
/*   5       Apple       Pie                                                                                              */
/*   6       Apple       Juice                                                                                            */
/*   7       Apple       Fries                                                                                            */
/*   8       Apple       Pure                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

proc sql;
   create
     table want as
   select
      rec
     ,ingredient
     ,dish
   from
      sd1.have
   where
     (ingredient='Apple' and dish in ('Pie','Juice'))
      or ingredient ne 'Apple'
;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  REC    INGREDIENT    DISH                                                                                             */
/*                                                                                                                        */
/*   1       Potato      Pie                                                                                              */
/*   2       Potato      Juice                                                                                            */
/*   3       Potato      Fries                                                                                            */
/*   4       Potato      Pure                                                                                             */
/*   5       Apple       Pie                                                                                              */
/*   6       Apple       Juice                                                                                            */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want <- sqldf("
   select
      rec
     ,ingredient
     ,dish
   from
      have
   where
     ( ingredient='Apple' and
      dish in ('Pie','Juice') )  or
      ingredient <> 'Apple'
   ")
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* > want                     SAS                                                                                         */
/*                                                                                                                        */
/*   REC INGREDIENT  DISH     ROWNAMES    REC    INGREDIENT    DISH                                                       */
/*                                                                                                                        */
/* 1   1     Potato   Pie         1        1       Potato      Pie                                                        */
/* 2   2     Potato Juice         2        2       Potato      Juice                                                      */
/* 3   3     Potato Fries         3        3       Potato      Fries                                                      */
/* 4   4     Potato  Pure         4        4       Potato      Pure                                                       */
/* 5   5      Apple   Pie         5        5       Apple       Pie                                                        */
/* 6   6      Apple Juice         6        6       Apple       Juice                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _   _                             _
 _ __  _   _| |_| |__   ___  _ __    ___  __ _| |
| `_ \| | | | __| `_ \ / _ \| `_ \  / __|/ _` | |
| |_) | |_| | |_| | | | (_) | | | | \__ \ (_| | |
| .__/ \__, |\__|_| |_|\___/|_| |_| |___/\__, |_|
|_|    |___/                                |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read())
have,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat')
want=pdsql('''                         \
   select                               \
      rec                               \
     ,ingredient                        \
     ,dish                              \
   from                                 \
      have                              \
   where                                \
     ( ingredient="Apple" and           \
      dish in ("Pie","Juice") )  or     \
      ingredient <> "Apple"             \
   ''')
print(want);
fn_tosas9x(want,outlib='d:/sd1/'  \
 ,outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;


/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Python                       SAS                                                                                      */
/*                                                                                                                        */
/*     REC INGREDIENT   DISH     REC    INGREDIENT    DISH                                                                */
/*                                                                                                                        */
/*  0  1.0     Potato    Pie      1       Potato      Pie                                                                 */
/*  1  2.0     Potato  Juice      2       Potato      Juice                                                               */
/*  2  3.0     Potato  Fries      3       Potato      Fries                                                               */
/*  3  4.0     Potato   Pure      4       Potato      Pure                                                                */
/*  4  5.0      Apple    Pie      5       Apple       Pie                                                                 */
/*  5  6.0      Apple  Juice      6       Apple       Juice                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _                 _   _                   _
| || |    _ __  _   _| |_| |__   ___  _ __   | |__   __ _ ___  ___
| || |_  | `_ \| | | | __| `_ \ / _ \| `_ \  | `_ \ / _` / __|/ _ \
|__   _| | |_) | |_| | |_| | | | (_) | | | | | |_) | (_| \__ \  __/
   |_|   | .__/ \__, |\__|_| |_|\___/|_| |_| |_.__/ \__,_|___/\___|
         |_|    |___/
*/

proc datasets lib=sd1 nolist nodetails;
 delete pywant;
run;quit;

%utl_pybeginx;
parmcards4;
exec(open('c:/oto/fn_python.py').read())
df,meta = ps.read_sas7bdat('d:/sd1/have.sas7bdat')
print(df)
want = df[ ~(df['INGREDIENT'].eq('Apple')  \
 & ~df['DISH'].isin(['Pie','Juice']))]
print(want);
fn_tosas9x(want,outlib='d:/sd1/'  \
 ,outdsn='pywant',timeest=3);
;;;;
%utl_pyendx;

proc print data=sd1.pywant;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Python                       SAS                                                                                      */
/*                                                                                                                        */
/*     REC INGREDIENT   DISH     REC    INGREDIENT    DISH                                                                */
/*                                                                                                                        */
/*  0  1.0     Potato    Pie      1       Potato      Pie                                                                 */
/*  1  2.0     Potato  Juice      2       Potato      Juice                                                               */
/*  2  3.0     Potato  Fries      3       Potato      Fries                                                               */
/*  3  4.0     Potato   Pure      4       Potato      Pure                                                                */
/*  4  5.0      Apple    Pie      5       Apple       Pie                                                                 */
/*  5  6.0      Apple  Juice      6       Apple       Juice                                                               */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
