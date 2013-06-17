C $Header: /u/gcmpack/MITgcm/pkg/streamice/streamice_velmask_upd.F,v 1.1 2013/06/12 21:30:22 dgoldberg Exp $
C $Name:  $

#include "STREAMICE_OPTIONS.h"

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

CBOP
      SUBROUTINE STREAMICE_VELMASK_UPD ( myThid )

C     /============================================================\
C     | SUBROUTINE                                                 |   
C     | o                                                          |
C     |============================================================|
C     |                                                            |
C     \============================================================/
      IMPLICIT NONE

C     === Global variables ===
#include "SIZE.h"
#include "GRID.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "STREAMICE.h"
#ifdef ALLOW_USE_MPI
# include "EESUPPORT.h"
#endif
! #include "STREAMICE_ADV.h"

      INTEGER myThid

#ifdef ALLOW_STREAMICE

      INTEGER i, j, bi, bj, ki, kj
      INTEGER maskFlag
      CHARACTER*(MAX_LEN_MBUF) msgBuf
#ifdef ALLOW_USE_MPI
      integer mpiRC, mpiMyWid
#endif
#ifdef ALLOW_PETSC
      _RS DoFCount
      integer n_dofs_proc_loc (0:nPx*nPy-1)
      integer n_dofs_cum_sum (0:nPx*nPy-1)
