
.. _TADF-example:

Theoretical Insight into the Thermally Activated Delayed Fluorescence (TADF) Mechanism of DPO-TXO2
=====================================================

Thermally Activated Delayed Fluorescence (TADF) materials represent the third generation of pure organic delayed fluorescence materials, developed after fluorescent materials and noble metal phosphorescent materials. Their hallmark features include a small singlet-triplet energy gap (ΔES-T) and positive temperature dependence.

In 2012, the Chiahaya Adachi group at Kyushu University first reported the 4CzIPN molecule with an external quantum efficiency (EQE) exceeding 20% [ ]. This material exhibited an almost negligible energy difference between singlet and triplet states, enabling complete exciton return from the triplet to singlet state under room temperature thermal disturbance (298 K) to emit fluorescence—thus named TADF (Thermally Activated Delayed Fluorescence).

When both S1 and T1 excitations exhibit HOMO→LUMO characteristics, their energy difference equals 2*K, where K is the exchange integral between HOMO and LUMO. As HOMO and LUMO separation increases, K rapidly decreases. Therefore, larger separation results in a smaller S1-T1 gap, facilitating the Reverse Intersystem Crossing (RISC) required for TADF.

.. figure:: /TADF-example/TADF.jpg
    :width: 800
    :align: center

To ensure efficient RISC, TADF materials require a small singlet-triplet energy gap, corresponding to effective HOMO/LUMO separation. Hence, TADF materials typically adopt donor (D)-acceptor (A) or D-A-D structures to achieve HOMO/LUMO separation while maintaining transition oscillator strength.

Factors such as electronic properties of different donors/acceptors, triplet energy levels, structural rigidity, and distortion degree collectively influence ΔEST, oscillator strength, density of states, and exciton lifetime, ultimately determining the material's photophysical properties and corresponding OLED device performance.

This topic uses the typical TADF molecule DPO-TXO2 as an example to demonstrate calculations for structural optimization, frequency analysis, single-point energy, excitation energy, spin-orbit coupling, etc. It also explains how to interpret data for result analysis, helping users gain deeper insights into BDF software usage.

Structural Optimization and Frequency Calculation
-------------------------------------------------

Generating Input Files for Structural Optimization and Frequency Analysis
########################################################

Import the prepared molecular structure DPO-TXO2.xyz into Device Studio to obtain the interface shown in Figure 1.1-1. Select Simulator → BDF → BDF, then configure parameters in the pop-up window.

.. figure:: /TADF-example/fig1.1-1.png
.. centered:: 1.1-1

For structural optimization, select "Opt+Freq" as the calculation type. Users can set parameters such as method, functional, and basis set according to computational needs. For example, configure the Basic Settings panel as shown in Figure 1.1-2, deselect "Use MPEC+COSX" in the SCF panel (Figure 1.1-3), and retain default values for OPT and Freq panels. Click "Generate files" to create corresponding input files.

.. figure:: /TADF-example/fig1.1-2.png
.. centered:: 1.1-2 

.. figure:: /TADF-example/fig1.1-3.png
.. centered:: 1.1-3 

Key sections of the generated input file bdf.inp are shown below:

.. code-block:: bdf

  $compass
  Title
    C39H28N2O4S
  Geometry
  C          3.86523        0.67704        0.08992
  C          2.59676        1.19847       -0.21677
  C          1.38236        0.46211       -0.14538
  C          1.50274       -0.90633        0.05433
  C          2.74673       -1.48909        0.32003
  C          3.89360       -0.68925        0.41062
  C          0.05129        1.23073       -0.21431
  C         -1.26041        0.42556       -0.14322
  C         -1.34326       -0.94957        0.03351
  S          0.09634       -1.96093       -0.00226
  C         -2.49139        1.13510       -0.19404
  C         -3.75015        0.57230        0.07933
  C         -3.75167       -0.80689        0.33485
  C         -2.57699       -1.57032        0.24960
  N          5.05789        1.50514        0.05106
  N         -4.95552        1.38707        0.07338
  C          5.09111        2.89319        0.50297
  C          6.28464        3.63010        0.39676
  O          7.47953        3.08357        0.01235
  C          7.47002        1.78524       -0.41733
  C          6.30967        0.99832       -0.48773
  C          8.72243        1.30821       -0.82591
  C          8.84826        0.02519       -1.33737
  C          7.70856       -0.74821       -1.50329
  C          6.45512       -0.24869       -1.12362
  C          4.01062        3.58921        1.07620
  C          4.07062        4.96296        1.37442
  C          5.24860        5.67030        1.18784
  C          6.36600        4.99303        0.72541
  C         -6.19457        0.91553       -0.52385
  C         -7.33964        1.73082       -0.48834
  O         -7.34248        3.01488       -0.01720
  C         -6.17443        3.51502        0.46887
  C         -4.99409        2.75189        0.59422
  C         -6.34490       -0.31630       -1.18638
  C         -7.59189       -0.76699       -1.64640
  C         -8.71481        0.03325       -1.52666
  C         -8.57997        1.30489       -0.97531
  C         -6.24475        4.86124        0.86098
  C         -5.14195        5.49110        1.41274
  C         -3.98465        4.75621        1.61916
  C         -3.93157        3.39823        1.25512
  O          0.11666       -2.61281       -1.29752
  O          0.10373       -2.72112        1.23297
  C          0.03300        2.06197       -1.51772
  C          0.04308        2.16169        1.03932
  H          2.54886        2.24058       -0.51595
  H          2.82840       -2.56453        0.47286
  H          4.82173       -1.17141        0.70878
  H         -2.46593        2.19212       -0.44272
  H         -4.67197       -1.32502        0.59460
  H         -2.63456       -2.65479        0.35810
  H          9.59544        1.95023       -0.74373
  H          9.82187       -0.35477       -1.63187
  H          7.78471       -1.74349       -1.93391
  H          5.60034       -0.87480       -1.35499
  H          3.08415        3.09348        1.32929
  H          3.19316        5.47421        1.76453
  H          5.30763        6.72822        1.42899
  H          7.31255        5.51704        0.61863
  H         -5.50297       -0.96874       -1.38412
  H         -7.67454       -1.75102       -2.10194
  H         -9.68032       -0.30389       -1.89032
  H         -9.43942        1.96697       -0.92291
  H         -7.17589        5.40700        0.73318
  H         -5.19606        6.53771        1.70383
  H         -3.11983        5.23203        2.07660
  H         -3.02635        2.86997        1.52459
  H          0.02919        1.39736       -2.38952
  H          0.89268        2.72961       -1.61468
  H         -0.84000        2.71525       -1.59635
  H          0.04113        1.57168        1.96645
  H         -0.82598        2.82200        1.07532
  H          0.91163        2.82447        1.08397
  End Geometry
  Basis
    Def2-SVP
  Skeleton
  Group
    C(1)
  $end
  
  $bdfopt
  Solver
    1
  MaxCycle
    444
  IOpt
    3
  Hess
    final
  $end
  
  $xuanyuan
  Direct
  $end
  
  $scf
  RKS
  Charge
    0
  SpinMulti
    1
  DFT
    PBE0
  Molden
  $end
  
  $resp
  Geom
  $end

