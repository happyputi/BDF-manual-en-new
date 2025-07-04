# Solvation Models
================================================

Solvation models are used to calculate interactions between solute and solvent, generally categorized into **implicit solvent models** (continuous medium models) and **explicit solvent models**. In BDF, for continuous solvent models, options include IEFPCM, SS(V)PE, CPCM, COSMO, ddCOSMO (domain-decomposition COSMO solvation model), and SMD. For explicit solvent models, the QM/MM method is employed, computed using the pDynamo2.0 program package.

Functionalities supported by BDF solvation models:

.. table::

  +-------------+--------------+----------+---------+---------------+----------+
  |             | Ground state                      | Excited state            |
  +  PCMs       +--------------+----------+---------+---------------+----------+
  |             | Single-point | Gradient | Hessian |  Single-point | Gradient |
  +=============+==============+==========+=========+===============+==========+
  | **COSMO**   | √            | √        | √       | √             | √        |
  +-------------+--------------+----------+---------+---------------+----------+
  | **CPCM**    | √            | √        | √       | √             | √        |
  +-------------+--------------+----------+---------+---------------+----------+
  | **SS(V)PE** | √            | √        | √       | √             | √        |
  +-------------+--------------+----------+---------+---------------+----------+
  | **IEFPCM**  | √            | √        | √       | √             | √        |
  +-------------+--------------+----------+---------+---------------+----------+
  | **SMD**     | √            | √        | √       | √             | √        |
  +-------------+--------------+----------+---------+---------------+----------+

## Solvent Type Setting
------------------------------------------------
Add the ``solvent`` keyword in the ``SCF`` module to enable solvation effect calculations. The solvent type (e.g., ``water``) should be specified on the next line.  
Example input for formaldehyde in aqueous solution:

.. code-block:: bdf

  $COMPASS
  Title
    ch2o Molecule test run
  Basis
    6-31g
  Geometry
    C    0.00000000    0.00000000   -0.54200000
    O    0.00000000    0.00000000    0.67700000
    H    0.00000000    0.93500000   -1.08200000
    H    0.00000000   -0.93500000   -1.08200000
  END geometry
  nosymm
  unit
   ang
  $END

  $xuanyuan
  $END

  $SCF
  rks
  dft
    b3lyp
  solvent   #Solvation calculation switch
    water    #Specify solvent
  grid
    medium
  $END

Solvent types can be specified using names or aliases from :ref:`BDF Supported Solvents List<SolventList>`. For solvents not listed, input the dielectric constant:

.. code-block:: bdf 

  solvent
    user   #User-specified
  dielectric
    78.3553   #Input dielectric constant

### Solvent Model Setting
--------------
Continuous medium models treat the solvent as a polarizable continuous medium with a specific dielectric constant.  
BDF currently supports **ddCOSMO**, **COSMO**, **CPCM**, **IEFPCM**, **SS(V)PE**, and **SMD** models. Keywords: ``ddcosmo``, ``cosmo``, ``cpcm``, ``iefpcm``, ``ssvpe``, ``smd``.  
Input example:

.. code-block:: bdf 

  solvent
    water
  solmodel
    IEFPCM   #Solvent model

For **COSMO** and **CPCM**, use ``cosmoFactorK`` to specify the dielectric screening factor :math:`f_\epsilon=\frac{\epsilon-1}{\epsilon+k}`. Default: ``k=0.5`` for COSMO, ``k=0`` for CPCM.

.. code-block:: bdf 

  cosmoFactorK
    0.5

For **SMD**, manually specify parameters:

.. code-block:: bdf 

  refractiveIndex # Refractive index
    1.43
  HBondAcidity # Abraham hydrogen bond acidity
    0.229
  HBondBasicity # Abraham hydrogen bond basicity
    0.265
  SurfaceTensionAtInterface # Surface tension
    61.24
  CarbonAromaticity # Aromaticity
    0.12
  ElectronegativeHalogenicity # Halogenicity
    0.24

.. note::

   Using the SMD model disables calculation of :ref:`non-electrostatic component of solvation free energy<SolventNonelec>`, replacing it with SMx series :math:`\Delta G_{CDS}`.