#endif

      _EXCH_XY_RL( H_streamice, myThid )
      _EXCH_XY_RL( area_shelf_streamice, myThid )
      _EXCH_XY_RL( STREAMICE_hmask, myThid )

      DO bj=myByLo(myThid),myByHi(myThid)
       DO bi=myBxLo(myThid),myBxHi(myThid)
        DO j=1-OLy,sNy+OLy
         DO i=1-OLx,sNx+OLx
          STREAMICE_umask(i,j,bi,bj) = 0. _d 0
          STREAMICE_vmask(i,j,bi,bj) = 0. _d 0
          STREAMICE_ufacemask(i,j,bi,bj) = 0. _d 0
          STREAMICE_vfacemask(i,j,bi,bj) = 0. _d 0
         ENDDO
        ENDDO
       ENDDO
      ENDDO

      DO bj=myByLo(myThid),myByHi(myThid)
       DO bi=myBxLo(myThid),myBxHi(myThid)
        DO j=0,sNy+1
         DO i=0,sNx+1
          IF (STREAMICE_hmask(i,j,bi,bj) .eq. 1) THEN

           DO kj=0,1
            DO ki=0,1
             STREAMICE_umask (i+ki,j+kj,bi,bj) = 1.0
             STREAMICE_vmask (i+ki,j+kj,bi,bj) = 1.0
            ENDDO
           ENDDO

           DO ki=0,1
            maskFlag=INT(STREAMICE_ufacemask_bdry(i+ki,j,bi,bj))
             IF (maskFlag.EQ.3) THEN
              DO kj=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 3.0
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 3.0
              ENDDO
              STREAMICE_ufacemask(i+ki,j,bi,bj) = 3.0
             ELSE IF (maskFlag.EQ.2) THEN
              !DO kj=0,1
               STREAMICE_ufacemask(i+ki,j,bi,bj) = 2.0
              !ENDDO
             ELSE IF (maskFlag.EQ.4) THEN
              DO kj=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 0.0
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 0.0             
              ENDDO
              STREAMICE_ufacemask(i+ki,j,bi,bj) = 4.0
             ELSE IF (maskFlag.EQ.0) THEN
              DO kj=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 0.0
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 0.0             
              ENDDO
              STREAMICE_ufacemask(i+ki,j,bi,bj) = 0.0
             ELSE IF (maskFlag.EQ.1) THEN
              DO kj=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 0.0
              ENDDO
            END IF
           ENDDO

           DO kj=0,1
            maskFlag=INT(STREAMICE_vfacemask_bdry(i,j+kj,bi,bj))
            IF (maskFlag.EQ.3) THEN
              DO ki=0,1
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 3.0
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 3.0
              ENDDO
              STREAMICE_vfacemask(i,j+kj,bi,bj) = 3.0
           ELSE IF (maskFlag.EQ.2) THEN
              !DO ki=0,1
               STREAMICE_vfacemask(i,j+kj,bi,bj) = 2.0
              !ENDDO
           ELSE IF (maskFlag.EQ.4) THEN
              DO ki=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 0.0
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 0.0             
              ENDDO
              STREAMICE_vfacemask(i,j+kj,bi,bj) = 4.0
           ELSE IF (maskFlag.EQ.0) THEN
              DO ki=0,1
               STREAMICE_umask(i+ki,j+kj,bi,bj) = 0.0
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 0.0             
              ENDDO
              STREAMICE_vfacemask(i+ki,j,bi,bj) = 0.0
           ELSE IF (maskFlag.EQ.1) THEN
              DO ki=0,1
               STREAMICE_vmask(i+ki,j+kj,bi,bj) = 0.0
              ENDDO
            ENDIF
           ENDDO

           IF (i .lt. sNx+OLx) THEN
            IF ((STREAMICE_hmask(i+1,j,bi,bj) .eq. 0.0) .OR.
     &          (STREAMICE_hmask(i+1,j,bi,bj) .eq. 2.0))  THEN
            !right boundary or adjacent to unfilled cell
             STREAMICE_ufacemask(i+1,j,bi,bj) = 2.0
            ENDIF
           ENDIF

           IF (i .gt. 1-OLx) THEN
            IF ((STREAMICE_hmask(i-1,j,bi,bj) .eq. 0.0) .OR.
     &          (STREAMICE_hmask(i-1,j,bi,bj) .eq. 2.0))  THEN
            !left boundary or adjacent to unfilled cell
             STREAMICE_ufacemask(i,j,bi,bj) = 2
            ENDIF
           ENDIF

           IF (j .lt. sNy+OLy) THEN
            IF ((STREAMICE_hmask(i,j+1,bi,bj) .eq. 0.0) .OR.
     &          (STREAMICE_hmask(i,j+1,bi,bj) .eq. 2.0))  THEN
            !top boundary or adjacent to unfilled cell
             STREAMICE_vfacemask(i,j+1,bi,bj) = 2
            ENDIF
           ENDIF

           IF (j .gt. 1-OLy) THEN
            IF ((STREAMICE_hmask(i,j-1,bi,bj) .eq. 0.0) .OR.
     &          (STREAMICE_hmask(i,j-1,bi,bj) .eq. 2.0))  THEN
            !bot boundary or adjacent to unfilled cell
             STREAMICE_vfacemask(i,j,bi,bj) = 2.0
            ENDIF
           ENDIF

          ENDIF
         ENDDO
        ENDDO
       ENDDO
      ENDDO

      _EXCH_XY_RL( STREAMICE_ufacemask, myThid )
      _EXCH_XY_RL( STREAMICE_vfacemask, myThid )
      _EXCH_XY_RL( STREAMICE_umask, myThid )
      _EXCH_XY_RL( STREAMICE_vmask, myThid )

!       CALL WRITE_FULLARRAY_RL ("umask",STREAMICE_umask,
!      c   1,0,0,1,0,myThid)
!      CALL WRITE_FLD_XY_RL ("umask","",STREAMICE_umask,0,myThid)
!      CALL WRITE_FLD_XY_RL ("vmask","",STREAMICE_vmask,0,myThid)
!      CALL WRITE_FLD_XY_RL ("ufacemask","",STREAMICE_ufacemask,0,myThid)
!      CALL WRITE_FLD_XY_RL ("vfacemask","",STREAMICE_vfacemask,0,myThid)