The Device Studio interface now appears as shown in Figure 1.1-4.

.. figure:: /TADF-example/fig1.1-4.png
.. centered:: 1.1-4 

.. note::

    Selecting "Opt+Freq" ensures identical conditions for structural optimization and frequency calculations. Separate Opt or Freq calculations are also possible.

Performing BDF Calculations
########################################################
Before running BDF calculations, connect to a server with BDF installed (configuration details refer to Hongzhiyun Operation Guide).

After connecting to the server, users may review the input file parameters. If adjustments are needed, edit the file directly or regenerate it before executing BDF calculations.

In the interface shown in Figure 1.1-4, right-click bdf.inp → Run. Import the appropriate script in the pop-up window and click "Run" to submit the job (Figure 1.1-5).

.. figure:: /TADF-example/fig1.1-5.png
.. centered:: 1.1-5

After calculation completes, click the download button to access results (Figure 1.1-6). Select the .out result file and click "Download". (Job submission steps will not be reiterated in subsequent sections)

.. figure:: /TADF-example/fig1.1-6.png
.. centered:: 1.1-6

Analyzing Structural Optimization Results
########################################################
Right-click the downloaded .out file and select "Open with/Open containing folder" to view results. Locate the convergence section:

.. code-block:: 

                   Force-RMS    Force-Max     Step-RMS     Step-Max
    Conv. tolerance :  0.2000E-03   0.3000E-03   0.8000E-03   0.1200E-02
    Current values  :  0.7369E-05   0.4013E-04   0.1843E-03   0.1041E-02
    Geom. converge  :     Yes          Yes          Yes          Yes

When all four "Geom.converge" values are "Yes", structural optimization has converged. Optimized Cartesian and internal coordinates appear above and below this section. The optimized coordinates can serve as initial structures for subsequent calculations.

Verify the absence of imaginary frequencies to confirm optimization reached a local minimum.

Single-Point Energy Calculation
-------------------------------------------------

Generating Single-Point Energy Input Files
########################################################

Import optimized coordinates into Device Studio and rename to DPO-TXO2-sp.xyz (Figure 1.2-1).

.. figure:: /TADF-example/fig1.2-1.png
.. centered:: 1.2-1 

Select Simulator → BDF → BDF. In the pop-up window, choose "Single Point" (default) as calculation type. Configure parameters as needed (e.g., functional=PBE0, basis=Def2-TZVP). Retain other defaults and click "Generate files". Key sections of bdf.inp:

.. code-block:: bdf

    $compass
    Title
      C39H28N2O4S
    Geometry
    C       3.470732   -0.452949    0.333229
    C       2.350276   -0.443126   -0.503378
    C       1.255134   -1.275716   -0.258388
    C       1.358849   -2.111496    0.851996
    C       2.440432   -2.124490    1.711142
    C       3.517727   -1.285828    1.451230
    C      -0.000048   -1.278142   -1.147435
    C      -1.255154   -1.275779   -0.258269
    C      -1.358725   -2.111574    0.852120
    S       0.000118   -3.243604    1.269861
    C      -2.350358   -0.443230   -0.503130
    C      -3.470738   -0.453151    0.333573
    C      -3.517603   -1.286054    1.451551
    C      -2.440223   -2.124643    1.711370
    N       4.564102    0.414026    0.042506
    N      -4.564206    0.413761    0.042962
    C       4.451652    1.797113    0.288414
    C       5.529066    2.638200   -0.032130
    O       6.712474    2.137493   -0.580518
    C       6.813862    0.759847   -0.795860
    C       5.755871   -0.112762   -0.496962
    C       7.999623    0.286590   -1.327509
    C       8.161221   -1.076261   -1.582122
    C       7.118160   -1.950624   -1.301513
    C       5.922124   -1.471078   -0.764717
    C       3.313452    2.367422    0.857787
    C       3.242304    3.742953    1.084847
    C       4.311909    4.564914    0.751035
    C       5.460487    4.001069    0.193102
    C      -5.755562   -0.112971   -0.497448
    C      -6.813628    0.759568   -0.796285
    O      -6.712738    2.137080   -0.579852
    C      -5.529582    2.637766   -0.030885
    C      -4.452105    1.796731    0.289592
    C      -5.921333   -1.471159   -0.766141
    C      -7.116971   -1.950658   -1.303865
    C      -8.160095   -1.076369   -1.584473
    C      -7.998981    0.286358   -1.328883
    C      -5.461319    4.000541    0.194998
    C      -4.313011    4.564332    0.753554
    C      -3.243348    3.742416    1.087286
    C      -3.314166    2.366978    0.859540
    O       0.000119   -4.563841    0.371547
    O       0.000187   -3.483649    2.840945
    C      -0.000061   -2.561317   -2.024419
    C      -0.000112   -0.071391   -2.097897
    H       2.353966    0.240214   -1.341805
    H       2.400109   -2.768057    2.584222
    H       4.382110   -1.260026    2.103052
    H      -2.354159    0.240153   -1.341521
    H      -4.381950   -1.260326    2.103422
    H      -2.399783   -2.768226    2.584432
    H       8.781734    1.005474   -1.536628
    H       9.092578   -1.440924   -1.998141
    H       7.222431   -3.011204   -1.498846
    H       5.108894   -2.153421   -0.550989
    H       2.483350    1.726165    1.126879
    H       2.346598    4.161499    1.529031
    H       4.264620    5.633193    0.924336
    H       6.321189    4.600814   -0.074686
    H      -5.108047   -2.153429   -0.552391
    H      -7.220889   -3.011140   -1.501914
    H      -9.091141   -1.440996   -2.001221
    H      -8.781175    1.005175   -1.537926
    H      -6.322045    4.600258   -0.072770
    H      -4.265977    5.632537    0.927382
    H      -2.347852    4.160920    1.531932
    H      -2.484014    1.725744    1.128541
    H      -0.000061   -3.470168   -1.414898
    H       0.891657   -2.554225   -2.661972
    H      -0.891789   -2.554218   -2.661957
    H      -0.000071    0.880895   -1.555239
    H      -0.877870   -0.116199   -2.750591
    H       0.877553   -0.116195   -2.750715
    End Geometry
    Basis
      Def2-TZVP
    Skeleton
    Group
      C(1)
    $end
    
    $xuanyuan
    Direct
    RS
      0.33
    $end
    
    $scf
    RKS
    Charge
      0
    SpinMulti
      1
    DFT
      CAM-B3LYP
    MPEC+COSX
    Molden
    $end

