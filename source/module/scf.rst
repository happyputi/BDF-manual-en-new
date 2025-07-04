Hartree-Fock and Kohn-Sham Self-Consistent Field Calculations - SCF Module
================================================
The SCF module is one of BDF's core computational modules, performing Hartree-Fock and DFT calculations.

**Method Keywords**

:guilabel:`RHF` / :guilabel:`UHF` / :guilabel:`ROHF` Parameter Type: Boolean
------------------------------------------------------------------------
For Hartree-Fock calculations, one of these three parameters must be selected to control the calculation type.

 * ``RHF``: Restricted Hartree-Fock
 * ``UHF``: Unrestricted Hartree-Fock
 * ``ROHF``: Restricted Open-shell Hartree-Fock

:guilabel:`RKS` / :guilabel:`UKS` / :guilabel:`ROKS` Parameter Type: Boolean
------------------------------------------------------------------------
For DFT calculations, one of these three parameters must be selected to control the calculation type.

 * ``RKS``: Restricted Kohn-Sham
 * ``UKS``: Unrestricted Kohn-Sham
 * ``ROKS``: Restricted Open-shell Kohn-Sham

**Wavefunction and Occupancy Keywords**

:guilabel:`Charge` Parameter Type: Integer
------------------------------------------------
 * Default: 0

Specifies the net charge of the molecular system.

:guilabel:`Spinmulti` Parameter Type: Integer
---------------------------------------------------
 * Default: 1 for even-electron systems, 2 for odd-electron systems

Specifies the spin multiplicity of the molecular system. Defined as 2S+1 (where S is the spin angular momentum). Can be calculated as | *number of spin-up electrons* - *number of spin-down electrons* | + 1. Therefore, when all unpaired electrons have parallel spins, the spin multiplicity equals the number of unpaired electrons plus one.

:guilabel:`Occupy` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of doubly-occupied molecular orbitals per irreducible representation for RHF/RKS calculations.

:guilabel:`Alpha` Parameter Type: Integer Array
---------------------------------------------------
See Beta entry below.

:guilabel:`Beta` Parameter Type: Integer Array
---------------------------------------------------
Alpha and Beta must be used together for UHF/UKS calculations, specifying the number of occupied alpha or beta orbitals per irreducible representation.

:guilabel:`Guess` Parameter Type: String
---------------------------------------------------
 * Default: atom
 * Options: atom, Hcore, Huckel, Readmo

Specifies the type of initial guess. Normally, `atom` is better than `Hcore` or `Huckel`. If `Readmo` is selected, the program checks for the existence of the following files in order:

 1. $BDF_TMPDIR/$BDFTASK.inporb
 2. $BDF_TMPDIR/inporb
 3. $BDF_WORKDIR/$BDFTASK.scforb

($BDF_TMPDIR is the current BDF temporary directory, $BDF_WORKDIR is the current BDF working directory, $BDFTASK is the input filename without the `.inp` suffix). The program reads the orbital information from the first existing file in this list. If reading fails or the orbital information is incompatible (e.g., different number of basis functions), it automatically switches to the `atom` guess. Read orbitals undergo Löwdin orthogonalization before SCF iteration.

.. hint::
     The orbital file must match the current calculation in the following aspects:
     
     1. Same number and types of atoms;
     2. Same atom ordering;
     3. Same point group;
     4. Same basis set;
     5. Both calculations must be RHF/RKS/ROHF/ROKS OR both must be UHF/UKS.
     
     Other aspects (coordinates, charge, spin multiplicity, functional, etc.) can differ. If points (1), (2), (3), (5) are satisfied but not (4), use the ``expandmo`` module to project the orbitals to the current basis set before reading as an initial guess (see :doc:`expandmo`).

Example: If a calculation was run at B3LYP/def2-TZVP (input `mol-B3LYP-Energy.inp`), and you want to run an M06-2X/def2-TZVP calculation on a different structure (input `mol-M062X-Energy.inp`), you can reuse the converged SCF wavefunction:

.. code-block:: bash

     cp mol-B3LYP-Energy.scforb mol-M062X-Energy.scforb

Add to the `$scf` block in `mol-M062X-Energy.inp`:
.. code-block:: bdf

     guess
      readmo

This reads the B3LYP wavefunction (despite different structure/functional) as the initial guess.

