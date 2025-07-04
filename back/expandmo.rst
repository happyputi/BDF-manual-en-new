expandmo Module
================================================
The `expandmo` module primarily implements the expansion of molecular orbitals from small basis sets to large basis sets to accelerate molecular orbital optimization in large basis sets. It also enables automatic generation of localized and canonical active orbitals, among other functions.

**Basic Control Parameters**

:guilabel:`Overlap` Parameter Type: Boolean
------------------------------------------------
Specifies expanding SCF-derived molecular orbitals from a small basis set to a large basis set to accelerate molecular orbital optimization in the large basis set.

:guilabel:`Overcri` Parameter Type: Floating-point
------------------------------------------------
Sets the occupation threshold for orbitals defined by the "Overlap" keyword: Orbitals with occupations exceeding this value are defined as occupied orbitals.
* Default: 0.0

:guilabel:`Sb2lb` Parameter Type: Boolean
------------------------------------------------
Uses molecular orbitals (MOs) from MCSCF calculations in a small basis set as initial guess orbitals for MCSCF calculations in a large basis set. See test150.inp for a specific example.

* Functionality:
  Basis set expansion strategy: Accelerates convergence in large basis sets by using orbitals optimized in a small basis set as starting points.
  Application scenario: Optimizes computational workflows during basis set upgrades, reducing iterations and resource consumption.
  File reference: test150.inp demonstrates parameter settings for orbital initialization during basis set transitions.

:guilabel:`Sbolb` Parameter Type: Boolean
------------------------------------------------
Specifies calculation of orbital overlap matrices.
Computes and outputs the overlap matrix between molecular orbitals (MOs) in a small basis set (`$BDF_WORKDIR/$BDFTASK.sbforb`) and a large basis set (`$BDF_WORKDIR/$BDFTASK.lbforb`).

* Functionality:
  1. Purpose: Quantifies orbital overlap between different basis sets, aiding analysis of basis set expansion effects on orbital properties.
  2. Output format: Matrix data written to specified output files as row-column numerical tables.
  3. Typical applications: Orbital continuity validation during basis set upgrades, pre-screening for automatic active space selection.

:guilabel:`S12cmo` Parameter Type: Boolean
------------------------------------------------
Computes orbital overlap matrices between two molecular configurations and matches orbitals of the second configuration to those of the first configuration to maximize similarity. Currently applicable only to molecular systems without symmetry.

Configuration 1 files:
Checkpoint file: `$BDF_WORKDIR/$BDFTASK.chkfil1`
Canonical molecular orbital (CMO) file: `$BDF_WORKDIR/$BDFTASK.inporb1`

Configuration 2 files:
Checkpoint file: `$BDF_WORKDIR/$BDFTASK.chkfil2`
Canonical molecular orbital (CMO) file: `$BDF_WORKDIR/$BDFTASK.inporb2`

* Functionality:
  1. Purpose: Quantifies orbital overlap between configurations (e.g., pre-/post-geometry optimization, reaction path nodes) to analyze electronic state changes.
  2. Output format: Matrix data written to specified output files as row-column numerical tables.
  3. Typical applications: Transition state analysis, configuration correlation studies, orbital continuity tracking.

.. code-block:: bdf
      $compass
      title
      c2h4 molecule test run
      basis
      cc-pvdz
      geometry
      c 0.00000000 0.00000000 1.25306000
      c 0.00000000 0.00000000 -1.25306000
      h 1.74646000 0.00000000 2.37500000
      h -1.74646000 0.00000000 2.37500000
      h 1.74646000 0.00000000 -2.37500000
      h -1.74646000 0.00000000 -2.37500000
      end geometry
      nosym
      unit
      bohr
      skeleton
      RI-C
      cc-pvdz
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.chkfil $BDF_WORKDIR/$BDFTASK.chkfil1
      
      $xuanyuan
      $end
      
      $scf
      RHF
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.scforb $BDF_WORKDIR/$BDFTASK.inporb
      
      $expandmo
      vcmo
      minbas
      4
      1C|2P-1  
      1C|2P0   
      2C|2P-1   
      2C|2P0   
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.exporb $BDF_WORKDIR/$BDFTASK.inporb
      
      $mcscf
      automc
      spin
      1
      roots
      2 2 1
      symmetry
      1
      guess
      read
      molden
      quasi
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.casorb $BDF_WORKDIR/$BDFTASK.inporb1
      
      $compass
      title
      c2h4 molecule test run
      basis
      cc-pvdz
      geometry
      c 0.00000000 0.00000000 1.35306000
      c 0.00000000 0.00000000 -1.35306000
      h 1.74646000 0.00000000 2.37500000
      h -1.74646000 0.00000000 2.37500000
      h 1.74646000 0.00000000 -2.37500000
      h -1.74646000 0.00000000 -2.37500000
      end geometry
      #nosym
      unit
      bohr
      skeleton
      RI-C
      cc-pvdz
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.chkfil $BDF_WORKDIR/$BDFTASK.chkfil2
      
      $xuanyuan
      $end
      
      $scf
      RHF
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.scforb $BDF_WORKDIR/$BDFTASK.inporb
      
      $expandmo
      vcmo
      minbas
      4
      1C|2P-1  
      1C|2P0   
      2C|2P-1   
      2C|2P0   
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.exporb $BDF_WORKDIR/$BDFTASK.inporb
      
      $mcscf
      automc
      #close
      #6
      #active
      #4
      #actele
      #4
      spin
      1
      roots
      2 2 1
      symmetry
      1
      guess
      read
      molden
      quasi
      $end
      
      %cp $BDF_WORKDIR/$BDFTASK.casorb $BDF_WORKDIR/$BDFTASK.inporb2
      
      $expandmo
      s12cmo
      $end
      

