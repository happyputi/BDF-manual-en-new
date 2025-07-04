Symmetry and Preprocessing - COMPASS Module
================================================
The COMPASS module primarily handles the initialization of computational tasks. This includes reading user-defined molecular structures, basis sets, and other fundamental information; determining molecular symmetry and point groups; generating symmetry-adapted orbitals; and converting this data into BDF's internal storage format. Key parameters for the Compass module include:

:guilabel:`Basis` Parameter Type: String
----------------------------------------------
Specifies the name of the basis set used for the calculation. BDF basis sets are stored in `$BDFHOME/basis_library`. The basis sets for all atoms in the current calculation must be placed in the file specified by this parameter. Since basis sets are read via this file, users can assign different basis sets to different atoms using custom basis set files (see Custom Basis Set instructions).

 .. code-block:: bdf

     $Compass
     Basis
       cc-pVDZ
     Geometry
     H   0.00  0.00   0.707
     H   0.00  0.00   -0.707
     End Geometry
     $End

:guilabel:`Basis-block` Parameter Type: String
----------------------------------------------
Allows specifying different basis sets for different elements. The first line is the default basis set. Subsequent lines assign other basis sets to specific elements or atoms using the format **element=basisname** or **element1,element2, ...,elementn=basisname**. Must end with ``End Basis``.

.. code-block:: bdf

  $Compass
  Basis-block
    3-21g
    C,N = 6-31g
    Xe = cc-pvdz-pp
  End Basis
  Geometry
  H    0.0  0.0 -1.1
  C    0.0  0.0  0.0
  N    0.0  0.0  1.0
  Xe   3.0  0.0  0.0
  End geometry
  $End

:guilabel:`MPEC+COSX` Parameter Type: Boolean
------------------------------------------------
Specifies the use of the Multipole Expansion of Coulomb Potential (MPEC) method to calculate the J matrix and the Chain-of-Sphere Exchange (COSX) method to calculate the K matrix.

:guilabel:`RI-J` , :guilabel:`RI-K` , :guilabel:`RI-C` Parameter Type: String
-------------------------------------------------------------------------------
Auxiliary basis sets for the Density-Fitting (DF) approximation acceleration algorithm.

 * RI-J: Coulomb fitting basis set
 * RI-K: Exchange fitting basis set
 * RI-C: Correlation fitting basis set

.. code-block:: bdf

     $Compass
     Basis
       DEF2-SVP
     RI-J
       DEF2-SVP
     Geometry
     H   0.00  0.00   0.707
     H   0.00  0.00   -0.707
     End Geometry
     $End

:guilabel:`Geometry` Parameter Type: String Array
---------------------------------------------
Specifies the molecular structure for the calculation. Can be in Cartesian coordinate mode or internal coordinate mode. Molecular coordinate definitions start on the line following the ``Geometry`` parameter and end on the line before ``End Geometry``.

**Cartesian Coordinates** mode

.. code-block:: bdf

     $Compass
     Basis
       cc-pVDZ
     Geometry
     H   0.00  0.00   0.707
     H   0.00  0.00   -0.707
     End Geometry
     $End

**Internal Coordinates** mode

.. code-block:: bdf

     $Compass
     Basis
       cc-pVDZ
     Geometry
     O   
     H   1  0.9  
     H   1  0.9   2 109.0
     End Geometry
     $End

:guilabel:`Restart` Parameter Type: Boolean
-------------------------------------------------------
Uses coordinates from the `$BDFTASK.optgeom` file for the calculation instead of the coordinates given under the `Geometry` keyword, where `$BDFTASK` is the input filename without the `.inp` suffix. **Note:** Although the coordinate values under the `Geometry` keyword are not used in this case, they cannot be omitted. The atom types, number, and order must match exactly; only the coordinate values can be arbitrary. For example, if the input file is named `1.inp` and the `1.optgeom` file contains:

.. code-block:: bdf

 GEOM
 O 0. 0. 0.
 H 0. 0. 2.
 H 0. 2. 0.

Then a `$compass` module like the following in `1.inp` will run correctly:

.. code-block:: bdf

 $compass
 ...
 geometry
 O 0. 0. 0.
 H 0. 0. 2.1
 H 0.1 2.0 0.
 end geometry
 restart
 ...
 $end

This input is equivalent to (even if units of Å were specified above):

