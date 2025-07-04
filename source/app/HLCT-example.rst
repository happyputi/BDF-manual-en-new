.. _HLCT-example:

Photophysical characterization of blue light HLCT molecules
==========================================================================================

Photophysical characterization of blue light HLCT molecules
==========================================================================================

Organic light-emitting diodes (OLEDs) are widely used in display and lighting, among which light-emitting dyes are the most critical part of OLED devices. When holes and electrons recombine in the light-emitting layer, the luminescent dye molecule is excited to the excited state (Figure 1a). According to exciton statistical rules, this recombination produces 25% singlet excitons and 75% triplet excitons. According to the selection rule, 75% of the triplet excitons are wasted because the triplet to singlet transition of a pure organic system is usually forbidden. Utilizing triplet excitons through appropriate methods is a challenge for the design of OLED luminescent dye molecules.

The hybrid local-charge transfer excited state (HLCT) proposed by Ma Yuguang's group is a luminescence mechanism that can use triplet excitons. By constructing the excited state of :math:'rm S_{1}' with HLCT characteristics, the orbital coupling of :math:'rm T_{n}' - :math:'rm S_{1}' can be increased (El-Sayed rule) to facilitate the anti-system crossing (RISC) of :math:'rm T_{n}' - :math:'rm S_{1}'. In addition, increasing the energy level difference of :math:'rm T_{n}' - :math:'rm T_{1}' and decreasing the energy level difference of :math:'rm T_{n}' - :math:'rm S_{1}' is also beneficial for the anti-system crossing. Linking the donor to the aromatic ring is a common method for constructing HLCT molecules.

Due to the higher energy levels, the photostability of blue light HLCT molecules is generally poor. Py is a class of aromatic rings with high light stability, while diphenylamine (TPA) is a common strong donor fragment. Linking the two with a single bond may be a means of constructing a highly stable blue-light HLCT molecule (Fig. 1b). In this paper, we will investigate whether 4,9-dimethyl-1-N,1-N,6-N,6-N-tetraphenylpyrene-1,6-diamine (2TPA-Py) has the characteristics of blue light HLCT by quantum chemical calculations, and verify the feasibility of the molecular design of donor-π-donor.

.. figure:: /HLCT-example/mechanism.png
    :align: center
.. centered:: Figure 1. (a) Schematic diagram of the electroluminescence mechanism of the HLCT molecule. (b) Molecular structure of 2DPA-Py.

Ground state :math:'rm S_{0}'
----------------------------

Before we can make accurate calculations on the molecule, we need to obtain a reliable ground state structure ( :math:'rm S_{0}' ), that is, structural optimization and vibration analysis of the ground state. Firstly, Gaussian was used to optimize the structure of the ground state of the molecule: math:'rm S_{0}', using the functional B3LYP, the basis group 6-31g**, and considering the dispersion correction. The B3LYP functional was chosen because of its high computational efficiency, low dependence on the accuracy of the integration lattice, and DFT-D3(BJ) dispersion correction to describe possible non-covalent bonding interactions. In addition, because the calculation results are less sensitive to the base set for structural optimization and vibration analysis, the selection of a small base group can save time. The gjf input file is as follows:
.. code-block:: bdf

    %nprocshared=32
    %chk=opt.chk
    #P B3LYP/6-31g** em=GD3BJ opt freq
    
    Title Card Required
    
    0 1
    C         1.23142086399057   -0.01598991339220   -0.21183114910141
    C         2.72871444990389   -0.00550853390551   -0.13727964385924
    C         3.41061821385248   -1.20117932087473   -0.03319288637410
    C         4.79904649004982   -1.26160428059098    0.03464278981730
    N         5.41364048996203   -2.51932450120475    0.15418467741142
    C         4.92747565422558   -3.57250001859245   -0.62664098365207
    C         4.55022212480360   -3.33536995952102   -1.94901522652513
    C         4.05642159683765   -4.36315245643423   -2.72763628208729
    C         3.93617240694700   -5.64193595032452   -2.20823626842045
    C         4.30884346659409   -5.88288539461667   -0.89597870946301
    C         4.79580537663213   -4.85982627352166   -0.10603578378833
    C         6.36147678282021   -2.74991702364612    1.15337779307768
    C         6.31970072442968   -2.03371232006357    2.35000679508950
    C         7.27393251117782   -2.25099389609825    3.32426315813784
    C         8.27590697003017   -3.18766118708190    3.13164605217437
    C         8.32033728954936   -3.90430287118972    1.94668478315316
    C         7.37766488670707   -3.68777915010114    0.96152123805281
    C         5.55426311556430   -0.07485171406329   -0.01954737716259
    C         4.87062379765459    1.16805677077445   -0.07171305294141
    C         3.45350429641720    1.20058735786973   -0.14489187126324
    C         2.81032456952191    2.46548965694624   -0.24263234170365
    C         3.51112662376826    3.62218562784879   -0.20116625218499
    C         4.92681570379474    3.62501895614023   -0.06751464021658
    C         5.61185537735068    2.38194680680533   -0.05584863189100
    C         7.03069025627284    2.34956069156028   -0.03333330974132
    C         7.67833561978987    1.08357530517932   -0.06820637808522
    C         6.97580495150633   -0.07284382674662   -0.05720475575518
    C         7.75357292329654    3.55630546250584    0.00437058511537
    C         7.06657662311645    4.75304774446334    0.04578195006735
    C         5.67683694346796    4.81291513479720    0.02109801284253
    N         5.05364278941578    6.07063412409978    0.08634601203580
    C         4.04430276290905    6.30650817126718    1.02225220987505
    C         4.01813497397634    5.60452422886364    2.22773071875455
    C         3.00342478983393    5.82342539394774    3.13839692752355
    C         2.00692660848240    6.74799998492145    2.87285054139819
    C         2.02998237520816    7.45096162278722    1.67912787314289
    C         3.03391132115340    7.23257419582758    0.75684192709414
    C         5.58014732987927    7.11518216961340   -0.67889062460768
    C         6.04635677519681    6.86001855649965   -1.96924843092115
    C         6.57901675320538    7.88011253315299   -2.73218118328052
    C         6.65054552833193    9.16913005476952   -2.22939545341485
    C         6.19012117760983    9.42795662197789   -0.94876996878721
    C         5.66385569959879    8.41283112869426   -0.17399231367271
    C         9.25252702611257    3.56676709389692    0.02982018386394
    H         0.85832992156275   -1.03632876280351   -0.16904659946900
    H         0.88933685332284    0.43501238502809   -1.14286926646989
    H         0.79789574594339    0.54473304731639    0.61552131117326
    H         2.85548199101679   -2.12853502172196    0.00413662861935
    H         4.64873169324299   -2.33946969900849   -2.35587693447180
    H         3.76953281079583   -4.16566889381519   -3.75015021922513
    H         3.55256748783067   -6.44401899690169   -2.82037387929308
    H         4.20934558011874   -6.87446192152345   -0.47900026581524
    H         5.06879641140089   -5.04938936946588    0.92181407561931
    H         5.53591434202605   -1.30746574426274    2.50753626302272
    H         7.22917194113817   -1.68928048139264    4.24582973230498
    H         9.01732005764785   -3.35753750290448    3.89755908403090
    H         9.10183011620465   -4.63207070344374    1.78327798868360
    H         7.42600935609078   -4.23604224027954    0.03176328355712
    H         1.73842332597976    2.49952836140925   -0.35594215471611
    H         2.99326193531308    4.56447070267168   -0.28988821662774
    H         8.75546098773894    1.04836100119705   -0.10774432599440
    H         7.49820003451026   -1.01601354833581   -0.09649295442825
    H         7.61798445128552    5.68140497373268    0.10650429470265
    H         4.79705375266048    4.88765786929865    2.44212003924378
    H         2.99594325952520    5.27247674972545    4.06748299539966
    H         1.21761156723492    6.91895418257396    3.58905207574990
    H         1.25350653787419    8.16906880804979    1.45894118248852
    H         3.03809992945878    7.76959529262987   -0.18069135423844
    H         5.98545198075639    5.85630503175884   -2.36409915773676
    H         6.93473355133126    7.66838923944818   -3.72993019870071
    H         7.06415340233785    9.96525107867144   -2.82966866197266
    H         6.25071932363493   10.42779312892758   -0.54419248783976
    H         5.32231798384009    8.61698483651345    0.83028525237055
    H         9.62929685852355    3.02395636423240    0.89604599037109
    H         9.62231936463369    4.58813097786218    0.07624892230056
    H         9.65623043406863    3.09668205158134   -0.86638315237225


