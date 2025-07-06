Molecular Structure Optimization - BDFOPT Module
================================================
The BDFOPT module is BDF's molecular geometry optimization module, used to locate energy local minima, transition states, conical intersections, etc. Unlike other modules, input files containing the bdfopt module are not executed linearly in module order; see the "Quick Start" section on structure optimization for details.

:guilabel:`Solver` Parameter Type: Integer
------------------------------------------------
* Default: 0
* Options: 0, 1

Specifies the optimizer for geometry optimization:
* ``Solver=0``: Uses the external DL-Find optimizer, supporting energy minimization, transition state search, higher-order saddle points, conical intersections, and minimum energy crossing points (MECP) in Cartesian or internal coordinates.
* ``Solver=1``: Uses BDF's built-in optimizer.

For energy minimization or transition state searches in redundant internal coordinates (see ``ICoord`` keyword), ``Solver=1`` is recommended.

.. attention::
   Due to conflicts between DL-FIND and BDF's default coordinate rotation, add the ``norotate`` keyword in the ``compass`` module to disable molecular rotation, or use ``nosymm`` to disable symmetry. For diatomic/triatomic molecules, only ``nosymm`` is allowed. This issue will be resolved in future updates.

:guilabel:`Imulti` Parameter Type: Integer
------------------------------------------------
* Default: 0
* Options: 0, 1, 2

Used for multi-state optimization (e.g., conical intersections (CI), intersystem crossings (ISC)). Currently only supported by DL-Find:
* ``Imulti = 0``: No multi-state optimization (default)
* ``Imulti = 1``: Optimizes CI/ISC using penalty functions (no non-adiabatic/spin-orbit coupling gradients required)
* ``Imulti = 2``: Optimizes CI/ISC using gradient projection (requires non-adiabatic coupling for CI; set ``Noncoupl`` to skip spin-orbit coupling gradients for ISC)

:guilabel:`Noncoupl` Parameter Type: Bool
-----------------------------------------------
Skips spin-orbit coupling gradient calculations for ISC optimization.

:guilabel:`Multistate` Parameter Type: String
------------------------------------------------
* Default: NONE
* Options: NONE, 2SOC, 3SOC, ..., 9SOC, MECP, CI

Specifies multi-state calculation type. Supported by both DL-Find and BDF optimizers:
* ``NONE``: Standard single-state optimization/frequency calculation (``1SOC`` is a synonym)
* ``2SOC`` [ ``chi`` ]: Two-state spin-mixing model using MSSM (Multi-State Spin Mixing) :cite:`Truhlar2018`. Simulates spin-orbit coupling between two spin states to obtain spin-mixed ground states. Supports structure optimization and vibrational frequencies.
* ``3SOC`` [ ``chi`` ]: MSSM model for three spin states. Similarly, ``4SOC`` [ ``chi`` ] to ``9SOC`` [ ``chi`` ] support up to nine spin-mixed states.
* ``MECP``: Optimizes minimum energy crossing points between two states (not yet supported)
* ``CI``: Optimizes conical intersections between two states (not yet supported)

``chi`` is an optional empirical spin-orbit coupling constant (units: :math:`\rm cm^{-1}`; default: 400):
* **3d elements**: ``chi`` = 50–400 (results are insensitive; up to 1800 for unsaturated bonding) :cite:`Takayanagi2018,Truhlar2018`
* **4d elements**: ``chi`` = 50–800 (up to 2000 for unsaturated bonding)
* **5d elements**: ``chi`` = 500–3000 (recommended: 2500) :cite:`Truhlar2018`. MSSM may be unreliable for unsaturated 5d systems; use two-/four-component relativistic methods for single-point corrections.
* **Not applicable** to actinides/heavier elements.

:guilabel:`Maxcycle` Parameter Type: Integer
---------------------------------------------------
Sets maximum optimization steps. Default: 50 (DL-Find); max(100, 6×number of atoms) (BDF).

:guilabel:`TolGrad` Parameter Type: Float
------------------------------------------------
Sets RMS gradient convergence threshold (units: Hartree/Bohr). Default: 2.D-4 (DL-Find), 3.D-4 (BDF). Max gradient threshold = 1.5 × TolGrad.

:guilabel:`TolEne` Parameter Type: Float
---------------------------------------------------
* Default: 1.D-6
Sets energy change convergence threshold between steps (units: Hartree). Only for DL-Find.

:guilabel:`TolStep` Parameter Type: Float
------------------------------------------------
* Default: 1.2D-3
Sets RMS step convergence threshold (units: Bohr). Only for BDF. Max step threshold = 1.5 × TolStep.

