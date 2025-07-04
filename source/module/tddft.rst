Time-Dependent Density Functional Theory - TDDFT Module
================================================
The TDDFT module calculates molecular excited states by solving the Casida equation based on linear response theory. It supports TDDFT (including TDHF), TDA (including CIS), and can handle closed-shell or open-shell ground states. For open-shell ground states, it supports both traditional U-TDDFT and the spin-matched SA-TDDFT (also known as X-TDDFT), the latter being a distinctive feature of BDF. Additionally, BDF supports spin-flip (SF-)TDDFT methods, including spin-up-flip and spin-down-flip TDDFT, for calculating excited states with spin multiplicities different from the ground state.

**Common Keywords**

:guilabel:`Imethod` Parameter Type: Integer
------------------------------------------------
 * Default: 1 for RHF/RKS reference states, else 2
 * Options: 1, 2

Specifies the ground-state method for TDDFT:
* 1: R-TDDFT (RHF/RKS reference state)
* 2: U-TDDFT (UHF/UKS reference state)
Spin-matched X-TDDFT requires a ROKS/ROHF reference and uses U-TDDFT with `imethod=2`, `itest=1`, `icorrect=1` (see below). This parameter usually doesn't need manual specification, as the program chooses a reasonable default. Note: U-TDDFT and X-TDDFT calculations are only supported in Abelian point groups.

:guilabel:`Isf` Parameter Type: Integer
---------------------------------------------------
 * Default: 0
 * Options: 0, 1, -1

Controls spin-flip TDDFT:
* 0: No spin-flip (spin-conserving, calculates states with same Ms as ground state)
* 1: Spin flip up (calculates states with Ms = ground state Ms + 1)
* -1: Spin flip down (calculates states with Ms = ground state Ms - 1)
Special case: When `imethod=1` and `isf=1`, the program calculates the Ms=0 component of the triplet state, not an Ms=1 state. This is still a spin-conserving R-TDDFT calculation, not spin-flip. Note: When `isf != 0` and `imethod=2`, `itda` must be set to 1.

:guilabel:`Itda` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1

Controls use of the Tamm-Dancoff Approximation (TDA):
* 0: Full TDDFT (no TDA)
* 1: TDA calculation.

:guilabel:`Ialda` Parameter Type: Integer
---------------------------------------------------
 * Default: 0
 * Options: 0, 1, 2, 3, 4

Specifies the TDDFT exchange-correlation kernel:
* 0: Full non-collinear kernel
* 1: Non-collinear ALDA kernel
* 2: No-collinear ALDA0 kernel
* 3: Full non-collinear kernel (spin-averaged density)
* 4: Full collinear kernel

For `isf=0` calculations, `ialda` has no effect. For `isf != 0` single-point calculations with non-RHF/RKS reference states, setting `ialda=2` is recommended for better numerical stability than the default 0. For `isf != 0` TDDFT geometry optimization, numerical frequencies, or NAC-TDDFT calculations, `ialda` *must* be set to 4. **Important:** This introduces an approximation, making results incomparable (and less accurate) to those obtained with `ialda != 4`. Thus, TDDFT geometry optimization/frequency results with `isf != 0` cannot be directly compared to TDDFT single-point energy results.

:guilabel:`Itest` & :guilabel:`icorrect` Parameter Type: Integer
------------------------------------------------------------
 * Default: 0
 * Options: 0, 1

When *both* `Itest` and `icorrect` are set to 1, `imethod=2`, and the reference state is ROKS/ROHF, the program performs X-TDDFT calculation.

:guilabel:`iact` & :guilabel:`elw` & :guilabel:`eup` Parameter Type: Integer, Float, Float
---------------------------------------------------------------------------------------
`Iact=1` specifies calculating excited states within an energy window defined by lower (`elw`) and upper (`eup`) bounds. Units: eV.

**Diagonalization Method Keywords**

:guilabel:`Idiag` Parameter Type: Integer
------------------------------------------------
 * Default: 1
 * Options: 1, 2, 3

Specifies the TDDFT diagonalization method:
* 1: Iterative diagonalization (Davidson method)
* 2: Full diagonalization
* 3: iVI diagonalization (does not support non-Abelian point groups)

Recommendations:
* Use `idiag=3` (iVI) for:
    - High-energy excitations (e.g., X-ray absorption/emission - see `iwindow`)
    - Calculating *all* states within a specific energy/wavelength range with guaranteed completeness (see `iwindow`).
* Use `idiag=2` (full diagonalization) for small molecules where a large number of states is needed (approaching the product of occupied and virtual orbitals).
* Use default `idiag=1` (Davidson) for most other cases.