Performing BDF Calculation
########################################################
Following the same procedure as structural optimization: Right-click bdf.inp → Run → Verify script → Click "Run". After completion, download the .out result file.

Analyzing Single-Point Energy Results
########################################################

Open the downloaded .out file to locate key energy terms. E_tot represents total system energy (E_tot = E_ele + E_nn). In this example, E_tot = -2310.04883102 Hartree. Other terms: E_ele=electronic energy, E_nn=nuclear repulsion, E_1e=one-electron energy, E_ne=nuclear-electron attraction, E_kin=electron kinetic energy, E_ee=two-electron energy, E_xc=exchange-correlation energy.

.. code-block:: bdf

     Final scf result
     E_tot =             -2311.25269871
     E_ele =             -7827.28555013
     E_nn  =              5516.03285142
     E_1e  =            -14125.30142654
     E_ne  =            -16425.97927385
     E_kin =              2300.67784730
     E_ee  =              6514.27065120
     E_xc  =              -216.25477479
     Virial Theorem      2.004596

Orbital occupation information follows, including energies and HOMO-LUMO gap. HOMO = -5.358 eV, LUMO = -1.962 eV, HOMO-LUMO gap = 3.396 eV. "Irrep" denotes irreducible representation (molecular orbital symmetry), both A for HOMO/LUMO in this case.

.. code-block:: bdf

     [Final occupation pattern: ]

     Irreps:        A
     detailed occupation for iden/irep:      1   1
    1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
    1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
    1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
    1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
    ...
     Alpha   HOMO energy:      -0.24254414 au      -6.59996455 eV  Irrep: A
     Alpha   LUMO energy:      -0.04116321 au      -1.12010831 eV  Irrep: A
     HOMO-LUMO gap:       0.20138093 au       5.47985625 eV

The bottom sections show Mulliken/Lowdin population analyses and dipole moment:

.. code-block:: bdf

     [Mulliken Population Analysis]
  Atomic charges:
     1C      -0.0009
     2C      -0.3029
     3C       0.2227
     4C      -0.0143
     5C      -0.1228
     6C      -0.1890
     7C       0.0046
     8C       0.2227
     9C      -0.0150
    10S       0.7787
    11C      -0.3023
    12C      -0.0022
    13C      -0.1888
    14C      -0.1223
    15N      -0.0121
    16N      -0.0121
    17C       0.0563
    ...

.. code-block:: bdf

     [Lowdin Population Analysis]
  Atomic charges:
     1C      -0.1574
     2C      -0.0592
     3C      -0.0682
     4C      -0.2154
     5C      -0.1050
     6C      -0.0869
     7C      -0.2270
     8C      -0.0682
     9C      -0.2154
    10S       1.0012
    11C      -0.0591
    12C      -0.1574
    13C      -0.0869
    14C      -0.1050
    ...

.. code-block:: bdf

     [Dipole moment: Debye]
              X          Y          Z         |u|
   Elec:-.3535E+01 0.8441E-03 -.1954E+01
   Nucl:-.1254E-12 -.4210E-12 -.2935E-13
   Totl:   -3.5348     0.0008    -1.9541     4.0389

Viewing HOMO Orbital Diagrams
########################################################

To better understand the electronic structure, frontier molecular orbital analysis is often required. The current BDF2022A release does not yet support post-processing data visualization. HOMO and LUMO orbital diagrams can be rendered using third-party software Multiwfn+VMD, requiring the scf.molden file. Usage methods are covered in dedicated posts on quantum chemistry forums and will not be addressed here.

.. figure:: /TADF-example/HOMO.png
.. centered:: HOMO Orbital Distribution

.. figure:: /TADF-example/LUMO.png
.. centered:: LUMO Orbital Distribution

