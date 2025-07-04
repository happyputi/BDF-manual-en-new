.. _FirstExample:

First Example: RHF Calculation of :math:`\ce{H2O}` Molecule
================================================
Hartree-Fock is the most fundamental algorithm in quantum chemistry. In this section, we will guide users through a Hartree-Fock calculation of a water molecule using BDF, analyzing input and output information. We first present the concise input for BDF. To help users understand the difference between BDF's concise and advanced input modes, we also provide the corresponding advanced input file for each concise input.

Preparing Input
-------------------------------------------------------
First, prepare the input file for the single-point energy Hartree-Fock calculation of a water molecule, named `h2o.inp`. The input content is as follows:

.. code-block:: bdf 

    #!bdf.sh
    HF/3-21G    
  
    Geometry
    O
    H  1  R1 
    H  1  R1  2 109.
  
    R1=1.0     # input bond length with the default unit angstrom
    End geometry

Interpretation of the input:
- The first line must start with `#!`, followed by a string named `bdf.sh`. This can be any alphanumeric string and may contain `.` but no other special characters. This is a system-reserved line; users can use this string to tag the calculation job.
- The second line `HF/3-21G` is BDF's calculation parameter control line. `HF` is the abbreviation for Hartree-Fock, and `3-21G` specifies the basis set. Key parameter control lines can span multiple consecutive lines.
- The third line is blank and can be ignored. It is used here to separate different input sections for readability and is recommended.
- Lines 4 and 10 are `Geometry` and `End geometry`, marking the start and end of molecular geometry input. The default unit for coordinates is Angstrom.
- Lines 5 to 9 input the water molecule structure in Z-matrix (internal coordinate) format (details in :ref:`Molecular Structure Input in Internal Coordinates<Internal-Coord>`).

The corresponding advanced input for this simple input is:

.. code-block:: bdf 

  $compass
  Geometry
    O
    H 1 1.0
    H 1 1.0 2 109.
  End geometry
  Basis
    3-21g  # set basis set as 3-21g
  $end
  
  $xuanyuan
  $end
  
  $scf
  RHF       # Restricted Hartree-Fock method
  Charge    # Molecular charge set to 0 (default for neutral molecules)
    0    
  Spinmulti # Spin multiplicity 2S+1 (defaults to singlet for even-electron systems)
    1    
  $end

From the advanced input, it can be seen that BDF will sequentially execute the **COMPASS**, **XUANYUAN**, and **SCF** modules to complete the single-point energy calculation of the water molecule.  
**COMPASS** reads molecular structure, basis functions, and other basic information, determines molecular symmetry, rotates the molecule to standard orientation (see :ref:`BDF's Use of Group Theory<Point-Group>`), generates symmetry-adapted orbitals, etc., and stores this information in the file `h2o.chkfil` in the execution directory. Key elements in **COMPASS**:
* Molecular structure defined between `Geometry` and `End geometry`;
* Basis set defined as `3-21G` via `Basis`.

.. note::
    Only in concise input can variables (e.g., R1 in the example) be used to define internal coordinates and assign values later. Advanced input requires direct numerical definition of internal coordinates; variables are not supported.

After executing **COMPASS**, BDF uses **XUANYUAN** to compute one- and two-electron integrals. BDF defaults to **Integral Direct SCF**, where integrals are recomputed as needed.

Finally, BDF executes the **SCF** module to perform the self-consistent field (SCF) calculation based on Hartree-Fock:
* `RHF` specifies the Restricted Hartree-Fock method;
* `Charge` sets the system charge to 0;
* `Spinmulti` sets the spin multiplicity to 1.

Here, `RHF` is mandatory. `Charge` and `Spinmulti` can be omitted for restricted methods.

Executing the Calculation
-------------------------------------------------------
To run the calculation, prepare a shell script named `run.sh` in the same directory as the input file `h2o.inp`. The content is:

.. code-block:: shell

    #!/bin/bash

    # Set BDF installation directory
    export BDFHOME=/home/bsuo/bdf-pkg-pro
    # Set temporary file directory
    export BDF_TMPDIR=/tmp/$RANDOM

    # Set unlimited stack memory (may be restricted by system on HPC)
    ulimit -s unlimited
    # Set unlimited CPU time (may be restricted by system on HPC)
    ulimit -t unlimited

    # Set OpenMP threads
    export OMP_NUM_THREADS=4
    # Set OpenMP stack size
    export OMP_STACKSIZE=1024M

    # Execute BDF (output defaults to stdout)
    $BDFHOME/sbin/bdfdrv.py -r h2o.inp 

This `Bash Shell` script defines environment variables and uses `$BDFHOME/sbin/bdfdrv.py` to run the calculation. Key environment variables:
* `BDFHOME`: BDF installation directory;
* `BDF_TMPDIR`: Temporary file directory;
* `ulimit -s unlimited`: Unlimited stack memory;
* `ulimit -t unlimited`: Unlimited execution time;
* `export OMP_NUM_THREADS=4`: Use 4 OpenMP threads;
* `export OMP_STACKSIZE=1024M`: Set stack memory to 1024 MB per thread.

Execute the calculation with:

.. code-block:: shell

    $ ./run.sh h2o.inp &>h2o.out&

Since BDF prints output to stdout, we redirect it to `h2o.out`.

Analyzing Results
-------------------------------------------------------
After calculation, files `h2o.out`, `h2o.chkfil`, and `h2o.scforb` are generated:
* `h2o.out`: Text file containing human-readable output;
* `h2o.chkfil`: Binary file for data transfer between BDF modules;
* `h2o.scforb`: Text file storing SCF molecular orbital coefficients, orbital energies, etc., used for restarts or as initial guesses.

If concise input is used, `h2o.out` first displays basic settings:

.. code-block:: bdf 

  |================== BDF Control parameters ==================|
 
    1: Input BDF Keywords
      soc=None    scf=rhf    skeleton=True    xcfuntype=None    
      xcfun=None    direct=True    charge=0    hamilton=None    
      spinmulti=1    
   
    2: Basis sets
       ['3-21g']
   
    3: Wavefunction, Charges and spin multiplicity
      charge=0    nuclearcharge=10    spinmulti=1    
   
    5: Energy method
       scf
   
    7: Acceleration method
       ERI
   
    8: Potential energy surface method
       energy

  |============================================================|

Here:
* `Input BDF Keywords` lists key control parameters;
* `Basis set` shows the basis set;
* `Wavefunction, Charges and spinmulti` shows charge, total nuclear charge, and spin multiplicity (2S+1);
* `Energy method` specifies the energy calculation method;
* `Acceleration method` shows the two-electron integral acceleration method;
* `Potential energy surface method` indicates a single-point calculation.

Next, the **COMPASS** module starts:

.. code-block:: 
  
    |************************************************************|
    
        Start running module compass
        Current time   2021-11-18  11:26:28

    |************************************************************|

It prints Cartesian coordinates (in **Bohr**) and basis function details:

.. code-block:: 

    |---------------------------------------------------------------------------------|
    
     Atom   Cartcoord(Bohr)               Charge Basis Auxbas Uatom Nstab Alink  Mass
      O     0.000000  0.000000  0.000000  8.00    1     0     0     0   E     15.9949
      H     1.889726  0.000000  0.000000  1.00    2     0     0     0   E      1.0073
      H    -0.615235  1.786771  0.000000  1.00    2     0     0     0   E      1.0073
    
    |----------------------------------------------------------------------------------|
    
      End of reading atomic basis sets ..
     Printing basis sets for checking ....
    
     Atomic label:  O   8
     Maximum L  1 6s3p ----> 3s2p NBF =   9
     #--->s function
          Exp Coef          Norm Coef       Con Coef
               322.037000   0.192063E+03    0.059239    0.000000    0.000000
                48.430800   0.463827E+02    0.351500    0.000000    0.000000
                10.420600   0.146533E+02    0.707658    0.000000    0.000000
                 7.402940   0.113388E+02    0.000000   -0.404454    0.000000
                 1.576200   0.355405E+01    0.000000    1.221562    0.000000
                 0.373684   0.120752E+01    0.000000    0.000000    1.000000
     #--->p function
          Exp Coef          Norm Coef       Con Coef
                 7.402940   0.356238E+02    0.244586    0.000000
                 1.576200   0.515227E+01    0.853955    0.000000
                 0.373684   0.852344E+00    0.000000    1.000000
    
    
     Atomic label:  H   1
     Maximum L  0 3s ----> 2s NBF =   2
     #--->s function
          Exp Coef          Norm Coef       Con Coef
                 5.447178   0.900832E+01    0.156285    0.000000
                 0.824547   0.218613E+01    0.904691    0.000000
                 0.183192   0.707447E+00    0.000000    1.000000

Molecular symmetry is automatically determined, and coordinates are rotated to standard orientation:

.. code-block:: 

    Auto decide molecular point group! Rotate coordinates into standard orientation!
    Threshold= 0.10000E-08 0.10000E-11 0.10000E-03
    geomsort being called!
    gsym: C02V, noper=    4
    Exiting zgeomsort....
    Representation generated
    Binary group is observed ...
    Point group name C(2V)                       4
    User set point group as C(2V)   
     Largest Abelian Subgroup C(2V)                       4
     Representation generated
     C|2|V|                    2

    Symmetry check OK
    Molecule has been symmetrized
    Number of symmery unique centers:                     2
    |---------------------------------------------------------------------------------|
    
     Atom   Cartcoord(Bohr)               Charge Basis Auxbas Uatom Nstab Alink  Mass
      O     0.000000  0.000000  0.000000  8.00    1     0     0     0   E     15.9949
      H     1.889726  0.000000  0.000000  1.00    2     0     0     0   E      1.0073
      H    -0.615235  1.786771  0.000000  1.00    2     0     0     0   E      1.0073
    
    |----------------------------------------------------------------------------------|
    
     Atom   Cartcoord(Bohr)               Charge Basis Auxbas Uatom Nstab Alink  Mass
      O     0.000000 -0.000000  0.219474  8.00    1     0     0     0   E     15.9949
      H    -1.538455  0.000000 -0.877896  1.00    2     0     0     0   E      1.0073
      H     1.538455 -0.000000 -0.877896  1.00    2     0     0     0   E      1.0073
    
    |----------------------------------------------------------------------------------|

Note: The final coordinates differ from the input due to symmetry rotation. **COMPASS** then generates symmetry-adapted orbitals, prints dipole/quadrupole irreps, multiplication table, and orbital counts:

.. code-block:: 

    Number of irreps:    4
    IRREP:   3   4   1
    DIMEN:   1   1   1
    
     Irreps of multipole moment operators ...
     Operator  Component    Irrep       Row
      Dipole       x           B1          1
      Dipole       y           B2          1
      Dipole       z           A1          1
      Quadpole     xx          A1          1
      Quadpole     xy          A2          1
      Quadpole     yy          A1          1
      Quadpole     xz          B1          1
      Quadpole     yz          B2          1
      Quadpole     zz          A1          1
    
     Generate symmetry adapted orbital ...
     Print Multab
      1  2  3  4
      2  1  4  3
      3  4  1  2
      4  3  2  1
    
    |--------------------------------------------------|
              Symmetry adapted orbital                   
    
      Total number of basis functions:      13      13
    
      Number of irreps:   4
      Irrep :   A1        A2        B1        B2      
      Norb  :      7         0         4         2
    |--------------------------------------------------|

Here, the C₂ᵥ point group has 4 irreps (`A1, A2, B1, B2`) with `7, 0, 4, 2` symmetry-adapted orbitals.