:guilabel:`IOpt` Parameter Type: Integer
---------------------------------------------------
* Default: 3
* Options: 3, 10 (Solver=1); 0,1,2,3,9,10,11,12,13,20,30,51,52 (Solver=0)

Specifies optimization target. For DL-Find, aligns with DL-Find's IOpt (common: 3=L-BFGS, 10=P-RFO). For BDF, only IOpt=3 (minima) and IOpt=10 (transition states) are supported.

:guilabel:`Trust` Parameter Type: Float
---------------------------------------------------
* Default: 0.3
* Options: Non-zero real
* Range: 0.005–0.5 or -0.5–-0.005

Sets trust radius. Positive values: initial trust radius = r (dynamically adjusted). Negative values: initial trust radius = |r| (never exceeds |r|).

:guilabel:`Update` Parameter Type: Integer
------------------------------------------------
* Default: 3 (minima), 2 (transition states)
* Options: 0,1,2,3,9

Sets Hessian update method:  
0 = recalculate numerical Hessian every step  
1 = Powell update (DL-Find only)  
2 = Bofill update (transition states)  
3 = L-BFGS (DL-Find) / BFGS (BDF)  
9 = Bofill update (minima)  
If ≠0, initial Hessian is force-field-based.

:guilabel:`ICoord` Parameter Type: Integer
---------------------------------------------------
* Options: 0, 1
Sets coordinate system: 0 = Cartesian (DL-Find default), 1 = redundant internal (BDF default; only option for BDF).

:guilabel:`ILine` Parameter Type: Integer
------------------------------------------------
* Options: 0, 1
Enables line searches during optimization (0 = disable, 1 = enable). Default: 0 (DL-Find), 1 (BDF).

:guilabel:`Frozen` Parameter Type: Integer Sequence
---------------------------------------------------
Performs constrained optimization by freezing Cartesian coordinates of specified atoms. First line = number of constraints (N). Lines 2–N+1: two integers per line (atom index + freeze code):  

.. code-block:: bdf

    0: Not frozen (default)  
   -1: Freeze x,y,z  
   -2: Freeze x  
   -3: Freeze y  
   -4: Freeze z  
  -23: Freeze x,y  
  -24: Freeze x,z  
  -34: Freeze y,z  

BDF optimizer only supports 0 or -1.  

.. note::  
     Freezes relative Cartesian coordinates; absolute coordinates may change due to molecular reorientation.

:guilabel:`Constrain` Parameter Type: Integer Sequence
---------------------------------------------------
Performs constrained optimization (Cartesian, bond lengths, angles, dihedrals). BDF optimizer only. First line = number of constraints (N). Lines 2–N+1:  
- 1 integer: freeze atom's Cartesian coordinates  
- 2 integers: freeze bond between atoms  
- 3 integers: freeze angle between atoms  
- 4 integers: freeze dihedral between atoms  

.. code-block:: bdf

     $bdfopt
     Constrain
     2
     1 5        # Freeze bond between atoms 1-5
     1 4 8      # Freeze angle between atoms 1-4-8
     $end

Optionally set values before freezing:  

.. code-block:: bdf

     $bdfopt
     Constrain
     2
     5 10                     # Freeze distance at initial value
     4 5 = 1.5                # Set distance to 1.5 Å, then freeze (units always Å)
     $end

.. note::  
     Works with Cartesian coordinates. Freezing preserves relative positions.

:guilabel:`Hess` Parameter Type: String
------------------------------------------------
* Options: only, init, final, init+final
Computes Hessian:  
- ``only``: Compute Hessian only (no optimization). Performs frequency/thermochemistry analysis.  
- ``init``: Compute initial Hessian for optimization (useful for transition states).  
- ``final``: Optimize → compute Hessian at converged geometry (opt+freq).  
- ``init+final``: Compute initial Hessian → optimize → compute final Hessian (analyzes final Hessian).  

.. attention::  
    BDF supports analytical Hessian for HF/DFT; TDDFT uses numerical Hessian. Force numerical Hessian with ``UseNumHess``.

:guilabel:`UseNumHess` Parameter Type: Bool
-----------------------------------------------
Forces numerical Hessian even if analytical Hessian is available (supports HF/DFT: LDA, GGA, Hybrid, RS-Hybrid).

:guilabel:`ReCalcHess` Parameter Type: Integer
---------------------------------------------------
* Options: Non-negative integer
Recalculates numerical Hessian every N steps during optimization. Default: never (unless Update=0).

:guilabel:`NumHessStep` Parameter Type: Float
------------------------------------------------
* Default: 0.005
* Options: Positive real
* Range: 0.001–0.02
Displacement step for numerical Hessian (units: Bohr). Requires Hessian calculation via other keywords.