:guilabel:`Aokxc` Parameter Type: Boolean
---------------------------------------------------
Specifies calculating the exchange-correlation kernel contribution to the Casida matrix in the AO basis. Enabled by default for AO-TDDFT calculations, so usually not needed.

:guilabel:`Iguess` Parameter Type: Integer
------------------------------------------------
 * Options: 10*x + y (x ∈ {0,1,2}, y ∈ {0,1})
 * Default: 20 for AO-TDDFT in Abelian groups, else 0

Controls TDDFT initial guess wavefunction:
* x=0: Diagonal guess
* x=1: Read initial wavefunction from file
* x=2: Tight-binding approximation guess
* y=0: Do *not* store Davidson/iVI iteration vectors
* y=1: *Do* store Davidson/iVI iteration vectors

:guilabel:`Itrans` Parameter Type: Integer
------------------------------------------------
 * Options: 0, 1
 * Default: 0

Controls transformation of the spin-orbital basis excited-state vectors to a spin-tensor basis. Only set `itrans=1` if:
1. Reference state is ROKS.
2. No subsequent calculations require `$resp` module (gradients, excited-state dipoles, NACs) or NTO analysis.
**Note:** If the reference state is ROKS and TDDFT-SOC calculation is planned, `itrans` *must* be set to 1.

.. _grimmestd:
:guilabel:`Grimmestd` Parameter Type: Boolean
------------------------------------------------
Specifies using Grimme's sTDA (if `itda=1`) or sTDDFT (if `itda=0`) method. sTDDFT/sTDA approximate TDDFT, running ~10-100x faster than MPEC+COSX, but with larger errors (~0.2 eV for excitation energies, up to ~1 eV for some transition metals). Recommended for pi-pi* excitations in large organic systems (>100 atoms) where conventional TDDFT is too slow/memory-intensive. Supports excitation energies, oscillator strengths, NTOs, SOC matrix elements for pure/hybrid functionals (including HF) and range-separated functionals wB97, wB97X, LC-BLYP, CAM-B3LYP. **Not supported:** Excited-state gradients, dipoles, NACs, or use with `isf=-1`.

**Grid Control Keywords**

:guilabel:`Grid` Parameter Type: String
------------------------------------------------
 * Default: Medium
 * Options: Ultra Coarse, Coarse, Medium, Fine, Ultra Fine

Specifies DFT numerical integration grid type.

:guilabel:`Gridtol` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.0E-4 (1.0E-6 for meta-GGA)
 
Specifies the cutoff threshold for DFT adaptive grid generation. Lower values increase grid points (higher precision, higher cost).

:guilabel:`MPEC+COSX` Parameter Type: Boolean
------------------------------------------------
Specifies using Multipole Expansion of Coulomb potential (MPEC) for the J matrix and Chain-of-Sphere Exchange (COSX) for the K matrix. Retained for backward compatibility; recommended to set in `Compass` module.

**Orbital Freezing Keywords**

:guilabel:`Frzcore` Parameter Type: Integer Array
---------------------------------------------------
Specifies the number of occupied orbitals to freeze *per irreducible representation* (lowest energy orbitals frozen first). Default: No freezing (unlike programs like ORCA). Example: Freeze the 20 lowest occupied orbitals in irrep 1 and 10 in irrep 2:

.. code-block:: bdf

     $tddft
     ...
     frzcore
      20 10
     $end

:guilabel:`Frzvirt` Parameter Type: Integer Array
---------------------------------------------------
Specifies the number of virtual orbitals to freeze *per irreducible representation* (highest energy orbitals frozen first). Default: No freezing.

.. note::

  Orbital freezing primarily saves memory in large systems (e.g., freeze core orbitals for UV-Vis spectra). Errors are typically < 0.01 eV. Also saves some compute time. Supports excitation energies, oscillator strengths, NTOs, SOC matrix elements. **Not supported:** Excited-state gradients, dipoles, NACs.

**Spectroscopy Keywords**

:guilabel:`ECD` Parameter Type: Boolean
------------------------------------------------
Specifies calculation of Electronic Circular Dichroism (ECD) spectra. Outputs transition magnetic dipole moments and rotatory strengths (length & velocity gauges) for each excited state, in addition to transition electric dipole moments and oscillator strengths.

**Convergence Control Keywords**

:guilabel:`Crit_e` Parameter Type: Floating-point
------------------------------------------------
* Default: 1e-7

TDDFT energy convergence threshold (Hartree).

:guilabel:`Crit_vec` Parameter Type: Floating-point
---------------------------------------------------
* Default: 1e-5

TDDFT wavefunction convergence threshold.

**Number of States Control Keywords**