Gaussian uses four criteria to determine whether the molecular structure is convergent based on four criteria: Force-RMS, Force-Max, Step-RMS, and Step-Max. After the job is finished, open the log output file and find the following keywords

.. code-block:: bdf

             Item               Value     Threshold  Converged?
    Maximum Force            0.000012     0.000450     YES
    RMS     Force            0.000002     0.000300     YES
    Maximum Displacement     0.001298     0.001800     YES
    RMS     Displacement     0.000336     0.001200     YES
    Predicted change in Energy=-5.865194D-09
    Optimization completed.
       -- Stationary point found.

The convergent structure is extracted as the initial structure for subsequent calculations. The following screenshot is a partial capture:

.. code-block:: bdf

                             Standard orientation:                         
 ---------------------------------------------------------------------
 Center     Atomic      Atomic             Coordinates (Angstroms)
 Number     Number       Type             X           Y           Z
 ---------------------------------------------------------------------
      1          6           0        1.565649   -4.134284   -0.176953
      2          6           0        1.643599   -2.628388   -0.152751
      3          6           0        2.886000   -2.003080   -0.112539
      4          6           0        3.020859   -0.613479   -0.088550
      5          7           0        4.325420   -0.044576   -0.036499
      6          6           0        5.278240   -0.466495   -0.995386
      7          6           0        4.884618   -0.626003   -2.332720

When the molecule is at the smallest point of the potential energy plane, there is generally no imaginary frequency (negative frequency). In order to verify the reliability of the structure, the frequency calculations are also checked. In the 'log'' output file, find the following keywords, since the vibrational frequencies are arranged from small to large, observing that the first few frequencies have no imaginary frequency, indicating that the molecule is at the local minimum point of the potential energy surface, and its molecular structure is generally reliable.

.. code-block:: bdf

                      1                      2                      3
                      A                      A                      A
 Frequencies --     12.2419                16.5051                20.1875
 Red. masses --      5.7419                 5.7737                 5.1174
 Frc consts  --      0.0005                 0.0009                 0.0012
 IR Inten    --      0.0197                 0.0135                 1.5193
  Atom  AN      X      Y      Z        X      Y      Z        X      Y      Z
     1   6     0.01   0.00  -0.04    -0.01  -0.00  -0.09    -0.02   0.03  -0.18
     2   6     0.00   0.00  -0.04    -0.01  -0.01  -0.07    -0.02   0.03  -0.12
     3   6     0.00   0.00  -0.03    -0.01  -0.01  -0.06    -0.02   0.03  -0.11
     4   6     0.00   0.00  -0.03    -0.00  -0.01  -0.04    -0.01   0.03  -0.06
     5   7    -0.00   0.01  -0.01    -0.01  -0.01  -0.00    -0.01   0.02  -0.05

absorption spectrum
-----------

The ground state of most organic molecules is a closed shell, usually a singlet state, which is generally denoted by :math:'rm S_{0}'. According to the first law of photochemistry (Stark-Einstein), a molecule needs to absorb a photon to make a single electron jump from an occupied orbital to an unoccupied orbital, and the energy of that photon must be consistent with the energy difference between the ground state and the excited state.

So as long as a molecule is irradiated with light of the right energy, will it absorb photons to reach the excited state of electrons?

In quantum mechanics, it can be deduced from Fermi's Golden Rule that a molecule needs to meet multiple conditions to transition from one state to another, which is called the selection rule. The specific derivation process will not be described here, but it is recommended that readers directly consult the relevant books on optical physics, and here is a brief list of some of the selection rules applicable to pure organic systems:

* Satisfies the Franck-Condon principle, which states that the geometry (nucleus position) of the initial and final state molecules does not change during the electron transition.

If the geometry of the excited state is very different from the ground state, then the geometry of the molecule needs to change when the electron is excited from the lowest vibrational energy level of the ground state to the lowest vibrational energy level of the excited state. However, since the mass of the nucleus is much larger than that of the electrons and cannot keep up with the speed of the electrons, the probability of such excitation is small.

* The electron spin does not change

Under the single-electron approximation, the spin orbit is orthogonally normalized. If the spins before and after the transition are different, the spin overlap integral must be 0, i.e., the transition prohibition. This is the spin selection rule: "Singlet → singlet, triplet→ triplet are allowed; Singlet →triplet, triplet →singlet forbidden".