### Cavity Customization
--------------
Cavity shape significantly impacts solvation energy. Common cavity types: vdW (van der Waals surface), SES (solvent-excluded surface), SAS (solvent-accessible surface).  

BDF defaults to **vdW cavity** using 1.1× UFF radii.  
Customize cavity shape for COSMO/CPCM/IEFPCM/SS(V)PE/SMD using:

.. code-block:: bdf

  cavity # Cavity surface generation method
    swig # swig | switching | ses | sphere (default: swig)
  uatm # United atom topology method
    false # false | true (default: false)
  radiusType
    UFF # UFF | Bondi (default: UFF)
  vdWScale
    1.1 # Default: 1.1 (1.1× RadiusType radius)
  radii
    1=1.4430 2=1.7500 # Set radius of atom 1 to 1.4430Å, atom 2 to 1.7500Å
    # No spaces around "="; max 128 characters/line; multiple lines allowed
  radii
    H=1.4430 O=1.7500 # Set H radius to 1.4430Å, O to 1.7500Å (mix with above)
  acidHRadius # Acidic H radius (Å)
    1.2

**Cavity Methods**:  
- ``switching``: Smoothing function for vdW surface grid weights  
- ``swig``: Switching/Gaussian (additional Gaussian smoothing)  
- ``sphere``: Spherical cavity enclosing molecule  

``uatm`` merges H atoms into heavy atoms for cavity formation.  

Control grid density with ``cavityNGrid`` or ``cavityPrecision``:

.. code-block:: bdf

  cavityNGrid # Max tesserae per atom (adjusted to nearest Lebedev grid)
    302 # Default: 302

  # OR

  cavityPrecision
    medium # ultraCoarse | coarse | medium | fine | ultraFine (default: medium)

## Ground State Solvation Energy Calculation
----------------------------------------------------------
Typically requires only ``solvent`` and ``solmodel`` in ``SCF`` module.  
Example for formaldehyde with SMD model:

.. code-block:: bdf

  $COMPASS
  Title
    ch2o Molecule test run
  Basis
    6-31g
  Geometry
    C    0.00000000    0.00000000   -0.54200000
    O    0.00000000    0.00000000    0.67700000
    H    0.00000000    0.93500000   -1.08200000
    H    0.00000000   -0.93500000   -1.08200000
  END geometry
  $END

  $xuanyuan
  $END

  $SCF
  rks
  dft
    gb3lyp
  solvent   #Solvation switch
    water    #Solvent
  solmodel  #Solvation model
    smd
  $END

.. note::

   Use ``cosmosave`` to export cavity volume/surface area, tesserae coordinates/charges/areas to .cosmo files. Convert to Gaussian format using ``$BDFHOME/sbin/conv2gaucosmo.py``.

## Non-Electrostatic Solvation Energy Calculation
----------------------------------------------------------
.. _SolventNonelec:

Solvation free energy = **Electrostatic** (PCM) + **Non-electrostatic** (:math:`\Delta G_{cav}` + :math:`\Delta G_{dis-rep}`).  
Cavitation energy (work to form cavity) uses scaled particle theory (Pierotti-Claverie). Dispersion-repulsion uses pairwise potentials.  

Non-electrostatic terms are **disabled by default**. Enable with:

.. code-block:: bdf 

  nonels
    dis rep cav # Dispersion | Repulsion | Cavitation
  solventAtoms # Solvent atom counts (molecular formula)
    H2O1 # Default: H2O1 ("1" required to avoid ambiguity)
  solventRho # Solvent number density (molecules/Å³)
    0.03333
  solventRadius # Solvent molecular radius (Å)
    1.385 

.. note::
   For ``cav``: Manual ``solventRho``/``solventRadius`` required for non-water solvents.  
   For ``dis``/``rep``: Manual ``solventRho``/``solventAtoms`` required for non-water solvents.

**Common Solvent Radii**:  

| Solvent              | Water | Tetrahydrofuran | Cyclohexane | Methanol | Ethanol | Tetrachloromethane |
|----------------------|-------|-----------------|-------------|----------|---------|---------------------|
| **Radius (Å)**       | 1.385 | 2.900           | 2.815       | 1.855    | 2.180   | 2.685              |