The Highest Occupied Molecular Orbital (HOMO) and Lowest Unoccupied Molecular Orbital (LUMO) are shown above. The symmetrically distributed phenoxazine heterocycles on both sides are typical electron-donating structures, while the central sulfonated tetrahydronaphthalene is a typical electron-accepting structure. Thus, the entire molecule exhibits a classic D-A-D configuration. The HOMO orbital is primarily distributed on the wings, and the LUMO orbital is concentrated in the center, with minimal overlap between HOMO and LUMO orbitals—consistent with the electronic structural characteristics of TADF molecules. However, not all molecules with separated HOMO/LUMO orbitals exhibit TADF photoelectric properties; they must also satisfy the condition that both S1 and T1 excitations correspond to HOMO→LUMO orbital transitions. Therefore, we can further calculate the excited-state electronic structure of this molecule using BDF software.

Excited State Calculation
-------------------------------------------------

Generating Excited State Calculation Input Files
########################################################
Using the optimized structure for TDDFT calculation: Right-click to copy the imported optimized structure and name it DPO-TXO2-td. Select TDDFT as the calculation type. Configure method, functional, basis set, etc., as needed. The previous single-point calculation showed clear HOMO-LUMO separation. For such distinctly D-A structured molecules, excited states often exhibit charge transfer characteristics. Thus, we select range-separated functionals most suitable for such systems, e.g., cam-B3LYP or ω-B97xd. Configure the Basic Settings panel as shown in Figure 1.3-1 and the TDDFT panel as in Figure 1.3-2. Click "Generate files" to create the input file.

.. figure:: /TADF-example/fig1.3-1.png
.. centered:: 1.3-1

.. figure:: /TADF-example/fig1.3-2.png
.. centered:: 1.3-2

Key sections of the generated bdf.inp file:

.. code-block:: bdf

     $compass
     Title
       C39H28N2O4S
     Geometry
     C 3.56215000 -0.34631300 0.45361300
     C 2.39970800 -0.43121500 -0.31807500
     C 1.26327600 -1.11500900 0.12738900
     C 1.35885600 -1.69579600 1.40258100
     C 2.49771000 -1.60285400 2.19867100
     C 3.61595700 -0.93278100 1.71813300
     C 0.00021500 -1.24592200 -0.73874600
     C -1.26297700 -1.11486500 0.12717900
     C -1.35882900 -1.69562600 1.40235700
     S -0.00010100 -2.61984500 2.07323100
     C -2.39926700 -0.43096700 -0.31848800
     C -3.56181100 -0.34590900 0.45301500
     C -3.61589000 -0.93235000 1.71754500
     C -2.49780200 -1.60255300 2.19826800
     N 4.68577300 0.35565000 -0.05695800
     N -4.68524700 0.35616500 -0.05781800
     C 4.85522500 1.71734000 0.22325100
     C 5.96987000 2.38879800 -0.31382300
     O 6.88491700 1.74830700 -1.09915200
     C 6.71947900 0.41903200 -1.36430000
     C 5.62682300 -0.30753500 -0.85481400
     C 7.67346300 -0.19823700 -2.15908800
     C 7.56580700 -1.55645700 -2.46709500
     C 6.49405000 -2.28575300 -1.96795600
     C 5.53176100 -1.66610500 -1.16680600
     C 3.96124200 2.44515800 1.01262100
     C 4.17031100 3.80330200 1.26473400
     C 5.27551600 4.45343400 0.73047600
     C 6.17535900 3.73680700 -0.06194800
     C -5.62705300 -0.30735400 -0.85450500
     C -6.71928700 0.41938500 -1.36464300
     O -6.88329900 1.74927200 -1.10167600
     C -5.96897100 2.38946600 -0.31526500
     C -4.85474100 1.71783400 0.22245400
     C -5.53310000 -1.66639800 -1.16475900
     C -6.49610200 -2.28636200 -1.96480800
     C -7.56751800 -1.55693200 -2.46448300
     C -7.67406700 -0.19823400 -2.15820200
     C -6.17456800 3.73743100 -0.06324300
     C -5.27514800 4.45388200 0.72982000
     C -4.17031500 3.80359400 1.26465900
     C -3.96122400 2.44545700 1.01253300
     O -0.00015400 -3.96830000 1.50483700
     O -0.00019500 -2.47109100 3.52665800
     C 0.00020300 -2.64509100 -1.40495400
     C 0.00034300 -0.20466000 -1.86117000
     H 2.41118900 0.06372500 -1.28828500
     H 2.48620300 -2.04935500 3.19547800
     H 4.52498100 -0.84886800 2.31658900
     H -2.41056900 0.06394100 -1.28871700
     H -4.52499700 -0.84831800 2.31586200
     H -2.48649200 -2.04903700 3.19508500
     H 8.50056300 0.41098100 -2.52869800
     H 8.32203900 -2.03354800 -3.09349600
     H 6.39429300 -3.34933700 -2.19485600
     H 4.69465500 -2.24580100 -0.77484200
     H 3.09145400 1.94045700 1.43579900
     H 3.45545900 4.34652000 1.88647900
     H 5.44614600 5.51436800 0.92329600
     H 7.05577600 4.20903800 -0.50207500
     H -4.69625700 -2.24619000 -0.77237400
     H -6.39717200 -3.35029700 -2.19042200
     H -8.32431800 -2.03427800 -3.09000200
     H -8.50081300 0.41112900 -2.52836600
     H -7.05465600 4.20980200 -0.50387800
     H -5.44580600 5.51480700 0.92266800
     H -3.45579100 4.34667900 1.88689800
     H -3.09175200 1.94062000 1.43619700
     H 0.00013000 -3.45332000 -0.66309300
     H 0.89243900 -2.75169300 -2.04060300
     H -0.89196300 -2.75164000 -2.04071100
     H 0.00033500 0.82736500 -1.47979800
     H -0.87501100 -0.33812800 -2.51032400
     H 0.87579000 -0.33816300 -2.51019000
     End Geometry
     Basis
       Def2-TZVP
     Skeleton
     Group
       C(1)
     $end
     
     $xuanyuan
     Direct
     RS
       0.33
     $end
     
     $scf
     RKS
     Charge
       0
     SpinMulti
       1
     DFT
       CAM-B3LYP
     D3
     MPEC+COSX
     Molden
     $end
     
     $tddft
     Imethod
       1
     Isf
       0
     Idiag
       1
     Iroot
       6
     MPEC+COSX
     Istore
       1
     $end
     
     $tddft
     NtoAnalyze
       0
     $end
     
     $tddft
     Imethod
       1
     Isf
       1
     Idiag
       1
     Iroot
       6
     MPEC+COSX
     Istore
       2
     $end
     
     $tddft
     NtoAnalyze
       0
     $end