* Track overlap

There must be overlap of the molecular orbitals before and after the transition, otherwise the dipole moment integral of the electronic transition is 0, that is, the transition is forbidden.

* Orbital symmetry changes

If the molecular orbitals are symmetrical, the orbital symmetry before and after the transition must be different except for the overlapping orbitals. According to the center inversion symmetry, the orbit is divided into g (center symmetry) and u (center antisymmetry), and the specific statement is: "g→u, u→g allowed, u →u, g → g forbidden".

It is often customary to describe the electron transition problem in the form of a transition from an orbital electron to a virtual orbital, such as natural transition orbital (NTO) analysis: the nature of the transition is illustrated by a pair of dominant orbital transition patterns. For the analysis of the electronic structure of the excited state, the time-dependent density functional (TDDFT) calculation is required, and in this case, the excited state selects the M062x functional and the Def2SVP basis group, and calculates 8 states for the singlet state and triplet state, respectively. The choice of the M062x functional is to speculate that the ground state of the molecule may have partial charge transfer (CT) properties. For this class of excited states, if you choose a functional with a lower HF component,
A ghost state (a state that does not exist) may occur. To be on the safe side, choose M062x with a high HF content. Of course, functionals of other HF components such as CAM-B3LYP and ωB97XD can also be used. The key word IOP(9/40=4)'' is to output more orbital information, so that the pair of NTOs that contribute the most to the electron excitation can be found after the MO is transformed into NTO. The gjf input file is as follows:

.. code-block:: bdf

    %nprocshared=32
    %mem=6GB
    %chk=tddft.chk
    #P M062x/Def2SVP TD(nstates=8, 50-50) IOP(9/40=4)
    
    Title Card Required
    
    0 1  
     C                  1.565649   -4.134284   -0.176953
     C                  1.643599   -2.628388   -0.152751
     C                  2.886000   -2.003080   -0.112539
     C                  3.020859   -0.613479   -0.088550
     N                  4.325420   -0.044576   -0.036499
     C                  5.278240   -0.466495   -0.995386
     C                  4.884618   -0.626003   -2.332720
     C                  5.799622   -1.064339   -3.285338
     C                  7.121820   -1.335486   -2.928150
     C                  7.515238   -1.172730   -1.598991
     C                  6.603320   -0.752040   -0.633991
     C                  4.698175    0.744156    1.076980
     C                  4.091832    0.542012    2.325047
     C                  4.427797    1.352319    3.406784
     C                  5.379893    2.362883    3.271786
     C                  5.988191    2.561344    2.030562
     C                  5.647767    1.769732    0.937881
     C                  1.876752    0.211899   -0.120738
     C                  0.588755   -0.407573   -0.126231
     C                  0.473733   -1.832327   -0.148612
     C                 -0.837555   -2.410247   -0.178205
     C                 -1.959943   -1.640762   -0.161854
     C                 -1.876694   -0.212016   -0.120592
     C                 -0.588696    0.407452   -0.126517
     C                 -0.473668    1.832190   -0.149905
     C                  0.837623    2.410088   -0.179888
     C                  1.960009    1.640614   -0.162984
     C                 -1.643530    2.628249   -0.154622
     C                 -2.885933    2.002973   -0.113981
     C                 -3.020804    0.613392   -0.088992
     N                 -4.325380    0.044559   -0.036541
     C                 -4.698230   -0.743314    1.077511
     C                 -4.091928   -0.540291    2.325457
     C                 -4.428022   -1.349755    3.407783
     C                 -5.380213   -2.360326    3.273499
     C                 -5.988485   -2.559645    2.032401
     C                 -5.647934   -1.768883    0.939143
     C                 -5.278162    0.465750   -0.995788
     C                 -4.884527    0.624147   -2.333249
     C                 -5.799513    1.061738   -3.286228
     C                 -7.121702    1.333222   -2.929264
     C                 -7.515137    1.171550   -1.599978
     C                 -6.603236    0.751616   -0.634632
     C                 -1.565577    4.134127   -0.179894
     H                  2.565826   -4.573123   -0.163055
     H                  1.054624   -4.497512   -1.075888
     H                  1.015461   -4.526102    0.685940
     H                  3.789152   -2.604760   -0.095814
     H                  3.860188   -0.404796   -2.611283
     H                  5.478783   -1.182339   -4.316028
     H                  7.834889   -1.669709   -3.674725
     H                  8.537506   -1.389762   -1.303667
     H                  6.910123   -0.642734    0.399820
     H                  3.355698   -0.245579    2.436971
     H                  3.946094    1.182749    4.365139
     H                  5.642450    2.988231    4.118776
     H                  6.724707    3.349483    1.905053
     H                  6.110094    1.939850   -0.027830
     H                 -0.934317   -3.489037   -0.217496
     H                 -2.937842   -2.104213   -0.185630
     H                  0.934386    3.488850   -0.219935
     H                  2.937915    2.104041   -0.187063
     H                 -3.789080    2.604673   -0.097685
     H                 -3.355727    0.247315    2.436831
     H                 -3.946346   -1.179515    4.366033
     H                 -5.642871   -2.985014    4.120945
     H                 -6.725084   -3.347795    1.907449
     H                 -6.110250   -1.939666   -0.026456
     H                 -3.860104    0.402673   -2.611627
     H                 -5.478667    1.178888   -4.317013
     H                 -7.834757    1.666861   -3.676114
     H                 -8.537402    1.388848   -1.304838
     H                 -6.910046    0.643140    0.399265
     H                 -1.015334    4.526556    0.682686
     H                 -2.565752    4.572979   -0.166245
     H                 -1.054607    4.496714   -1.079120

After the job is completed, the energy level of the low excited state is plotted according to the excited energy. It can be seen that the energy level difference between the :math:'rm S_{1}' state and the :math:'rm T_{2}' and :math:'rm T_{3}' states is small, and if the rotary-orbit coupling matrix element is large, there is a possibility of inter-system channeling and anti-system channeling.

.. figure:: /HLCT-example/fig3.2-1.png
:target: 3.2-1

The strength of the transition between two states can be measured by the oscillator strength, which is a dimensionless quantity. The expression for the oscillator intensity of the |i> → |j> transition in atomic units is
.. math::
    f_{ij} = 2/3(E_{j}-E_{i})|<i|-r|j>|^2

where

.. math::
    <i|-r|j>≡∫\varphi_{i}(r)(-r)\varphi_{j}(r)dr

