C $Header: /u/gcmpack/MITgcm/pkg/bling/bling_diagnostics_init.F,v 1.6 2017/03/16 17:03:26 mmazloff Exp $
C $Name:  $

#include "GCHEM_OPTIONS.h"

CBOP
      subroutine BLING_DIAGNOSTICS_INIT(myThid )

C     =================================================================
C     | subroutine bling_diagnostics_init
C     | o Define diagnostics for bling pkg
C     =================================================================

      implicit none
      
C     === Global variables ===
#include "SIZE.h"
#include "EEPARAMS.h"

C  myThid               :: thread number
      INTEGER myThid
CEOP

#ifdef ALLOW_DIAGNOSTICS

C     !LOCAL VARIABLES:
      INTEGER       diagNum
      CHARACTER*8   diagName
      CHARACTER*16  diagCode
      CHARACTER*16  diagUnits
      CHARACTER*(80) diagTitle

C     Define diagnostics Names :

c biology

      diagName  = 'BLGPSM  '
      diagTitle = 'Small phytoplankton biomass (mol C/m3/s)'
      diagUnits = 'mol C/m3        '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPLG  '
      diagTitle = 'Large phytoplankton biomass (mol C/m3/s)'
      diagUnits = 'mol C/m3        '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPDIA '
      diagTitle = 'Diazotroph phytoplankton biomass (mol C/m3/s)'
      diagUnits = 'mol C/m3        '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGCHL  '
      diagTitle = 'Chlorophyll concentration'
      diagUnits = 'mol chl/m3      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPOCF '
      diagTitle = 'Particulate Organic Carbon Flux'
      diagUnits = 'mol C/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNPP  '
      diagTitle = 'Net Primary Production'
      diagUnits = 'mol C/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNCP  '
      diagTitle = 'Net Community Production'
      diagUnits = 'mol C/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPCM  '
      diagTitle = 'Maximum photosynthesis rate'
      diagUnits = '1/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGMU   '
      diagTitle = 'Phytoplankton growth rate'
      diagUnits = '1/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGMUDIA'
      diagTitle = 'Diazotroph growth rate'
      diagUnits = '1/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGIRRK '
      diagTitle = 'Nutrient-limited photosynthesis efficiency'
      diagUnits = 'W/m2   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGLLIM '
      diagTitle = 'Light limitation'
      diagUnits = '-      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNLIM '
      diagTitle = 'N limitation'
      diagUnits = '-      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPLIM '
      diagTitle = 'P limitation'
      diagUnits = '-      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFELIM'
      diagTitle = 'Fe limitation'
      diagUnits = '-      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c carbon system

      diagName  = 'BLGPCO2 '
      diagTitle = 'Surface ocean partial pressure of CO2'
      diagUnits = 'atm             '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPH3D '
      diagTitle = 'pH'
      diagUnits = 'dimensionless   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGOMAR '
      diagTitle = 'Aragonite saturation'
      diagUnits = 'dimensionless   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGCFLX '
      diagTitle = 'Flux of CO2 due to air-sea exch (mol/m2/s)'
      diagUnits = 'mol/m2/sec      '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

#ifdef USE_EXFCO2
      diagName  = 'EXFapco2 '
      diagTitle = 'Atmospheric partial pressure of CO2'
      diagUnits = '10^-6 ppm       '
      diagCode  = 'SM      U1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I          diagName, diagCode, diagUnits, diagTitle, 0, myThid )
#endif

