xianci Module
================================================
The xianci module originates from the Xi'an-CI program package and performs calculations including ucMRCI, icMRCI, XSDSCI, CB-MRPT2/3, MS-CASPT2, XMS-CASPT2, XDW-CASPT2, RMS-CASPT2, MS-NEVPT2, SS-NEVPT3, SDSPT2f, SDSPT2, SDSCIf, SDSCI, and others.

**Basic Control Parameters**

:guilabel:`Roots` Parameter Type: Integer
------------------------------------------------
Specifies number of roots (electronic states) to compute.
* If mcscf calculates only one spatial/spin symmetry, xianci inherits root count from mcscf (no input needed).
* Default: 1

:guilabel:`Istate` Parameter Type: Integer
------------------------------------------------
Specifies root count and indices. Overrides `Roots` if used.

.. attention::
  Applicable only to CASPT2, NEVPT2, SDSPT2, SDSCI, and XSDSCI methods.

Format: Line 1 = root count; Line 2 = root indices.

.. code-block:: bdf

     $xianci
     ...
     istate
     2
     1 3 
     $end

:guilabel:`Spin` Parameter Type: Integer
------------------------------------------------
Specifies spin multiplicity (2S+1).
* Inherited from mcscf if single symmetry calculated.
* Default: 1

:guilabel:`Symmetry` Parameter Type: Integer
------------------------------------------------
Specifies spatial symmetry.
* Inherited from mcscf if single symmetry calculated.
* Default: 1

:guilabel:`Frozen` Parameter Type: Integer Array
------------------------------------------------
Specifies frozen doubly-occupied (inactive) orbitals per irreducible representation (recommended for core orbitals).
* Default: No frozen orbitals.

:guilabel:`Core` Parameter Type: Integer Array
------------------------------------------------
Specifies frozen doubly-occupied orbitals per irreducible representation (recommended for core orbitals).
* Default: No frozen orbitals.

:guilabel:`Dele` Parameter Type: Integer Array
------------------------------------------------
Specifies frozen virtual orbitals per irreducible representation.
* Default: No frozen virtual orbitals.

:guilabel:`Electron` Parameter Type: Integer
------------------------------------------------
Specifies correlated electrons.
* Default: Inherited from mcscf.

:guilabel:`Inactive` Parameter Type: Integer Array
------------------------------------------------
Specifies inactive orbitals per irreducible representation.
* Default: Inherited from mcscf.

:guilabel:`Active` Parameter Type: Integer Array
------------------------------------------------
Specifies active orbitals per irreducible representation.
* Default: Inherited from mcscf.

:guilabel:`XvrUse` Parameter Type: Boolean
------------------------------------------------
Uses MCSCF XVR method to delete virtual orbitals when `Dele` is unused.
.. attention::
  `Dele` takes priority if both specified.

* Full logic example: test126.inp

:guilabel:`Rootprt` Parameter Type: Integer
------------------------------------------------
Specifies electronic state for numerical gradients (numgrad module).
* Default: 1

:guilabel:`Orbtxt` Parameter Type: String
------------------------------------------------
Specifies MO file suffix.

:guilabel:`CVS` Parameter Type: Boolean
------------------------------------------------
Generates Core Valence Separation DRT for core excitation calculations.
  
:guilabel:`ReadDRT` Parameter Type: Boolean
------------------------------------------------
Reads DRT from `$WORKDIR/$BDFTASK.cidrt` to reduce generation time (recommended for large active spaces).
  
:guilabel:`Nexci` Parameter Type: Integer
------------------------------------------------
Specifies excitation level from reference configurations.
* Default: 2
* Options: 1 (single excitations), ≥3 (triple+ excitations)