where :math:'rm E_{j}' and :math:'rm E_{i}' are the energies of the two states, respectively. The greater the oscillator strength between the ground state and an excited state, the easier it is to absorb electromagnetic waves of the corresponding frequency and transition to that excited state, and the stronger the corresponding absorption peak in the absorption spectrum. In general, an oscillator strength of less than 0.001 can be considered a transition prohibition.

The low excited state excitation energy, oscillator strength, and transition dipole moment are shown in the table.

.. table:: 
    :widths: auto


    ============ ============== ============ ======================
Excited state Excitation energy/eV oscillator strength Transition dipole moment/Debye
    ============ ============== ============ ======================
      S1           3.1509         0.6012          19.7948        
      T1           2.1539         0.0000           0.0000        
      T2           3.2507         0.0000           0.0000        
    ============ ============== ============ ======================

The absorption spectra plotted are as follows.

.. figure:: /HLCT-example/fig3.2-2.png
   :target: 3.2-2

Convert the chk file to the fchk file. Render NTO tracks with Multiwfn VMD.

.. figure:: /HLCT-example/fig3.2-3.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.2-4.png
    :width: 320
    :align: right


.. centered::  :math:`\rm S_{0}` → :math:`\rm S_{1}` The NTO contribution to the transition with the largest contribution is 96.40%.

.. figure:: /HLCT-example/fig3.2-5.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.2-6.png
    :width: 320
    :align: right


.. centered::  :math:`\rm S_{0}` → :math:`\rm T_{1}` The NTO contribution to the transition with the largest contribution was 95.52%.

.. figure:: /HLCT-example/fig3.2-7.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.2-8.png
    :width: 320
    :align: right


.. centered::  :math:`\rm S_{0}` → :math:`\rm T_{2}`The NTO contribution to the transition was 86.41%.

.. figure:: /HLCT-example/fig3.2-9.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.2-10.png
    :width: 320
    :align: right


.. centered::  :math:`\rm S_{0}` → :math:`\rm T_{3}` 跃迁贡献最大的NTO对贡献值为62.93%。

As can be seen from the diagram, the :math:'rm T_{1}' and :math:'rm T_{3}' states are typical local excitation (LE), while the :math:'rm S_{1}' and :math:'rm T_{2}' states have both charge transfer and local excitation components, which belong to the HLCT state.

Excited state :math:'rm S_{1}' optimization
-------------------------------

Fluorescence is a cold light phenomenon that generally refers to the radiation process that occurs between spin singlet states. According to the Kasha rule, it is the emission from the lowest excited state to the ground state, which is generally from the :math:'rm S_{1}' state to the :math:'rm S_{0}' state. In order to simulate the fluorescence process, it is also necessary to optimize the structure and frequency of the excited state :math:'rm S_{1}', and obtain the ''log'' file and ''fchk'' file to prepare for the subsequent MOMAP calculation. The functional and base groups are M062x and Def2SVP, respectively, and the ''gjf'' file is as follows:

.. code-block:: bdf

    %nprocshared=32
    %mem=6GB
    %chk=s1opt.chk
    #P opt freq M062x/Def2SVP TD(nstates=3,root=1)
    
    Title Card Required
    
    0 1  
     C                  1.565649   -4.134284   -0.176953
     C                  1.643599   -2.628388   -0.152751
     C                  2.886000   -2.003080   -0.112539
     C                  3.020859   -0.613479   -0.088550
     N                  4.325420   -0.044576   -0.036499
     C                  5.278240   -0.466495   -0.995386
     C                  4.884618   -0.626003   -2.332720
     C                  5.799622   -1.064339   -3.285338
     C                  7.121820   -1.335486   -2.928150
     C                  7.515238   -1.172730   -1.598991
     C                  6.603320   -0.752040   -0.633991
     C                  4.698175    0.744156    1.076980
     C                  4.091832    0.542012    2.325047
     C                  4.427797    1.352319    3.406784
     C                  5.379893    2.362883    3.271786
     C                  5.988191    2.561344    2.030562
     C                  5.647767    1.769732    0.937881
     C                  1.876752    0.211899   -0.120738
     C                  0.588755   -0.407573   -0.126231
     C                  0.473733   -1.832327   -0.148612
     C                 -0.837555   -2.410247   -0.178205
     C                 -1.959943   -1.640762   -0.161854
     C                 -1.876694   -0.212016   -0.120592
     C                 -0.588696    0.407452   -0.126517
     C                 -0.473668    1.832190   -0.149905
     C                  0.837623    2.410088   -0.179888
     C                  1.960009    1.640614   -0.162984
     C                 -1.643530    2.628249   -0.154622
     C                 -2.885933    2.002973   -0.113981
     C                 -3.020804    0.613392   -0.088992
     N                 -4.325380    0.044559   -0.036541
     C                 -4.698230   -0.743314    1.077511
     C                 -4.091928   -0.540291    2.325457
     C                 -4.428022   -1.349755    3.407783
     C                 -5.380213   -2.360326    3.273499
     C                 -5.988485   -2.559645    2.032401
     C                 -5.647934   -1.768883    0.939143
     C                 -5.278162    0.465750   -0.995788
     C                 -4.884527    0.624147   -2.333249
     C                 -5.799513    1.061738   -3.286228
     C                 -7.121702    1.333222   -2.929264
     C                 -7.515137    1.171550   -1.599978
     C                 -6.603236    0.751616   -0.634632
     C                 -1.565577    4.134127   -0.179894
     H                  2.565826   -4.573123   -0.163055
     H                  1.054624   -4.497512   -1.075888
     H                  1.015461   -4.526102    0.685940
     H                  3.789152   -2.604760   -0.095814
     H                  3.860188   -0.404796   -2.611283
     H                  5.478783   -1.182339   -4.316028
     H                  7.834889   -1.669709   -3.674725
     H                  8.537506   -1.389762   -1.303667
     H                  6.910123   -0.642734    0.399820
     H                  3.355698   -0.245579    2.436971
     H                  3.946094    1.182749    4.365139
     H                  5.642450    2.988231    4.118776
     H                  6.724707    3.349483    1.905053
     H                  6.110094    1.939850   -0.027830
     H                 -0.934317   -3.489037   -0.217496
     H                 -2.937842   -2.104213   -0.185630
     H                  0.934386    3.488850   -0.219935
     H                  2.937915    2.104041   -0.187063
     H                 -3.789080    2.604673   -0.097685
     H                 -3.355727    0.247315    2.436831
     H                 -3.946346   -1.179515    4.366033
     H                 -5.642871   -2.985014    4.120945
     H                 -6.725084   -3.347795    1.907449
     H                 -6.110250   -1.939666   -0.026456
     H                 -3.860104    0.402673   -2.611627
     H                 -5.478667    1.178888   -4.317013
     H                 -7.834757    1.666861   -3.676114
     H                 -8.537402    1.388848   -1.304838
     H                 -6.910046    0.643140    0.399265
     H                 -1.015334    4.526556    0.682686
     H                 -2.565752    4.572979   -0.166245
     H                 -1.054607    4.496714   -1.079120

