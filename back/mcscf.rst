mcscf Module
================================================
Multi-configuration self-consistent field calculation module. Performs second-order convergent RHF if no active space is defined. Performs CASCI only if molecular orbitals are not optimized.

:guilabel:`AutoMC` Parameter Type: Boolean
------------------------------------------------
When the user explicitly enables automatic active space selection in the `$expandmo` module, this keyword directs BDF to auto-generate values for ``close``, ``active``, and ``actel`` keywords.

.. attention::
  User input priority: Manually set values for ``close``, ``active``, ``actel`` in subsequent input files will override auto-generated values.

:guilabel:`Core` Parameter Type: Integer Array
------------------------------------------------
Specifies number of frozen doubly-occupied orbitals per irreducible representation.

:guilabel:`Delete` Parameter Type: Integer Array
---------------------------------------------------
Specifies number of frozen virtual orbitals per irreducible representation. Frozen orbitals are excluded from optimization.

:guilabel:`Close` Parameter Type: Integer Array
------------------------------------------------
Specifies number of non-frozen doubly-occupied (inactive) orbitals per irreducible representation.

:guilabel:`Active` Parameter Type: Integer Array
------------------------------------------------
Specifies number of active orbitals per irreducible representation.

:guilabel:`Actel` Parameter Type: Integer
---------------------------------------------------
Specifies number of active electrons.

:guilabel:`RootPrt` Parameter Type: Integer Array
------------------------------------------------
Specifies which MCSCF root to use for numerical gradient calculations.

:guilabel:`Symmetry` Parameter Type: Integer
------------------------------------------------
Specifies spatial symmetry of the electronic state for MCSCF calculation.

:guilabel:`Spin` Parameter Type: Integer
---------------------------------------------------
Specifies spin multiplicity (2S+1) of the electronic state for MCSCF calculation.

:guilabel:`Roots` Parameter Type: Integer Array
------------------------------------------------
Multi-line parameter specifying number of roots and state averaging. Requires 1-3 lines:
Line 1: 2-3 integers "n m i" – "n" roots for averaging, "m" roots for CI (n≤m). If "i"=1, no extra input needed (averages lowest "n" states). If "i" omitted/0, two additional lines required.
Line 2: Specifies roots for averaging.
Line 3: Specifies weights (automatically normalized).

.. code-block:: python

     $MCSCF
     ...
     Roots
     3 4        # Average 3 roots, compute 4 CI roots
     1 2 4      # Average states 1,2,4
     1 1 1      # Equal weights
     $End

.. code-block:: python

     $MCSCF
     ...
     Roots
     3 4 1   # Average 3 lowest roots, compute 4 CI roots
     $End

:guilabel:`MixCI` Parameter Type: Integer Array
---------------------------------------------------
Multi-line parameter for state averaging across spin multiplicities/symmetries. Requires four lines:
Line 1: Integer "n" (number of distinct spin/symmetry states).
Line 2: Spin multiplicities for each state.
Line 3: Number of roots per state.
Line 4: Spatial symmetries per state.

.. code-block:: python

     $MCSCF
     ....
     MixCI  
      3       # 3 distinct electronic states
     1 3 5    # Singlet, triplet, quintet
     3 1 2    # Average 3, 1, 2 roots respectively
     1 4 3    # Irreducible representations 1,4,3
     $End

:guilabel:`Guess` Parameter Type: String
---------------------------------------------------
Options: hcore, huckel, hforb, mcorb, Inporb

Specifies initial guess orbitals for MCSCF:
hcore: Solutions of one-electron Hamiltonian.
huckel: Extended Hückel method.
hforb: Read from `bdftask.hforb` (SCF output).
mcorb: Read from `bdftask.mcorb` (MCSCF output).
Inporb: Read text-format `inporb` (from SCF/MCSCF).

:guilabel:`Guga` Parameter Type: Boolean
------------------------------------------------
Uses GUGA algorithm for CASCI. Default: TUGA algorithm.

