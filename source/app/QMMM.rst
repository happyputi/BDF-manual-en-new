BDF-QM/MM Case Tutorial I
=====================================================

This topic introduces a quantum chemistry and molecular mechanics combined method (QM/MM method), which incorporates the accuracy of quantum chemistry and the efficiency of molecular mechanics. The core idea is to treat the region of interest with quantum mechanics while handling the remaining parts with classical molecular mechanics.

This chapter uses a typical gallic acid molecule (Gallic Acid, GA) as an example to cover input file preparation, QM/MM single-point calculations, QM/MM structural optimization, and QM/MM excited-state calculations. The BDF program primarily handles the quantum chemistry calculations, while the modified pDynamo2.0 package developed by the BDF team manages the remaining tasks. The tutorial also explains how to read data for result analysis, helping users gain a deeper understanding of BDF software usage.

Input File Preparation
-------------------------------------------------

Generally, molecular dynamics simulations are required before QM/MM calculations to obtain suitable initial conformations. When using PDB, MOL2, or xyz files as input, the pDynamo2.0 package only supports the OPLS force field. For small molecules and non-standard amino acids, force field parameters may be incomplete, so this approach is not recommended. Amber is preferred, using topology files to input force field parameters. Using Amber as an example, extract structures of interest from the dynamics simulation trajectory and store them in a .crd file. This file, along with the corresponding parameter/topology file .prmtop, serves as the starting point for QM/MM calculations. The Python script is as follows:

.. code-block:: python

  from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem
  # Read input information
  molecule  = AmberTopologyFile_ToSystem (Topfile)
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3(CRDfile)

Prerequisites: Install AmberTools and Python 2.0, and correctly set the **AMBERHOME** and **PDYNAMO** environment variables. To generate the coordinate file GallicAcid.crd and parameter/topology file GallicAcid.prmop from the initial structure file GallicAcid.pdb (Figure 1, unit cell 2 * 1 * 1), follow these steps:

.. figure:: /TADF-example/GA.png
     :width: 800
     :align: center

Run the antechamber program to convert the Pdb file to a mol2 file:

.. code-block:: python

antechamber -i GallicAcid.pdb -fi pdb -o GallicAcid.mol2 -fo mol2 -j 5 -at amber -dr no
- -i specifies the input file
- -fi specifies the input file type
- -o specifies the output file
- -fo specifies the output file type
- -j matches atom and bond types
- -at defines atom types

Run the parmchk2 program to generate the force field parameter file for the system:

.. code-block:: python

parmchk2 -i GallicAcid.mol2 -f mol2 -o GallicAcid.frcmod

Run the tleap program to build the system topology and define force field parameters:

1. Start the tleap program using the **tleap** command:

.. code-block:: bdf

   -I: Adding /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/prep to search path.
   -I: Adding /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/lib to search path.
   -I: Adding /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/parm to search path.
   -I: Adding /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/cmd to search path.
   
   Welcome to LEaP!
   (no leaprc in search path)
   >

2. Identify and load the system force field: `source leaprc.gaff` (this is the GAFF force field):

.. code-block:: bdf
   
   > source leaprc.gaff
   ----- Source: /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/cmd/leaprc.gaff
   ----- Source of /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/cmd/leaprc.gaff done
   Log file: ./leap.log
   Loading parameters: /es01/jinan/hzw001/home/hzw1011/anaconda3/envs/AmberTools21/dat/leap/parm/gaff.dat
   Reading title:
   AMBER General Force Field for organic molecules (Version 1.81, May 2017)
   >

3. Load the ligand mol2 file: `GA = loadmol2 GallicAcid.mol2`:

.. code-block:: bdf
   
   > GA = loadmol2 GallicAcid.mol2
   Loading Mol2 file: ./GallicAcid.mol2
   Reading MOLECULE named WAT
   >
   
4. Check if the imported structure is accurate or missing parameters: `check GA`
5. Load the system molecule template and complete missing parameters: `loadamberparams GallicAcid.frcmod`
6. Prepare the generated Sustiva library file: `saveoff GA GallicAcid.lib`
7. Modify the generated Sustiva library file and load it: `loadoff GallicAcid.lib`

.. code-block:: bdf

   > loadoff GallicAcid.lib
   Loading library: ./GallicAcid.lib

8. Save the .crd and .prmop files: `saveamberparm GA GallicAcid.prmtop GallicAcid.crd`

.. code-block:: bdf

   > saveamberparm GA GallicAcid.prmtop GallicAcid.crd
   Checking Unit.
   Building topology.
   Building atom parameters.
   Building bond parameters.
   Building angle parameters.
   Building proper torsion parameters.
   Building improper torsion parameters.
    total 112 improper torsions applied
   Building H-Bond parameters.
   Incorporating Non-Bonded adjustments.
   Not Marking per-residue atom chain types.
   Marking per-residue atom chain types.
     (Residues lacking connect0/connect1 -
      these don't have chain types marked:
   
           res     total affected
   
           WAT     1
     )
    (no restraints)
   >