After the job is completed, find the last excited state in the log file 1 is :math:'rm S_{1}' excitation energy, and Total Energy is the electronic state energy.

.. code-block:: bdf

     Excited State   1:      Singlet-A      2.7938 eV  443.79 nm  f=0.8006  <S**2>=0.000
     149 ->150         0.69410
     This state for optimization and/or second-order correction.
     Total Energy, E(TD-HF/TD-DFT) =  -1727.22867894    
     Copying the excited state density for this state as the 1-particle RhoCI density.

Excitted state :math:`\rm T_{2}` 、 :math:`\rm T_{3}` optimize
-------------------------------------------——————————————————————————————————————————————————————————————

Since MOMAP will be used to calculate the inter-system crossing rate of :math:'rm T_{2}' → :math:'rm S_{1}' states and :math:'rm T_{3}' → :math:'rm S_{1}' states in the early stage, it is also necessary to optimize the structure and frequency calculation of excited states :math:'rm T_{2}' and :math:'rm T_{3}' to obtain 'log'' files and '' FCHK'' file. The functional and base groups are M062x and Def2SVP, respectively, and the T2.gjf file is as follows:

.. code-block:: bdf

    %nprocshared=32
    %mem=6GB
    %chk=t2.chk
    #P opt freq M062x/Def2SVP TD(triplets,nstates=6,root=2)
    
    Title Card Required
    
    0 1  
     C                  1.565649   -4.134284   -0.176953
     C                  1.643599   -2.628388   -0.152751
     C                  2.886000   -2.003080   -0.112539
     C                  3.020859   -0.613479   -0.088550
     N                  4.325420   -0.044576   -0.036499
     C                  5.278240   -0.466495   -0.995386
     C                  4.884618   -0.626003   -2.332720
     C                  5.799622   -1.064339   -3.285338
     C                  7.121820   -1.335486   -2.928150
     C                  7.515238   -1.172730   -1.598991
     C                  6.603320   -0.752040   -0.633991
     C                  4.698175    0.744156    1.076980
     C                  4.091832    0.542012    2.325047
     C                  4.427797    1.352319    3.406784
     C                  5.379893    2.362883    3.271786
     C                  5.988191    2.561344    2.030562
     C                  5.647767    1.769732    0.937881
     C                  1.876752    0.211899   -0.120738
     C                  0.588755   -0.407573   -0.126231
     C                  0.473733   -1.832327   -0.148612
     C                 -0.837555   -2.410247   -0.178205
     C                 -1.959943   -1.640762   -0.161854
     C                 -1.876694   -0.212016   -0.120592
     C                 -0.588696    0.407452   -0.126517
     C                 -0.473668    1.832190   -0.149905
     C                  0.837623    2.410088   -0.179888
     C                  1.960009    1.640614   -0.162984
     C                 -1.643530    2.628249   -0.154622
     C                 -2.885933    2.002973   -0.113981
     C                 -3.020804    0.613392   -0.088992
     N                 -4.325380    0.044559   -0.036541
     C                 -4.698230   -0.743314    1.077511
     C                 -4.091928   -0.540291    2.325457
     C                 -4.428022   -1.349755    3.407783
     C                 -5.380213   -2.360326    3.273499
     C                 -5.988485   -2.559645    2.032401
     C                 -5.647934   -1.768883    0.939143
     C                 -5.278162    0.465750   -0.995788
     C                 -4.884527    0.624147   -2.333249
     C                 -5.799513    1.061738   -3.286228
     C                 -7.121702    1.333222   -2.929264
     C                 -7.515137    1.171550   -1.599978
     C                 -6.603236    0.751616   -0.634632
     C                 -1.565577    4.134127   -0.179894
     H                  2.565826   -4.573123   -0.163055
     H                  1.054624   -4.497512   -1.075888
     H                  1.015461   -4.526102    0.685940
     H                  3.789152   -2.604760   -0.095814
     H                  3.860188   -0.404796   -2.611283
     H                  5.478783   -1.182339   -4.316028
     H                  7.834889   -1.669709   -3.674725
     H                  8.537506   -1.389762   -1.303667
     H                  6.910123   -0.642734    0.399820
     H                  3.355698   -0.245579    2.436971
     H                  3.946094    1.182749    4.365139
     H                  5.642450    2.988231    4.118776
     H                  6.724707    3.349483    1.905053
     H                  6.110094    1.939850   -0.027830
     H                 -0.934317   -3.489037   -0.217496
     H                 -2.937842   -2.104213   -0.185630
     H                  0.934386    3.488850   -0.219935
     H                  2.937915    2.104041   -0.187063
     H                 -3.789080    2.604673   -0.097685
     H                 -3.355727    0.247315    2.436831
     H                 -3.946346   -1.179515    4.366033
     H                 -5.642871   -2.985014    4.120945
     H                 -6.725084   -3.347795    1.907449
     H                 -6.110250   -1.939666   -0.026456
     H                 -3.860104    0.402673   -2.611627
     H                 -5.478667    1.178888   -4.317013
     H                 -7.834757    1.666861   -3.676114
     H                 -8.537402    1.388848   -1.304838
     H                 -6.910046    0.643140    0.399265
     H                 -1.015334    4.526556    0.682686
     H                 -2.565752    4.572979   -0.166245
     H                 -1.054607    4.496714   -1.079120

After the job is completed, find the last excited state in the log file 2 is :math:'rm T_{2}' excited energy, and Total Energy is the electronic state energy.

.. code-block:: bdf

     Excited State   2:      Triplet-A      3.0388 eV  408.01 nm  f=0.0000  <S**2>=2.000
     138 ->150        -0.14038
     148 ->150         0.61959
     149 ->155         0.16846
     149 ->157        -0.14448
     This state for optimization and/or second-order correction.
     Total Energy, E(TD-HF/TD-DFT) =  -1727.22151297    
     Copying the excited state density for this state as the 1-particle RhoCI density.