:guilabel:`iCI` Parameter Type: Boolean
------------------------------------------------
Uses iCI method as CASCI solver without ENPT2 correction (iCISCF method).

:guilabel:`iCIPT2` Parameter Type: Boolean
------------------------------------------------
Uses iCI method as CASCI solver with ENPT2 correction (iCISCF(2) method).

:guilabel:`CVS` Parameter Type: Boolean
------------------------------------------------
Calculates core excitations using GUGA method.

:guilabel:`Actfrz` Parameter Type: Integer
---------------------------------------------------
Freezes core-like molecular orbitals (MOs) within active space for core excitation calculations.

Input format: 
Line 1: Number of MOs to freeze (positive integer).
Line 2: Indices of MOs to freeze.

.. code-block:: bdf

 $mcscf
 ...
 actfrz
 3
 10 11 12  ! Freeze MOs 10-12 (core orbitals)
 $end

:guilabel:`SOCCAS` Parameter Type: Boolean
------------------------------------------------
Uses TUGA for SOiCISCF calculations.

:guilabel:`SOCene` Parameter Type: Boolean
------------------------------------------------
Calculates spin-orbit couplings (SOC) between MCSCF electronic states using GUGA.

:guilabel:`XvrSet` Parameter Type: Integer Array
------------------------------------------------
Sets extended virtual orbitals (XVR) per irreducible representation generated by `expandmo`.
Must be used with `expandmo`'s ``VSD`` keyword to define XVR initialization.

.. attention::
  Enforces orbital ordering: Closed → Active → Virtual → XVR.

* Full logic example: test126.inp

:guilabel:`Virdel` Parameter Type: Boolean
------------------------------------------------
Enforces orbital ordering: Closed → Active → Virtual → XVR.

* Full logic example: test126.inp

:guilabel:`XvrUse` Parameter Type: Boolean
------------------------------------------------
Outputs XVR orbitals to checkpoint file (`chkfil`) for subsequent `xianci` module use.
Retains XVR orbitals instead of default deletion for cross-module data reuse.

.. note::
If disabled, `xianci` automatically deletes/recomputes temporary XVR.

* Full logic example: test126.inp

:guilabel:`Solvate` Parameter Type: Boolean
------------------------------------------------
Enables solvation effects in MCSCF calculations.
.. note:: 
   Solvent/model/parameters inherited from preceding SCF calculation.

:guilabel:`Sortact` Parameter Type: Integer
------------------------------------------------
Activates active space orbital reordering.

Input format:
Line 1: Number of swap pairs (integer).
Line 2: MO indices to move INTO active space.
Line 3: MO indices to move OUT OF active space (paired with Line 2).

.. code-block:: bdf

 $mcscf
 ...
 SortAct  
 3  
 10 15 20   # Move MOs 10,15,20 INTO active space  
 12 13 14   # Move MOs 12,13,14 OUT OF active space 
 $end

.. note:: 

 Performs three swaps: MO10↔MO12, MO15↔MO13, MO20↔MO14.
 Indexing based on output/Molden file orbital ordering.

Use case:
Manual adjustment of active orbitals in CASSCF. Fixes convergence issues from orbital misassignment.

:guilabel:`grad` Parameter Type: Boolean
------------------------------------------------
Computes/stores MO integrals and orbital Hessian for analytical gradients.
Required for `grad` module MCSCF gradient calculations.

:guilabel:`iCAS` Parameter Type: Boolean
------------------------------------------------
Enforces active space validation per macro-iteration via MOM/SVD/Hungary algorithms.

* Function: Validates closed/active/virtual partitioning and enforces CAS space.
* Default: MOM method. Use ``Hungary`` or ``SVD`` for alternatives.

:guilabel:`SVD` Parameter Type: Boolean
------------------------------------------------
Uses SVD algorithm for orbital space validation.