.. attention::
    Different quantum chemistry software may use different standard orientations, potentially labeling molecular orbitals with different irreps.

**COMPASS** concludes:

.. code-block:: 

    |******************************************************************************|

        Total cpu     time:          0.00  S
        Total system  time:          0.00  S
        Total wall    time:          0.02  S
    
        Current time   2021-11-18  11:26:28
        End running module compass
    |******************************************************************************|

.. note::
    Each BDF module prints start/end times for easy error diagnosis.

Next, the **XUANYUAN** module computes one-electron integrals. Key output:

.. code-block:: 

    [aoint_1e]
      Calculating one electron integrals ...
      S T and V integrals ....
      Dipole and Quadupole integrals ....
      Finish calculating one electron integrals ...
    
     ---------------------------------------------------------------
      Timing to calculate 1-electronic integrals                                      
    
      CPU TIME(S)      SYSTEM TIME(S)     WALL TIME(S)
              0.017            0.000               0.000
     ---------------------------------------------------------------
    
     Finish calculating 1e integral ...
     Direct SCF required. Skip 2e integral!
     Set significant shell pairs!
    
     Number of significant pairs:        7
     Timing caluclate K2 integrals.
     CPU:       0.00 SYS:       0.00 WALL:       0.00

Overlap (S), kinetic (T), nuclear attraction (V), dipole, and quadrupole integrals are computed. Direct SCF skips persistent storage of two-electron integrals.

Finally, the **SCF** module performs the **RHF** calculation. Key outputs include:

Wavefunction information:

.. code-block:: 

     Wave function information ...
     Total Nuclear charge    :      10
     Total electrons         :      10
     ECP-core electrons      :       0
     Spin multiplicity(2S+1) :       1
     Num. of alpha electrons :       5
     Num. of beta  electrons :       5

Initial density matrix from atomic densities:

.. code-block:: 

     [ATOM SCF control]
      heff=                     0
     After initial atom grid ...
     Finish atom    1  O             -73.8654283850
     After initial atom grid ...
     Finish atom    2  H              -0.4961986360
    
     Superposition of atomic densities as initial guess.

Basis linear dependence check:

.. code-block:: 

     Check basis set linear dependence! Tolerance =   0.100000E-04

SCF iterations (converged in 8 steps):

.. code-block:: 

    Iter. idiis vshift    SCF Energy      DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S) 
       1    0   0.000  -75.465225043  -0.607399386  0.039410497  0.238219747  0.0000   0.00
       2    1   0.000  -75.535887715  -0.070662672  0.013896819  0.080831047  0.0000   0.00
       3    2   0.000  -75.574187153  -0.038299437  0.004423591  0.029016074  0.0000   0.00
       4    3   0.000  -75.583580885  -0.009393732  0.000961664  0.003782740  0.0000   0.00
       5    4   0.000  -75.583826898  -0.000246012  0.000146525  0.000871203  0.0000   0.00
       6    5   0.000  -75.583831666  -0.000004768  0.000012300  0.000073584  0.0000   0.00
       7    6   0.000  -75.583831694  -0.000000027  0.000001242  0.000007487  0.0000   0.00
       8    7   0.000  -75.583831694  -0.000000000  0.000000465  0.000002549  0.0000   0.00
     diis/vshift is closed at iter =   8
       9    0   0.000  -75.583831694  -0.000000000  0.000000046  0.000000221  0.0000   0.00
    
      Label              CPU Time        SYS Time        Wall Time
     SCF iteration time:         0.017 S        0.017 S        0.000 S

Energy decomposition and Virial ratio:

.. code-block:: 

     Final scf result
       E_tot =               -75.58383169
       E_ele =               -84.37566837
       E_nn  =                 8.79183668
       E_1e  =              -121.94337426
       E_ne  =              -197.24569473
       E_kin =                75.30232047
       E_ee  =                37.56770589
       E_xc  =                 0.00000000
      Virial Theorem      2.003738