:guilabel:`Iroot` Parameter Type: Integer
------------------------------------------------
* Default: 10
* Options: Non-zero integer

* `iroot > 0`: Calculate `iroot` states per irreducible representation.
* `iroot < 0`: Calculate `|iroot|` states total across all irreps (program determines per-irrep count).
**Note:** For degenerate irreps, different components of the same state count as one state (e.g., `iroot=3` for a 2D irrep yields 3 distinct energy states). Synonym: `iexit`.

:guilabel:`Nroot` Parameter Type: Integer Array
---------------------------------------------------
Specifies the number of states per irrep. Example: `5 1 3` calculates 5 states in irrep 1, 1 in irrep 2, 3 in irrep 3. If both `iroot` and `nroot` are specified, `nroot` is ignored.

:guilabel:`Iwindow` Parameter Type: Floating-point Array
---------------------------------------------------
Specifies an energy/wavelength range to calculate excited states within. Avoids wasteful calculation of states outside the region of interest.

Format: Next line contains two floats (range) + optional unit (`au`/`eV`/`nm`/`cm-1`). Default unit: eV. Best used with iVI (`idiag=3`) to ensure all states within the range are found without wasting resources on states outside. Example: Calculate all states between 1-5 eV:

.. code-block:: bdf

     $tddft
     ...
     idiag
      3           # Use iVI method
     iwindow
      1 5 eV
     $end

Can be used with Davidson (`idiag=1`, default) but behavior differs:

.. code-block:: bdf

     $tddft
     ...
     iwindow
      1 5 eV      # Davidson method: Lower bound (1 eV) ignored. Calculates all states below 5 eV.
     $end

Davidson cannot guarantee all states within 1-5 eV are found or exclude states outside it. It may waste resources calculating low-energy states irrelevant to the window (especially problematic for high-energy windows like XAS, e.g., `300 305 eV`). Use iVI (`idiag=3`) for such cases.

.. hint::
     `Iwindow` is incompatible with `idiag=2` (full diagonalization).

If `iwindow` is specified, `iroot`/`nroot` do not control the number of states calculated. However, for `iwindow` + `idiag=3` (iVI), `iroot`/`nroot` still affect initial memory allocation. If the program errors with "too small iroot/nroot, require xxx, but only yyy provided", set `iroot` or `nroot` for that irrep to a value >= `xxx`.

:guilabel:`Maxld` Parameter Type: Integer
---------------------------------------------------
Maximum dimension of the iVI expansion space. Usually set automatically. If error "too small ld xxx, require yyy" occurs, set `maxld` >= `yyy`.

**Wavefunction Storage Keyword**

:guilabel:`Istore` Parameter Type: Integer
------------------------------------------------
Specifies a file identifier (`istore`) to save the wavefunction for use in subsequent calculations.

**Output Control Keywords**

:guilabel:`Nprt` Parameter Type: Integer
------------------------------------------------
Prints information only for the first `nprt` excited states. Default: Print all states.

:guilabel:`Cthrd` Parameter Type: Floating-point
---------------------------------------------------
Prints orbital excitation information only if the coefficient magnitude exceeds `cthrd`.

**TD-DFT/SOC and Property Calculation Control**

:guilabel:`Nfiles` Parameter Type: Integer
------------------------------------------------
Reads `nfiles` previously calculated TDDFT wavefunctions for SOC calculation.

:guilabel:`Isoc` Parameter Type: Integer
---------------------------------------------------
 * Default: 1
 * Options: 1, 2, 3

Specifies TDDFT-SOC method:
* 1: Closed-shell systems only
* 2: General SOC calculation
* 3: Only prints SOC coupling matrix elements between scalar states (no SOC Hamiltonian diagonalization)

:guilabel:`Ifgs` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, 1

Includes the ground state in TDDFT-SOC calculation:
* 0: Exclude ground state. Cannot get transition dipoles between ground state and spinor states or calculate ground-state SOC correction. Can still get SOC-corrected excitation energies.
* 1: Include ground state. Enables SOC-corrected spectra and ground-state SOC correction. Limit the number of scalar excited states included (typically 10-100), otherwise ground-state energy is underestimated, overestimating excitation energies.

:guilabel:`Imatsoc` Parameter Type: Integer Array
---------------------------------------------------
Specifies which SOC matrix elements to calculate.

