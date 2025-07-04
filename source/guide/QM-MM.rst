# Document: QM/MM Hybrid Methods  
================================================  

QM/MM hybrid methods typically divide a system into two regions: the QM region and the MM region. The total energy of the system is expressed as:  

.. math::  

    E_{QM/MM}(\mathbb{S}) = E_{MM}(\mathbb{O}) + E_{QM}(\mathbb{I+L}) + E_{QM/MM}(\mathbb{I,O})  

Here, **S** denotes the entire system, **I** represents the QM layer, **O** represents the MM layer, and **L** denotes link atoms.  
:math:`E_{MM}(\mathbb{O})` is computed using molecular mechanics force fields.  
:math:`E_{QM/MM}(\mathbb{I,O})` consists of two terms:  

.. math::  

    E_{QM/MM}(\mathbb{I,O}) = E_{nuc-MM} + V_{elec-MM}  

In BDF, :math:`E_{nuc-MM} + V_{elec-MM}` is implemented by incorporating external point charges in the QM region.  

Thus, the total energy of the system comprises two parts: :math:`E_{MM}` is calculated using molecular mechanics methods, while :math:`E_{QM}` and :math:`E_{QM/MM}` are computed using quantum chemical methods. Additionally, interactions between the QM and MM regions (e.g., van der Waals interactions) are omitted here for brevity. Bond breaking between QM and MM regions is typically described using the link atom model.  

The BDF program primarily handles the quantum chemical computation part, while other components are managed by the modified pdynamo2.0 package from our research group. See the examples below for details.  

.. note::  
  - Installation instructions for the pdynamo program are provided in the package documentation. Detailed features of the package are described in its help files.  
  - This manual only provides instructions and examples for performing QM/MM calculations using BDF.  
  - QM/MM environment setup and configuration reference: :ref:`QM/MM Environment Setup<qmmmsetup>`  

---

## Input File Preparation  
-------------------------------------------------  
Typically, molecular dynamics (MD) simulations of the target system are performed before QM/MM calculations to obtain suitable initial conformations. Different MD software packages produce varying output formats.  
pDynamo-2 currently supports force fields like **Amber**, **CHARMM**, and **Gromacs**, and can read molecular coordinates from **PDB**, **MOL2**, or **xyz** formats.  

.. note::  
  - When using PDB, MOL2, or xyz files as input, pDynamo only supports the OPLS force field. Parameters for small molecules and non-standard amino acids are incomplete; thus, this approach is not recommended. **Amber** is preferred, with force field parameters input via topology files. For pure QM calculations, any input method is acceptable.  

Taking Amber as an example, extract structures of interest from the MD trajectory and save them in a `.crd` file. The corresponding topology file (`.prmtop`) serves as the starting point for QM/MM calculations. The Python script is as follows:  

.. code-block:: python  

  from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem  
  # Read input data  
  molecule = AmberTopologyFile_ToSystem(Topfile)  
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3(CRDfile)  

Molecular information is stored in the `molecule` structure. For QM/MM calculations, operations like energy computation and geometry optimization can be performed. Additionally, defining an **active region** in the MM region accelerates calculations.  

---

## Total Energy Calculation  
-------------------------------------------------  

Consider a 10 Å water box as an example. After MD simulations, files `wat.prmtop` and `wat.crd` are extracted. Full quantum chemical calculations can be performed as follows:  

.. code-block:: python  

  import glob, math, os  
  from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem  
  from pCore import logFile  
  from pMolecule import QCModelBDF, System  
  # Read water box coordinates and topology  
  molecule = AmberTopologyFile_ToSystem("wat.prmtop")  
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3("wat.crd")  
  # Define energy calculation mode: Full-system DFT, B3LYP/6-31g  
  model = QCModelBDF("B3LYP:6-31g")  
  molecule.DefineQCModel(model)  
  molecule.Summary()  # Output system settings  
  # Compute total energy  
  energy = molecule.Energy()  

The `QCModelBDF` class defines the method and basis set (`B3LYP:6-31g`), separated by `:`. To perform QM/MM calculations (e.g., treating the 5th water molecule with QM and others with MM (Amber force field)), note that periodic boundary conditions (PBC) used in MD are not supported in QM/MM. Disable PBC in the script:  

.. code-block:: python  

  molecule.DefineSymmetry(crystalClass=None)  

The `Selection` class in pDynamo selects specific QM atoms (see documentation). Select QM atoms as follows:  

.. code-block:: python  

  qm_area = Selection.FromIterable(range(12, 15))  # Indices 12,13,14 = 5th water molecule  
  molecule.DefineQCModel(qcModel, qcSelection=qm_area)  

The complete QM/MM energy calculation script:  

.. code-block:: python  

  import glob, math, os  
  from pBabel import AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem  
  from pCore import logFile, Selection  
  from pMolecule import NBModelORCA, QCModelBDF, System  
  # Define energy models  
  nbModel = NBModelORCA()  
  qcModel = QCModelBDF("B3LYP:6-31g")  
  # Read data  
  molecule = AmberTopologyFile_ToSystem("wat.prmtop")  
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3("wat.crd")  
  # Disable symmetry (PBC)  
  molecule.DefineSymmetry(crystalClass=None)  
  # Select QM region (5th water molecule)  
  qm_area = Selection.FromIterable(range(12, 15))  
  # Define energy models  
  molecule.DefineQCModel(qcModel, qcSelection=qm_area)  
  molecule.DefineNBModel(nbModel)  
  molecule.Summary()  
  # Compute energy  
  energy = molecule.Energy()  

.. note::  
  * QM/MM supports two input modes: simple cases accept parameters directly in `QCModelBDF`.  
  * Complex cases use **calculation templates**.  

---