.. note::

  1.	Files with identical names in Device Studio will be overwritten. Input files default to bdf.inp. To avoid data loss, create a new project for each calculation.
  2.	In the TDDFT panel, Method is generally recommended as TDDFT. Multiplicity can select singlet, triplet, or both. The default number of excited states calculated is 6. It is advisable to calculate 3 more states than needed (e.g., set to 13 for 10 desired states).
  3.	To perform NTO analysis, check "Perform NTO Analyze" in the TDDFT panel.

Performing BDF Calculation
########################################################
After connecting to a server with BDF installed: Right-click bdf.inp → Run → Verify script → Click "Run". After completion, download the .out result file.

Analyzing Excited State Results
########################################################

Excitation Energy Analysis
^^^^^^^^^^^^^^^^^^^^^^^
Open the downloaded .out file to locate excitation energies, oscillator strengths, and transition dipole moments. isf=0 indicates singlet excited state information; isf=1 indicates triplet excited state information.

.. code-block:: bdf

           No. Pair   ExSym   ExEnergies     Wavelengths      f     D<S^2>          Dominant Excitations             IPA   Ova     En-E1
     
         1   A    2   A    3.4840 eV        355.86 nm   0.0023   0.0000  69.9%  CV(0):   A( 162 )->   A( 163 )   5.584 0.164    0.0000
         2   A    3   A    3.4902 eV        355.24 nm   0.0005   0.0000  69.3%  CV(0):   A( 161 )->   A( 163 )   5.592 0.167    0.0061
         3   A    4   A    3.8143 eV        325.05 nm   0.0003   0.0000  31.6%  CV(0):   A( 162 )->   A( 164 )   6.182 0.482    0.3302
         4   A    5   A    3.8152 eV        324.97 nm   0.0040   0.0000  31.0%  CV(0):   A( 161 )->   A( 164 )   6.189 0.485    0.3312
         5   A    6   A    4.1185 eV        301.05 nm   0.0163   0.0000  30.7%  CV(0):   A( 161 )->   A( 168 )   6.944 0.583    0.6344
         6   A    7   A    4.1229 eV        300.72 nm   0.1369   0.0000  30.8%  CV(0):   A( 162 )->   A( 168 )   6.936 0.582    0.6388
     
      *** Ground to excited state Transition electric dipole moments (Au) ***
         State          X           Y           Z          Osc.
            1       0.0003      -0.1642       0.0004       0.0023
            2       0.0579      -0.0010       0.0549       0.0005
            3       0.0019       0.0580      -0.0012       0.0003
            4      -0.1789       0.0007       0.1034       0.0040
            5      -0.0070      -0.4020       0.0039       0.0163
            6       1.0339      -0.0028      -0.5353       0.1369
     
         ---------------------------------------------
         ---- End TD-DFT Calculations for isf = 0 ----
     ...
       No. Pair   ExSym   ExEnergies     Wavelengths      f     D<S^2>          Dominant Excitations             IPA   Ova     En-E1
     
         1   A    1   A    2.7522 eV        450.49 nm   0.0000   2.0000  25.3%  CV(1):   A( 162 )->   A( 167 )   6.920 0.659    0.0000
         2   A    2   A    2.7522 eV        450.49 nm   0.0000   2.0000  25.1%  CV(1):   A( 161 )->   A( 167 )   6.928 0.659    0.0000
         3   A    3   A    3.3404 eV        371.17 nm   0.0000   2.0000  33.1%  CV(1):   A( 154 )->   A( 163 )   8.200 0.672    0.5882
         4   A    4   A    3.3862 eV        366.15 nm   0.0000   2.0000  20.9%  CV(1):   A( 154 )->   A( 165 )   8.983 0.649    0.6340
         5   A    5   A    3.4620 eV        358.13 nm   0.0000   2.0000  50.3%  CV(1):   A( 162 )->   A( 163 )   5.584 0.322    0.7098
         6   A    6   A    3.4757 eV        356.72 nm   0.0000   2.0000  32.5%  CV(1):   A( 161 )->   A( 163 )   5.592 0.466    0.7235
     
      *** Transition dipole moments (Au) ***
         State          X           Y           Z          Osc.
            1-6: All 0.0000 (spin-forbidden transitions)
     
         ---------------------------------------------
         ---- End TD-DFT Calculations for isf = 1 ----

Results are summarized in the table below:

.. table::

    ================== ========== ========== ======== ======== ========= ============
     Main Transition    Excitation Oscillator  Contribution Dipole   Wavelength  Absolute Overlap
     Orbitals           Energy/eV  Strength   %        Moment   /nm       Integral
    ================== ========== ========== ======== ======== ========= ============
     A(162) -> A(163)    3.4840     0.0023    69.9%    0.1642   355.86     0.164
     A(161) -> A(163)    3.4902     0.0005    69.3%    0.0798   355.24     0.167
     A(162) -> A(164)    3.8143     0.0003    31.6%    0.0580   325.05     0.482
     A(162) -> A(167)    2.7522     0.0000    25.1%    0.0000   450.49     0.659
     A(161) -> A(167)    2.7522     0.0000    25.3%    0.0000   450.49     0.659
     A(154) -> A(163)    3.3404     0.0000    33.1%    0.0000   371.17     0.672
    ================== ========== ========== ======== ======== ========= ============