.. code-block:: bdf

 $compass
 ...
 geometry
 O 0. 0. 0.
 H 0. 0. 2.
 H 0. 2. 0.
 end geometry
 unit
  bohr
 ...
 $end

However, the `$compass` module in `1.inp` **cannot** be written like the following because the number of atoms doesn't match the `.optgeom` file:

.. code-block:: bdf

 $compass
 ...
 geometry
 O 0. 0. 0.
 H 0. 2.1 0.
 end geometry
 restart
 ...
 $end

Nor can it be written like this, because the atom order doesn't match the `.optgeom` file:

.. code-block:: bdf

 $compass
 ...
 geometry
 H 0. 2.1 0.
 O 0. 0. 0.
 H 0. 0. 2.1
 end geometry
 restart
 ...
 $end

``restart`` is primarily used for resuming interrupted geometry optimizations. Using the `1.inp` example, if `1.inp` is an input file for a geometry optimization that didn't finish normally (e.g., due to non-convergence, an error, or user termination), the structure from the last optimization step is saved in `1.optgeom`. Adding the `restart` keyword to the `$compass` module in `1.inp` and rerunning `1.inp` allows resuming the geometry optimization from the last structure, without manually copying the contents of `1.optgeom` into `1.inp`.

:guilabel:`Group` Parameter Type: String
--------------------------------------
Specifies the molecular symmetry point group. BDF automatically determines molecular symmetry. HF/DFT/TDDFT support high-order molecular point groups. However, some electron correlation methods like MCSCF and MRCI only support D2h and its subgroups. This parameter can be used to force BDF to use an Abelian group for such calculations.

 .. code-block:: bdf

     # Benzene has highest symmetry D6h. Without specifying a group, BDF determines D6h symmetry.
     $COMPASS
     Title
       C6H6 Molecule test run, cc-pVDZ
     Basis
       cc-pVDZ
     Geometry
     C    0.00000000000000   1.39499100000000   0.00000000000000
     C   -1.20809764405066   0.69749550000000   0.00000000000000
     C    0.00000000000000  -1.39499100000000   0.00000000000000
     C   -1.20809764405066  -0.69749550000000   0.00000000000000
     C    1.20809764405066  -0.69749550000000   0.00000000000000
     C    1.20809764405066   0.69749550000000   0.00000000000000
     H    0.00000000000000   2.49460100000000   0.00000000000000
     H   -2.16038783830606   1.24730050000000   0.00000000000000
     H    0.00000000000000  -2.49460100000000   0.00000000000000
     H   -2.16038783830607  -1.24730050000000   0.00000000000000
     H    2.16038783830607  -1.24730050000000   0.00000000000000
     H    2.16038783830606   1.24730050000000   0.00000000000000
     End geometry
     Check
     $END
    
     # Subgroups of D6h include D3h, C6v, D3d, D2h, C2v, C1, etc. This example forces benzene calculation using D2h group.
     $COMPASS 
     Title
       C6H6 Molecule test run, cc-pVDZ
     Basis
       cc-pVDZ
     Geometry
     ...
     End geometry
     Check
     Group
       D(2h)
     $END

:guilabel:`Nosymm` Parameter Type: Boolean
----------------------------------------------
 * Default: false
  
Forces BDF to ignore molecular symmetry during the calculation.

.. attention:: 

    Unlike specifying the C1 group, using this parameter prevents rotation of molecular coordinates. By default, molecular coordinates are rotated to the standard orientation.

:guilabel:`Norotate` Parameter Type: Boolean
------------------------------------------------
Forces BDF *not* to rotate molecular coordinates to the standard orientation. Unlike `Nosymm`, `Norotate` does *not* ignore molecular symmetry. However, **critical requirement**: When symmetry elements like axes or planes are present, their spatial orientation relative to the molecule must exactly match the orientation they would have after rotation to the standard orientation. For example, for a water molecule lying in the yz-plane and symmetric about the xz-plane, BDF would normally rotate it to lie in the xz-plane. Using `Norotate` forces BDF to calculate with the molecule in the yz-plane while still utilizing its C(2v) symmetry, because the symmetry axis (z-axis) and mirror planes (xz and yz planes) align correctly regardless of the molecular plane (xz or yz). However, if the water molecule lies in the xy-plane, using `Norotate` will cause an error because its symmetry axis would not be aligned with the z-axis.

:guilabel:`Unit` Parameter Type: String
---------------------------------------------------

 * Default: Angstrom
 * Options: Bohr, Angstrom