Definitions:
* `E_tot`: Total energy (`E_ele` + `E_nn`)
* `E_ele`: Electronic energy (`E_1e` + `E_ee` + `E_xc`)
* `E_nn`: Nuclear repulsion energy
* `E_1e`: One-electron energy (`E_ne` + `E_kin`)
* `E_ne`: Nuclear-electron attraction
* `E_kin`: Electron kinetic energy
* `E_ee`: Two-electron energy (Coulomb + exchange)
* `E_xc`: Exchange-correlation energy (0 for HF)

Orbital energies, HOMO-LUMO gap:

.. code-block:: 

     [Final occupation pattern: ]
    
     Irreps:        A1      A2      B1      B2  
    
     detailed occupation for iden/irep:      1   1
        1.00 1.00 1.00 0.00 0.00 0.00 0.00
     detailed occupation for iden/irep:      1   3
        1.00 0.00 0.00 0.00
     detailed occupation for iden/irep:      1   4
        1.00 0.00
     Alpha       3.00    0.00    1.00    1.00
    
    
     [Orbital energies:]
    
     Energy of occ-orbs:    A1            3
        -20.43281195      -1.30394125      -0.52260024
     Energy of vir-orbs:    A1            4
          0.24980046       1.23122290       1.86913815       3.08082943
    
     Energy of occ-orbs:    B1            1
         -0.66958992
     Energy of vir-orbs:    B1            3
          0.34934415       1.19716413       2.03295437
    
     Energy of occ-orbs:    B2            1
          -0.47503768
     Energy of vir-orbs:    B2            1
           1.78424252
    
     Alpha   HOMO energy:      -0.47503768 au     -12.92643838 eV  Irrep: B2      
     Alpha   LUMO energy:       0.24980046 au       6.79741929 eV  Irrep: A1      
     HOMO-LUMO gap:       0.72483814 au      19.72385767 eV

Condensed orbital summary:

.. code-block:: 

      Symmetry   1 A1
    
        Orbital          1          2          3          4          5          6
        Energy     -20.43281   -1.30394   -0.52260    0.24980    1.23122    1.86914
        Occ No.      2.00000    2.00000    2.00000    0.00000    0.00000    0.00000
    
    
      Symmetry   2 A2
    
    
      Symmetry   3 B1
    
        Orbital          8          9         10         11
        Energy      -0.66959    0.34934    1.19716    2.03295
        Occ No.      2.00000    0.00000    0.00000    0.00000
    
    
      Symmetry   4 B2
    
        Orbital         12         13
        Energy      -0.47504    1.78424
        Occ No.      2.00000    0.00000

Population analysis and dipole moment:

.. code-block:: 

     [Mulliken Population Analysis]
      Atomic charges: 
         1O      -0.7232
         2H       0.3616
         3H       0.3616
         Sum:    -0.0000
    
     [Lowdin Population Analysis]
      Atomic charges: 
         1O      -0.4756
         2H       0.2378
         3H       0.2378
         Sum:    -0.0000
    
    
     [Dipole moment: Debye]
               X          Y          Z     
       Elec:-.1081E-64 0.4718E-32 -.2368E+01
       Nucl:0.0000E+00 0.0000E+00 0.5644E-15
       Totl:   -0.0000     0.0000    -2.3684

.. hint:: 
    1. Add `iprtmo 2` to the **SCF** input to print detailed molecular orbitals.
    2. Add `molden` to the **SCF** input to output orbitals in molden format for visualization (e.g., `GabEdit <http://gabedit.sourceforge.net/>`_, `JMol <http://jmol.sourceforge.net>`_, `Molden <https://www.theochem.ru.nl/molden/>`_, `Multiwfn <http://sobereva.com/multiwfn/>`) or for :ref:`wavefunction analysis<1e-prop>` and :ref:`one-electron properties<1e-prop>`.