9. Exit the tleap program: `quit`

Molecular Dynamics Simulation
-------------------------------------------------

1. Use Amber software for molecular dynamics simulation. First, perform energy minimization on the system. The input file min.in is as follows:

.. code-block:: bdf

    Initial minimisation of GallicAcid complex
     &cntrl
      imin=1, maxcyc=200, ncyc=50,
      cut=16, ntb=0, igb=1,
    &end
 - imin=1: Run energy minimization
 - maxcyc=200: Maximum number of minimization cycles
 - ncyc=50: Use steepest descent algorithm for cycles 0 to ncyc, then switch to conjugate gradient for cycles ncyc to maxcyc
 - cut=16: Non-bonded cutoff distance in Å
 - ntb=0: Turn off periodic boundary conditions
 - igb=1: Born model

Run energy minimization with the following command:

 **sander -O -i min.in -o GallicAcid_min.out -p GallicAcid.prmtop -c GallicAcid.crd -r GallicAcid_min.rst  &** 

Where GallicAcid_min.rst is the output restart file containing coordinates and velocities.

2. Use the restart file from minimization to heat the system and complete molecular dynamics simulation. The input file md.in is as follows:

.. code-block:: bdf

   Initial MD equilibration
    &cntrl
     imin=0, irest=0,
     nstlim=1000,dt=0.001, ntc=1,
     ntpr=20, ntwx=20,
     cut=16, ntb=0, igb=1,
     ntt=3, gamma_ln=1.0,
     tempi=0.0, temp0=300.0,
   &end

- imin=0: Perform molecular dynamics (MD)
- irest=0: Read coordinates and velocities from a previously saved restart file
- nstlim=1000: Number of MD steps to run
- dt=0.001: Time step (in ps)
- ntc=1: Do not enable SHAKE constraints
- ntpr=20: Output energy information to mdout every ntpr steps
- ntwx=20: Output Amber trajectory file mdcrd every ntwx steps
- ntt=3: Langevin thermostat controls temperature
- gamma_ln=1.0: Collision frequency for the Langevin thermostat
- tempi=0.0: Initial temperature of the simulation
- temp0=300.0: Final temperature of the simulation

Run molecular dynamics simulation with the following command:

 **sander -O -i md.in -o md.out -p GallicAcid.prmtop -c GallicAcid_min.rst -r GallicAcid_md.rst -x GallicAcid_md.mdcrd -inf GallicAcid_md.mdinfo** 

The GallicAcid_md.mdcrd file is the trajectory file from the MD simulation. Visualize the molecular structure using VMD software and extract structures of interest from the trajectory, storing them in a .crd file.

QM/MM Total Energy Calculation
-------------------------------------------------

After molecular dynamics simulation, extract the files GallicAcid.prmtop and GallicAcid.crd to perform a full quantum chemistry total energy calculation. The Python code is as follows:

.. code-block:: bdf
  
   import glob, math, os
   from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem
   from pCore import logFile
   from pMolecule import QCModelBDF,  System
   # Read water box coordinates and topology information
   molecule = AmberTopologyFile_ToSystem ("GallicAcid.prmtop")
   molecule.coordinates3 = AmberCrdFile_ToCoordinates3("GallicAcid.crd")
   # Define energy calculation mode: full-system DFT with method GB3LYP and basis set 6-31g
   model = QCModelBDF("GB3LYP:6-31g")
   molecule.DefineQCModel(model)
   molecule.Summary()  # Output system calculation settings
   # Calculate total energy
   energy  = molecule.Energy()

In addition to full quantum chemistry QM calculations for the system's total energy, QM/MM calculations can be performed on molecules of interest (in this case, specifying the fifth molecule for QM calculation). The Python script for combined QM/MM energy calculation is as follows:

.. code-block:: bdf

   import glob, math, os
   from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem
   from pCore import logFile, Selection
   from pMolecule import NBModelORCA, QCModelBDF,  System
    # Define energy calculation model
   nbModel = NBModelORCA()  # Handles interactions between QM and MM regions
   qcModel = QCModelBDF("GB3LYP:6-31g")
   # Read system coordinates and topology information
   molecule = AmberTopologyFile_ToSystem("GallicAcid.prmtop")
   molecule.coordinates3 = AmberCrdFile_ToCoordinates3("GallicAcid.crd")
   # Disable system symmetry
   molecule.DefineSymmetry(crystalClass = None)  # QM/MM method does not support periodic boundary conditions
   # Specify QM region
   qm_area = Selection.FromIterable(range (72, 90))  # Specify the fifth molecule for QM calculation. (72,90) indicates atom list indices 72,73,...89 (value = atomic number -1)
   # Define energy calculation model
   molecule.DefineQCModel (qcModel, qcSelection = qm_area)
   molecule.DefineNBModel (nbModel)
   molecule.Summary()
   # Calculate total energy
   energy  = molecule.Energy()