.. code-block:: bdf

     ...
     # First SCF calculation (Singlet ground state S0)
     $scf
     spin
     0
     ...
     $end

     # First TDDFT: Singlets S1-S10
     $tddft
     imethod
      1
     isf
      0
     iroot
      10
     ....
     $end

     # Second TDDFT: Triplets T1-T10
     $tddft
     imethod
      1
     isf
      1
     iroot
      10
     $end

     $tddft
     ....
     # imatsoc < 0: Print ALL SOC matrix elements
     # imatsoc = 0: Print NO SOC matrix elements
     # imatsoc > 0: Print `imatsoc` specified matrix elements
     imatsoc
      7              # Calculate 7 specific SOC matrix elements (max 4000 allowed)
     0 0 0 2 1 1     # "0 0 0" represents the ground state (S0)
     0 0 0 2 1 2     # Format: "i m n" = i-th TDDFT calc, m-th irrep, n-th state
     1 1 1 2 1 1     # Calculate <S1|H_SOC|T1>
     1 1 1 2 1 2
     1 1 2 2 1 1
     1 1 2 2 1 2
     2 1 1 2 1 1
     2 1 1 2 1 2
     $end

:guilabel:`Imatrsf` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: 0, -1

Controls printing transition dipole moments between scalar states in TDDFT-SOC calculations. `imatrsf=-1` prints all transition dipoles.

:guilabel:`Imatrso` Parameter Type: Integer Array
---------------------------------------------------
Specifies printing transition dipole moments (and oscillator strengths/radiative rates) between spinor states after SOC.

.. code-block:: bdf

     $TDDFT
     ...
     Imatrso
     # Print 5 specific spinor-spinor transition dipoles (max 4000)
     # imatrso = -1: Print ALL pairs
     # imatrso = -2: Print ALL ground_spinor -> excited_spinor pairs (excludes ground-ground & excited-excited)
     5
     1 1             # Between spinor state 1 and spinor state 1
     1 2             # Between spinor state 1 and spinor state 2
     1 3
     2 3
     2 4
     $END

**Excited State Property Analysis**

:guilabel:`Ntoanalyze` Parameter Type: Integer Array
---------------------------------------------------
Natural Transition Orbital (NTO) analysis for specified TDDFT states. Supports Abelian point groups only.

.. code-block:: bdf

     $TDDFT
     istore
     1           # Store wavefunction (Must be 1, even if not the first $tddft block)
     $End

     $TDDFT
     Ntoanalyze
     2           # Analyze 2 states
     1 3         # Analyze the 1st and 3rd excited states
     $End

Outputs NTOs in Molden format: `bdftask.tdno_irepm_staten.molden` (m = irrep index, n = state index within irrep).

:guilabel:`TRDDens` Parameter Type: Boolean 
Outputs transition density to Cube files. Default name: `bdftask.trd_irepm_staten.cube` (m = irrep index, n = state index).

:guilabel:`DensCube` Parameter Type: Boolean 
Outputs ground and excited state densities to Cube files. For singlet ground states:
* File `rho_irepn_singlet.cube` contains densities for the n-th irrep.
* For irrep 1 (usually totally symmetric), file `rho_irep1_singlet.cube` contains n excited state densities followed by the ground state density.

:guilabel:`Cubexyz` Parameter Type: Floating-point Array
Specifies grid step size (x, y, z) for Cube files.

.. code-block:: bdf

     $TDDFT
     istore
     1           # Store wavefunction (Must be 1)
     $End

     $TDDFT
     TRDDens
     Cubexyz
      0.2 0.2 0.2 # 0.2 Å grid step
     $End

**Memory Control Parameters**

:guilabel:`Memjkop` Parameter Type: Integer
---------------------------------------------------
Controls memory (MW = 8 MB blocks) for integral-direct TDDFT J/K operator calculation. If insufficient, multiple passes over integrals are needed, reducing efficiency.

.. code-block:: bdf

     $TDDFT
     memjkop 
       2048          # Allocate 2048 MW = 2048 * 8 MB = 16 GB memory
     $End

:guilabel:`Imemshrink` Parameter Type: Integer
---------------------------------------------------
 * Default: 0
 * Options: 0, 1

Controls OpenMP parallel memory usage for integral-direct J/K calculation:
* 0: Do not reduce memory usage (default).
* 1: Reduce OpenMP memory footprint (slightly less efficient). Use if `memjkop` cannot be increased further for large systems/many states.

**Solvation Effect Control Keywords**

:guilabel:`Solneqlr` Parameter Type: Boolean
------------------------------------------------
Specifies linear response calculation with nonequilibrium solvation effects.

:guilabel:`Soleqlr` Parameter Type: Boolean
------------------------------------------------
Specifies linear response calculation with equilibrium solvation effects.

:guilabel:`Solneqss` Parameter Type: Boolean
------------------------------------------------
Specifies state-specific calculation with nonequilibrium solvation effects.

:guilabel:`Soleqss` Parameter Type: Boolean
------------------------------------------------
Specifies state-specific calculation with equilibrium solvation effects.