Specifies the unit of length for input coordinates. `Bohr` indicates atomic units (Bohr radii), `Angstrom` indicates Ångstroms.

.. _compass.skeleton:

:guilabel:`Skeleton` Parameter Type: Boolean
---------------------------------------------------
Specifies the symmetry handling method within BDF calculations. BDF offers two approaches to molecular point group symmetry:
1.  **Traditional:** Construct symmetry-adapted orbitals first. Atomic orbital integrals are symmetrized during calculation and stored based on symmetry-adapted orbitals. This method supports non-direct-integral wavefunction theories like SCF, MCSCF, MRCI, CCSD.
2.  **Skeleton:** Only compute and store symmetry-unique atomic orbital integrals ("skeleton integrals"). Symmetry-adapted operators like the J and K matrices are constructed directly during calculations like Hartree-Fock or Kohn-Sham DFT. This "Skeleton" method supports non-Abelian point groups.

Originally, BDF defaulted to the first approach. It now defaults to the second (Skeleton) method. **However, Skeleton cannot be used for various post-HF wavefunction theories.** Use the :ref:`Saorb<compass.saorb>` keyword to switch back to the first approach in such cases.

.. _compass.saorb:

:guilabel:`Saorb` Parameter Type: Boolean
---------------------------------------------------
Specifies the traditional symmetry handling approach (symmetry-adapted orbital construction) within BDF. **Required for various post-HF wavefunction theory calculations.** See :ref:`Skeleton<compass.skeleton>` keyword.

:guilabel:`Extcharge` Parameter Type: String
---------------------------------------------------
Valid input value: `point`

Specifies the need for external point charges in the calculation. The external charges are placed in a file named `$BDFTASK.extcharge`. The file format is:

   First line is a title line (can be empty).
   Second line: An integer `N` defining the number of additional charges.
   Third line onwards: `N` lines defining the charge coordinates and magnitude. Format:
   `Atom` \   `Charge` \  `x` `y` `z`

:guilabel:`Thresh` Parameter Type: String
------------------------------------------------------
 * Default: Medium
 * Options: Coarse, Medium, Strict

Specifies the precision threshold for determining molecular symmetry. A key feature of BDF is its support for molecular point groups. The compass module automatically identifies the molecular symmetry group and rigorously symmetrizes the molecule accordingly. Due to modeling precision, a molecule might not strictly belong to a particular symmetry point group; this parameter controls the tolerance level for symmetry determination.

 .. code-block:: bdf
     
    $COMPASS 
    Basis
      cc-pVDZ
    Geometry
    C    0.00000000000000   1.39499100000000   0.00000000000000
    C   -1.20809764405066   0.69749550000000   0.00000000000000
    C    0.00000000000000  -1.39499100000000   0.00000000000000
    ...
    End geometry
    Thresh
      Medium
    $END

:guilabel:`ExpBas` Parameter Type: Integer
-----------------------------------------------------
 * Options: 0, 1, 2, 3, 4, 5

Prints the basis set and pseudopotentials in the output file using formats compatible with other quantum chemistry programs.

 * 0: Default BDF format
 * 1: Molpro format
 * 2: Molcas format
 * 3: Gaussian format
 * 4: ORCA format
 * 5: CFour format

:guilabel:`Uncontract` Parameter Type: Boolean
-------------------------------------------------------
Forces the use of the uncontracted primitive Gaussian basis functions for calculation, regardless of whether the input basis set is contracted. Primarily used for testing.

:guilabel:`Primitive` Parameter Type: Boolean
-----------------------------------------------------
Specifies that only primitive Gaussian basis functions in a specific format are input. Primarily used for testing.

:guilabel:`Check` Parameter Type: Boolean
-----------------------------------------------------
Prints the most important results in a specific format. Primarily used for testing.

:guilabel:`AtomMass` Input Block
-----------------------------------------------------
Specifies isotopic masses for atoms. Input format:

 .. code-block:: ruby

    $compass
        ...
        Geometry
            O   -1.81084784   -0.11050725    0.00000000
            H   -2.16957593    0.77995003    0.00000000
            K    0.87665046    0.00547937    0.00000000
        End Geom
        AtomMass
            2          # Specify masses for 2 atoms. Unspecified atoms use their most abundant isotope mass.
            2   2.0    # Specify mass number 2.0 for atom 2 (H)
            1  18.0    # Specify mass number 18.0 for atom 1 (O)
    $end