:guilabel:`SadGuessAverageOutPartiallyFilledShell`/:guilabel:`SadAvgPart` Parameter Type: Boolean
-------------------------------------------------------------------------------------------------
Specifies using atomic calculations with partially filled shells averaged for the Superposition of Atomic Density (SAD) initial guess. Default and only option when `SecScf` is disabled.

:guilabel:`SadGuessAverageOutValenceShell`/:guilabel:`SadAvgVal` Parameter Type: Boolean
----------------------------------------------------------------------------------------
Specifies using atomic calculations with valence shells averaged for the SAD initial guess. Only usable when `SecScf` is enabled.

:guilabel:`SadGuessAverageOutPartiallyFilledShellFor`/:guilabel:`SadAvgPartFor` Parameter Type: Integer
-------------------------------------------------------------------------------------------------------
Specifies using partially filled shell averaging for specific atomic numbers in SAD initial guess. Use multiple times for multiple elements.

:guilabel:`SadGuessAverageOutValenceShellFor`/:guilabel:`SadAvgValFor` Parameter Type: Integer
-------------------------------------------------------------------------------------------
Specifies using valence shell averaging for specific atomic numbers in SAD initial guess. Use multiple times for multiple elements.

:guilabel:`Mixorb` Parameter Type: Integer/Floating-point Array
---------------------------------------------------
Mixes initial guess orbitals in specified proportions. The first line after `Mixorb` is an integer `N` (number of orbital pairs to mix). Lines 2 to `N+1` contain 5 numbers per line: mixing details. First number: alpha(1)/beta(2) orbital (must be 1 for RHF/RKS/ROHF/ROKS). Second number: irrep index (must be 1 for no symmetry). Third and fourth numbers: orbital indices within the irrep. Fifth number: mixing angle θ (degrees). Mixing formula:

 * New orbital 1 = cosθ × original orbital 1 + sinθ × original orbital 2
 * New orbital 2 = sinθ × original orbital 1 - cosθ × original orbital 2

Common angles: θ=45° (equal mixing), θ=90° (swap orbitals). Example mixing beta orbitals 10 and 11 in irrep 3 (for spin symmetry breaking):

.. code-block:: bdf

     $scf
     UHF
     guess
      readmo
     mixorb
      1
      2,3,10,11,45
     $end

Example swapping orbitals:

.. code-block:: bdf

     $scf
     ROHF
     guess
      readmo
     mixorb
      2
      1,5,7,8,90  # Swap orbitals 7 and 8 in irrep 5
      1,6,3,4,90  # Swap orbitals 3 and 4 in irrep 6
     $end

Note: `Mixorb` is typically used with `Guess=readmo`, as orbital composition is unknown otherwise.

**DFT Exchange-Correlation Functional Keywords**

:guilabel:`DFT` Parameter Type: String
---------------------------------------------------
Specifies the exchange-correlation functional for DFT calculations. See BDF's supported functional list.

:guilabel:`D3` Parameter Type: Boolean
------------------------------------------------
Specifies adding Grimme's D3 dispersion correction to DFT calculations.

:guilabel:`FACEX` Parameter Type: Floating-point
---------------------------------------------------
Specifies the HF exchange fraction in the functional. Currently only SVWN, SVWN5, PBE, PBE0, PW91, BP86, BLYP, B3LYP, GB3LYP, B3PW91, BHHLYP, SF5050, B2PLYP allow user-defined FACEX. Example changing PBE HF exchange to 37.5% (PBE38):

.. code-block:: bdf

 $scf
 ...
 DFT
  PBE
 facex
  0.375
 $end

:guilabel:`FACCO` Parameter Type: Floating-point
---------------------------------------------------
Specifies the MP2 correlation fraction in the functional. Currently only B2PLYP allows user-defined FACCO. Example customizing B2PLYP to DSD-BLYP:

.. code-block:: bdf

 $scf
 ...
 dft
  B2PLYP
 facex
  0.75
 facco
  0.47
 $end

 $mp2
 fss
  0.60
 fos
  0.46
 $end