c oxygen

      diagName  = 'BLGOFLX '
      diagTitle = 'Flux of O2 due to air-sea exch (mol/m2/s)'
      diagUnits = 'mol/m2/sec   '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c iron

      diagName  = 'BLGSURFE'
      diagTitle = 'Surface deposition of Fe (mol/m2/s)'
      diagUnits = 'mol/m2/sec   '
      diagCode  = 'SM P    L1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEUP '
      diagTitle = 'Iron uptake by bio'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFESPM'
      diagTitle = 'Iron sinking particle flux'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEREM'
      diagTitle = 'Iron remin of sinking organic matter'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFERD '
      diagTitle = 'Iron remin from Diel Vertical Migration'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEREC'
      diagTitle = 'Iron recycling'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEADI'
      diagTitle = 'Iron inorganic adsorption'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEADO'
      diagTitle = 'Iron organic adsorption'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFESED'
      diagTitle = 'Iron sediment source'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGFEBUR'
      diagTitle = 'Iron burial into sediment'
      diagUnits = 'mol Fe/m3/s     '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c nitrogen

      diagName  = 'BLGNUP  '
      diagTitle = 'Nitrogen uptake by bio'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNFIX '
      diagTitle = 'Nitrogen fixation'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNSPM '
      diagTitle = 'Nitrogen sinking particle flux'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNREM '
      diagTitle = 'Nitrogen remin of sinking org matter'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNDVM '
      diagTitle = 'Nitrogen vertical flux due to DVM'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNRD  '
      diagTitle = 'Nitrogen remin by Diel Vertical Migration'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNREC '
      diagTitle = 'Nitrogen recycling'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNDENB'
      diagTitle = 'Benthic denitrification'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNDENP'
      diagTitle = 'Pelagic denitrification'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGDONP '
      diagTitle = 'Dissolved Organic Nitrogen Production'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGDONR '
      diagTitle = 'Dissolved Organic Nitrogen Remineralization'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c phosphorus 

      diagName  = 'BLGPUP  '
      diagTitle = 'Phosphorus uptake by bio'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPSPM '
      diagTitle = 'Phosphorus sinking particle flux'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPREM '
      diagTitle = 'Phosphorus remin of sinking org matter'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPDVM '
      diagTitle = 'Phosphorus vertical flux due to DVM'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPRD  '
      diagTitle = 'Phosphorus remin by Diel Vertical Migration'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPREC '
      diagTitle = 'Phosphorus recycling'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGDOPP '
      diagTitle = 'Dissolved Organic Phosphorus Production'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c light

      diagName  = 'BLGQSW  '
      diagTitle = 'Effective irradiance'
      diagUnits = 'W/m2   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGIRRIS'
      diagTitle = 'Effective irradiance'
      diagUnits = 'W/m2   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGIEFF '
      diagTitle = 'Effective irradiance'
      diagUnits = 'W/m2   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGIMEM '
      diagTitle = 'Irradiance memory'
      diagUnits = 'W/m2   '
      diagCode  = 'SM P    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

c bgc

      diagName  = 'BLGBIOC '
      diagTitle = 'Tendency of DIC due to biology (mol C/m3/s)'
      diagUnits = 'mol C/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGBIOAL'
      diagTitle = 'Tendency of alkalinity due to biology (mol alk/m3/s)'
      diagUnits = 'mol alk/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGBIOO2'
      diagTitle = 'Tendency of oxygen due to biology (mol O/m3/s)'
      diagUnits = 'mol O/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGBION '
      diagTitle = 'Tendency of nitrate due to biology (mol N/m3/s)'
      diagUnits = 'mol N/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGBIOP '
      diagTitle = 'Tendency of phosphate due to biology (mol P/m3/s)'
      diagUnits = 'mol P/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGBIOFE'
      diagTitle = 'Tendency of iron due to biology (mol Fe/m3/s)'
      diagUnits = 'mol Fe/m3/sec    '
      diagCode  = 'SMRP    MR      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGNSED '
      diagTitle = 'Nitrogen flux in/out of sediments'
      diagUnits = 'mol N/m3/s      '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGPSED '
      diagTitle = 'Phosphorus flux in/out of sediments'
      diagUnits = 'mol P/m3/s      '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

      diagName  = 'BLGOSED '
      diagTitle = 'Oxygen flux in/out of sediments'
      diagUnits = 'mol O/m3/s      '
      diagCode  = 'SM P    M1      '
      CALL DIAGNOSTICS_ADDTOLIST( diagNum,
     I       diagName, diagCode, diagUnits, diagTitle, 0, myThid )

#endif /* ALLOW_DIAGNOSTICS */

      RETURN
      END