#ifdef ALLOW_PETSC

      DO bj = myByLo(myThid), myByHi(myThid)
       DO bi = myBxLo(myThid), myBxHi(myThid)
        DO j=1,sNy
         DO i=1,sNx
           streamice_petsc_dofs_u (i,j,bi,bj) = -2.0
           streamice_petsc_dofs_v (i,j,bi,bj) = -2.0
         ENDDO
        ENDDO
       ENDDO
      ENDDO

      DoFCount = -1.0
      DO bj = myByLo(myThid), myByHi(myThid)
       DO bi = myBxLo(myThid), myBxHi(myThid)
        DO j=1,sNy
         DO i=1,sNx


C   DOFS ARE NUMBERED AS FOLLOWS ON PROCESSOR DOMAIN:
C    grid is stepped through in order bj, bi, j, i
C    1) if umask(i,j,bi,bj)==1, the counter is updated by 1;
C        streamice_petsc_dofs_u is assigned the counter;
C        o/w  streamice_petsc_dofs_u is assigned -1
C    2) if vmask(i,j,bi,bj)==1, the counter is updated by 1;
C        streamice_petsc_dofs_v is assigned the counter;
C        o/w  streamice_petsc_dofs_v is assigned -1
C    NOTE THESE NUMBERING ARRAYS ARE USED TO CONSTRUCT PETSC VECTORS AND MATRIX

          if (STREAMICE_umask (i,j,bi,bj).eq.1.0) THEN
           DoFCount = DoFCount + 1.0
           streamice_petsc_dofs_u (i,j,bi,bj) = DoFCount
          else
           streamice_petsc_dofs_u (i,j,bi,bj) = -1.0
          endif

          if (STREAMICE_vmask (i,j,bi,bj).eq.1.0) THEN
           DoFCount = DoFCount + 1.0
           streamice_petsc_dofs_v (i,j,bi,bj) = DoFCount
          else
           streamice_petsc_dofs_v (i,j,bi,bj) = -1.0
          endif

         ENDDO
        ENDDO
       ENDDO
      ENDDO

#ifdef ALLOW_USE_MPI 

      DO i=0,nPx*nPy-1
       n_dofs_proc_loc (i) = 0
      ENDDO

      CALL MPI_COMM_RANK( MPI_COMM_WORLD, mpiMyWId, mpiRC )

      n_dofs_proc_loc (mpiMyWId) = INT(DoFCount)+1

      CALL MPI_Allreduce(n_dofs_proc_loc,n_dofs_process,nPx*nPy,
     &       MPI_INTEGER, MPI_SUM,MPI_COMM_MODEL,mpiRC)

      n_dofs_cum_sum(0) = 0

      DO i=1,nPx*nPy-1
       n_dofs_cum_sum(i) = n_dofs_cum_sum(i-1)+
     &                     n_dofs_process(i-1)
      ENDDO

#else /* ALLOW_USE_MPI */

      n_dofs_process (0) = INT(DoFCount)+1
      n_dofs_cum_sum (0) = INT(DoFCount)+1

#endif /* ALLOW_USE_MPI */

      DO bj = myByLo(myThid), myByHi(myThid)
       DO bi = myBxLo(myThid), myBxHi(myThid)
        DO j=1,sNy
         DO i=1,sNx
          IF (streamice_petsc_dofs_u(i,j,bi,bj).ge.0 ) THEN
           streamice_petsc_dofs_u(i,j,bi,bj) =
     &      streamice_petsc_dofs_u(i,j,bi,bj) +
     &      n_dofs_cum_sum(mpimywid)
          ENDIF
          IF (streamice_petsc_dofs_v(i,j,bi,bj).ge.0 ) THEN
           streamice_petsc_dofs_v(i,j,bi,bj) =
     &      streamice_petsc_dofs_v(i,j,bi,bj) +
     &      n_dofs_cum_sum(mpimywid)
          ENDIF
         ENDDO
        ENDDO
       ENDDO
      ENDDO

      _EXCH_XY_RS(streamice_petsc_dofs_u,myThid)
      _EXCH_XY_RS(streamice_petsc_dofs_v,myThid)


#endif /* ALLOW_PETSC */


#endif
      RETURN
      END