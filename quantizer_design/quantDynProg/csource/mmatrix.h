
/* MWORD is set to be a double */
typedef double MWORD;

#define EPS          2.7105053E-19F   /*guardband by 1E+1*/

#define MEX 1

#if MEX==1
#include "mex.h"
#endif

#define VARNAMELEN 30           /*maximum length for variable names*/


typedef struct {
    int64_t nr;             /* number of rows */
    int64_t nc;             /* number of colums */
    MWORD **elt;        /* pointer to rows */
    MWORD *cols;        /* pointer to contents of matrix */
    char name[VARNAMELEN+1];
    int type;           /* 0 for MWORDs, 1 for MWORD interpretted as strings */
    int init;           /* 0 if rows/contents not yet malloc'd, 1 otherwise */
} MATRIX;

/************************************************
    Initialize a matrix.  Unless a matrix in input from matlab,
    the declaration should look like this:
    MATRIX *x = matrix("x",0,0);    //for outputs
    MATRIX *x = matrix("x",nr,nc);   //for inputs
    x->elt[col][row] = 10;
    
    matrix_free(x);
    
    An alternate usage is:
    MATRIX dd = {1000,1,NULL,NULL,"d",0};
    MATRIX *d = &dd;
    
    An exception is when the matrix is an input from Matlab.
    The function matlab_to_matrix() invokes the 
    function matrix():
    
    MATRIX *a;

    a = matlab_to_matrix(prhs[0]);
    
*************************************************/

MATRIX *matrix(char *name,int64_t nr,int64_t nc,...);
void error(char *message);
void matrix_name(MATRIX *m, char *name);
void matrix_clear(MATRIX *m,MWORD f);
int matrix_isinit(MATRIX *m);


void matrix_init_ptr(MATRIX *m, int64_t nr,int64_t nc);
void matrix_free(MATRIX *m);
void matrix_null(MATRIX *m);


#if MEX==1
MATRIX *matlab_to_matrix(const mxArray *matlab);
mxArray *matrix_to_matlab(MATRIX *m);
#endif



