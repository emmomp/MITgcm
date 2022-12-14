C $Header: /u/gcmpack/MITgcm/verification/tutorial_global_oce_optim/code_ad/cost_temp.F,v 1.7 2014/09/11 19:52:44 jmc Exp $
C $Name:  $

#include "COST_OPTIONS.h"
c#ifdef ALLOW_CTRL
c# include "CTRL_OPTIONS.h"
c#endif

      SUBROUTINE COST_TEMP( myThid )
C     *==========================================================*
C     | SUBROUTINE COST_TEMP
C     | o the subroutine computes the sum of the squared errors
C     |   relatively to the Levitus climatology
C     *==========================================================*

       IMPLICIT NONE

C     == Global variables ===
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "cost.h"
#include "ctrl_weights.h"

C     ======== Routine arguments ======================
C     myThid - Thread number for this instance of the routine.
      INTEGER myThid

#ifdef ALLOW_COST_TEMP
C     ========= Local variables =========================
      INTEGER i, j, k
      INTEGER bi, bj
      INTEGER Nk
      _RL locfc,tmp
      _RL thetalev(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy)

      Nk = 2
C Read annual mean Levitus temperature

      CALL READ_FLD_XYZ_RL('lev_t_an.bin',' ',thetalev,0,myThid)

C  Total number of wet temperature point
      tmp  = 0. _d 0
      DO bj=myByLo(myThid),myByHi(myThid)
       DO bi=myBxLo(myThid),myBxHi(myThid)
         DO k=1, Nk
          DO j=1,sNy
           DO i=1,sNx
             tmp = tmp + maskC(i,j,k,bi,bj)
           ENDDO
          ENDDO
         ENDDO
       ENDDO
      ENDDO
      _GLOBAL_SUM_RL( tmp , myThid )
      IF ( tmp.GT.0. ) tmp = 1. _d 0 / tmp

      DO bj=myByLo(myThid),myByHi(myThid)
       DO bi=myBxLo(myThid),myBxHi(myThid)

         locfc = 0. _d 0
         DO k=1,Nk
           DO j=1,sNy
            DO i=1,sNx
              locfc = locfc + tmp*maskC(i,j,k,bi,bj)*
     &         wtheta(k,bi,bj)*
     &         ( cMeanTheta(i,j,k,bi,bj) - thetalev(i,j,k,bi,bj) )**2
            ENDDO
           ENDDO
         ENDDO

         objf_temp_tut(bi,bj) = locfc
c        print*,'objf_temp_tut =',locfc,startTime,endTime,tmp

       ENDDO
      ENDDO

#endif /* ALLOW_COST_TEMP */
      RETURN
      END