:guilabel:`ReadHess` Parameter Type: Bool
---------------------------------------------------
Reads $BDFTASK.hess as initial Hessian ($BDFTASK = input filename without .inp). File can be from any frequency calculation.

:guilabel:`RestartHess` Parameter Type: Bool
---------------------------------------------------
Restarts a frequency calculation from checkpoint.

:guilabel:`RmImag` Parameter Type: Bool
---------------------------------------------------
Automatically eliminates imaginary frequencies:  
- Minima: Removes all imaginary frequencies.  
- Transition states: Reduces to exactly one imaginary frequency.  
Success not guaranteed; verify results manually.

:guilabel:`NDeg` Parameter Type: Integer
---------------------------------------------------
* Default: 1
* Options: Positive integer
Electronic degeneracy for thermochemistry (Gibbs free energy). Degeneracy = spatial degeneracy × spin degeneracy. Default=1; crucial for open-shell systems.

:guilabel:`NTemp` Parameter Type: Integer
---------------------------------------------------
* Default: 1
* Options: Positive integer
Number of temperature values (defined by ``Temp``). Must precede ``Temp``.

:guilabel:`Temp` Parameter Type: Float
---------------------------------------------------
* Default: 298.15
* Options: Positive real
Temperature for thermochemistry (units: K).

:guilabel:`NPress` Parameter Type: Integer
---------------------------------------------------
* Default: 1
* Options: Positive integer
Number of pressure values (defined by ``Press``). Must precede ``Press``.  
- ``NTemp`` > 1, ``NPress`` = 1: Vary temperature at fixed pressure.  
- ``NTemp`` = 1, ``NPress`` > 1: Vary pressure at fixed temperature.  
- Both >1: Compute for all T/P pairs (pad with defaults if unequal).

:guilabel:`Press` Parameter Type: Float
---------------------------------------------------
* Default: 1.0
* Options: Positive real
Pressure for thermochemistry (units: atm).

:guilabel:`Scale` Parameter Type: Float
---------------------------------------------------
* Default: 1.0
* Options: Positive real
Frequency scaling factor.

:guilabel:`Dimer` Parameter Type: Bool
---------------------------------------------------
Uses DL-FIND's Dimer method :cite:`dimer1999,dimer2005,dimer2008,dlfind2009` for transition state optimization (gradients only; no Hessian). Modify defaults via ``Dimer-Block``.

:guilabel:`Dimer-Block` Parameter Type: Multiple Keywords
---------------------------------------------------
Modifies Dimer parameters (end with ``End Dimer``):  
- ``NoInterpolation``: Recomputes gradients after rotation (slower but fewer steps).  
- ``Delta`` (default: 0.01): Image separation (Bohr; Cartesian only).  
- ``Crude``: Relaxes RMS gradient threshold to 1.33D-3 (faster but less precise).

:guilabel:`NEB` Parameter Type: Bool
---------------------------------------------------
Uses DL-FIND's CI-NEB method :cite:`neb2000,dlfind2009` for reaction paths (highest energy = transition state). Requires:  
- Reactant geometry from ``Compass``.  
- Product geometry from ``Geometry2`` (atom order must match).  
- Optional intermediate images (see ``NFrame``).  
Modify defaults via ``NEB-Block``.

:guilabel:`NEB-Block` Parameter Type: Multiple Keywords
---------------------------------------------------------
Modifies CI-NEB parameters (end with ``End NEB``):  
- ``NImage`` (default: 5): Number of intermediate images. Total images = NImage + 3.  
- ``NEBk`` (default: 0.01): Empirical force constant.  
- ``NEBMode`` (default: 2): Endpoint handling (0=minimize, 1=minimize perpendicular, 2=fixed).  
- ``Crude``: Relaxes RMS gradient threshold to 1.33D-3.

:guilabel:`NFrame` Parameter Type: Integer
---------------------------------------------------
* Default: 1
* Options: 1 to ``NImage``+1 (CI-NEB)
Number of coordinates in ``Geometry2``. Must precede ``Geometry2``.

:guilabel:`Geometry2` Parameter Type: String Array
---------------------------------------------
Specifying the geometry of the second endpoint for the CI-NEB method is currently only supported in Cartesian coordinates (to be improved in the future) in angstroms. If the input coordinates are atomic units, you can add Bohr, i.e. Geometry2 Bohr.
This keyword ends with ''End Geometry2''.
Since the atomic order of the second endpoint must be the same as the first endpoint, the atomic name can be omitted here and only the Cartesian coordinate data can be entered.

If NFrame > 1, the structure of the intermediate image points can be provided for the CI-NEB calculation in Geometry2, sorted by the number of the image points, and the structure of the second endpoint can be placed last.