The QM/MM simulation output summarizes calculation details for the MM part, QM part, and QM-MM interaction part:

.. code-block:: bdf
  
   ----------------------------------- Summary for MM Model "AMBER" -----------------------------------
   LJ 1-4 Scaling                   =          0.500  El. 1-4 Scaling                  =          0.833
   Number of MM Atoms               =            288  Number of MM Atom Types          =              6
   Number of Inactive MM Atoms      =             18  Total MM Charge                  =           0.00
   Harmonic Bond Terms              =            288  Harmonic Bond Parameters         =              7
   Harmonic Bond Inactive           =             18  Harmonic Angle Terms             =            400
   Harmonic Angle Parameters        =              9  Harmonic Angle Inactive          =             25
   Fourier Dihedral Terms           =            592  Fourier Dihedral Parameters      =              5
   Fourier Dihedral Inactive        =             37  Fourier Improper Terms           =            112
   Fourier Improper Parameters      =              1  Fourier Improper Inactive        =              7
   Exclusions                       =           1216  1-4 Interactions                 =            528
   LJ Parameters Form               =          AMBER  LJ Parameters Types              =              5
   1-4 Lennard-Jones Form           =          AMBER  1-4 Lennard-Jones Types          =              5
   ----------------------------------------------------------------------------------------------------
   
   ------------------- Summary for QC Model "BDF:GB3LYP:STO-3g" -------------------
   Number of QC Atoms     =             18  Boundary Atoms         =              0
   Nuclear Charge         =             88  Orbital Functions      =              0
   Fitting Functions      =              0  Energy Base Line       =        0.00000
   --------------------------------------------------------------------------------
   
   ----------------------------- ORCA NB Model Summary ----------------------------
   El. 1-4 Scaling        =       0.833333  QC/MM Coupling         =    RC Coupling
   --------------------------------------------------------------------------------
   
   ------------------------------- Sequence Summary -------------------------------
   Number of Atoms            =        288  Number of Components       =         16
   Number of Entities         =          1  Number of Linear Polymers  =          0
   Number of Links            =          0  Number of Variants         =          0
   --------------------------------------------------------------------------------

Output system total energy information and contributions from each part:

.. code-block:: bdf
  
  --------------------------------- Summary of Energy Terms --------------------------------
  Potential Energy          =    -1671893.4718  RMS Gradient              =             None
  Harmonic Bond             =        1743.3211  Harmonic Angle            =         124.9878
  Fourier Dihedral          =         269.8417  Fourier Improper          =           0.1346
  MM/MM LJ                  =        -138.0022  MM/MM 1-4 LJ              =         474.4044
  QC/MM LJ                  =         -42.2271  BDF QC                    =    -1674325.9320
  ------------------------------------------------------------------------------------------


QM/MM Structural Optimization
-------------------------------------------------
Python script for QM/MM geometry optimization:

.. code-block:: bdf

  import glob, math, os.path

  from pBabel import  AmberCrdFile_ToCoordinates3, \
                      AmberTopologyFile_ToSystem , \
                      SystemGeometryTrajectory   , \
                      AmberCrdFile_FromSystem    , \
                      PDBFile_FromSystem         , \
                      XYZFile_FromSystem
  
  from pCore import Clone, logFile, Selection
  
  from pMolecule import NBModelORCA, QCModelBDF, System
  
  from pMoleculeScripts import ConjugateGradientMinimize_SystemGeometry, \
                               FIREMinimize_SystemGeometry             , \
                               LBFGSMinimize_SystemGeometry            , \
                               SteepestDescentMinimize_SystemGeometry
  # Define structure optimization interface
  def opt_ConjugateGradientMinimize(molecule, selection):
      molecule.DefineFixedAtoms(selection)       # Fix atoms
      # Define optimization method
      ConjugateGradientMinimize_SystemGeometry(
          molecule,
          maximumIterations    =  40,   # Maximum optimization steps
          rmsGradientTolerance =  0.1, # Optimization convergence control
          trajectories   = [(trajectory, 1)]
      )   # Define trajectory save frequency
  #  Define energy calculation model
  nbModel = NBModelORCA()
  qcModel = QCModelBDF("GB3LYP:6-31g")
  # Read system coordinates and topology information
  molecule = AmberTopologyFile_ToSystem ("GallicAcid.prmtop")
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3("GallicAcid.crd")
  # Disable system symmetry
  molecule.DefineSymmetry(crystalClass = None)  # QM/MM method does not support periodic boundary conditions
  #. Define Atoms List
  natoms = len(molecule.atoms)                      # Total number of atoms in the system
  qm_list = range(72, 90)                            # QM region atoms
  activate_list = range(126, 144) + range (144, 162)   # MM region active atoms (can move during optimization)
  # Define MM region atoms
  mm_list = range (natoms)
  for i in qm_list:
      mm_list.remove(i)                              # MM region: remove QM atoms
  mm_inactivate_list = mm_list[:]
  for i in activate_list :
      mm_inactivate_list.remove(i)
  # Input QM atoms
  qmmmtest_qc = Selection.FromIterable(qm_list)     
  #  Define selection regions
  selection_qm_mm_inactivate = Selection.FromIterable(qm_list + mm_inactivate_list)
  selection_mm = Selection.FromIterable(mm_list)
  selection_mm_inactivate = Selection.FromIterable(mm_inactivate_list)
  # . Define the energy model.
  molecule.DefineQCModel(qcModel, qcSelection = qmmmtest_qc)
  molecule.DefineNBModel(nbModel)
  molecule.Summary()
  # Calculate total energy at optimization start
  eStart = molecule.Energy()
  # Define output file directory name
  outlabel = 'opt_watbox_bdf'
  if os.path.exists(outlabel):
      pass
  else:
      os.mkdir (outlabel)
  outlabel = outlabel + '/' + outlabel
  # Define output trajectory
  trajectory = SystemGeometryTrajectory (outlabel + ".trj" , molecule, mode = "w")
  # Start first stage optimization
  # Define two optimization steps
  iterations = 2
  #  Optimize sequentially by fixing QM and MM regions
  for i in range(iterations):
      opt_ConjugateGradientMinimize(molecule, selection_qm_mm_inactivate) # Fix QM region, optimize MM
      opt_ConjugateGradientMinimize(molecule, selection_mm)                # Fix MM region, optimize QM
  # Start second stage optimization
  # Optimize QM and MM regions simultaneously
  opt_ConjugateGradientMinimize(molecule, selection_mm_inactivate)
  # Output optimized total energy
  eStop = molecule.Energy()
  # Save optimized coordinates (xyz/crd/pdb formats)
  XYZFile_FromSystem(outlabel +  ".xyz", molecule)
  AmberCrdFile_FromSystem(outlabel +  ".crd" , molecule)
  PDBFile_FromSystem(outlabel +  ".pdb" , molecule)

Output system convergence information (showing first 20 steps):

.. code-block:: bdf

    ----------------------------------------------------------------------------------------------------------------
    Iteration       Function             RMS Gradient        Max. |Grad.|          RMS Disp.         Max. |Disp.|
    ----------------------------------------------------------------------------------------------------------------
     0     I   -1696839.69778731          2.46510318          9.94250232          0.00785674          0.03168860
     2   L1s   -1696839.82030342          1.38615730          5.83254788          0.00043873          0.00126431
     4   L1s   -1696839.90971371          1.41241184          5.29242524          0.00067556          0.00172485
     6   L0s   -1696840.01109863          1.41344485          4.70119338          0.00090773          0.00265969
     8   L1s   -1696840.09635696          1.44964059          5.72496661          0.00108731          0.00328490
     10  L1s   -1696840.17289698          1.28607709          4.73666387          0.00108469          0.00354577
     12  L1s   -1696840.23841524          1.03217304          3.00441004          0.00081945          0.00267931
     14  L1s   -1696840.30741088          1.40349698          5.22220965          0.00162080          0.00519590
     16  L1s   -1696840.43546466          1.32604042          4.51175225          0.00158796          0.00455431
     18  L0s   -1696840.52547251          1.27123125          4.20616166          0.00158796          0.00428040
     20  L0s   -1696840.60265453          1.08553355          3.12355616          0.00158796          0.00470223
    ----------------------------------------------------------------------------------------------------------------

Output system total energy information:

.. code-block:: bdf
 
  --------------------------------- Summary of Energy Terms --------------------------------
  Potential Energy          =    -1696841.6016  RMS Gradient              =             None
  Harmonic Bond             =           3.0295  Harmonic Angle            =           3.6222
  Fourier Dihedral          =          32.0917  Fourier Improper          =           0.0040
  MM/MM LJ                  =         -69.3255  MM/MM 1-4 LJ              =          43.9528
  QC/MM LJ                  =         -47.2706  BDF QC                    =    -1696807.7057
  ------------------------------------------------------------------------------------------

.. note::

   QM/MM geometry optimization is generally challenging to converge and requires advanced techniques. Common approaches include: fixing the MM region and optimizing the QM region; then fixing the QM region and optimizing the MM region. After several iterations, optimize both regions simultaneously. Convergence depends on QM region selection and whether the QM/MM boundary contains highly charged atoms. To accelerate optimization, fix the MM region and select only a suitable nearby region as the active area whose coordinates can change during optimization.

QM/MM Excited State Calculation
-------------------------------------------------

Based on the previous QM/MM geometry optimization, add MM region active atoms to the QM region for QM/MM-TDDFT calculations. The complete code is as follows:

.. code-block:: bdf
  
  import glob, math, os.path

  from pBabel import  AmberCrdFile_ToCoordinates3, \
                      AmberTopologyFile_ToSystem , \
                      SystemGeometryTrajectory   , \
                      AmberCrdFile_FromSystem    , \
                      PDBFile_FromSystem         , \
                      XYZFile_FromSystem
  
  from pCore import Clone, logFile, Selection
  
  from pMolecule import NBModelORCA, QCModelBDF, System
  
  from pMoleculeScripts import ConjugateGradientMinimize_SystemGeometry, \
                               FIREMinimize_SystemGeometry             , \
                               LBFGSMinimize_SystemGeometry            , \
                               SteepestDescentMinimize_SystemGeometry
  # Define structure optimization interface
  def opt_ConjugateGradientMinimize(molecule, selection):
      molecule.DefineFixedAtoms(selection)       # Fix atoms
      # Define optimization method
      ConjugateGradientMinimize_SystemGeometry(
          molecule,
          maximumIterations    =  40,   # Maximum optimization steps
          rmsGradientTolerance =  0.1, # Optimization convergence control
          trajectories   = [(trajectory, 1)]
      )   # Define trajectory save frequency
  #  Define energy calculation model
  nbModel = NBModelORCA()
  qcModel = QCModelBDF("GB3LYP:6-31g")
  # Read system coordinates and topology information
  molecule = AmberTopologyFile_ToSystem ("GallicAcid.prmtop")
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3("GallicAcid.crd")
  # Disable system symmetry
  molecule.DefineSymmetry(crystalClass = None)  # QM/MM method does not support periodic boundary conditions
  #. Define Atoms List
  natoms = len(molecule.atoms)                      # Total number of atoms in the system
  qm_list = range(72, 90)                            # QM region atoms
  activate_list = range(126, 144) + range (144, 162)   # MM region active atoms (can move during optimization)
  # Define MM region atoms
  mm_list = range (natoms)
  for i in qm_list:
      mm_list.remove(i)                              # MM region: remove QM atoms
  mm_inactivate_list = mm_list[:]
  for i in activate_list :
      mm_inactivate_list.remove(i)
  # Input QM atoms
  qmmmtest_qc = Selection.FromIterable(qm_list)     
  #  Define selection regions
  selection_qm_mm_inactivate = Selection.FromIterable(qm_list + mm_inactivate_list)
  selection_mm = Selection.FromIterable(mm_list)
  selection_mm_inactivate = Selection.FromIterable(mm_inactivate_list)
  # . Define the energy model.
  molecule.DefineQCModel(qcModel, qcSelection = qmmmtest_qc)
  molecule.DefineNBModel(nbModel)
  molecule.Summary()
  # Calculate total energy at optimization start
  eStart = molecule.Energy()
  # Define output file directory name
  outlabel = 'opt_watbox_bdf'
  if os.path.exists(outlabel):
      pass
  else:
      os.mkdir (outlabel)
  outlabel = outlabel + '/' + outlabel
  # Define output trajectory
  trajectory = SystemGeometryTrajectory (outlabel + ".trj" , molecule, mode = "w")
  # Start first stage optimization
  # Define two optimization steps
  iterations = 2
  #  Optimize sequentially by fixing QM and MM regions
  for i in range(iterations):
      opt_ConjugateGradientMinimize(molecule, selection_qm_mm_inactivate) # Fix QM region, optimize MM
      opt_ConjugateGradientMinimize(molecule, selection_mm)                # Fix MM region, optimize QM
  # Start second stage optimization
  # Optimize QM and MM regions simultaneously
  opt_ConjugateGradientMinimize(molecule, selection_mm_inactivate)
  # Output optimized total energy
  eStop = molecule.Energy()
  # Save optimized coordinates (xyz/crd/pdb formats)
  XYZFile_FromSystem(outlabel +  ".xyz", molecule)
  AmberCrdFile_FromSystem(outlabel +  ".crd" , molecule)
  PDBFile_FromSystem(outlabel +  ".pdb" , molecule)
  
  #  TDDFT calculation
  qcModel = QCModelBDF_template ( )
  qcModel.UseTemplate (template = 'head_bdf_nosymm.inp' )
  
  tdtest = Selection.FromIterable ( qm_list + activate_list )
  # . Define the energy model.
  molecule.DefineQCModel ( qcModel, qcSelection = tdtest )
  molecule.DefineNBModel ( nbModel )
  molecule.Summary ( )
  
  # . Calculate
  energy  = molecule.Energy ( )

Output system total energy information:

.. code-block:: bdf

  --------------------------------- Summary of Energy Terms --------------------------------
  Potential Energy          =    -5088333.3818  RMS Gradient              =             None
  Harmonic Bond             =           0.0000  Harmonic Angle            =           0.0000
  Fourier Dihedral          =           0.0000  Fourier Improper          =           0.0000
  QC/MM LJ                  =        -112.3207  BDF QC                    =    -5088221.0611
  ------------------------------------------------------------------------------------------

