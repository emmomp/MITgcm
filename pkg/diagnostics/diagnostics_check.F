C $Header: /u/gcmpack/MITgcm/pkg/diagnostics/diagnostics_check.F,v 1.10 2017/01/11 00:22:48 gforget Exp $
C $Name:  $

#include "DIAG_OPTIONS.h"

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
CBOP 0
C     !ROUTINE: DIAGNOSTICS_CHECK

C     !INTERFACE:
      SUBROUTINE DIAGNOSTICS_CHECK(myThid)

C     !DESCRIPTION:
C     Check option and parameter consistency

C     !USES:
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "DIAGNOSTICS_SIZE.h"
#include "DIAGNOSTICS.h"

C     !INPUT PARAMETERS:
      INTEGER myThid
CEOP

C     !LOCAL VARIABLES:
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      INTEGER ld,md,nd
      INTEGER k,m
      INTEGER jpoint1, ipoint1, jpoint2, ipoint2
      _RL     margin

      _BEGIN_MASTER(myThid)

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
C     Check diagnostics parameter consistency

      IF ( useMissingValue .AND. .NOT. diag_mnc ) THEN
        WRITE(msgBuf,'(2A)') '** WARNING ** DIAGNOSTICS_CHECK: ',
     &            'ignore "useMissingValue" since "diag_mnc" is off'
        CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &                      SQUEEZE_RIGHT , myThid )
      ENDIF

      IF ( diag_mnc.AND.(diagMdsDir.NE.' ') ) THEN
        WRITE(msgBuf,'(A,A)') 'S/R DIAGNOSTICS_CHECK: diagMdsDir ',
     &       'and pkg/mnc cannot be used together'
        CALL PRINT_ERROR( msgBuf, myThid )
        CALL ALL_PROC_DIE( 0 )
        STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
      ENDIF

      IF ( (mdsioLocalDir.NE.' ').AND.(diagMdsDir.NE.' ') ) THEN
        WRITE(msgBuf,'(A)')
     &   'S/R DIAGNOSTICS_CHECK: mdsioLocalDir and diagMdsDir cannot be'
        CALL PRINT_ERROR( msgBuf, myThid )
        WRITE(msgBuf,'(A)')
     &   'S/R DIAGNOSTICS_CHECK: specified at the same time'
        CALL PRINT_ERROR( msgBuf, myThid )
        CALL ALL_PROC_DIE( 0 )
        STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
      ENDIF

#ifdef DIAGNOSTICS_HAS_PICKUP
      IF ( diag_pickup_read ) THEN
        WRITE(msgBuf,'(2A)') '**CAUTION** (DIAGNOSTICS_CHECK): ',
     &   'reading diagnostics previous state'
        CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &       SQUEEZE_RIGHT , myThid)
        WRITE(msgBuf,'(2A)') '**CAUTION** ',
     &   ' from a pickup file can only work if data.diagnostics'
        CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &       SQUEEZE_RIGHT , myThid)
        WRITE(msgBuf,'(2A)') '**CAUTION** ',
     &   ' is not changed (<= further checking not yet implemented)'
        CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &       SQUEEZE_RIGHT , myThid)
      ENDIF
#else /* undef DIAGNOSTICS_HAS_PICKUP */
C-    stop if trying to use part of the code that is not compiled:
      IF ( diag_pickup_read  ) THEN
        WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &   'diag_pickup_read  is TRUE ',
     &   'but DIAGNOSTICS_HAS_PICKUP is "#undef"'
        CALL PRINT_ERROR( msgBuf , myThid)
      ENDIF
      IF ( diag_pickup_write ) THEN
        WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &   'diag_pickup_write is TRUE ',
     &   'but DIAGNOSTICS_HAS_PICKUP is "#undef"'
        CALL PRINT_ERROR( msgBuf , myThid)
      ENDIF
      IF ( diag_pickup_read .OR. diag_pickup_write ) THEN
        STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
      ENDIF
#endif /* DIAGNOSTICS_HAS_PICKUP */

C-    File names:
      DO ld = 2,nlists
       DO m = 1,ld-1
        IF ( fnames(ld).EQ.fnames(m) ) THEN
         WRITE(msgBuf,'(2A)') 'DIAGNOSTICS_CHECK: ',
     &            'found 2 identical filenames:'
         CALL PRINT_ERROR( msgBuf , myThid )
         WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &    '1rst (m=', m, ' ): ', fnames(m)
         CALL PRINT_ERROR( msgBuf , myThid )
         WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &    ' 2nd (n=', ld, ' ): ', fnames(ld)
         CALL PRINT_ERROR( msgBuf , myThid )
         STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
        ENDIF
       ENDDO
      ENDDO

      DO ld = 2,diagSt_nbLists
       DO m = 1,ld-1
        IF ( diagSt_Fname(ld).EQ.diagSt_Fname(m) ) THEN
         WRITE(msgBuf,'(2A)') 'DIAGNOSTICS_CHECK: ',
     &            'found 2 identical stat_fname:'
         CALL PRINT_ERROR( msgBuf , myThid )
         WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &    '1rst (m=', m, ' ): ', diagSt_Fname(m)
         CALL PRINT_ERROR( msgBuf , myThid )
         WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &    ' 2nd (n=', ld, ' ): ', diagSt_Fname(ld)
         CALL PRINT_ERROR( msgBuf , myThid )
         STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
        ENDIF
       ENDDO
      ENDDO

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
C-    Check for field that appears 2 times (or more) with differents frequency:
C     disable this checking since now diagnostics pkg can handle this case.

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|