:guilabel:`Readref` Parameter Type: Integer
------------------------------------------------
Reads reference configurations from `$WORKDIR/BDFTASK.select_*_#` (*=spin, #=symmetry).
* Default: Inherited from mcscf.
* Required if mcscf lacks "iCI"/"iCIPT2" keywords.

:guilabel:`Node` Parameter Type: Integer
------------------------------------------------
Initial array size for CAS reference space (P-space) sub-DRTs (not needed for selected configurations).
* Default: 1000000

:guilabel:`Pmin` Parameter Type: Floating-point
------------------------------------------------
Reference configuration coefficient threshold (from `BDFTASK.select_*_#`).
* Default: 0.0 (if mcscf uses iCI/iCIPT2, inherits `Cmin`)
* Recommended: 1.d-3

:guilabel:`QminDV` Parameter Type: Floating-point
------------------------------------------------
FOIS threshold for pruning uncontracted excitations in \bar{D}V subspace (3 active + 1 inactive orbital).
* Default: 0.0 
* Recommended: 1.d-5

:guilabel:`QminVD` Parameter Type: Floating-point
------------------------------------------------
FOIS threshold for pruning uncontracted excitations in \bar{V}D subspace (3 active + 1 virtual orbital).
* Default: 0.0 
* Recommended: 1.d-5

:guilabel:`Qnex` Parameter Type: Boolean
------------------------------------------------
Disables DVD approximation (ignores certain double excitations with 3 active orbitals).
* Default: false

:guilabel:`Epic` Parameter Type: Floating-point
------------------------------------------------
Threshold for storing internally contracted function coefficients.
* Default: 0.0 
* Recommended: 1.d-5

:guilabel:`Seleref` Parameter Type: Integer
------------------------------------------------
Specifies reference orbital configurations (oCFGs) for MRCI. Format: nref+1 lines.
* Default: Not needed if `readref` is used.

.. code-block:: python

     $xianci
     ...
     seleref
     3 
     2200
     2110
     2020
     $end

Line 1: Reference count (nref)
Lines 2-nref+1: oCFGs

:guilabel:`Prtcri` Parameter Type: Floating-point
------------------------------------------------
CSF print threshold.
* Default: 0.05

:guilabel:`Ethres` Parameter Type: Floating-point
------------------------------------------------
H0 diagonalization energy convergence threshold.
* Default: 1.D-8

:guilabel:`Conv` Parameter Type: Floating-point Array
------------------------------------------------
MRCI iterative diagonalization thresholds (energy, wavefunction, residual vector).
* Default: 1.D-8, 1.D-6, 1.D-8

:guilabel:`Maxiter` Parameter Type: Integer
------------------------------------------------
Max H0/H matrix diagonalization iterations.
* Default: 200

:guilabel:`Maxbloch` Parameter Type: Integer
------------------------------------------------
Max BLOCH equation iterations for CASPT2/SDSPT2f/SDSCIf.
* Default: 5

:guilabel:`InitHDav` Parameter Type: Integer
------------------------------------------------
Initial vector method for MRCI diagonalization:
* 1: Use excitations strongly coupled to lowest CSF (default)
* 2: Use CSFs ordered by Hamiltonian diagonal
* 3: Use reference wavefunction

:guilabel:`InitH0Dav` Parameter Type: Integer
------------------------------------------------
Initial vector method for H0 diagonalization:
* 2: Use CSFs ordered by Hamiltonian diagonal (default)
* 1: Use excitations strongly coupled to lowest CSF

:guilabel:`Cipro` Parameter Type: Boolean
------------------------------------------------
Computes one-electron reduced density matrix and properties (e.g., dipole).

:guilabel:`DCRI` Parameter Type: Floating-point
------------------------------------------------
Orthogonalization threshold for internally contracted configurations.
* Default: 1.D-12

:guilabel:`EPCC` Parameter Type: Floating-point
------------------------------------------------
Contracted configuration coupling coefficient threshold (higher values speed icMRCI but reduce accuracy).
* Default: 1.D-20

:guilabel:`Qfix` Parameter Type: Floating-point
------------------------------------------------
iCMRCI optimization threshold (excitations with |coefficient| > threshold are optimized).
* Default: 0.0

:guilabel:`Ncisave` Parameter Type: Integer
------------------------------------------------
Max H0 matrix dimension for full diagonalization (increase for large memory systems).
* Default: 50000

:guilabel:`Saveact` Parameter Type: Boolean
------------------------------------------------
Stores coupling coefficients in memory for H0 diagonalization (faster but memory-intensive).
  
:guilabel:`Setlpact` Parameter Type: Integer
------------------------------------------------
Initial array size for storing coupling coefficients (larger values reduce resizing).
* Default: 100000000
 
:guilabel:`Setblkact` Parameter Type: Integer
------------------------------------------------
Initial array size for coupling coefficient classes (larger values reduce resizing).
* Default: 10000000
 
:guilabel:`Nosavelp` Parameter Type: Boolean
------------------------------------------------
Disables storage of (contracted) coupling coefficients (slower but disk-efficient for large active spaces).

:guilabel:`Setloop` Parameter Type: Integer
------------------------------------------------
Initial array size for coupling coefficients in MRCI diagonalization (larger values reduce resizing).
* Default: 10000000
 
:guilabel:`Setblk` Parameter Type: Integer
------------------------------------------------
Initial array size for coupling coefficient classes in MRCI diagonalization (larger values reduce resizing).
* Default: 10000000

**Inner-Contracted CI Method Selection**

:guilabel:`FCCI` Parameter Type: Boolean
------------------------------------------------
Performs fully internally contracted MRCI (icMRCI) for excited space (Q) with uncontracted reference space (P).
* Default method.

:guilabel:`XSDSCI` Parameter Type: Boolean
------------------------------------------------
Performs FCCI with excitation coefficients from SDSPT2 (Dyall Hamiltonian as H0), avoiding intruder states for low excitations.

:guilabel:`VSD` Parameter Type: Boolean
------------------------------------------------
Virtual Space Decomposition (VSD): Projects large-basis virtual MOs onto small-basis space using SVD to isolate strong correlation subspaces. Combines with XSDSCI for efficient multi-reference calculations.
* Example: test126.inp

:guilabel:`NoVDVP` Parameter Type: Boolean
------------------------------------------------
Skips CI Hamiltonian elements between Q subspaces (\bar{V}D, \bar{V}P) and zeroth-order wavefunction.

:guilabel:`SDSCI` Parameter Type: Boolean
------------------------------------------------
Performs SDSCI with excitation coefficients from SDSPT2 (Dyall Hamiltonian as H0), avoiding intruder states (recommended minimal-cost MRCI).

:guilabel:`SDSCIf` Parameter Type: Boolean
------------------------------------------------
Performs SDSCIf with excitation coefficients from SDSPT2f (generalized Fock as H0), may have intruder states.

:guilabel:`UCCI` Parameter Type: Boolean
------------------------------------------------
Performs uncontracted MRCISD (ucMRCI).

:guilabel:`NICI` Parameter Type: Boolean
------------------------------------------------
Performs non-contracted icMRCI for full internal space excitations.

:guilabel:`CWCI` Parameter Type: Boolean
------------------------------------------------
Performs Celani-Werner contracted icMRCI.

:guilabel:`WKCI` Parameter Type: Boolean
------------------------------------------------
Performs Werner-Knowles contracted WicMRCI.

:guilabel:`SDCI` Parameter Type: Boolean
------------------------------------------------
Performs SDCI-mode icMRCI (intermediate contraction between CWCI/WKCI).

**Multi-Reference Perturbation Parameters**

:guilabel:`CASPT2` Parameter Type: Boolean
------------------------------------------------
Performs MS-CASPT2 (Multi-State) with Q-space per reference state.

:guilabel:`RMSCASPT2` Parameter Type: Boolean
------------------------------------------------
Performs RMS-CASPT2 (Rotated Multi-State) with Q-space per reference state.

:guilabel:`XMSCASPT2` Parameter Type: Boolean
------------------------------------------------
Performs XMS-CASPT2 (Extended Multi-State) with Q-space per reference state.

:guilabel:`XDWCASPT2` Parameter Type: Boolean
------------------------------------------------
Performs XDW-CASPT2 (Extended Dynamic Weight Multi-State) with Q-space per reference state.

:guilabel:`XDWPara` Parameter Type: Floating-point
------------------------------------------------
XDW-CASPT2 parameter:
* Default: 50
* 0 → XMS-CASPT2; ∞ → RMS-CASPT2.

:guilabel:`SDSPT2f` Parameter Type: Boolean
------------------------------------------------
Performs SDSPT2f with generalized Fock as H0 (may have intruder states).

:guilabel:`Rshift` Parameter Type: Floating-point
------------------------------------------------
Real level shift for intruder state mitigation (generalized Fock H0 methods).
* Default: 0.0
* Recommended: 0.3

:guilabel:`Ishift` Parameter Type: Floating-point
------------------------------------------------
Imaginary level shift for intruder state mitigation.
* Default: 0.0
* Recommended: 0.1

:guilabel:`NEVPT2` Parameter Type: Boolean
------------------------------------------------
Performs MS-NEVPT2 (Multi-State) with Q-space per reference state.

:guilabel:`SDSPT2` Parameter Type: Boolean
------------------------------------------------
Performs SDSPT2 with Dyall Hamiltonian as H0 (avoids intruder states for low excitations).

:guilabel:`DVRLS` Parameter Type: Floating-point
------------------------------------------------
Real level shift for \bar{D}V subspace intruder states (Dyall H0 methods).
* Default: 0.0
* Recommended: 0.3

:guilabel:`VDRLS` Parameter Type: Floating-point
------------------------------------------------
Real level shift for \bar{V}D subspace intruder states.
* Default: 0.0
* Recommended: 0.3

:guilabel:`DDRLS` Parameter Type: Floating-point
------------------------------------------------
Real level shift for \bar{D}D subspace intruder states.
* Default: 0.0
* Recommended: 0.3

:guilabel:`DVILS` Parameter Type: Floating-point
------------------------------------------------
Imaginary level shift for \bar{D}V subspace (not recommended).
* Default: 0.0
* Recommended: 0.1

:guilabel:`VDILS` Parameter Type: Floating-point
------------------------------------------------
Imaginary level shift for \bar{V}D subspace (not recommended).
* Default: 0.0
* Recommended: 0.1

:guilabel:`DDILS` Parameter Type: Floating-point
------------------------------------------------
Imaginary level shift for \bar{D}D subspace (not recommended).
* Default: 0.0
* Recommended: 0.1

:guilabel:`SAFock` Parameter Type: Boolean
------------------------------------------------
Uses state-averaged (SA) MO energies/integrals for NEVPT2/SDSPT2/SDSCI.
* Default: true

:guilabel:`SDFock` Parameter Type: Boolean
------------------------------------------------
Uses state-specific (SS) MO energies + SA integrals for NEVPT2/SDSPT2/SDSCI.
* Default: false

:guilabel:`SSFock` Parameter Type: Boolean
------------------------------------------------
Uses SS MO energies/integrals for NEVPT2.
* Default: false

:guilabel:`Dylan` Parameter Type: Boolean
------------------------------------------------
Truncates high-energy Ps functions for SDSPT2(f)/SDSCI(f) secondary states (default).
* Effective Hamiltonian dimension: 3N. Maintains accuracy but Ps count varies by geometry.

:guilabel:`Nolan` Parameter Type: Boolean
------------------------------------------------
Skips Ps wavefunction generation for SDSPT2(f)/SDSCI(f).
* Effective Hamiltonian dimension: 2N. Faster but reduced accuracy near conical intersections.

:guilabel:`Dolan` Parameter Type: Boolean
------------------------------------------------
Uses Lanczos for SDSPT2(f)/SDSCI(f) secondary states (not recommended: computationally expensive).
* Effective Hamiltonian dimension: 3N.

:guilabel:`DEPENST` Parameter Type: Boolean
------------------------------------------------
Uses SS Fock diagonal elements in Dyall Hamiltonian (default: SA).

:guilabel:`MR-NEVPT2` Parameter Type: Boolean
------------------------------------------------
Performs Multi-reference NEVPT2 with globally orthogonal configuration space.

:guilabel:`NEVPT3` Parameter Type: Boolean
------------------------------------------------
Performs SS-NEVPT3 with independent Q-space per state.

:guilabel:`CBMPRT2` Parameter Type: Boolean
------------------------------------------------
Performs CBMRPT2.

:guilabel:`MR-CBMRPT2` Parameter Type: Boolean
------------------------------------------------
Performs MR-CBMPRT2 with globally orthogonal configuration space.

:guilabel:`CBMRPT3` Parameter Type: Boolean
------------------------------------------------
Performs CBMRPT3 with independent Q-space per state.

**Test Cases**

:guilabel:`test069.inp`
------------------------------------------------
.. attention::
   SDSPT2(f)/SDSCI(f)/XSDSCI/icMRCI energies include +Q1 (Pople Correction).
   ucMRCI energies include +Q3 (Davidson Correction).

.. code-block:: bdf
     [Preserved code blocks with English outputs]

:guilabel:`test080.inp`
------------------------------------------------

:guilabel:`test095.inp`
------------------------------------------------

:guilabel:`test126.inp`
------------------------------------------------

:guilabel:`test131.inp`
------------------------------------------------

:guilabel:`test139.inp`
------------------------------------------------

:guilabel:`test148.inp`
------------------------------------------------