:guilabel:`RSOMEGA` / :guilabel:`RS` Parameter Type: Floating-point
-------------------------------------------------------------------
Specifies the ω parameter (some literature uses μ) for range-separated functionals (e.g., CAM-B3LYP). `RS` is a synonym for `RSOMEGA`. Primarily for debugging in the **scf** module; recommended to set in :ref:`xuanyuan<xuanyuan>` module.

**DFT Numerical Integration Grid Control Keywords**

:guilabel:`NPTRAD` Parameter Type: Integer
---------------------------------------------------
Specifies radial grid points for numerical integration. Primarily for debugging.

:guilabel:`NPTANG` Parameter Type: Integer
------------------------------------------------
Specifies angular grid points for numerical integration. Primarily for debugging.

:guilabel:`Grid` Parameter Type: String
------------------------------------------------
 * Default: Medium
 * Options: Ultra Coarse, Coarse, Medium, Fine, Ultra Fine

Specifies DFT numerical integration grid type.

:guilabel:`Gridtol` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.0E-6 (1.0E-8 for meta-GGA)
 
Specifies the cutoff threshold for generating DFT adaptive grids. Lower values increase grid points, precision, and computational cost.

:guilabel:`Gridtype` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1, 2, 3

Specifies radial and angular grid point generation method.

:guilabel:`Partitiontype` Parameter Type: Integer
---------------------------------------------------
 * Default: 1
 * Options: 0, 1

Specifies DFT grid partitioning type: 0 = Becke, 1 = Stratmann-Scuseria-Frisch.

:guilabel:`Numinttype` Parameter Type: Integer
------------------------------------------------
 * Default: 0

Specifies numerical integration calculation method. Primarily for debugging.

:guilabel:`NosymGrid` Parameter Type: Boolean
---------------------------------------------------
Specifies not using molecular symmetry for numerical integration. For debugging.

:guilabel:`DirectGrid` / :guilabel:`NoDirectGrid` Parameter Type: Boolean
--------------------------------------------------------------------
Specifies direct integration mode (no storage of basis function values). Required for DirectSCF. `NoDirectGrid` only relevant for non-DirectSCF. Primarily for debugging.

:guilabel:`NoGridSwitch` Parameter Type: Boolean
------------------------------------------------
Disables grid switching during SCF iterations. By default, BDF starts with an `ultra coarse` grid and switches to the user-specified grid after a threshold. This forces the user-specified grid throughout.

:guilabel:`ThreshRho` & :guilabel:`ThreshBSS` Parameter Type: Floating-point
---------------------------------------------------------------------
Controls grid pre-screening thresholds. For debugging.

**SCF Acceleration Algorithms**

:guilabel:`MPEC+COSX` Parameter Type: Boolean
------------------------------------------------
Specifies using Multipole Expansion of Coulomb potential (MPEC) for the J matrix and Chain-of-Sphere Exchange (COSX) for the K matrix. Retained for backward compatibility; recommended to set in `Compass` module.

:guilabel:`Coulpot` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1, 2

Controls MPEC calculation method for Coulomb potential (Vc) and nuclear attraction (Vn) matrices:
* 0: Analytical integration for Vc and Vn
* 1: Multipole expansion for Vc, analytical for Vn
* 2: Multipole expansion for Vc, numerical integration for Vn

:guilabel:`Coulpotlmax` Parameter Type: Integer
---------------------------------------------------
 * Default: 8
 
Maximum angular momentum L for MPEC multipole expansion.

:guilabel:`Coulpottol` Parameter Type: Integer
------------------------------------------------
 * Default: 8 (meaning 1.0E-8)
 
Precision threshold for multipole expansion (higher = more precise).

:guilabel:`MPEC` Parameter Type: Boolean
------------------------------------------------
Specifies using MPEC for J matrix calculation.

:guilabel:`COSX` Parameter Type: Boolean
------------------------------------------------
Specifies using COSX for K matrix calculation.

**SCF Convergence Control Keywords**

:guilabel:`Maxiter` Parameter Type: Integer
---------------------------------------------------
 * Default: 100

Maximum SCF iterations.

:guilabel:`Vshift` Parameter Type: Floating-point
------------------------------------------------
 * Default: 0
 * Options: Non-negative real
 * Recommended range (if non-zero): 0.2~1.0
 
Shifts virtual orbital energies by the specified value to increase the HOMO-LUMO gap and accelerate convergence. Larger values reduce oscillations but slow convergence. Useful for molecules with small HOMO-LUMO gaps (< 2 eV) and non-monotonic energy convergence.