Similarly, optimizing :math:'rm T_{3}' yields the energy of the :math:'rm T_{3}' state. The results show that the energy of the electronic state of :math:'rm T_{3}' is less than that of the :math:'rm T_{2}' state, which means that the energy of the :math:'rm T_{2}' and :math:'rm T_{3}' states may cross in the process of optimization away from the Frank-Condon zone, so that the energy of the final optimized :math:'rm T_{3}' minimum point is less than that of :math:'rm T_{2}'.
.. code-block:: bdf

     Excited State   3:      Triplet-A      2.9283 eV  423.40 nm  f=0.0000  <S**2>=2.000
     149 ->151         0.67322
     149 ->155         0.11403
     This state for optimization and/or second-order correction.
     Total Energy, E(TD-HF/TD-DFT) =  -1727.22240086    
     Copying the excited state density for this state as the 1-particle RhoCI density.

Spin orbit coupling
----------------

Spin-orbit coupling (SOC) reflects the interaction between the spin of an electron and the rotation of an electron around the nucleus. When calculating the transitions between the singlet and triplet states, if the spin-orbit coupling is not considered (i.e., the coupling is strictly 0), then their transitions are forbidden. However, when the rotary-orbit coupling is introduced into the Hamiltonian, the coupling between the two states is not strictly 0, and the transition between the singlet and triplet states is possible. We tend to be concerned with the spin-orbit coupling between the :math:'rm S_{i}' state and the :math:'rm T_{j}' state in a particular structure. where :math:'rm <S_{i}|SOC|T_{j}>' denotes the spin-orbit coupling matrix element, which is measured by its modulus to measure the size of the spin-orbit coupling between the :math:'rm S_{i}' and :math:'rm T_{j}' electronic states. This physical quantity can also be used to calculate the intersystem crossing (ISC) rate and the reverse intersystem crossing (RISC) rate.

In this example, BDF is used to calculate the spin-orbit coupling matrix element between the :math:'rm S_{1}' - :math:'rm T_{2}' and :math:'rm S_{1}-T_{3}' states, using the M062x functional, Def2SVP basis set, and the ''inp'' file is as follows:

.. code-block:: bdf

    $compass
    Title
      C42H32N2
    Geometry
     C                  1.586003   -4.127364   -0.277679
     C                  1.687147   -2.632259   -0.222611
     C                  2.912299   -2.005731   -0.177241
     C                  3.045692   -0.604559   -0.100709
     N                  4.333135   -0.047256   -0.013973
     C                  5.334680   -0.519389   -0.889609
     C                  5.015755   -0.759732   -2.235838
     C                  5.984347   -1.247032   -3.105784
     C                  7.281444   -1.498204   -2.653995
     C                  7.598599   -1.262567   -1.315545
     C                  6.635646   -0.783602   -0.432749
     C                  4.653716    0.850763    1.024080
     C                  3.972142    0.778096    2.248981
     C                  4.252686    1.694201    3.257436
     C                  5.214213    2.687133    3.070218
     C                  5.894013    2.759318    1.852004
     C                  5.615474    1.857669    0.831601
     C                  1.878302    0.232663   -0.125495
     C                  0.592246   -0.400870   -0.142073
     C                  0.488519   -1.828638   -0.190107
     C                 -0.793696   -2.412608   -0.223962
     C                 -1.944019   -1.641486   -0.186177
     C                 -1.878300   -0.232665   -0.125495
     C                 -0.592244    0.400868   -0.142073
     C                 -0.488517    1.828637   -0.190108
     C                  0.793698    2.412606   -0.223963
     C                  1.944022    1.641485   -0.186177
     C                 -1.687145    2.632258   -0.222613
     C                 -2.912297    2.005730   -0.177243
     C                 -3.045690    0.604558   -0.100710
     N                 -4.333133    0.047256   -0.013974
     C                 -4.653717   -0.850761    1.024079
     C                 -3.972142   -0.778097    2.248980
     C                 -4.252689   -1.694201    3.257435
     C                 -5.214220   -2.687128    3.070218
     C                 -5.894022   -2.759311    1.852005
     C                 -5.615479   -1.857663    0.831601
     C                 -5.334678    0.519389   -0.889611
     C                 -5.015753    0.759734   -2.235839
     C                 -5.984345    1.247034   -3.105785
     C                 -7.281443    1.498203   -2.653996
     C                 -7.598599    1.262562   -1.315546
     C                 -6.635645    0.783598   -0.432750
     C                 -1.586001    4.127363   -0.277682
     H                  2.581935   -4.588013   -0.284388
     H                  1.048934   -4.459802   -1.181513
     H                  1.027774   -4.525258    0.585788
     H                  3.824462   -2.607245   -0.175768
     H                  4.002023   -0.553508   -2.582465
     H                  5.725422   -1.423160   -4.150923
     H                  8.039250   -1.878188   -3.339953
     H                  8.605471   -1.467565   -0.948393
     H                  6.879710   -0.616710    0.617096
     H                  3.223855   -0.001794    2.394755
     H                  3.715870    1.625084    4.204829
     H                  5.431113    3.401551    3.864968
     H                  6.641732    3.536971    1.688418
     H                  6.130708    1.931595   -0.127046
     H                 -0.888701   -3.496890   -0.277700
     H                 -2.914627   -2.134719   -0.218301
     H                  0.888703    3.496889   -0.277701
     H                  2.914629    2.134717   -0.218301
     H                 -3.824459    2.607244   -0.175771
     H                 -3.223853    0.001791    2.394754
     H                 -3.715872   -1.625085    4.204828
     H                 -5.431123   -3.401546    3.864969
     H                 -6.641744   -3.536960    1.688420
     H                 -6.130714   -1.931587   -0.127046
     H                 -4.002021    0.553512   -2.582466
     H                 -5.725421    1.423163   -4.150924
     H                 -8.039249    1.878187   -3.339954
     H                 -8.605471    1.467558   -0.948395
     H                 -6.879709    0.616703    0.617094
     H                 -1.027772    4.525257    0.585785
     H                 -2.581933    4.588012   -0.284392
     H                 -1.048931    4.459800   -1.181516
    End Geometry
    Basis
      Def2-SVP
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
      M062X
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
      3
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
      3
    MPEC+COSX
    Istore
      2
    $end
    
    $tddft
    Isoc
      2
    Nfiles
      2
    Ifgs
      1
    Imatsoc
      2
    1 1 1 2 1 2
    1 1 1 2 1 3
    $end