The table lists excited states in ascending energy order, including multiplicity, irreducible representation, dominant electron-hole pair excitations, excitation energy, oscillator strength, transition orbital contribution percentage, dipole moment, wavelength, and absolute overlap integral. It shows that the six calculated singlet excited states have energies between 2.7-4.0 eV, densely distributed. The first two singlet excited states have wavelengths around 355 nm, primarily involving HOMO→LUMO and HOMO-1→LUMO transitions, exhibiting charge transfer characteristics.

.. figure:: /TADF-example/Wavelength.png
    :width: 800
    :align: center

Literature reports indicate that DPO-TXO2's lowest absorption peak in solvent environments is around 380 nm, red-shifting with increasing solvent polarity. This occurs because higher polarity solvents stabilize more polar excited states to a greater extent. n-orbitals have the highest polarity, followed by π*, while π-orbitals have the lowest polarity.

Calculations show DPO-TXO2's ground state dipole moment is 2.842 D, while the S1 excited state dipole moment is 19.4 D. The significantly larger excited state dipole moment leads to greater stabilization through electrostatic interactions with the solvent environment compared to the ground state, resulting in a red shift of the absorption spectrum.

.. figure:: /TADF-example/energy.png
    :width: 800
    :align: center

NTO Analysis
^^^^^^^^^^^^^^^^^^^^^^^
After excited state calculations, Natural Transition Orbital (NTO) analysis can provide clearer insights into transition characteristics. Readers interested in NTO principles may refer to relevant articles (http://sobereva.com/91).

To analyze the S1 state specifically: Configure the Basic Settings panel as in Figure 1.3-1 and check "Perform NTO Analyze" in the TDDFT panel (Figure 1.3-6).

.. figure:: /TADF-example/fig1.3-6.png
.. centered:: 1.3-6

.. note::
    The second tddft module in the input file can also be manually modified as:

.. code-block:: bdf

     $tddft
     NtoAnalyze
       1       # NTO analysis for one state
       1       # Specify the first excited state
     $end

After calculation, an nto1_1.molden file is generated containing NTO orbital information instead of MO orbitals. Process this file using Multiwfn (main function 0 with adjusted orbital info) to obtain NTO eigenvalues and orbital diagrams. Usage details are covered in specialized forum posts and won't be discussed here.

DPO-TXO2's S1 excitation requires two sets of NTO orbitals for adequate description. Below are VMD-rendered hole-particle orbital pairs:

.. figure:: /TADF-example/hole1-1.png
    :width: 300
    :align: left
.. figure:: /TADF-example/hole1-2.png
    :width: 300
    :align: right

.. centered:: Hole1 → particle1 (73.26%)

.. figure:: /TADF-example/hole2-1.png
    :width: 300
    :align: left
.. figure:: /TADF-example/hole2-2.png
    :width: 300
    :align: right

.. centered:: Hole2 → particle2 (26.59%)

NTO analysis reveals the dominant transition is Hole1→particle1 (73.26%), followed by Hole2→particle2 (26.59%). Electrons transition from phenoxazine donor groups on both sides to the central acceptor group in the S1 excited state.

Absorption Spectrum Analysis
^^^^^^^^^^^^^^^^^^^^^^^

To theoretically predict absorption spectra, excite states are broadened using Gaussian functions. After TDDFT calculation, execute the plotspec.py script from the BDF installation path via terminal. For Hongzhiyun Cloud users, terminal access methods are covered in the user guide (not discussed here).

Run `$BDFHOME/sbin/plotspec.py bdf.out` to generate bdf.stick.csv (stick spectrum data) and bdf.spec.csv (Gaussian-broadened spectrum, default FWHM=0.5 eV). Plot bdf.spec.csv using Origin:

.. figure:: /TADF-example/fig1.3-8.png
    :width: 800
    :align: center
    :alt: Figure 1.3-8

This indicates electrons in the ground state are most likely to absorb 300 nm light for transitions.

Excited State Optimization
-------------------------------------------------

Generating Excited State Optimization Input Files
########################################################
Import the optimized ground state structure. Select TDDFT-OPT as calculation type with PBE0 functional and Def2-SVP basis set. Configure Basic Settings as in Figure 1.4-1 and disable "Use MPEC+COSX" in the SCF panel (Figure 1.1-3). For S1 optimization: Set multiplicity to Singlet and Target State to 1 in the TDDFT panel, checking "Calculate Dipole Moments of Target State" (Figure 1.4-2). Keep OPT panel defaults and click "Generate files".

.. figure:: /TADF-example/fig1.4-1.png
.. centered:: 1.4-1

.. figure:: /TADF-example/fig1.4-2.png
.. centered:: 1.4-2

Generated bdf.inp parameters:

.. code-block:: bdf
  
     $compass
     Title
       C39H28N2O4S
     Geometry
     C 3.56215000 -0.34631300 0.45361300
     C 2.39970800 -0.43121500 -0.31807500
     C 1.26327600 -1.11500900 0.12738900
     C 1.35885600 -1.69579600 1.40258100
     C 2.49771000 -1.60285400 2.19867100
     C 3.61595700 -0.93278100 1.71813300
     C 0.00021500 -1.24592200 -0.73874600
     C -1.26297700 -1.11486500 0.12717900
     C -1.35882900 -1.69562600 1.40235700
     S -0.00010100 -2.61984500 2.07323100
     C -2.39926700 -0.43096700 -0.31848800
     C -3.56181100 -0.34590900 0.45301500
     C -3.61589000 -0.93235000 1.71754500
     C -2.49780200 -1.60255300 2.19826800
     N 4.68577300 0.35565000 -0.05695800
     N -4.68524700 0.35616500 -0.05781800
     C 4.85522500 1.71734000 0.22325100
     C 5.96987000 2.38879800 -0.31382300
     O 6.88491700 1.74830700 -1.09915200
     C 6.71947900 0.41903200 -1.36430000
     C 5.62682300 -0.30753500 -0.85481400
     C 7.67346300 -0.19823700 -2.15908800
     C 7.56580700 -1.55645700 -2.46709500
     C 6.49405000 -2.28575300 -1.96795600
     C 5.53176100 -1.66610500 -1.16680600
     C 3.96124200 2.44515800 1.01262100
     C 4.17031100 3.80330200 1.26473400
     C 5.27551600 4.45343400 0.73047600
     C 6.17535900 3.73680700 -0.06194800
     C -5.62705300 -0.30735400 -0.85450500
     C -6.71928700 0.41938500 -1.36464300
     O -6.88329900 1.74927200 -1.10167600
     C -5.96897100 2.38946600 -0.31526500
     C -4.85474100 1.71783400 0.22245400
     C -5.53310000 -1.66639800 -1.16475900
     C -6.49610200 -2.28636200 -1.96480800
     C -7.56751800 -1.55693200 -2.46448300
     C -7.67406700 -0.19823400 -2.15820200
     C -6.17456800 3.73743100 -0.06324300
     C -5.27514800 4.45388200 0.72982000
     C -4.17031500 3.80359400 1.26465900
     C -3.96122400 2.44545700 1.01253300
     O -0.00015400 -3.96830000 1.50483700
     O -0.00019500 -2.47109100 3.52665800
     C 0.00020300 -2.64509100 -1.40495400
     C 0.00034300 -0.20466000 -1.86117000
     H 2.41118900 0.06372500 -1.28828500
     H 2.48620300 -2.04935500 3.19547800
     H 4.52498100 -0.84886800 2.31658900
     H -2.41056900 0.06394100 -1.28871700
     H -4.52499700 -0.84831800 2.31586200
     H -2.48649200 -2.04903700 3.19508500
     H 8.50056300 0.41098100 -2.52869800
     H 8.32203900 -2.03354800 -3.09349600
     H 6.39429300 -3.34933700 -2.19485600
     H 4.69465500 -2.24580100 -0.77484200
     H 3.09145400 1.94045700 1.43579900
     H 3.45545900 4.34652000 1.88647900
     H 5.44614600 5.51436800 0.92329600
     H 7.05577600 4.20903800 -0.50207500
     H -4.69625700 -2.24619000 -0.77237400
     H -6.39717200 -3.35029700 -2.19042200
     H -8.32431800 -2.03427800 -3.09000200
     H -8.50081300 0.41112900 -2.52836600
     H -7.05465600 4.20980200 -0.50387800
     H -5.44580600 5.51480700 0.92266800
     H -3.45579100 4.34667900 1.88689800
     H -3.09175200 1.94062000 1.43619700
     H 0.00013000 -3.45332000 -0.66309300
     H 0.89243900 -2.75169300 -2.04060300
     H -0.89196300 -2.75164000 -2.04071100
     H 0.00033500 0.82736500 -1.47979800
     H -0.87501100 -0.33812800 -2.51032400
     H 0.87579000 -0.33816300 -2.51019000
     End Geometry
     Basis
       Def2-TZVP
     Skeleton
     Group
       C(1)
     $end
     
     $bdfopt
     Solver
       1
     MaxCycle
       444
     IOpt
       3
     $end
     
     $xuanyuan
     Direct
     $end
     
     $scf
     RKS
     Charge
       0
     SpinMulti
       1
     DFT
       PBE0
     D3
     Molden
     $end
     
     $tddft
     Imethod
       1
     Isf
       0
     Ialda
       4  
     Idiag
       1
     Iroot
       4
     MPEC+COSX
     Istore
       1
     $end
     
     $resp
     Geom
     Method
       2
     Nfiles
       1
     Iroot
       1
     $end  

.. note::
    For T1 optimization: Change multiplicity to Triplet in the TDDFT panel while keeping other parameters identical to S1 optimization.

Performing BDF Calculation
########################################################
After connecting to a BDF server: Right-click bdf.inp → Run → Verify script → Click "Run". Download the .out result file after completion.

Analyzing Excited State Optimization Results
Open the .out file. Convergence is confirmed when all four Geom.converge values are "YES" (similar to ground state optimization). The energy difference between optimized T1 and S1 gives ΔEST ≈ 2.425 eV.

.. figure:: /TADF-example/T1-S1.png
    :width: 800
    :align: center

Spin-Orbit Coupling Calculation
-------------------------------------------------

Generating Spin-Orbit Coupling Input Files
########################################################
Perform SOC calculation on optimized structures. Select TDDFT-SOC as calculation type with sf-x2c Hamiltonian. Choose relativistic basis sets (e.g., cc-pVDZ-DK). Configure Basic Settings as in Figure 1.5-1, keeping SCF/TDDFT panels at defaults. Click "Generate files".

.. figure:: /TADF-example/fig1.5-1.png
.. centered:: 1.5-1

Generated bdf.inp parameters:

.. code-block:: bdf

     $compass
     Title
       C39H28N2O4S
     Geometry
     C 3.56214999 -0.34631300 0.45361300
     C 2.39970799 -0.43121500 -0.31807500
     C 1.26327600 -1.11500899 0.12738900
     C 1.35885600 -1.69579600 1.40258100
     C 2.49771000 -1.60285400 2.19867100
     C 3.61595699 -0.93278100 1.71813299
     C 0.00021500 -1.24592199 -0.73874600
     C -1.26297700 -1.11486500 0.12717899
     C -1.35882900 -1.69562600 1.40235700
     S -0.00010100 -2.61984500 2.07323099
     C -2.39926700 -0.43096700 -0.31848800
     C -3.56181100 -0.34590900 0.45301500
     C -3.61588999 -0.93235000 1.71754500
     C -2.49780200 -1.60255299 2.19826800
     N 4.68577300 0.35565000 -0.05695800
     N -4.68524700 0.35616500 -0.05781800
     C 4.85522499 1.71734000 0.22325100
     C 5.96987000 2.38879800 -0.31382300
     O 6.88491699 1.74830700 -1.09915199
     C 6.71947899 0.41903200 -1.36430000
     C 5.62682299 -0.30753500 -0.85481400
     C 7.67346299 -0.19823700 -2.15908800
     C 7.56580700 -1.55645700 -2.46709500
     C 6.49404999 -2.28575300 -1.96795600
     C 5.53176100 -1.66610499 -1.16680600
     C 3.96124200 2.44515800 1.01262099
     C 4.17031099 3.80330200 1.26473400
     C 5.27551599 4.45343399 0.73047600
     C 6.17535900 3.73680700 -0.06194800
     C -5.62705300 -0.30735400 -0.85450500
     C -6.71928699 0.41938500 -1.36464300
     O -6.88329900 1.74927200 -1.10167600
     C -5.96897099 2.38946600 -0.31526500
     C -4.85474099 1.71783400 0.22245400
     C -5.53310000 -1.66639800 -1.16475900
     C -6.49610199 -2.28636200 -1.96480800
     C -7.56751799 -1.55693200 -2.46448300
     C -7.67406700 -0.19823400 -2.15820200
     C -6.17456799 3.73743100 -0.06324299
     C -5.27514799 4.45388200 0.72982000
     C -4.17031500 3.80359399 1.26465899
     C -3.96122400 2.44545700 1.01253299
     O -0.00015400 -3.96830000 1.50483700
     O -0.00019500 -2.47109099 3.52665799
     C 0.00020300 -2.64509099 -1.40495400
     C 0.00034300 -0.20466000 -1.86117000
     H 2.41118899 0.06372500 -1.28828499
     H 2.48620300 -2.04935499 3.19547800
     H 4.52498100 -0.84886800 2.31658900
     H -2.41056900 0.06394100 -1.28871699
     H -4.52499699 -0.84831800 2.31586200
     H -2.48649200 -2.04903700 3.19508500
     H 8.50056299 0.41098100 -2.52869799
     H 8.32203900 -2.03354800 -3.09349600
     H 6.39429300 -3.34933699 -2.19485600
     H 4.69465500 -2.24580100 -0.77484200
     H 3.09145400 1.94045700 1.43579900
     H 3.45545899 4.34651999 1.88647900
     H 5.44614599 5.51436800 0.92329600
     H 7.05577599 4.20903799 -0.50207500
     H -4.69625700 -2.24618999 -0.77237400
     H -6.39717200 -3.35029699 -2.19042199
     H -8.32431799 -2.03427800 -3.09000200
     H -8.50081300 0.41112900 -2.52836600
     H -7.05465599 4.20980199 -0.50387800
     H -5.44580600 5.51480700 0.92266800
     H -3.45579100 4.34667899 1.88689800
     H -3.09175200 1.94062000 1.43619699
     H 0.00012999 -3.45332000 -0.66309300
     H 0.89243900 -2.75169300 -2.04060299
     H -0.89196300 -2.75164000 -2.04071099
     H 0.00033500 0.82736500 -1.47979799
     H -0.87501100 -0.33812800 -2.51032400
     H 0.87579000 -0.33816300 -2.51019000
     End Geometry
     Basis
       cc-pVDZ-DK
     Skeleton
     Group
       C(1)
     $end
     
     $xuanyuan
     Heff
       21
     Hsoc
       2
     Direct
     RS
       0.33
     $end
     
     $scf
     RKS
     Charge
       0
     SpinMulti
       1
     DFT
       CAM-B3LYP
     D3
     MPEC+COSX
     Molden
     $end
     
     $tddft
     Imethod
       1
     Isf
       0
     Idiag
       1
     Iroot
       6
     MPEC+COSX
     Istore
       1
     $end
     
     $tddft
     Imethod
       1
     Isf
       1
     Idiag
       1
     Iroot
       6
     MPEC+COSX
     Istore
       2
     $end
     
     $tddft
     Isoc
       2
     Nfiles
       2
     Imatsoc
       -1
     Imatrsf
       -1
     Imatrso
       -1
     $end  



Performing BDF Calculation
########################################################
After connecting to a BDF server: Right-click bdf.inp → Run → Verify script → Click "Run". Download the .out result file after completion.

Spin-Orbit Coupling Matrix Element Analysis
########################################################
Open the .out file. SOC matrix elements are printed under "Print selected matrix elements of [Hsoc]":

.. code-block:: bdf
  
     SocPairNo. =    8   SOCmat = <  0  0  0 |Hso|  2  1  1 >     Dim =    1    3
       mi/mj          ReHso(au)       cm^-1               ImHso(au)       cm^-1
      0.0 -1.0     -0.0000018883     -0.4144393040     -0.0000012470     -0.2736747987
      0.0  0.0      0.0000000000      0.0000000000     -0.0000076582     -1.6807798007
      0.0  1.0     -0.0000018883     -0.4144393040      0.0000012470      0.2736747987
   
     SocPairNo. =    9   SOCmat = <  0  0  0 |Hso|  2  1  2 >     Dim =    1    3
       mi/mj          ReHso(au)       cm^-1               ImHso(au)       cm^-1
      0.0 -1.0      0.0000038630      0.8478326909     -0.0000006073     -0.1332932016
      0.0  0.0      0.0000000000      0.0000000000     -0.0000037537     -0.8238381363
      0.0  1.0      0.0000038630      0.8478326909      0.0000006073      0.1332932016
    ...


Tabulated results:

.. table:: 
    :widths: 30 20 20

    =================  =======  =======
     |SOC| (cm⁻¹)        T1      T2
    =================  =======  =======
           S0           1.822    1.467
           S1           0.522    0.842
    =================  =======  =======

The calculated SOC between S0 and T1 is 1.822 cm⁻¹. If the energy gap is sufficiently small, this facilitates intersystem crossing.