C--   Vertical Interpolation: check for compatibility:
C     better to stop here, rather much later, when trying to write output
      DO ld = 1,nlists
       IF ( fflags(ld)(2:2).EQ.'P' ) THEN
        IF ( fluidIsAir ) THEN
C-    check that interpolated levels are >0 & fall within the domain +/- X %
C      (needs p>0 for p^kappa ; here take a 10 % margin)
          margin = rkSign*(rF(Nr+1)-rF(1))*0.1 _d 0
          DO k=1,nlevels(ld)
           IF ( levs(k,ld)-MAX(rF(1),rF(Nr+1)).GT.margin
     &     .OR. levs(k,ld)-MIN(rF(1),rF(Nr+1)).LT.-margin
     &     .OR. levs(k,ld).LE.0. ) THEN

            WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &       'Vertical Interp. for list l=', ld,
     &       ', filename: ', fnames(ld)
            CALL PRINT_ERROR( msgBuf , myThid )
            WRITE(msgBuf,'(2A,I4,3(A,F16.8))') 'DIAGNOSTICS_CHECK: ',
     &       ' lev(k=', k, ') p=', levs(k,ld),
     &       ' not in the domain:',rF(1),' :',rF(Nr+1)
            CALL PRINT_ERROR( msgBuf , myThid )
            STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
           ENDIF
          ENDDO
        ELSE
C-    p^kappa interpolation: meaningfull only if Atmosphere & P-coordiante
          WRITE(msgBuf,'(2A)') 'DIAGNOSTICS_CHECK: ',
     &       'INTERP_VERT not allowed in this config'
          CALL PRINT_ERROR( msgBuf , myThid )
           WRITE(msgBuf,'(2A,I5,2A)') 'DIAGNOSTICS_CHECK: ',
     &       ' for list l=', ld, ', filename: ', fnames(ld)
          CALL PRINT_ERROR( msgBuf , myThid )
          STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
        ENDIF
        IF (select_rStar.GT.0) THEN
C-    If nonlinear free surf is active, need averaged pressures
         DO md = 1,nfields(ld)
          nd = jdiag(md,ld)
          CALL DIAGNOSTICS_GET_POINTERS( 'RSURF   ', ld,
     &                                   jpoint1, ipoint1, myThid )
          IF ( useFIZHI .AND.
     &          gdiag(nd)(10:10) .EQ. 'L') THEN
           CALL DIAGNOSTICS_GET_POINTERS('FIZPRES ', ld,
     &                                   jpoint2, ipoint2, myThid )
          ELSE
           CALL DIAGNOSTICS_GET_POINTERS('RCENTER ', ld,
     &                                   jpoint2, ipoint2, myThid )
          ENDIF
          IF ( ipoint1.EQ.0 .OR. ipoint2.EQ.0 ) THEN
            WRITE(msgBuf,'(2A,I5)') 'DIAGNOSTICS_CHECK: ',
     &      'to interpolate diags from output list:', ld
            CALL PRINT_ERROR( msgBuf , myThid )
            IF ( ipoint1.EQ.0 .AND. jpoint1.EQ.0 ) THEN
              WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &        'needs to turn ON surface pressure diagnostic "RSURF   "'
              CALL PRINT_ERROR( msgBuf , myThid )
            ELSEIF ( ipoint1.EQ.0 ) THEN
              WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &        'needs surface pressure diagnostic "RSURF   " ',
     &        'with same output time'
              CALL PRINT_ERROR( msgBuf , myThid )
            ENDIF
            IF ( ipoint2.EQ.0 .AND. jpoint2.EQ.0 ) THEN
              WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &        'needs to turn ON  3-D pressure diagnostic "RCENTER "'
              CALL PRINT_ERROR( msgBuf , myThid )
            ELSEIF ( ipoint2.EQ.0 ) THEN
              WRITE(msgBuf,'(3A)') 'DIAGNOSTICS_CHECK: ',
     &        'needs  3-D pressure diagnostic "RCENTER " ',
     &        'with same output time'
              CALL PRINT_ERROR( msgBuf , myThid )
            ENDIF
            STOP 'ABNORMAL END: S/R DIAGNOSTICS_CHECK'
          ENDIF
         ENDDO
        ENDIF
       ENDIF
      ENDDO

      _END_MASTER(myThid)

      RETURN
      END