After the job is completed, the following keywords are found in the ''out' output file, which is the rotary-orbit coupling matrix element result

.. code-block:: bdf

     [tddft_soc_matsoc]
     
      Print selected matrix elements of [Hsoc] 
     
      SocPairNo. =    1   SOCmat = <  1  1  1 |Hso|  2  1  2 >     Dim =    1    3
        mi/mj          ReHso(au)       cm^-1               ImHso(au)       cm^-1
       0.0 -1.0     -0.0000031365     -0.6883766845      0.0000019744      0.4333410617
       0.0  0.0      0.0000000000      0.0000000000     -0.0000000001     -0.0000289692
       0.0  1.0     -0.0000031365     -0.6883766845     -0.0000019744     -0.4333410617
     
      SocPairNo. =    2   SOCmat = <  1  1  1 |Hso|  2  1  3 >     Dim =    1    3
        mi/mj          ReHso(au)       cm^-1               ImHso(au)       cm^-1
       0.0 -1.0     -0.0000000002     -0.0000481328      0.0000000002      0.0000411125
       0.0  0.0      0.0000000000      0.0000000000     -0.0000069588     -1.5272872617
       0.0  1.0     -0.0000000002     -0.0000481328     -0.0000000002     -0.0000411125

Here :math:'rm SOCmat=<1 1 1 |H_{SO}| 2 1 2>' represents the matrix element :math:'rm <S_{1}| H_{SO} |T_{2}>' , ReHso and ImHso represent the real and imaginary parts, respectively, in au or :math:'rm cm^{-1}'. After summing the modulus squares of the SOC matrix elements of the three mj components, and then opening the square to obtain the coupling matrix element of the :math:'rm S_{1}' state and the :math:'rm T_{2}' state of the subsequent MOMAP, that is, 1.15035 :math:'rm cm^{-1}'; :math:'rm S_{1}' state and :math:'rm T_{3}' state spin-orbit coupling matrix element 1.52729 :math:'rm cm^{-1}'.

Reforming energy
---------

The reforming energy refers to the change in the energy of the system due to the relaxation of the geometric structure when the molecule gains and loses electrons. It is not only a key physical quantity that affects the electron transfer rate (based on the Marcus theory), but also an important factor affecting the spectral spectrum and radiation rate. Specifically, the energy difference between the initial and final states of a molecule is the reforming energy of the ground state and the excited state, respectively: math:'lambda_{S0}=E_{3}-E_{1}' , :math:'lambda_{S1}=E_{2}-E_{4}'.

.. figure::  /HLCT-example/fig3.6-1.png

Reforming energy can also be defined as:

.. math::
      \lambda_{k} = S_{k}ћω_{k} = 1/2ω_{k}^2 D_{k}^2

where :math:'rm S_k' and :math:'rm ω_k' are the Huang−Rhys factor and frequency of the k-th mode, respectively, and D is the mode shift.
 
Huang Kun factor

.. math::
     S_k=ω_{k}/2ћ * D_{k}^2
     
The input files require the structural optimization and frequency calculation log files and fchk files of :math:'rm S_0' and :math:'rm S_1', as well as the momap.inp' file and the momap.inp file, as follows:

.. code-block:: bdf

    do_evc            = 1

    &evc
      ffreq(1)      = "s0.log"
      ffreq(2)      = "s1.log"
      set_cart = t
    /

After the job is completed, the evc.cart.dat' file is generated, and the following keywords are found to be the restructure energy of :math:'rm S_0' and :math:'rm S_1'. As shown in the figure below, :math:'lambda_{S0} = 1610.605 cm^{−1}' , :math:'lambda_{S1} = 1864.085 cm^{−1}', that is, the ground state and excited state reforming energies are not much different, indicating that the two state configurations are not much different and belong to the same Franck-Condon region.

.. code-block:: bdf

      Total reorganization energy      (cm-1):         1610.605075       1864.085048

Opening the evc.cart.dat file in Device Studio gives the :math:'rm S_0 state and the :math:rm S_1 state rewhole energy and the contribution of the Huang Kun factor in each vibration mode.

.. figure:: /HLCT-example/fig3.6-2.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.6-3.png
    :width: 320
    :align: right

.. figure:: /HLCT-example/fig3.6-4.png
    :width: 320
    :align: left
.. figure:: /HLCT-example/fig3.6-5.png
    :width: 320
    :align: right

The vibration modes are analyzed, and it is found that the main contribution of the recombination energy of the :math:'rm S_{0}' state comes from the high-frequency C-C telescopic vibration of 1676.69 :math:'rm cm^{-1}' and the high-frequency bending vibration of 1308.32 :math:'rm cm^{-1}', and the main contribution of the recombination energy of the :math:'rm S_1' state comes from 1683.31 :math:'rm cm^{-1}' and 1695.91 : Math:'rm cm^{-1}' and 1414.86:math:'rm cm^{-1}'. The maximum mode of the Huangkun factor in the :math:'rm S_{0}' state is 12.24 :math:'rm cm^{-1}', and the maximum mode of the Huangkun factor in the S1 state is 18.30 :math:'rm cm^{-1}'.

In the photophysical process of molecules, the Duschinsky rotation effect caused by the overlap between the regular modes of the transition initial state and the final state will also have an important impact on the spectrum and rate, the 3N-6 regular coordinates obtained at the S0 and S1 minima are different, and they are linear transformation relations with each other, which can be expressed as Q''=J*Q' ΔQ, where Q' and Q'' represent the regular modes at the two electronic minima respectively, J is called the Duschinsky matrix. Open the evc.cart.abs file in Device Studio to get a 2D plot of the Duschinsky rotation matrix between the S0 and S1 states.

.. figure:: /HLCT-example/fig3.6-6.png

Fluorescence spectroscopy
-----------

The calculation of the fluorescence radiation rate with MOMAP requires the results of the previous step "evc.cart.dat'" and the new input files "momap.inp" and "momap.inp" which are as follows:

.. code-block:: bdf

    do_spec_tvcf_ft   = 1
    do_spec_tvcf_spec = 1
    
    &spec_tvcf
      DUSHIN        = .t.
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs
      Ead           = 0.09626 au
      EDMA          = 8.18309 debye
      EDME          = 9.64296 debye
      FreqScale     = 1.0
      DSFile        = "evc.cart.dat"
      Emax          = 0.3 au
      dE            = 0.00001 au
      logFile       = "spec.tvcf.log"
      FtFile        = "spec.tvcf.ft.dat"
      FoFile        = "spec.tvcf.fo.dat"
      FoSFile       = "spec.tvcf.spec.dat"
    /