:guilabel:`Core` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of frozen doubly-occupied (inactive) orbitals per irreducible representation. 

:guilabel:`Close` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of non-frozen doubly-occupied (inactive) orbitals per irreducible representation. 

:guilabel:`Active` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of active orbitals per irreducible representation. 

:guilabel:`Acte` Parameter Type: Integer
------------------------------------------------
Specifies the number of active electrons.

:guilabel:`Phosp` Parameter Type: Integer
------------------------------------------------
Sets projected hybrid orbitals (PHO) as active atomic orbitals, supporting sp²/sp³/sp hybrid system modeling.

.. code-block:: bdf
   PHOSP
   2  ! Line 1: Total hybridized atoms
   2 1 2 3 4 0  ! Line 2: sp² parameters: (n=2) (center atom 1) (coordinating atoms 2,3,4) (0: no adjacent atom)
   ! Parameter details:
   ! 2 → Principal quantum number n=2 (operates on 2s/2p orbitals)
   ! 1 → Center atom ID 1
   ! 2 3 4 → Three coordinating atom IDs
   ! 0 → Marks sp² hybridization (non-zero triggers sp³)
   2 2 1 5 6 7  ! Line 3: sp³ parameters: (n=2) (center atom 2) (coordinating atoms 1,5,6,7) 
   3 4 1 5 0 0  ! Line 4: sp parameters: (n=3) (center atom 4) (coordinating atoms 1,5) (0,0: no adjacent atoms) 

.. attention:: 

   If specific hybrid orbitals (e.g., sp³) are desired but insufficient adjacent atoms exist, substitute with nearby secondary atoms.
   This keyword generates approximate hybrid atomic orbitals for initial guesses of specific bond-type molecular orbitals. Final MOs are generated by MCSCF calculations.

:guilabel:`Minbas` Parameter Type: String
------------------------------------------------
Specifies selected active (hybrid) atomic orbitals. If "Phosp" is used, hybrid atomic orbitals are selected.
First line specifies the number of selected orbitals.
Subsequent lines define each atomic orbital.
* Must strictly use atomic orbital symbols from COMPASS output (case-insensitive).
  Standard basis format: "Element|Orbital" (e.g., 1Co|3D0).
  Prefix "1" = atom serial number, "Co3" = basis set index. Orbital symbols must match internal definitions exactly.
* Modifying orbital symbol naming conventions is prohibited.

.. attention::
   When PHOsp is enabled, BDF's atomic orbital ordering rules apply:

   1. sp³ hybridization (atom + 4 neighbors):
   s0  : Hybrid AO bonded to 1st neighbor
   p-1 : Hybrid AO bonded to 2nd neighbor
   p1  : Hybrid AO bonded to 3rd neighbor
   p0  : Hybrid AO bonded to 4th neighbor

   2. sp² hybridization (atom + 3 neighbors):
   s0  : Hybrid AO bonded to 1st neighbor
   p-1 : Hybrid AO bonded to 2nd neighbor
   p1  : Hybrid AO bonded to 3rd neighbor
   p0  : Hybrid AO (approximately) perpendicular to S0, P-1, P1

   3. sp hybridization (atom + 2 neighbors):
   s0  : Hybrid AO bonded to 1st neighbor
   p-1 : Hybrid AO bonded to 2nd neighbor
   p1  : Lone-pair hybrid AO
   p0  : Second lone-pair hybrid AO