Simultaneously generate .log result files. Similar to regular excited-state calculations, information such as oscillator strength, excitation energy, and total energy of excited states can be viewed:

.. code-block:: bdf

    No.     1    w=      4.7116 eV    -1937.8276358207 a.u.  f=    0.0217   D<Pab>= 0.0000   Ova= 0.6704
      CV(0):    A( 129 )->   A( 135 )  c_i:  0.7254  Per: 52.6%  IPA:     7.721 eV  Oai: 0.6606
      CV(0):    A( 129 )->   A( 138 )  c_i:  0.2292  Per:  5.3%  IPA:     9.104 eV  Oai: 0.8139
      CV(0):    A( 132 )->   A( 135 )  c_i:  0.4722  Per: 22.3%  IPA:     7.562 eV  Oai: 0.6924
      CV(0):    A( 132 )->   A( 138 )  c_i: -0.4062  Per: 16.5%  IPA:     8.946 eV  Oai: 0.6542

Transition dipole moments are also printed:

.. code-block:: bdf

   *** Ground to excited state Transition electric dipole moments (Au) ***
    State          X           Y           Z          Osc.
       1       0.0959       0.1531       0.3937       0.0217       0.0217
       2       0.0632      -0.1286       0.3984       0.0207       0.0207
       3      -0.0797      -0.2409       0.4272       0.0287       0.0287
       4       0.0384      -0.0172      -0.0189       0.0003       0.0003
       5       1.1981       0.8618      -0.1305       0.2751       0.2751


---------------------------------------------------------------------------------------------------------


QM/MM Case Tutorial II: Benzophenone
==========================================

Benzophenone Structure Preparation
-----------------------------------

First prepare the coordinate file for benzophenone (Benzophenone), named BPH.xyz

.. code-block:: python

 24
 
 C         -2.54700        0.45510        0.06680
 C         -2.54160       -0.01810        1.38630
 C         -3.74290       -0.40660        1.99760
 C         -4.94170       -0.34290        1.28250
 C         -4.94480        0.12330       -0.03620
 C         -3.74920        0.52640       -0.64160
 C         -1.27680       -0.08120        2.18450
 O         -1.26930        0.16880        3.37250
 C         -0.02150       -0.46400        1.46430
 C          1.18620        0.13430        1.85330
 C          2.37660       -0.21530        1.21040
 C          2.36490       -1.17300        0.19100
 C          1.16310       -1.78220       -0.18680
 C         -0.03080       -1.42830        0.44700
 H          1.18770        0.86620        2.66440
 H         -3.73280       -0.75010        3.03460
 H          3.31310        0.25350        1.50860
 H         -5.87330       -0.64990        1.75530
 H          3.29390       -1.44820       -0.30740
 H         -5.88040        0.17660       -0.59220
 H          1.15790       -2.53420       -0.97410
 H         -3.75550        0.89780       -1.66500
 H         -0.96650       -1.90720        0.15500
 H         -1.61620        0.77400       -0.40440



Use Open Babel and Amber plugin antechamber to obtain bond and charge information.
Command line operations:

.. code-block:: python

 obabel BPH.xyz -O BPH_mid.mol2
 # Default molecule name is NUL; replace with BPH in mol2 file (not done in this example)
 antechamber -i BPH_mid.mol2 -fi mol2 -o BPH.mol2 -fo mol2 -c bcc -at gaff

Use Amber's parmchk tool to obtain force field parameters
Command line operation:

.. code-block:: python

 parmchk -a Y -i BPH.mol2 -f mol2 -o BPH.frcmod

Perform solvation using tleap and obtain small molecule lib file and solvated system.
Prepare tleap.in file to obtain top and crd files (named BPH_solv.top BPH_solv.crd)

.. code-block:: python

 source leaprc.protein.ff14SB
 source leaprc.water.tip3p
 loadamberparams BPH.frcmod
 BPH=loadmol2 BPH.mol2
 check BPH
 saveoff BPH BPH.lib
 solvateoct BPH TIP3PBOX 18.0
 saveamberparm BPH BPH_solv.top BPH_solv.crd
 quit

Command line run:

.. code-block:: python

 tleap -f tleap.in

Obtain initial conformation BPH_solv.top BPH_solv.crd.

.. figure:: /app/QMMM_example/BPH/BPHimage/fig1.png


Dynamics Equilibration
-----------------------------------

Create folder md/, prepare dynamics simulation files: minimization input file
:download:`01_Min.in </app/QMMM_example/BPH/BPHfilelist/01_Min.in>`,
heating input file
:download:`02_Heat.in </app/QMMM_example/BPH/BPHfilelist/02_Heat.in>`,
equilibration input file
:download:`03_Prod.in </app/QMMM_example/BPH/BPHfilelist/03_Prod.in>`.

Use Amber's sander for molecular dynamics minimization, heating, and equilibration:

Command line sequential runs:

.. code-block:: python

 ### Optimization
 sander -O -i 01_Min.in -o 01_Min.out -p ../BPH_solv.top -c ../BPH_solv.crd -r 01_Min.rst -inf 01_Min.mdinfo
 ### Heat
 sander -O -i 02_Heat.in -o 02_Heat.out -p ../BPH_solv.top -c 01_Min.rst -r 02_Heat.rst -x 02_Heat.mdcrd -inf 02_Heat.mdinfo
 ### Production
 sander -O -i 03_Prod.in -o 03_Prod.out -p ../BPH_solv.top -c 02_Heat.rst -r 03_Prod.rst -x 03_Prod.mdcrd -inf 03_Prod.mdinfo

Dynamics Result Analysis
-----------------------------------

.. figure:: /app/QMMM_example/BPH/BPHimage/energy.png
.. figure:: /app/QMMM_example/BPH/BPHimage/pres.png
.. figure:: /app/QMMM_example/BPH/BPHimage/temp.png

Randomly Select Single Frame Structure and Extract Partial Water Conformation
-----------------------------------

1. Use cpptraj to obtain single frame conformation (randomly selected for demonstration)

Prepare input file snap.trajin

.. code-block:: python

 parm ../BPH_solv.top
 trajin 03_Prod.mdcrd 2976 2976 1      # read from mdcrd frames 2976 to 2976 (1 frame)
 center :1                             # put BPH in the center
 image familiar                        # re-image
 trajout snapshot_2976.rst rest        # write the coordinates of this frame
 go 

Command line run:

.. code-block:: python

 cpptraj -i snap.trajin

2. Extract partial water conformation

Remove water molecules >20Å from C7 atom in BPH. Prepare input file strip.trajin:

.. code-block:: python

 parm ../BPH_solv.top
 trajin snapshot_2976.rst                 # read the snapshot
 reference snapshot_2976.rst rest         # use it as reference (necessary for strip command)
 strip @7>:20.0                           # strip all waters further than 20A around atom C7
 trajout strip_2976.pdb pdb               # write pdb output
 go

Command line run:

.. code-block:: python

 cpptraj -i strip.trajin

Obtain new solvated system: 
:download:`strip_2976.pdb </app/QMMM_example/BPH/BPHfilelist/strip_2976.pdb>`.

QM/MM Calculation Preparation
-----------------------------------
1. Top and crd file preparation

pDynamo uses Amber's top and crd files as input. Using strip_2976.pdb and previously generated force field files, obtain corresponding Amber top and crd files.
Create and enter folder md/get_topcrd/, prepare tleap input file
:download:`tleap.in </app/QMMM_example/BPH/BPHfilelist/tleap.in>`.

.. code-block:: python

 source leaprc.protein.ff14SB
 source leaprc.water.tip3p
 loadamberparams ../../BPH.frcmod
 loadoff ../../BPH.lib
 a=loadpdb strip_2976.pdb
 check a
 saveamberparm a BPH_new.top BPH_new.crd
 savepdb a BPH_new.pdb
 quit

Command line run to obtain new top and crd files (
:download:`BPH_new.top </app/QMMM_example/BPH/BPHfilelist/BPH_new.top>`,
:download:`BPH_new.crd </app/QMMM_example/BPH/BPHfilelist/BPH_new.crd>`,
:download:`BPH_new.pdb </app/QMMM_example/BPH/BPHfilelist/BPH_new.pdb>`
)

2. Active region water layer selection
In VMD, select water within 3Å of benzophenone as movable water layer. Set VMD as shown below to display benzophenone and its surrounding 3Å water layer:

.. figure:: /app/QMMM_example/BPH/BPHimage/vmdset.png

BPH and water within 3Å are shown below:

.. figure:: /app/QMMM_example/BPH/BPHimage/BPH3A.png

Overall conformation is shown below:

.. figure:: /app/QMMM_example/BPH/BPHimage/BPHandwat.png

QM/MM region division for the entire system is shown below:

.. figure:: /app/QMMM_example/BPH/BPHimage/QMMMzone.png

Use VMD's TkConsole to obtain atomic indices for MM active region, which will be used in QM/MM input files.
In TkConsole console, type sequentially:

.. code-block::bdf

 # Select water within 3Å of BPH
 set sel [atomselect 0 "same residue as exwithin 3 of residue 0"] 
 # Get indices of water within 3Å of BPH
 $sel get index

As shown:

.. figure:: /app/QMMM_example/BPH/BPHimage/tk.png

QM/MM Calculation
-----------------------------------
1. Ground State Optimization

- Create folder qmmm/, copy BPH_new.crd and BPH_new.top to this directory
- Create qmmm/ground_opt/ folder for ground state QM/MM geometry optimization
  
Prepare QM/MM input file opt.py, defining QM region and movable MM region:

.. code-block:: python

 #. Define Atoms List 
 natoms = len ( molecule.atoms )
 qm_list = range(24)
 activate_list = [387,388,389,390,391,392,402,403,404,552,553,554,624,625,626,1104,1105,1106,
                  1203,1204,1205,1359,1360,1361,1419,1420,1421,1554,1555,1556,1572,1573,1574,
                  1611,1612,1613,1617,1618,1619,1845,1846,1847,1944,1945,1946,2139,2140,2141,
                  2262,2263,2264,2337,2338,2339,2460,2461,2462,2568,2569,2570,2736,2737,2738]
 mm_list = range ( natoms )
 for i in qm_list :
     mm_list.remove( i )
 mm_inactivate_list = mm_list[ : ]
 for i in activate_list :
     mm_inactivate_list.remove( i )

 # . Define the selection for the first molecule.
 qmmmtest_qc = Selection.FromIterable ( qm_list )

 # . Define Fixed Atoms
 selection_qm_mm_inactivate = Selection.FromIterable ( qm_list + mm_inactivate_list )


Minimize for 100 steps

.. code-block:: python

 ConjugateGradientMinimize_SystemGeometry ( molecule                    ,
                                          logFrequency         =  2,
                                          maximumIterations    =  100,
                                          rmsGradientTolerance =  0.1,
                                          trajectories   = [ ( trajectory, 2 ) ])

QM model selection

.. code-block:: python

 qcModel = QCModelBDF ( "GB3LYP:6-31g" )

Full file:
:download:`opt.py </app/QMMM_example/BPH/BPHfilelist/ground_opt/opt.py>`

- QM/MM ground state geometry optimization results

.. figure:: /app/QMMM_example/BPH/BPHimage/groundshow.png
.. figure:: /app/QMMM_example/BPH/BPHimage/groundenergy.png

2. S1 State Optimization

- Create qmmm/s1_opt/ folder for S1 state QM/MM geometry optimization
- Prepare QM/MM input file opt.py with same QM region and movable MM region as ground state
  
QM model uses QCModelBDF_TDGRAD1 class with template file for excited state geometry optimization:

.. code-block:: python

 qcModel = qcModel = QCModelBDF_TDGRAD1 ( template = 'temple.inp', exgrad = 1 )

Full file:
:download:`opt.py </app/QMMM_example/BPH/BPHfilelist/s1_opt/opt.py>`;
Template file:
:download:`opt.py </app/QMMM_example/BPH/BPHfilelist/s1_opt/temple.inp>`
sets excited state gradient to S1 state gradient.

- QM/MM S1 state geometry optimization results

.. figure:: /app/QMMM_example/BPH/BPHimage/s1show.png

.. figure:: /app/QMMM_example/BPH/BPHimage/s1energy.png

----------------------------------------------------------------------------

.. include:: /app/QMMM_example/menprotein/menprotein.rst

----------------------------------------------------------------------------

QM/MM Boundary Selection Example Tutorial
=======================================

This tutorial demonstrates how QM/MM boundary selection affects geometry optimization. Incorrect boundary selection may lead to unexpected conformational changes.

System View
-----------------------------------
This example uses a pentapeptide as the computational system to test QM region selection. The system
(:download:`5ala.pdb </app/QMMM_example/qmmmboundary/qmmmboundaryfilelist/5ala.pdb>`)
consists of five ALAs, with N-terminus and C-terminus capped with ACE and NME respectively.

.. image:: /app/QMMM_example/qmmmboundary/qmmmboundaryimage/5ala.png

QM Region Selection
-----------------------------------
Using pentapeptide system as example:

1 QM Region: ALA4
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
QM Region Selection 1:

Select third alanine ALA4 as QM region, adjacent ALAs as active MM region

.. code-block :: bdf

 qm_list = range (26, 36 )
 activate_list = range ( 16, 26 ) + range ( 36, 46 )

.. image:: /app/QMMM_example/qmmmboundary/qmmmboundaryimage//QM-1.jpg

QM/MM Optimization Result

.. image:: /app/QMMM_example/qmmmboundary/qmmmboundaryimage/choose1.gif

When selecting QM region, if adjacent MM region carries strong charges (e.g., C=O in this case), strong electrostatic interactions between QM and MM regions prevent system convergence. As shown in animation, large charges in adjacent MM region cause issues in QM region structure optimization.

2 QM Region: ALA4 and C=O
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
QM Region Selection 2:

Select third alanine ALA4 as QM region plus adjacent C=O group, with other adjacent ALAs as active MM region

.. code-block :: bdf

 qm_list = range (24, 36 )
 activate_list = range ( 16, 24 ) + range ( 36, 46 )

.. image:: /app/QMMM_example/qmmmboundary/qmmmboundaryimage/QM-2.jpg

QM/MM Optimization Result

.. image:: /app/QMMM_example/qmmmboundary/qmmmboundaryimage/choose2.gif

Including C=O group in QM region enables system convergence, with structure optimizing within reasonable range.

_________________________________________________________________________________________