:guilabel:`Damp` Parameter Type: Floating-point
---------------------------------------------------
 * Default: 0
 * Options: Real number ≥ 0 and < 1
 * Recommended range (if non-zero): 0.5~0.99
 
Mixes the current and previous density matrices: P(i) := (1-C) × P(i) + C × P(i-1). Larger damping factors reduce oscillations but slow convergence. Useful for non-monotonic energy convergence.

:guilabel:`ThrEne` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.d-8

SCF energy convergence threshold (Hartree).

:guilabel:`ThrDen` Parameter Type: Floating-point
------------------------------------------------
 * Default: 5.d-6

SCF root-mean-square (RMS) density matrix element convergence threshold.

:guilabel:`ThreshConv` Parameter Type: Floating-point
---------------------------------------------------
Simultaneously sets SCF energy and density matrix thresholds. Example:

.. code-block:: bdf

     $scf
     ...
     ThreshConv
      1.d-6 1.d-4
     $end
 
Equivalent to:

.. code-block:: bdf

     $scf
     ...
     ThrEne
      1.d-6
     ThrDen
      1.d-4
     $end

.. hint::

 SCF convergence is declared if ANY of the following is met:
 (1) Energy change < ThrEne AND RMS density change < ThrDen
 (2) Energy change < 0.1 × ThrEne AND RMS density change < 1.5 × ThrDen
 (3) Maximum density matrix element change < ThrDen

:guilabel:`NoXiis`/:guilabel:`NoDiis` Parameter Type: Boolean
----------------------------------------------------------
Disables DIIS family convergence acceleration. Use only if SCF oscillates significantly (> 1.0E-5) and `Damp`/`VShift` are ineffective.

:guilabel:`Diis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the traditional DIIS algorithm. Default.

:guilabel:`Lciis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the LCIIS algorithm.

:guilabel:`Ediis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the EDIIS algorithm. Prefer `EdiisPlusDiis` over pure EDIIS.

:guilabel:`Adiis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the ADIIS algorithm. Prefer `AdiisPlusDiis` over pure ADIIS.