:guilabel:`Hungary` Parameter Type: Boolean
------------------------------------------------
Uses Hungary algorithm for orbital space validation.

:guilabel:`Actadd` Parameter Type: Boolean
------------------------------------------------
Function: Automatically expands active space when combined with iCAS/SVD validation.

Trigger conditions:
1. With iCAS: Adds near-degenerate orbitals based on occupation fluctuations.
2. With SVD: Dynamically extends space via matrix rank analysis.

:guilabel:`Statemo` Parameter Type: Integer
------------------------------------------------
Specifies state-specific MO output.

* Function: Sets state index for state-specific orbitals.
* Default: 0 (outputs state-averaged orbitals).

:guilabel:`Qcmo` Parameter Type: Boolean
------------------------------------------------
Generates quasi-canonical active MOs. Default: Natural orbitals.

:guilabel:`Direct` Parameter Type: Boolean
------------------------------------------------
Performs direct CI per MCSCF iteration.

:guilabel:`Molden` Parameter Type: Boolean
---------------------------------------------------
Outputs optimized MOs to `$BDFTASK.mcscf.molden`.

:guilabel:`Iprtmo` Parameter Type: Integer
------------------------------------------------
Sets MO print level (same as SF module).

:guilabel:`CASCI` Parameter Type: Boolean
------------------------------------------------
Performs CI only (no orbital optimization).

:guilabel:`cionly` Parameter Type: Boolean
------------------------------------------------
Performs CI only (no orbital optimization). Alias for ``CASCI``.

:guilabel:`orbonly` Parameter Type: Boolean
------------------------------------------------
Optimizes orbitals only (no CI).

:guilabel:`CIread` Parameter Type: Boolean
---------------------------------------------------
Reads CI wavefunction as initial guess for CI calculation.

**Localized MCSCF Parameters**

:guilabel:`Localmc` 
------------------------------------------------
Localizes MCSCF-optimized molecular orbitals.

:guilabel:`Nolmocls` Parameter Type: Boolean
------------------------------------------------
Disables localization of closed orbitals.

:guilabel:`Nolmoact` Parameter Type: Boolean
------------------------------------------------
Disables localization of active orbitals.

:guilabel:`Nolmovir` Parameter Type: Boolean
------------------------------------------------
Disables localization of virtual orbitals.

:guilabel:`Nature` 
------------------------------------------------
Generates natural active orbitals (default).

:guilabel:`Mom` 
------------------------------------------------
Uses MOM algorithm for orbital space validation (default).

**MCSCF Orbital Optimization Algorithms**

:guilabel:`Quasi` Parameter Type: Boolean
------------------------------------------------
Uses quasi-Newton MCSCF.

:guilabel:`Superci` Parameter Type: Boolean
------------------------------------------------
Uses Super-CI-PT for orbital Hessian diagonals (alternative to ``Quasi``).
Requires fewer integrals (pw|uv) vs. (pq|uv) in ``Quasi``. Recommended for systems with >1500 AOs.

.. attention::
  Higher approximation risk. May cause convergence failure – revise active space if unstable.

:guilabel:`QNDIIS` Parameter Type: Floating-point
------------------------------------------------
Sets threshold for QN/DIIS acceleration in Super-CI-PT orbital gradient optimization.
* Default: 1.D-3

:guilabel:`DIIS` Parameter Type: Boolean
------------------------------------------------
Uses DIIS acceleration for Super-CI-PT (default: QN).

:guilabel:`Werner` Parameter Type: Boolean
------------------------------------------------
Uses Werner's quadratically convergent MCSCF (default).
Requires [pq|(i+u)(j+v)] integrals. Use ``Quasi``/``Superci`` for large systems.

:guilabel:`Mixopt` Parameter Type: Boolean
------------------------------------------------
Hybrid Werner + Quasi algorithms for difficult convergence cases.

**Iteration & Convergence Control**

:guilabel:`Macit` Parameter Type: Integer
------------------------------------------------
Maximum macro-iterations.

