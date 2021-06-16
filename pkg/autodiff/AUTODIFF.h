C $Header: /u/gcmpack/MITgcm/pkg/autodiff/AUTODIFF.h,v 1.16 2017/02/18 19:39:50 gforget Exp $
C $Name:  $

#ifdef ALLOW_AUTODIFF_WHTAPEIO
      COMMON /AUTODIFF_WHTAPEIO_I/
     &  tapeFileCounter, tapeMaxCounter, tapeFileUnit, tapeFileUnitS
      integer tapeFileCounter, tapeMaxCounter
      integer tapeFileUnit, tapeFileUnitS(4)
      COMMON /AUTODIFF_WHTAPEIO_L/ 
     &  tapeConcatIO, tapeSingleCpuIO, tapeBufferIO
      logical tapeConcatIO, tapeSingleCpuIO, tapeBufferIO
#endif

c ad dump record number (used only if dumpAdByRec is true)
      INTEGER dumpAdRecMn
      INTEGER dumpAdRecDy
      INTEGER dumpAdRecSi
      INTEGER dumpAdRecEt
      COMMON /AUTODIFF_DUMP_AD_REC/
     &       dumpAdRecMn, dumpAdRecDy, dumpAdRecSi,
     &       dumpAdRecEt
