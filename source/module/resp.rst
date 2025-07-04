DFT/TDDFT Gradients and Response Properties - RESP Module
================================================
The resp module is used to calculate DFT/TDDFT gradients, nonadiabatic coupling matrix elements at the TDDFT level (including ground-excited and excited-excited couplings), and response properties such as excited-state dipole moments.

**Basic Keywords**

:guilabel:`Iprt` Parameter Type: Integer
------------------------------------------------
Controls print output level, primarily used for program debugging.

:guilabel:`NOrder` Parameter Type: Integer
------------------------------------------------
 * Default: 1
 * Options: 0, 1, 2

Order of geometric coordinate derivatives. Currently supports 0 and 1:
* 0: Calculates response properties without nuclear coordinate derivatives (e.g., excited-state dipole moments)
* 1: Calculates analytical gradients
* 2: Not yet supported (analytical Hessian)
Requires `Geom` to be set.

:guilabel:`Geom` Parameter Type: Boolean
------------------------------------------------
This keyword requires no parameter. Used with `Norder` to specify calculation of first or second geometric derivatives.
Options: 1 (Gradient or fo-NACMEs); 2 (Hessian - under development)

:guilabel:`NFiles` Parameter Type: Integer
------------------------------------------------
For TD-DFT response property calculations, specifies which `$tddft` block results to read. Note: `nfiles = x` does not simply mean reading the x-th `$tddft` block, but rather the block whose `istore` value equals `x`. Example for a closed-shell molecule:

.. code-block:: bdf

     $tddft
     imethod
     1
     Nroot
     1
     istore
     1
     $end

     $tddft
     imethod
     1
     isf
     1
     Nroot
     1
     istore
     2
     $end

     $resp
     geom
     imethod
     2
     nfiles
     2            # Calculates gradient for the lowest triplet excited state, NOT the lowest singlet
                  # because nfiles=2, and only the 2nd $tddft block (lowest triplet) has istore=2
     $end

:guilabel:`Imethod` Parameter Type: Integer
------------------------------------------------
 * Default: 1
 * Options: 1, 2

Specifies whether to perform DFT ground-state or TD-DFT excited-state calculations:
* 1: Ground state
* 2: Excited state
(Older BDF versions used `Method`; currently both `Imethod` and `Method` are supported, but future versions may only support `Imethod`).

.. code-block:: bdf

     # Calculate TD-DFT gradient for the first TD-DFT excited state
     $tddft
     Nroot
     1
     istore
     1
     $end

     $resp
     geom
     imethod
     2
     nfiles
     1
     $end

.. code-block:: bdf

     # Calculate ground state gradient
     $resp
     geom
     $end

:guilabel:`Ignore` Parameter Type: Integer
------------------------------------------------
 * Default: 0
 * Options: -1, 0, 1

Performs data consistency checks for TDDFT gradient calculations, primarily for debugging:
* -1: Recalculates TDDFT excitation energies to verify consistency between Resp and TDDFT modules (debugging only)
* 0: Checks if the Wmo matrix is symmetric. If significant asymmetry is detected (possible due to unconverged TDDFT/Z-Vector iterations or input errors), the program exits with an error.
* 1: Ignores Wmo matrix symmetry check. Use only if convergence thresholds are tight, results are acceptable, and input is correct, but the program still fails the symmetry check.

:guilabel:`IRep` & :guilabel:`IRoot` Parameter Type: Integer
-----------------------------------------------------
These keywords specify which state(s) to calculate TD-DFT gradients or excited-state dipole moments for. Four cases:

a. Both `IRep` and `IRoot` specified:
.. code-block:: bdf

     # Calculate gradient/dipole moment for the 3rd root in the 2nd irreducible representation
     irep
     2
     iroot
     3

b. Only `IRep` specified: Calculates for all roots in that irreducible representation.
c. Only `IRoot` specified:
.. code-block:: bdf

     # Sorts all roots (across irreps) by energy and calculates for the 3rd root
     iroot
     3
d. Neither specified: Calculates for all states obtained from TDDFT.

:guilabel:`JahnTeller` Parameter Type: String
------------------------------------------------
For molecules with high symmetry, TDDFT geometry optimization might induce Jahn-Teller distortion, potentially leading to multiple symmetry-lowering paths. This keyword specifies the desired Jahn-Teller distortion mode. Example:

.. code-block:: bdf

     $resp
     ...
     JahnTeller
      D(2h)   # Prefer distortion yielding D2h symmetry if multiple options exist
     $End
   
If group theory predicts no distortion or rules out the specified point group, a warning is printed and the input is ignored. Without this keyword, the program maximizes retention of high-symmetry axes during distortion.

:guilabel:`Line` Parameter Type: Boolean
------------------------------------------------
Performs linear response calculation.

:guilabel:`Quad` Parameter Type: Boolean
------------------------------------------------
Specifies quadratic response calculation.

:guilabel:`Fnac` Parameter Type: Boolean
------------------------------------------------
Specifies calculation of first-order nonadiabatic coupling (fo-NAC) vectors. Must be used with `Single` or `Double` to compute ground-excited or excited-excited couplings, respectively.

:guilabel:`Single` Parameter Type: Boolean
------------------------------------------------
Specifies calculation of ground-excited nonadiabatic coupling vectors.

:guilabel:`States` Parameter Type: Integer Array
------------------------------------------------
Specifies which excited states to compute ground-excited couplings with (multi-line parameter):
* Line 1: Integer `n` (number of states)
* Lines 2 to `n+1`: `m i l` (file number `m` from TDDFT `istore`, irrep `i`, root `l`)

:guilabel:`Double` Parameter Type: Boolean
------------------------------------------------
Specifies calculation of excited-excited nonadiabatic coupling vectors.

:guilabel:`Pairs` Parameter Type: Integer Array
------------------------------------------------
Specifies which pairs of excited states to compute couplings between (multi-line parameter):
* Line 1: Integer `n` (number of pairs)
* Lines 2 to `n+1`: `m1 i1 l1 m2 i2 l2` (specifies each excited state pair)

:guilabel:`Noresp` Parameter Type: Boolean
------------------------------------------------
Specifies ignoring transition density matrix response terms in `Double` and `FNAC` calculations. Recommended.

:guilabel:`Grid` Parameter Type: String
------------------------------------------------
 * Default: Medium
 * Options: Ultra Coarse, Coarse, Medium, Fine, Ultra Fine

Specifies DFT numerical integration grid type.

:guilabel:`Gridtol` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.0E-6 (1.0E-8 for meta-GGA)
 
Sets the cutoff threshold for generating DFT adaptive grids. Lower values increase grid points, precision, and computational cost.

:guilabel:`MPEC+COSX` Parameter Type: Boolean
------------------------------------------------
Specifies using Multipole Expansion of Coulomb potential (MPEC) for the J matrix and Chain-of-Sphere Exchange (COSX) for the K matrix. Retained for backward compatibility; recommended to set in `Compass` module.

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