Customize radii for dispersion-repulsion/cavitation:

.. code-block:: bdf 

  solventAtomicSASRadii # SAS radii for dispersion-repulsion (solvent atoms)
    H=1.20 O=1.50
  radiiForCavEnergy # Radii for cavitation energy (solute)
    H=1.4430 O=1.7500 # Same syntax as ``radii``
  acidHRadiusForCavEnergy # Acidic H radius for cavitation (Å)
    1.2

## Introduction to Nonequilibrium Solvation Theory
----------------------------------------------------------
Excited-state solvation requires **nonequilibrium** treatment due to rapid vertical absorption/emission processes. Solvent polarization has:  
- **Fast** (electronic) component  
- **Slow** (orientational) component  

Traditional theories overestimate solvent reorganization energy. BDF implements **new theory** by Prof. Xiangyuan Li (Int. J. Quantum Chem. 2015, 115(11): 700-721) for state-specific calculations.

## Excited State Solvation Effect Calculation
----------------------------------------------------------
Implicit models handle excited states via:  
- **Linear Response (LR)**  
- **State-Specific (SS)**  

### Vertical Absorption Calculation
##########################################################
**Linear Response** example:

.. code-block:: bdf

  $COMPASS
  Title
    ch2o Molecule test run
  Basis
    6-31g
  Geometry
    C    0.00000000    0.00000000   -0.54200000
    O    0.00000000    0.00000000    0.67700000
    H    0.00000000    0.93500000   -1.08200000
    H    0.00000000    -0.9350000  -1.08200000
  END geometry
  nosymm
  unit
   ang
  $END

  $xuanyuan
  $END

  $SCF
  rks
  dft
    b3lyp
  grid
    medium
  solvent
    user      # User-specified
  dielectric
    78.3553   # Dielectric constant
  opticalDielectric
    1.7778    # Optical dielectric constant
  solmodel 
    iefpcm
  $END

  $TDDFT
  iroot
    8
  solneqlr   # Enable nonequilibrium solvation (LR)
  $END

.. note::
   User-specified solvents require ``opticalDielectric`` (see :ref:`BDF Supported Solvents List<SolventList>`).

**Perturbative State-Specific (ptSS)** example:

.. code-block:: bdf

  $COMPASS
  Title
    SS-PCM of S-trans-acrolein Molecule
  Basis
    cc-PVDZ
  Geometry
    C                  0.55794100   -0.45384200   -0.00001300
    H                  0.44564200   -1.53846100   -0.00002900
    C                 -0.66970500    0.34745600   -0.00001300
    H                 -0.50375600    1.44863100   -0.00005100
    C                  1.75266800    0.14414300    0.00001100
    H                  2.68187400   -0.42304000    0.00001600
    H                  1.83151500    1.23273300    0.00002700
    O                 -1.78758800   -0.11830000    0.00001600
  END geometry
  $END

  $xuanyuan
  $END

  $SCF
  rks
  dft
    PBE0
  solvent
    water
  solmodel 
    iefpcm
  $END

  $TDDFT
  iroot
    5
  istore
    1
  $END

  $resp
  nfiles
    1
  method
    2
  iroot
    1 2 3
  geom
  norder
    0
  solneqss   # State-specific nonequilibrium
  $end

Output snippet:

.. code-block:: 

  -Energy correction based on constrant equilibrium theory with relaxed density
 *State   1  ->  0
 Corrected vertical absorption energy               =    3.6935 eV
 Nonequilibrium solvation free energy               =   -0.0700 eV
 Equilibrium solvation free energy                  =   -0.1744 eV

Among them, Corrected vertical absorption energy refers to the excitation energy correction calculated by using the new theory of non-equilibrium solvation developed by Prof. Xiangyuan Li's group.

In the above example, the vertical absorption energy is :math:`3.69eV`.

BDF currently also supports the calculation of corrected linear response (cLR), and the following is an input file for calculating the non-equilibrium solvation effect of acrolein molecules in the excited state using cLR:

.. code-block:: bdf

  $COMPASS
  Title
    cLR-PCM of S-trans-acrolein Molecule
  Basis
    cc-PVDZ
  Geometry
    C                  0.55794100   -0.45384200   -0.00001300
    H                  0.44564200   -1.53846100   -0.00002900
    C                 -0.66970500    0.34745600   -0.00001300
    H                 -0.50375600    1.44863100   -0.00005100
    C                  1.75266800    0.14414300    0.00001100
    H                  2.68187400   -0.42304000    0.00001600
    H                  1.83151500    1.23273300    0.00002700
    O                 -1.78758800   -0.11830000    0.00001600
  END geometry
  $END

  $xuanyuan
  $END

  $SCF
  rks
  dft
    PBE0
  solvent
    water
  solmodel 
    iefpcm
  $END

  $TDDFT
  iroot
    5
  istore
    1
  $END

  $TDDFT
  iroot
    5
  istore
    1
  solneqlr
  $END

  $resp
  nfiles
    1
  method
    2
  iroot
    1
  geom
  norder
    0
  solneqlr
  solneqss
  $end

Locate the output from the **first TDDFT** section and the cLR output from the resp module:

.. code-block:: 

  No.     1    w=      3.7475 eV     -191.566549 a.u.  f=    0.0001   D<Pab>= 0.0000   Ova= 0.4683
      CV(0):    A(  15 )->   A(  16 )  c_i:  0.9871  Per: 97.4%  IPA:     5.808 eV  Oai: 0.4688
      CV(0):    A(  15 )->   A(  17 )  c_i:  0.1496  Per:  2.2%  IPA:     9.144 eV  Oai: 0.4392

  ...

  Excitation energy correction(cLR)                  =   -0.0377 eV

The cLR excitation energy is calculated as: :math:`3.7475 - 0.0377 = 3.7098\text{eV}`.

### Excited State Geometry Optimization
##########################################################
During geometry optimization, solvent has sufficient time to respond, so equilibrium solvation should be considered.
Use the ``soleqlr`` keyword in both ``tddft`` and ``resp`` modules to enable equilibrium solvation effects. Other input/output details are similar to the :ref:`TDDFT geometry optimization section<TDDFTopt>` and won't be repeated here.

Phenol molecule example with solvation effects:

.. code-block:: bdf

  $COMPASS
  Geometry
    C                 -1.15617700   -1.20786100    0.00501300
    C                 -1.85718200    0.00000000    0.01667700
    C                 -1.15617700    1.20786100    0.00501300
    C                  0.23962700    1.21165300   -0.01258600
    C                  0.93461900    0.00000000   -0.01633400
    C                  0.23962700   -1.21165300   -0.01258600
    H                 -1.69626800   -2.15127300    0.00745900
    H                 -2.94368500    0.00000000    0.02907200
    H                 -1.69626800    2.15127300    0.00745900
    H                  0.80143900    2.14104700   -0.03186000
    H                  0.80143900   -2.14104700   -0.03186000
    O                  2.32295900    0.00000000   -0.08796400
    H                  2.68364400    0.00000000    0.81225800
  End geometry
  basis
    6-31G
  $END

  $bdfopt
  solver
    1
  $end

  $XUANYUAN
  $END

  $SCF
  DFT
    gb3lyp
  rks
  solModel
    iefpcm
  solvent
    water
  $END

  $TDDFT
  iroot
    5
  istore
    1
  soleqlr
  $END

  $resp
  geom
  soleqlr
  method
    2
  nfiles
    1
  iroot
    1
  $end

Vertical Emission Calculation
##########################################################

In the equilibrium geometry of the excited state, the equilibrium solvation effect of ptSS or cLR is calculated, and the corresponding solvent slow polarization charge is saved. The keyword ''emit'' was added to the SCF module to calculate the non-equilibrium ground state energy. Taking the acrolein molecule as an example, ptSS is used to calculate the excited state, and the corresponding input file is as follows:

.. code-block:: bdf

  $COMPASS
  Geometry
    C       -1.810472    0.158959    0.000002
    H       -1.949516    1.241815    0.000018
    H       -2.698562   -0.472615   -0.000042
    C       -0.549925   -0.413873    0.000029
    H       -0.443723   -1.502963   -0.000000
    C        0.644085    0.314498    0.000060
    H        0.618815    1.429158   -0.000047
    O        1.862127   -0.113145   -0.000086
  End geometry
  basis
    cc-PVDZ
  $END

  $XUANYUAN
  $END

  $SCF
  DFT
    PBE0
  rks
  solModel
    iefpcm
  solvent
    water
  $END

  $TDDFT
  iroot
    5
  istore
    1
  #soleqlr
  $END

  $resp
  nfiles
    1
  method
    2
  iroot
    1
  geom
  norder
    0
  #soleqlr
  soleqss
  $end

  $SCF
  DFT
    PBE0
  rks
  solModel
    iefpcm
  solvent
    water
  emit
  $END

Care needs to be taken to specify ''soleqss'' to calculate the equilibrium solvation effect. The output in the file is:

.. code-block:: 

 -Energy correction based on constrant equilibrium theory
 *State   1  ->  0
 Corrected vertical emission energy                 =    2.8118 eV
 Nonequilibrium solvation free energy               =   -0.0964 eV
 Equilibrium solvation free energy                  =   -0.1145 eV

The "Corrected vertical emission energy" represents the emission energy correction using Prof. Li's theory. In this example, vertical emission energy is :math:`2.81eV`.

When using the cLR calculation, you need to find the output of the first TDDFT in the file, and the cLR output in the resp module, and add it to the difference between the E_tot two scfs to get the final vertical emission energy.

A combination of explicit and implicit solvents was used to calculate the aroused solvation effect
----------------------------------------------------------

The excited solvation effect can be calculated using a combination of explicit and implicit solvents. In the case of aqueous solutions, it is possible to diffuse to the HOMO and LUMO orbitals of the solute molecules
The first hydrate layer, so the water molecules of the first hydrate can be included in the TDDFT calculation area when performing the excited state calculation, while the rest is treated with implicit solvents.

Take sinapic acid, for example. To determine the first hydrate layer of solute molecules, the Amber procedure can be used to perform molecular dynamics simulations by placing the sinapic acid molecules in small water boxes.
After the system is equilibrated, the distribution of water molecules around the solute molecules can be analyzed to determine the first hydration layer. Of course, it is also possible to select a multi-frame structure for calculation and then average it.

Hydrate molecule selection can be done using the VMD program. Assuming the input is a pdb file, the first hydrate molecule can be selected in the command line and saved as a pdb file. The command is as follows:

.. code-block:: bdf 

  atomselect top  "same resid as (within 3.5  of not water)"   # Select the first hydrate layer
 atomselect0 writepdb sa.pdb                     #The solute molecule and the first hydrate layer are stored in a PDB file

In the example above, all water molecules within 3.5 angstroms of the solute molecule are selected, and as long as one of the three atoms of the water molecule is within the truncated range, the entire molecule is selected. The selection result is shown in the figure:

.. figure:: /images/SAtddft.jpg

According to the coordinate information in the sa.pdb file, the TDDFT is calculated, and the input file is as follows:

.. code-block:: bdf

  $COMPASS 
  Title
   SA Molecule test run
  Basis
   6-31g
  Geometry
  C          14.983  14.539   6.274
  C          14.515  14.183   7.629
  C          13.251  14.233   8.118
  C          12.774  13.868   9.480
  C          11.429  14.087   9.838
  C          10.961  13.725  11.118
  O           9.666  13.973  11.525
  C           8.553  14.050  10.621
  C          11.836  13.125  12.041
  O          11.364  12.722  13.262
  C          13.184  12.919  11.700
  O          14.021  12.342  12.636
  C          15.284  11.744  12.293
  C          13.648  13.297  10.427
  O          14.270  14.853   5.341
  O          16.307  14.468   6.130
  H          15.310  13.847   8.286
  H          12.474  14.613   7.454
  H          10.754  14.550   9.127
  H           7.627  14.202  11.188
  H           8.673  14.888   9.924
  H           8.457  13.118  10.054
  H          10.366  12.712  13.206
  H          15.725  11.272  13.177
  H          15.144  10.973  11.525
  H          15.985  12.500  11.922
  H          14.687  13.129  10.174
  H          16.438  14.756   5.181
  O          18.736   9.803  12.472
  H          18.779  10.597  11.888
  H          19.417  10.074  13.139
  O          18.022  14.021   8.274
  H          17.547  14.250   7.452
  H          18.614  13.310   7.941
  O           8.888  16.439   7.042
  H           9.682  16.973   6.797
  H           8.217  17.162   7.048
  O           4.019  14.176  11.140
  H           4.032  13.572  10.360
  H           4.752  14.783  10.885
  O          16.970   8.986  14.331
  H          17.578   9.273  13.606
  H          17.497   8.225  14.676
  O           8.133  17.541  10.454
  H           8.419  17.716  11.386
  H           8.936  17.880   9.990
  O           8.639  12.198  13.660
  H           7.777  11.857  13.323
  H           8.413  13.155  13.731
  O          13.766  11.972   4.742
  H          13.858  12.934   4.618
  H          13.712  11.679   3.799
  O          10.264  16.103  14.305
  H           9.444  15.605  14.054
  H          10.527  15.554  15.084
  O          13.269  16.802   3.701
  H          13.513  16.077   4.325
  H          14.141  17.264   3.657
  O          13.286  14.138  14.908
  H          13.185  14.974  14.393
  H          13.003  13.492  14.228
  O          16.694  11.449  15.608
  H          15.780  11.262  15.969
  H          16.838  10.579  15.161
  O           7.858  14.828  14.050
  H           7.208  15.473  13.691
  H           7.322  14.462  14.795
  O          15.961  17.544   3.706
  H          16.342  16.631   3.627
  H          16.502  17.866   4.462
  O          10.940  14.245  16.302
  H          10.828  13.277  16.477
  H          11.870  14.226  15.967
  O          12.686  10.250  14.079
  H          11.731  10.151  14.318
  H          12.629  11.070  13.541
  O           9.429  11.239   8.483
  H           8.927  10.817   7.750
  H           9.237  12.182   8.295
  O          17.151  15.141   3.699
  H          17.124  14.305   3.168
  H          18.133  15.245   3.766
  O          17.065  10.633   9.634
  H          16.918  10.557   8.674
  H          17.024   9.698   9.909
  O          17.536  14.457  10.874
  H          18.014  13.627  11.089
  H          17.683  14.460   9.890
  O           5.836  16.609  13.299
  H           4.877  16.500  13.549
  H           5.760  16.376  12.342
  O          19.014  12.008  10.822
  H          18.249  11.634  10.308
  H          19.749  11.655  10.256
  O          15.861  14.137  15.750
  H          14.900  13.990  15.574
  H          16.185  13.214  15.645
  O          11.084   9.639  10.009
  H          11.641   9.480   9.213
  H          10.452  10.296   9.627
  O          14.234  10.787  16.235
  H          13.668  10.623  15.444
  H          13.663  10.376  16.925
  O          14.488   8.506  13.105
  H          13.870   9.136  13.550
  H          15.301   8.683  13.628
  O          14.899  17.658   9.746
  H          15.674  18.005   9.236
  H          15.210  16.754   9.926
  O           8.725  13.791   7.422
  H           9.237  13.488   6.631
  H           8.845  14.770   7.309
  O          10.084  10.156  14.803
  H           9.498  10.821  14.366
  H          10.215  10.613  15.669
  O           5.806  16.161  10.582
  H           5.389  16.831   9.993
  H           6.747  16.470  10.509
  O           6.028  13.931   7.206
  H           5.971  14.900   7.257
  H           6.999  13.804   7.336
  O          17.072  12.787   2.438
  H          16.281  12.594   1.885
  H          17.062  11.978   3.013
  END geometry
  nosymm
  mpec+cosx
  $END
  
  $xuanyuan
  $end
  
  $SCF
  rks
  dft
   b3lyp   
  solvent
   water 
  grid
   medium
  $END
  
  # input for tddft
  $tddft
  iroot    # Calculate 1 root for each irrep. By default, 10 roots are calculated
    1      # for each irrep
  memjkop  # maxium memeory for Coulomb and Exchange operator. 1024 MW (Mega Words)
    1024 
  $end


A list of solvent types supported in BDF
----------------------------------------------------------
.. _SolventList:
.. include:: /guide/Solvent-Dielectric.rst