:guilabel:`EdiisPlusDiis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the EDIIS + DIIS algorithm.

:guilabel:`AdiisPlusDiis` Parameter Type: Boolean
-----------------------------------------------------
Specifies using the ADIIS + DIIS algorithm.

:guilabel:`MaxXiis`/:guilabel:`MaxDiis` Parameter Type: Integer
-----------------------------------------------------------
 * Default: 8

Maximum subspace dimension for DIIS family methods.

:guilabel:`MinXiis`/:guilabel:`MinDiis` Parameter Type: Integer
-----------------------------------------------------------
 * Default: 2

Minimum subspace dimension for DIIS family methods.

:guilabel:`XiisMode`/:guilabel:`DiisMode` Parameter Type: Integer
--------------------------------------------------------------------
Controls subspace storage strategy when maximum dimension is reached:
 * Default: 0 (Discard oldest entries until subspace is at minimum size)
 * Options: 0, 1 (Discard the oldest entry), 3 (Discard entry with largest RMS error), 4 (Discard entry with largest absolute error element)

.. note::
    * Options 3 and 4 require `NLopt`
    * Options 3 and 4 often converge better than 0 but may cause oscillations (try level shifting)

:guilabel:`DoNotOrthogonalizeDiisErrorMatrix` Parameter Type: Boolean
--------------------------------------------------------------------
Specifies using non-orthogonalized error vectors in traditional DIIS. Default.

:guilabel:`OrthogonalizeDiisErrorMatrix` Parameter Type: Boolean
--------------------------------------------------------------------
Specifies using orthogonalized error vectors in traditional DIIS (requires `NLopt`). Disabled by default and if basis set linear dependence exists.

:guilabel:`SMH` Parameter Type: Boolean
------------------------------------------------
Specifies using Semiempirical Model Hamiltonian (SMH) to accelerate SCF convergence :cite:`SMH`. Typically saves 10~15% SCF iterations (more for charge-transfer/spin-polarized systems) and increases stability. Disabled for: (1) ROHF/ROKS, (2) `Smeartemp` specified, (3) Basis set linear dependence. Otherwise, enabled by default.

:guilabel:`NoSMH` Parameter Type: Boolean
------------------------------------------------
Disables SMH convergence acceleration.

:guilabel:`Smeartemp` Parameter Type: Floating-point
---------------------------------------------------
 * Default: 0
 * Options: Non-negative real (Kelvin)

Specifies electronic temperature for Fermi smearing (alters frontier orbital occupancies). The final energy includes the electronic entropy contribution (-TSelec). Subtracting this term (negative, so adding its absolute value) gives the electronic energy. Cannot be used with `Vshift` or `SMH` or in FLMO/iOI calculations.

Use cases:
 * Study temperature effects on electronic structure, energy, properties.
 * Improve convergence for systems with small/no HOMO-LUMO gaps (set ~5000 K for pure functionals, ~10000 K for hybrids, ~20000 K for HF). To get the 0 K result, run without smearing using the converged smeared orbitals as initial guess.
 * Help obtain symmetry-adapted orbitals when HF/DFT breaks spatial symmetry (e.g., cyclobutadiene D4h symmetry).

**Fock Matrix Diagonalization Control Keywords**

:guilabel:`Sylv` Parameter Type: Boolean
---------------------------------------------------
Uses Sylvester equation solving for block-diagonalization instead of full diagonalization to save time. Example:

.. code-block:: bdf

     $scf
     ...
     sylv
     $end

Beneficial for very large systems (e.g., >1000 atoms, >10000 basis functions) as Fock diagonalization becomes significant. Converged orbitals are localized (if initial guess is localized) but span the same occupied space as canonical orbitals. For canonical orbitals, run a subsequent calculation without `sylv` using the converged orbitals as initial guess.

:guilabel:`Iviop` Parameter Type: Integer
---------------------------------------------------
 * Default: None
 * Options: 1~3
 * Recommended: 1

Controls use of iVI method (requires `Blkiop=7`).

:guilabel:`Blkiop` Parameter Type: Integer
------------------------------------------------
 * Default: 3 (if `Sylv` specified), else none
 * Options: 1~8 (SAI, DDS, DNR, DGN, FNR, FGN, iVI, CHC)
 * Recommended: 3

Specifies block-diagonalization method, typically for iVI or FLMO calculations. Default is full diagonalization.

**Print and Molecular Orbital Output Control**

:guilabel:`Print` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1

Controls SCF print level (debugging).

:guilabel:`IprtMo` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1, 2

Controls printing of molecular orbital coefficients:
* 0: No orbitals printed
* 1: Print frontier orbitals (HOMO-5 to LUMO+5 per irrep) - occupation, energy, coefficients
* 2: Print all orbitals

:guilabel:`Noscforb` Parameter Type: Boolean
---------------------------------------------------
Forces not saving molecular orbitals to .scforb file.

:guilabel:`Pyscforb` Parameter Type: Boolean
------------------------------------------------
Saves converged SCF orbitals in PySCF format.

:guilabel:`Molden` Parameter Type: Boolean
---------------------------------------------------
Outputs molecular orbitals in Molden format for wavefunction analysis.

**Relativistic One-Electron Properties**

Supports sf-X2C Hamiltonian and localized variants (set `Heff=21, 22, or 23` in `xuanyuan` module).

:guilabel:`Reled` Parameter Type: Integer
---------------------------------------------------
Calculates **effective contact density** for elements with atomic number ≥ this value. Requires finite nucleus model (`nuclear=1` in `xuanyuan`). No default.

:guilabel:`Relefg` Parameter Type: Integer
---------------------------------------------------
Calculates **electric field gradient** (EFG) tensor for elements with atomic number ≥ this value. For isotopes with experimental/reliable theoretical nuclear quadrupole moments (NQM), also calculates **nuclear quadrupole coupling constants** (NQCC). Uses built-in NQM data :cite:`NQM2018,NQM-Bi209-2023,NQM-Stone2021`. Requires finite nucleus model (`nuclear=1` in `xuanyuan`). No default.

**Basis Set Linear Dependence Keywords**

:guilabel:`Checklin` Parameter Type: Boolean
------------------------------------------------
Forces SCF to perform basis set linear dependence check. Enabled by default for DirectSCF to improve convergence with diffuse basis functions.

:guilabel:`Tollin` Parameter Type: Floating-point
---------------------------------------------------
 * Default: 1.0E-7

Linear dependence check threshold.

**MOM (Maximum Overlap Method) Control Keywords**

MOM is a ΔSCF method that forces SCF to converge to an excited state by maximizing overlap between current and initial occupied orbitals. Typically more difficult to converge than ground state.

:guilabel:`Iaufbau` Parameter Type: Integer
------------------------------------------------
 * Default: 0 if `Occupy`, `Alpha`, or `Beta` are set; else 1
 * Options: 0, 1, 2, 3

Controls orbital occupancy assignment:
* 0: Occupancy fixed to initial guess
* 1: Aufbau principle (lowest orbitals occupied)
* 2: MOM (maximize overlap with initial guess orbitals). For ΔSCF excited states.
* 3: Debugging (avoid for production)

:guilabel:`IfPair` & :guilabel:`hpalpha` & :guilabel:`hpbeta` Parameter Type: Integer
-----------------------------------------------------------------------------
Specifies electronic excitations for MOM initial state. Defines excitations from occupied to virtual orbitals relative to the ground state.

.. code-block:: bdf

      # Example: Excitations for a molecule with 4 irreps:
      # - Alpha electrons from orbitals 5 and 6 (irrep 1) to 7 and 8 (irrep 1)
      # - Alpha electron from orbital 3 (irrep 3) to 4 (irrep 3)
      # - Beta electron from orbital 7 (irrep 1) to 8 (irrep 1)
      $scf
      Ifpair
      Hpalpha
      2             # Number of alpha excitation pairs
      5 0 3 0       # Pair 1: From occupied alpha orb 5 (irrep 1) to virtual alpha orb 3 (irrep 1? Note format: occ_irr occ_idx vir_irr vir_idx)
      8 0 4 0       # Correction: Likely meant to specify transitions
      6 0 0 0       # Excitation 1: From orb 6 (irrep 1) to ? (0 might indicate unspecified virtual)
      9 0 0 0       # Excitation 2: From orb 9 (irrep 1?) to ? 
      Hbeta
      1             # Number of beta excitation pairs
      7 0 0 0       # Excitation 1: From beta orb 7 (irrep 1?) to ? 
      8 0 0 0       # Excitation 2: From beta orb 8 (irrep 1?) to ?    
      ...
      $end

:guilabel:`Pinalpha` & :guilabel:`Pinbeta` Parameter Type: Integer
-----------------------------------------------------------
Specifies orbitals with fixed occupation numbers.

:guilabel:`EnableSecondOrderScf` & :guilabel:`EnableApproxSecondOrderScf` Parameter Type: Boolean
----------------------------------------------------------------------------------------------
Enables strict second-order or approximate second-order SCF with default settings. Strict second-order convergence is expensive; use only when other algorithms fail.

.. hint::
    * Second-order (and approximate) SCF does not currently support iOI, etc.
    * Not available for ROHF/ROKS.
    * Not available for relativistic calculations.

:guilabel:`DisableSecondOrderScf` & :guilabel:`DisableApproxSecondOrderScf` Parameter Type: Boolean
------------------------------------------------------------------------------------------------
Disables second-order or approximate second-order SCF.

:guilabel:`SecondOrderConfig` & :guilabel:`ApproxSecondOrderConfig` Input Block
-------------------------------------------------------------------------------
Specifies advanced settings for second-order or approximate second-order SCF. Most users only need `EnableSecondOrderScf`.

.. code-block:: bdf

    $Scf
        ...
        SecondOrderConfig
            Enable
            EnableExpression
                AfterIteration 10
            LevelShiftGradientThreshold
                1e-3
            ConvergeGradientThreshold
                1e-6
            ConvergeRotationThreshold
                1e-9
            MaxIterationCycle
                16
            InitialTrustRadius
                0.4
            MaxTrustRadius
                5
            MaxConjugateGradientIterationCycle
                16
            MaxDavidsonIterationCycle
                16
            CorrectionType
                Olsen
            LinearSolverTolerance
                1e-4
            AllowConverge
            ScfConvergeGradientThreshold
                1e-7
        EndSecondOrderConfig
        ...
    $End

* ``Enable``: Specifies enabling second-order SCF and sets the enable expression to default.
* ``Disable``: Specifies disabling second-order SCF.
* ``EnableExpression``: Specifies the enabling condition expression (specifying this implicitly sets ``Enable``).

    - ``AfterIteration`` + integer: Enables after N standard SCF iterations.
    - ``AfterDeltaEnergyLessThan`` + float: Enables after the energy error falls below a specified value during standard SCF iterations.
    - ``AfterDeltaRmsDensityLessThan`` + float: Enables after the density matrix error falls below a specified value during standard SCF iterations.
    - Custom logical expression. Note: Custom expressions are provided for developer debugging and advanced users needing flexible options. If uncomfortable with this, consider using the default or preset options mentioned above. Valid keywords: ``Iteration``, ``DeltaEnergy``, and ``DeltaRmsDensity``. Valid operators: ``&`` (AND), ``|`` (OR), ``!`` (NOT), ``>`` (greater than), ``<`` (less than), ``=`` (equal), and ``[]`` (logical evaluation brackets). Operators cannot be chained. Variables must be enclosed in logical evaluation brackets ``[]``. Expressions are case-insensitive and ignore all whitespace (e.g., "DeltaRmsDensity" is equivalent to "Delta RMS Density"). Example:
     ``[ [ Iteration > 10 ] & [ [ DeltaEnergy < 1e-3 ] | [![ DeltaRmsDensity > 2.5e-3 ]] ] ]``
* ``LevelShiftGradientThreshold``, float: Specifies the energy-orbital gradient threshold below which the trust radius is lifted, switching to the Newton-Raphson method for rotation vector calculation.
* ``ConvergeGradientThreshold``, float: Specifies the threshold for the norm of the energy-orbital gradient below which second-order SCF micro-iterations stop.
* ``ConvergeRotationThreshold``, float: Specifies the threshold for the norm of the rotation vector below which second-order SCF micro-iterations stop.
* ``MaxIterationCycle``, integer: Specifies the maximum number of second-order SCF micro-iterations before performing a standard SCF update.
* ``InitialTrustRadius``, float: Specifies the initial trust radius for the Levenberg-Marquardt method when calculating the rotation vector.
* ``MaxTrustRadius``, float: Specifies the maximum trust radius for the Levenberg-Marquardt method when calculating the rotation vector.
* ``MaxConjugateGradientIterationCycle``, integer: Specifies the maximum number of iterations for the conjugate gradient method when solving the Newton-Raphson equations. The final vector is used as the rotation vector even if not fully converged.
* ``MaxDavidsonIterationCycle``, integer: Specifies the maximum number of iterations for the Davidson diagonalization when solving the Levenberg-Marquardt equations. The final vector is used as the rotation vector even if not fully converged.
* ``CorrectionType``, string: Specifies the correction method for Davidson diagonalization. Options: ``DavidsonDPR`` (or ``DPR``), ``JacobiDavidson``, and ``Olsen``.
* ``LinearSolverTolerance``, float: Specifies the convergence threshold for the linear solver used in Davidson diagonalization.
* ``ExcludeNonOccupiesFromRotation``: Specifies excluding orbitals that *should* be occupied according to the Aufbau principle but are explicitly set as unoccupied by the user from rotation pairs. This prevents collapse to the Aufbau state. Only active during ΔSCF calculations.
* ``IncludeNonOccupiesInRotation``: Specifies including *all* orbitals in rotation pairs. Only active during ΔSCF calculations.
* ``AllowConverge``: Allows SCF convergence to be declared during second-order convergence iterations.
* ``ForbidConverge``: Forbids SCF convergence from being declared during second-order convergence iterations.
* ``ScfConvergeGradientThreshold``, float: Specifies the threshold for the norm of the energy-orbital gradient below which SCF convergence is declared. Only effective if ``AllowConverge`` is set.
* ``QuasiNewtonAlgorithm``, string: Specifies the quasi-Newton algorithm. Options: ``BFGS`` (default), ``SR1``, and ``DFP``. Only effective when using approximate second-order SCF.

.. note::
    Unlike other input blocks in BDF, floating-point parameters within the ``SecondOrderConfig`` input block **must** use `e` or `E` for scientific notation (e.g., `1.0e-6`). Using `d` or `D` is **not supported** and will cause unexpected behavior.