:guilabel:`Micit` Parameter Type: Integer
------------------------------------------------
Maximum micro-iterations.

:guilabel:`Ciiter` Parameter Type: Integer
------------------------------------------------
Maximum CI iterations.

:guilabel:`Conv` Parameter Type: Floating-point
------------------------------------------------
Default: 1.D-8 (energy), 1.d-4 (orbital gradient)

:guilabel:`Cmin` Parameter Type: Floating-point
------------------------------------------------
UGA-CI/iCI truncation threshold.
* Default: 1.0d-4
* Function: Discards CSFs with |coefficient| < threshold. Lower = higher accuracy/cost.
* Priority: User-defined values override defaults.

:guilabel:`Actmin` Parameter Type: Floating-point
------------------------------------------------
Jacobi rotation threshold for iCI active MO optimization.
* Default: 1.0d-6

:guilabel:`Actopt` Parameter Type: Boolean
------------------------------------------------
Active space optimization method:
* 0: Disabled (default).
* 1: Enabled (Werner/quasi-Newton).
* 2: Enabled (Jacobi rotation). Higher stability but costly for large active spaces.

:guilabel:`Prtcri` Parameter Type: Floating-point
------------------------------------------------
CSF print threshold.
* Default: 0.05

:guilabel:`SOCcri` Parameter Type: Floating-point
------------------------------------------------
SOC print threshold for ``SOCene``.

:guilabel:`Prtiter` Parameter Type: Boolean
------------------------------------------------
Outputs per-iteration MOs to `$BDFTASK.mciter.molden`.

:guilabel:`Maxstep` Parameter Type: Floating-point
------------------------------------------------
Default: 0.1 (maximum orbital rotation step size).

:guilabel:`Ucutoff` Parameter Type: Floating-point
------------------------------------------------
Default: 1.D-8 (integral transformation threshold for internal space optimization).

**GUGA-CI Control Parameters**

:guilabel:`Ncisave` Parameter Type: Integer
------------------------------------------------
Default: 20000 (max CI matrix dimension).

:guilabel:`Node` Parameter Type: Integer
------------------------------------------------
Default: 30000 (max DRT nodes).

:guilabel:`Wei` Parameter Type: Integer
------------------------------------------------
Max arc weights.

:guilabel:`Ploop` Parameter Type: Integer
------------------------------------------------
Max partial loops for GUGA loop search.

:guilabel:`Nref` Parameter Type: Integer
------------------------------------------------
Default: 10000 (reference states).

:guilabel:`Nvff` Parameter Type: Integer
------------------------------------------------
Default: 10000000 (max two-electron integrals in active space).

**Test Cases**

:guilabel:`test004.inp`
------------------------------------------------

:guilabel:`test015.inp`
------------------------------------------------

:guilabel:`test016.inp`
------------------------------------------------

:guilabel:`test019.inp`
------------------------------------------------

:guilabel:`test020.inp`
------------------------------------------------

:guilabel:`test021.inp`
------------------------------------------------

:guilabel:`test061.inp`
------------------------------------------------

:guilabel:`test069.inp`
------------------------------------------------

:guilabel:`test070.inp`
------------------------------------------------

:guilabel:`test071.inp`
------------------------------------------------

:guilabel:`test080.inp`
------------------------------------------------

:guilabel:`test086.inp`
------------------------------------------------

:guilabel:`test095.inp`
------------------------------------------------

:guilabel:`test100.inp`
------------------------------------------------

:guilabel:`test105.inp`
------------------------------------------------

:guilabel:`test114.inp`
------------------------------------------------

:guilabel:`test126.inp`
------------------------------------------------

:guilabel:`test131.inp`
------------------------------------------------

:guilabel:`test139.inp`
------------------------------------------------

:guilabel:`test148.inp`
------------------------------------------------

:guilabel:`test150.inp`
------------------------------------------------