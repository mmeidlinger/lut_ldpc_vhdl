
#include <stdio.h>
#include <stdlib.h>  /* for malloc */
#include <string.h>  /* for strcpy */
#include <math.h>    /* for random number generation */
#include <time.h>    /* for seeding random number generators */
#include <stdarg.h>  /* for matrix_op which uses variable args */
#include <float.h>   /* for DBL_MAX and DBL_MIN, etc. */
#include "mmatrix.h"
#include "matrix.h"

#if MEX==1
	#include "mex.h"
#endif


MATRIX *matrix(char *name,int64_t nr,int64_t nc,...)
{
	va_list ap;
	int64_t ii,jj,f=0;
   MATRIX *m;
   MWORD mw;

	va_start(ap,nc);
    if(*name == '*') {
		if(*(name+1) == 'i') {
	   	f = 1;
      } else {
      	if(*(name+1) == 'm') {
	   	   f = 2;
         } else {
         	error("matrix(): unrecognized option\n");
         }
      }
      name = name+3;
   }

   #if MEX==1
	   m = mxCalloc(1,sizeof(MATRIX));
   #else
	   m = malloc(sizeof(MATRIX));
   #endif

   if(m == NULL) {
	   printf("matrix(): matrix %s failed to malloc.\n",name);
   	error("Error in matrix()\n");
   }

   matrix_name(m,name);
   m->type = 0;

   if( (nc > 0) && (nr > 0) ) {
   	m->nr = nr;
	   m->nc = nc;
   	m->cols = malloc(sizeof(MWORD) * (m->nr) * (m->nc) );
	   m->elt = malloc(sizeof(m->cols) * (m->nc) );
	   for(jj=0;jj<m->nc;jj++)
   		m->elt[jj] = m->cols + (jj * (m->nr));
      m->init = 1;
		matrix_clear(m,0);
   } else {
	   m->cols = NULL;
   	m->elt = NULL;
	   m->nc = 0;
   	m->nr = 0;
      m->init = 0;
   }

	if(f==1) {
   	for(ii=0;ii<nr;ii++) {
      	for(jj=0;jj<nc;jj++) {
         	mw = (MWORD)va_arg(ap, int);
            m->elt[jj][ii] = mw;
         }
      }
   }

	if(f==2) {
   	for(ii=0;ii<nr;ii++) {
      	for(jj=0;jj<nc;jj++) {
         	mw = va_arg(ap, MWORD);
            m->elt[jj][ii] = mw;
         }
      }
   }

   return m;
}


void matrix_name(MATRIX *m, char *name)
{
 	strcpy(m->name,name);
	return;
}



void matrix_clear(MATRIX *m,MWORD f)
{
 	int ii;

	if(matrix_isinit(m)) {
	   for(ii=0;ii < m->nr * m->nc ;ii++)
				m->cols[ii] = f;
   } else {
      printf("name = %s\n",m->name);
   	error("matrix_clear() must have a defined matrix\n");
   }

   return;
}



int matrix_isinit(MATRIX *m)
{
 	return m->init;
}



void matrix_init_ptr(MATRIX *m,int64_t nr,int64_t nc)
{
	int64_t jj;

	
	if (matrix_isinit(m)) {
      if ((m->nc == nc) && (m->nr == nr) ) {
	      matrix_clear(m,0);
   	   return;
   	} else {
      	matrix_free(m);
      }
   }

   m->nr = nr;
   m->nc = nc;
   m->cols = malloc(sizeof(MWORD) * (m->nr) * (m->nc) );
   m->elt = malloc(sizeof(m->cols) * (m->nc) );

   for(jj=0;jj<m->nc;jj++)
   	m->elt[jj] = m->cols + (jj * (m->nr));

   m->type = 0;
	m->init = 1;

	matrix_clear(m,0);

   return;
}



void matrix_free(MATRIX *m)
{
	if(matrix_isinit(m)) {
		free(m->elt);
   	free(m->cols);

		m->cols = NULL;
   	m->elt = NULL;
	   m->nc = 0;
   	m->nr = 0;
   } else {
   	error("Tried to matrix_free() a matrix that was not initialized\n");
   }

	return;
}






void error(char *message)
{
	#if MEX==0
	printf("ERROR:\n");
	printf("%s",message);
   exit(1);
   #else
   mexErrMsgTxt(message);
	#endif
}


#if MEX==1
MATRIX *matlab_to_matrix(const mxArray *matlab)
{
   double *fp;
   int64_t r,c;
   FILE *fl;
   MATRIX *m = matrix("matlab",0,0);

   /* m = malloc(sizeof(MATRIX)); */
   
   matrix_init_ptr(m,mxGetM(matlab),mxGetN(matlab));
   fp = mxGetPr(matlab);
   m->type = 0;
   /* matrix_name(m,mxGetName(matlab));  not compatible with V6.5 */

   for(c=0;c < m->nc;c++)
  		for(r=0;r < m->nr;r++) {
			m->elt[c][r] = *(fp++) ;
   }
    
   
   return m;
}

mxArray *matrix_to_matlab(MATRIX *m)
{
   double *fp;
   int64_t r,c;
   mxArray *matlab;

   matlab = mxCreateDoubleMatrix(m->nr,m->nc,mxREAL);
   fp     = mxGetPr(matlab);
	for(c=0;c < m->nc;c++)
      for(r=0;r < m->nr;r++)
			*(fp++) = m->elt[c][r] ;
	return matlab;
} 


#endif