:guilabel:`Avas` Parameter Type: Boolean
------------------------------------------------
Generates quasi-canonical molecular orbitals including active molecular orbitals derived from "Minbas"-selected atomic orbitals using the Atomic Valence Active Space (AVAS) method. Automatically generated doubly-occupied, active, and virtual orbitals are sorted by ascending energy.

:guilabel:`Vcmo` Parameter Type: Boolean
------------------------------------------------
Generates quasi-canonical molecular orbitals including active molecular orbitals derived from "Minbas"-selected atomic orbitals using the Imposed CAS (iCAS) method. Automatically generated doubly-occupied, active, and virtual orbitals are sorted by ascending energy.

:guilabel:`Localmo` Parameter Type: Boolean
------------------------------------------------
Localizes quasi-canonical molecular orbitals generated by "Vcmo", categorized as doubly-occupied, active, and virtual orbitals.
* Default: Generates Pipek-Mezey localized orbitals.

:guilabel:`Vlmo` Parameter Type: Boolean
------------------------------------------------
Contracts the Fock matrix to active atomic orbitals, diagonalizes it, and localizes valence canonical molecular orbitals (VCMOs) to generate valence pre-localized molecular orbitals (pre-LMOs). Automatically selects active localized molecular orbitals (LMOs) or fragment localized molecular orbitals (FLMOs).

.. attention::
   Only supports symmetric systems. pre-LMOs currently support generation only from pre-CMOs via localization (external orbital input not supported).
   Default localization method: Pipek-Mezey. Other methods (e.g., "Boys") can be selected via keywords.

:guilabel:`Nolmocls` Parameter Type: Boolean
------------------------------------------------
Specifies no localization of doubly-occupied orbitals generated by "Vcmo" or "Vlmo".

:guilabel:`Nolmoact` Parameter Type: Boolean
------------------------------------------------
Specifies no localization of active orbitals generated by "Vcmo" or "Vlmo".

:guilabel:`Nolmovir` Parameter Type: Boolean
------------------------------------------------
Specifies no localization of virtual orbitals generated by "Vcmo" or "Vlmo".

:guilabel:`Pipek` Parameter Type: Boolean
------------------------------------------------
Specifies localization of quasi-canonical molecular orbitals into Pipek-Mezey localized orbitals.
* Default: Uses Mulliken charges. For Löwdin charges, use keyword "Lowdin".
* Default: First-order Jacobi sweep iteration. For second-order trust-region method, use keyword "Trust".
  
:guilabel:`Boys` Parameter Type: Boolean
------------------------------------------------
Specifies localization of quasi-canonical molecular orbitals into Boys localized orbitals.
* Not supported for symmetric molecular systems.

:guilabel:`mBoys` Parameter Type: Integer
------------------------------------------------
Specifies localization of quasi-canonical molecular orbitals into mBoys localized orbitals.
* Not supported for symmetric molecular systems.

.. code-block:: bdf
   mBoys
   2  ! Specifies powern value

:guilabel:`Cdloc` Parameter Type: Boolean
------------------------------------------------
Specifies localization of quasi-canonical molecular orbitals into Cholesky localized orbitals.

:guilabel:`Maxcycle` Parameter Type: Integer
------------------------------------------------
Sets maximum iterations for localization calculations.
* Default: 3000

:guilabel:`Thresh` Parameter Type: Floating-point
------------------------------------------------
Sets two convergence thresholds for localization iterations.
* Default: 1.d-6 1.d-6

:guilabel:`Highsym` Parameter Type: Boolean
------------------------------------------------
Specifies atomic orbitals for high-order point groups.

:guilabel:`VSD` Parameter Type: Boolean
------------------------------------------------
Partitions virtual molecular orbitals (VMOs) in large basis sets into strongly and weakly correlated spaces via singular value decomposition (SVD) screening conditions.

* Complete input logic example: test126.inp

**Test Cases**

:guilabel:`test071.inp`
------------------------------------------------

:guilabel:`test080.inp`
------------------------------------------------

:guilabel:`test086.inp`
------------------------------------------------

:guilabel:`test100.inp`
------------------------------------------------

:guilabel:`test114.inp`
------------------------------------------------

:guilabel:`test126.inp`
------------------------------------------------

:guilabel:`test131.inp`
------------------------------------------------

:guilabel:`test148.inp`
------------------------------------------------

:guilabel:`test150.inp`
------------------------------------------------