For the adiabatic excitation energy Ead, since Gaussian uses different calculation levels to calculate :math:'rm S_0 and :math:'rm S_1', we use the structure of :math:'rm S_1' to do a single point calculation at the calculation level of :math:'rm S_0' for correction: with this energy - :math:'rm S_0' energy :math:'rm S_1' The excitation energy yields the adiabatic excitation energy, i.e., Ead=0.09626 au. For the absorption transition dipole moment EDMA, read the first ground state to the excited state transition electric dipole moment Dip.S. from the S1.log file, and convert the root number and units to obtain 8.18309 debye. For the emission transition dipole moment EDME, 9.64296 debye is obtained by reading the last ground state to the excited state transition electric dipole moment Dip.S. from the S1.log file, and the root number is converted into units. (The results of Ead, EDMA and EDME were obtained under the condition of adding benzene solvent (scrf(solvent=benzene, SMD)) to simulate the thin film environment).

After the job is completed, the radiation rate can be read at the end of the spec.tvcf.log file, in this case :math:'rm S_1' → :math:'rm S_0' The radiation rate is :math:'rm 1.77 times 10^8 s^{-1}' and the fluorescence lifetime is 5.64 ns.

.. code-block:: bdf

      I^-1 =     3.05463233E+00 Hartree =    6.70414303E+05 cm-1 =   8.31208105E+01 eV

    radiative rate     (0):     4.28614462E-09    1.77195105E+08 /s,       5.64 ns

Open the spec.tvcf.spec.dat file in Device Studio to obtain the absorption and emission spectra, as shown below, with the absorption at 388 nm and the emission at 497 nm.

.. figure:: /HLCT-example/fig3.7-1.png

The rate of inter-system channeling
---------------

Intersystem channeling is an important radiation-free process in photochemistry. It refers to the fact that after the molecule is excited, due to the intersection between the potential energy surfaces of states with different spin multiplicities, the spin multiplicity changes in a non-radiative way when the system undergoes such a structure. In general organic systems, RISC refers to the transition from a single to a triplet state, and reverse RISC refers to the transition from a triplet to a singlet state. The inter-system crossing rate, e.g. :math:'rm S_0 → t_2', is also related to their energy level difference :math:'Delta E_{ST}'. Here :math:'Delta E_{ST}' can be obtained by subtracting the excited state energy of :math:'rm S_{1}' from the excited state energy of :math:'rm T_{2}'. Calculate :math:'rm S_1 - T_2' state :math:'Delta E_{ST}' =0.05518 au, :math:'rm S_1 - T_3' state :math:'Delta E_{ST}' =0.05528 au.

In order to calculate the inter-system channeling rate in the MOMAP program, you first need to calculate the electronic vibration coupling of :math:'rm S_1' and :math:'rm T_2', the file needs the log frequency calculation files of :math:'rm S_1' and :math:'rm T_2' and the fchk file, as well as the momap.inp input file, and the momap.inp file as follows:

.. code-block:: bdf

    do_evc            = 1

    &evc
      ffreq(1)      = "s1.log"
      ffreq(2)      = "t2.log"
      set_cart = t
    /

After the job is completed, the generated evc.cart.dat file is placed in the same directory as the new momap.inp file to calculate the non-radiometric rate. The input file ''momap.inp'' is as follows:

.. code-block:: bdf

    do_isc_tvcf_ft   = 1
    do_isc_tvcf_spec = 1
    
    &isc_tvcf
       DUSHIN    = .t.
       Temp      = 298 K
       tmax      = 1500 fs
       dt        = 1 fs
       Ead       = 0.05518 au
       Hso       = 1.15035 cm-1
       DSFile    = "evc.cart.dat"
       Emax      = 0.3 au
       logFile   = "isc.tvcf.log"
       FtFile    = "isc.tvcf.ft.dat"
       FoFile    = "isc.tvcf.fo.dat"
    /

Ead is :math:'Delta E_{ST}' , :math:'rm H_{SO}' is the :math:'rm S_1' state and :math:'rm T_2' state spin-orbit coupling matrix element, and the calculated isc.tvcf.log file ends with the intersystem channeling rate and the anti-system channeling rate, in this case :math:'rm k_{ISC} = 4.53 times 10^4 s^{-1}' , :math :`k_{RISC} = 1.48 times 10^2 s^{-1}`` 。

.. code-block:: bdf

    #         Intersystem crossing Ead is      0.0551800 au, rate is    4.53103856E+04 s-1, lifetime is    2.20699954E-05 s
    # Reverse Intersystem crossing Ead is     -0.0551800 au, rate is    1.47691362E+02 s-1, lifetime is    6.77087667E-03 s

Similarly, the inter-system crossing rate between the :math:'rm S_1' state and the :math:'T_3' state is :math:'rm k_{ISC} = 8.75 times 10^7 s^{-1}' and the anti-system crossing rate :math:'rm k_{ISC} = 1.32 times 10^7 s^{-1}'.

.. code-block:: bdf

    #         Intersystem crossing Ead is      0.0552800 au, rate is    8.75255907E+07 s-1, lifetime is    1.14252300E-08 s
    # Reverse Intersystem crossing Ead is     -0.0552800 au, rate is    1.31729899E+07 s-1, lifetime is    7.59129104E-08 s

Through calculation, we find that the anti-system crossing rate between the :math:'rm T_2' state and the :math:'rm S_1' state is very small, which does not meet the requirements of HLCT molecules. The anti-system crossing rate from the :math:'rm T_3' state to the :math:'rm S_1' state is large, indicating that the triplet exciton may undergo anti-system crossing in the :math:'rm T_3' state and transform into the :math:'rm S_1' state.

conclusion
--------

In this paper, based on the DFT and TDDFT theories, the excited photophysical processes of 2TPA-Py molecules are calculated. The results show that the :math:'rm S_1' state of 2TPA-Py molecule has the characteristics of HLCT, and its maximum emission wavelength is sky blue at 497 nm. The inter-anti-transparency rate of :math:'rm T_3 → S_1' of this molecule is as high as :math:'4.39 times 106 s^{-1}', which basically satisfies the requirement of utilizing triplet excitons through anti-inter-transgression. It can be seen that the molecular design strategy of donor-π-donor is expected to be an effective means to construct high-stability blue light HLCT molecules.