## Geometry Optimization  
-------------------------------------------------  
.. _QMMMopt:  
QM/MM geometry optimization often faces convergence challenges. Common strategies include:  
1. Freeze MM region → Optimize QM region  
2. Freeze QM region → Optimize MM region  
3. Repeat steps 1-2 cyclically  
4. Optimize QM+MM regions simultaneously  

Convergence depends on QM region selection and charge distribution near the QM/MM boundary. To accelerate optimization:  
- Freeze the MM region  
- Define an **active region** near the QM region whose coordinates can change during optimization.  

Example optimization script:  

.. code-block:: python  

  import glob, math, os.path  
  from pBabel import (  
      AmberCrdFile_ToCoordinates3, AmberTopologyFile_ToSystem,  
      SystemGeometryTrajectory, AmberCrdFile_FromSystem,  
      PDBFile_FromSystem, XYZFile_FromSystem  
  )  
  from pCore import Clone, logFile, Selection  
  from pMolecule import NBModelORCA, QCModelBDF, System  
  from pMoleculeScripts import ConjugateGradientMinimize_SystemGeometry  

  # Define optimization interface  
  def opt_ConjugateGradientMinimize(molecule, selection):  
      molecule.DefineFixedAtoms(selection)  # Define fixed atoms  
      ConjugateGradientMinimize_SystemGeometry(  
          molecule,  
          maximumIterations=400,  # Max optimization steps  
          rmsGradientTolerance=0.1,  # Convergence threshold  
          trajectories=[(trajectory, 1)]  # Trajectory save frequency  
      )  

  # Define energy models  
  nbModel = NBModelORCA()  
  qcModel = QCModelBDF("B3LYP:6-31g")  
  # Read data  
  molecule = AmberTopologyFile_ToSystem("wat.prmtop")  
  molecule.coordinates3 = AmberCrdFile_ToCoordinates3("wat.crd")  
  # Disable symmetry (PBC)  
  molecule.DefineSymmetry(crystalClass=None)  
  # Define atom lists  
  natoms = len(molecule.atoms)              # Total atoms  
  qm_list = range(12, 15)                  # QM atoms (5th water)  
  activate_list = range(6, 12) + range(24, 27)  # MM active atoms  
  mm_list = range(natoms)                   # MM atoms  
  for i in qm_list:  
      mm_list.remove(i)  
  mm_inactivate_list = mm_list[:]  
  for i in activate_list:  
      mm_inactivate_list.remove(i)  
  # Define regions  
  qmmmtest_qc = Selection.FromIterable(qm_list)  
  selection_qm_mm_inactivate = Selection.FromIterable(qm_list + mm_inactivate_list)  
  selection_mm = Selection.FromIterable(mm_list)  
  selection_mm_inactivate = Selection.FromIterable(mm_inactivate_list)  
  # Define energy model  
  molecule.DefineQCModel(qcModel, qcSelection=qmmmtest_qc)  
  molecule.DefineNBModel(nbModel)  
  molecule.Summary()  
  # Compute initial energy  
  eStart = molecule.Energy()  
  # Set output  
  outlabel = 'opt_watbox_bdf'  
  os.makedirs(outlabel, exist_ok=True)  
  outlabel = os.path.join(outlabel, outlabel)  
  # Define trajectory  
  trajectory = SystemGeometryTrajectory(outlabel + ".trj", molecule, mode="w")  
  # Stage 1: Cyclic optimization  
  iterations = 2  
  for i in range(iterations):  
      opt_ConjugateGradientMinimize(molecule, selection_qm_mm_inactivate)  # Freeze QM → Optimize  
      opt_ConjugateGradientMinimize(molecule, selection_mm)               # Freeze MM → Optimize QM  
  # Stage 2: Simultaneous QM+MM optimization  
  opt_ConjugateGradientMinimize(molecule, selection_mm_inactivate)  
  # Compute final energy  
  eStop = molecule.Energy()  
  # Save optimized coordinates  
  XYZFile_FromSystem(outlabel + ".xyz", molecule)  
  AmberCrdFile_FromSystem(outlabel + ".crd", molecule)  
  PDBFile_FromSystem(outlabel + ".pdb", molecule)  

---

## QM/MM-TDDFT Example  
-------------------------------------------------  
After geometry optimization, TDDFT calculations can be performed on the QM/MM-optimized ground state. BDF’s **template** feature allows users to update coordinates in a predefined `.inp` file. The QM region can be adjusted for excited-state calculations (e.g., including the first solvation shell). Building on the previous example:  

.. code-block:: python  

  # Continued from optimization script  
  # Start TDDFT calculation using a template file  
  qcModel = QCModelBDF_template(template='head_bdf_nosymm.inp')  
  # Redefine QM region (e.g., add solvation shell)  
  tdtest = Selection.FromIterable(qm_list + activate_list)  
  molecule.DefineQCModel(qcModel, qcSelection=tdtest)  
  molecule.DefineNBModel(nbModel)  
  molecule.Summary()  
  # Compute energy (TDDFT as defined in the template)  
  energy = molecule.Energy()  

Template file `head_bdf_nosymm.inp` (BDF input format):  

.. code-block:: bdf  

  $COMPASS  
  Title  
    cla_head_bdf  
  Basis  
    6-31g  
  Geometry  
    H   100.723   207.273   61.172  
    MG   92.917   204.348   68.063  
    C    95.652   206.390   67.185  
  END geometry  
  Extcharge  
    point  
  nosymm  
  $END  

  $XUANYUAN  
  RSOMEGA  
      0.33  
  $END  

  $SCF  
  RKS  
  DFT  
      cam-B3LYP  
  $END  

  $tddft   # TDDFT settings  
  iprt  
      3  
  iroot  
      5  
  $end  