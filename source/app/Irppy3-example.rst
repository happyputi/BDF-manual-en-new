.. _Irppy3-example:

Theoretical Investigation of Phosphorescence Emission Mechanism in Ir(ppy)₃
==============================================

Since phosphorescent materials were applied to OLEDs, research on organic light-emitting devices based on phosphorescence mechanisms has developed rapidly, including representative red, green, and blue monochromatic phosphorescent devices and full-phosphorescent white OLEDs. Due to spin-forbidden transitions, phosphorescence quantum yields are generally much lower than fluorescence. Therefore, methods such as the heavy atom effect are typically employed to enhance phosphorescence quantum yield. When heavy atoms are introduced, spin-orbit coupling strengthens, making the forbidden triplet-to-singlet transitions allowed. This significantly reduces the time molecules remain in the triplet state and greatly improves the internal quantum efficiency of devices. Commonly used heavy metal atoms include Ir, Pt, Re, Os, Cu, etc.

Phosphorescent materials should generally possess good photothermal stability, large molecular absorption cross-sections, high intersystem crossing ability, high phosphorescence quantum yields at room temperature, and short triplet lifetimes. Since green phosphorescent materials are easiest to obtain among organic materials, research began with phosphorescent green OLEDs. Among them, Ir(ppy)₃ is the most representative material and has been widely used in phosphorescent devices. The phosphorescence emission rate is an important parameter in luminescence mechanism research. This article will use Ir(ppy)₃ as an example to calculate its phosphorescence emission rate using BDF and MOMAP software. First, structural optimization, frequency calculation, and spin-orbit coupling calculation need to be performed using BDF quantum software. Then, based on BDF's structural optimization and frequency calculation result files, and spin-orbit coupling calculation result files, MOMAP software will be used to calculate the phosphorescence radiative rate.

Ground State Optimization
------------

First, use BDF quantum software to perform structural optimization and frequency calculation for Ir(ppy)₃'s ground state S₀ and first triplet excited state T₁.

Prepare the xyz file of Ir(ppy)₃'s molecular structure:

.. code-block:: python

    61

    Ir   -2.606160230000     -0.262817540000      0.032585640000
    C    -3.837298770000      2.407777490000      0.243683290000
    C    -1.553000180000      2.622608110000      0.521271830000
    C    -3.991643180000      3.786525490000      0.422094600000
    C    -4.929719550000      1.476909230000     -0.003856060000
    C    -1.634158680000      3.988444110000      0.709067180000
    H    -0.591261780000      2.126459120000      0.554253960000
    C    -2.889293280000      4.581787990000      0.656041260000
    H    -4.972006580000      4.231616950000      0.376099570000
    C    -6.263398690000      1.888616610000     -0.076321100000
    H    -0.744068550000      4.570116630000      0.889344200000
    H    -2.999939670000      5.647195600000      0.795286530000
    C    -5.623129880000     -0.778047400000     -0.424041550000
    C    -7.264449980000      0.973962040000     -0.319493370000
    H    -6.527094820000      2.928025340000      0.057085040000
    C    -6.940359500000     -0.364034500000     -0.495248330000
    H    -5.397358100000     -1.824987250000     -0.570011260000
    H    -8.293855190000      1.298147200000     -0.375111620000
    H    -7.723296650000     -1.084118350000     -0.689505650000
    C    -2.780095460000     -2.271307610000     -0.073978550000
    C    -2.962145630000     -2.905938610000      1.179649240000
    C    -2.704720750000     -3.101798200000     -1.194651040000
    C    -3.053849400000     -4.297470620000      1.273150410000
    C    -3.052375550000     -2.037406190000      2.345262930000
    C    -2.797310890000     -4.477732940000     -1.095358170000
    H    -2.574810200000     -2.657655530000     -2.171485550000
    C    -2.970830350000     -5.080470100000      0.142706420000
    H    -3.190782260000     -4.777448690000      2.231582660000
    C    -3.251325250000     -2.483356810000      3.656088400000
    H    -2.735191030000     -5.089028800000     -1.985144810000
    H    -3.042943740000     -6.155896270000      0.221114210000
    C    -2.995026490000      0.148733040000      3.092507280000
    C    -3.319187740000     -1.576319800000      4.692855730000
    H    -3.353725050000     -3.536644150000      3.859562860000
    C    -3.186631940000     -0.222801710000      4.408749290000
    H    -2.888815760000      1.194668600000      2.833837140000
    H    -3.472767910000     -1.912494740000      5.707724440000
    H    -3.232610730000      0.522480480000      5.186904590000
    N    -2.927015180000     -0.717593640000      2.090156960000
    C     0.125501920000     -0.309636820000     -1.075330180000
    C     0.242318970000     -0.710559210000      1.197687130000
    C     1.518232510000     -0.401785790000     -1.166132500000
    C    -0.762473880000     -0.044853840000     -2.198985150000
    C     1.619464440000     -0.811598610000      1.179643800000
    H    -0.298309850000     -0.828666640000      2.128258480000
    C     2.270161400000     -0.653514600000     -0.037593100000
    H     2.007628100000     -0.277927520000     -2.118201950000
    C    -2.150460220000     -0.005742870000     -1.917121780000
    C    -0.287950380000      0.157363030000     -3.497950870000
    H     2.165728000000     -1.009392350000      2.088259610000
    H     3.346017750000     -0.726918300000     -0.099292420000
    C    -3.004998770000      0.237880450000     -2.994864780000
    C    -1.165335710000      0.397865570000     -4.532504760000
    H     0.771521710000      0.127613130000     -3.708268180000
    C    -2.529020200000      0.436535570000     -4.277665910000
    H    -4.071982740000      0.267717660000     -2.824596670000
    H    -0.792761550000      0.552584980000     -5.535050450000
    H    -3.220629300000      0.622039860000     -5.087916480000
    N    -0.487689310000     -0.467248190000      0.117089220000
    N    -2.608631830000      1.850704260000      0.298598520000
    C    -4.578169480000      0.115167240000     -0.176155400000

Open Device Studio, click File → New Project, name it ``phosphorescence.hpf``, drag ``Ir(ppy)3_s0.xyz`` into the Project, and double-click ``Ir(ppy)3_s0.hzw``. Next, perform structural optimization and frequency calculation for Ir(ppy)₃'s ground state S₀. Select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select Opt+Freq for Calculation Type, choose PBE0 functional for method, and select Def2-SVP basis set under All Electron type in Basis. Use recommended default values for other parameters in the Basic Settings interface without modification.

.. figure:: /Irppy3-example/fig4.1-1.png

In the SCF Settings interface, select Coarse for DFT Integral Grid and Tight for Convergence Threshold. Use recommended default values for other parameters in the SCF Settings interface without modification.

.. figure:: /Irppy3-example/fig4.1-2.png

In the OPT Settings interface, select Tight for Convergence Threshold. Use recommended default values for other parameters in the OPT Settings interface without modification.

.. figure:: /Irppy3-example/fig4.1-3.png

Use recommended default values for parameters in the Freq Settings interface without modification. Then click Generate files to generate the input file for the corresponding calculation. Select the generated ``bdf.inp`` file, right-click and choose open with to open the file, as shown below:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run, the following server submission interface pops up:

.. figure:: /Irppy3-example/fig4.1-4.png

Click Run to submit the job. After the job ends, three result files ``bdf.out``, ``bdf.out.tmp``, and ``bdf.scf.molden`` will appear in the Project.

Select ``bdf.out``, right-click show view, in the Optimization dialog box, it shows that the structure has met the convergence criteria.

.. figure:: /Irppy3-example/fig4.1-5.png 

In the Frequency dialog box, check the frequencies; if no imaginary frequencies exist, it proves the structure has been optimized to a minimum point.

.. figure:: /Irppy3-example/fig4.1-6.png

Excited State Optimization
-----------

Select the ``bdf.out`` file, right-click open with containing folder to open the folder. In the ``bdf.out`` file, search for ``converged in``. The structure output under ``Molecular Cartesian Coordinates (X,Y,Z) in Angstrom :`` immediately following is the optimized S₀ structure of Ir(ppy)₃.

Save it as ``Irppy3_t1.xyz`` file, and drag ``Irppy3_t1.xyz`` into Device Studio for T₁ excited state structural optimization and frequency calculation.

Content of ``Irppy3_t1.xyz``:

.. code-block:: python

    61

     Ir         -0.00021963       0.00084588       0.01424181
      C           2.59517396      -1.31710199      -0.58086411
      C           2.23709967       0.40664133      -2.11684705
      C           3.82729349      -1.60375453      -1.18851600
      C           2.03843393      -2.01080680       0.57861773
      C           3.44334868       0.17103124      -2.75937571
      H           1.56522101       1.20579483      -2.43942631
      C           4.25160770      -0.86138490      -2.27959559
      H           4.44860577      -2.40719663      -0.79331056
      C           2.69382363      -3.08153995       1.20802708
      H           3.74085930       0.78654308      -3.60925966
      H           5.21146469      -1.08097154      -2.75293386
      C           0.24421139      -2.16970311       2.17811922
      C           2.12763720      -3.69300459       2.31682204
      H           3.65478554      -3.44259873       0.83261331
      C           0.89831764      -3.22978876       2.79882363
      H          -0.71249803      -1.82386403       2.57651491
      H           2.63779958      -4.52517522       2.80699129
      H           0.44660698      -3.70582388       3.67403286
      C          -1.72035469       0.07933387       1.04722001
      C          -2.76313413      -0.76101290       0.56881686
      C          -2.01025266       0.87257612       2.17113445
      C          -4.02037491      -0.79383502       1.19368759
      C          -2.43582629      -1.59048558      -0.58889316
      C          -3.25751526       0.83538180       2.78746398
      H          -1.23410642       1.52839366       2.57249446
      C          -4.29332764       0.34509124       2.25152759
      H          -4.89835192      -1.11318656       0.80076906
      C          -3.29617560      -2.51740929      -1.19724703
      H          -3.44731484       1.46422538       3.66217358
      H          -5.27935386       0.39610056       2.71819787
      C          -0.75837785      -2.13799807      -2.04878703
      C          -3.02057249      -3.12865177      -2.21547404
      H          -4.44525951      -2.39959512      -0.77498376
      C          -1.70631730      -3.03592702      -2.67708276
      H           0.27022263      -1.95736074      -2.36320871
      H          -3.72428268      -3.82273458      -2.68079360
      H          -1.34337957      -3.64618311      -3.50492143
      N          -1.25281509      -1.36491844      -1.03498749
      C           0.05749757       2.91146589      -0.57266019
      C          -1.32777267       1.80183369      -2.13392316
      C          -0.20378718       4.13789922      -1.23242993
      C           0.84833732       2.74053836       0.60027468
      C          -1.62207961       2.97568834      -2.79963589
      H          -1.76529075       0.85235254      -2.45705604
      C          -1.02279372       4.18710974      -2.33345871
      H           0.25619858       5.05119986      -0.85064151
      C           0.99228869       1.37116718       1.10523883
      C           1.50408647       3.78492492       1.29091761
      H          -2.29824567       2.96275979      -3.65460398
      H          -1.21968527       5.13470890      -2.83803374
      C           1.79964051       1.14876808       2.23660071
      C           2.27478596       3.51131149       2.40946143
      H           1.40861651       4.81693356       0.94742301
      C           2.43450283       2.19478112       2.89597173
      H           1.90681895       0.12796182       2.60984200
      H           2.77105979       4.33756352       2.92655136
      H           3.04508360       2.00761950       3.78145403
      N          -0.50508694       1.73366277      -1.08285478
      N           1.77567220      -0.40171722      -1.08777429
      C           0.72548984      -1.57229627       1.07484739

Select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select TDDFT-OPT+Freq for Calculation Type, use the default PBE0 functional for method, and select Def2-SVP basis set under All Electron type in Basis. Use recommended default values for other parameters in the Basic Settings interface without modification.

.. figure:: /Irppy3-example/fig4.2-1.png

In the SCF Settings interface, uncheck the default Use MPEC+COSX Acceleration. Use recommended default values for other parameters in the SCF Settings interface without modification.

.. figure:: /Irppy3-example/fig4.2-2.png

In the TDDFT Settings panel, uncheck the default Use MPEC+COSX Acceleration. Select Triplet for Multiplicity and Very Tight for Convergence Threshold. Use recommended default values for other parameters in the TDDFT Settings interface without modification.

.. figure:: /Irppy3-example/fig4.2-3.png

Use recommended default values for parameters in the OPT Settings and Freq Settings panels without modification. Then click Generate files to generate the input file for the corresponding calculation. Select the generated ``bdf.inp`` file, right-click and choose open containing folder to enter the folder. In the ``bdf.inp``'s ``$tddft`` module, add:

.. code-block:: python

    Gridtol
    1E-6

Content of ``bdf.inp``:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run to submit the job. After the job ends, three result files ``bdf.out``, ``bdf.out.tmp``, and ``bdf.scf.molden`` will appear in the Project.

Select ``bdf.out``, right-click show view, in the Optimization dialog box, it shows that the structure has met the convergence criteria.

.. figure:: /Irppy3-example/fig4.2-4.png

In the Frequency dialog box, check the frequencies; if no imaginary frequencies exist, it proves the structure has been optimized to a minimum point.

.. figure:: /Irppy3-example/fig4.2-5.png

Spin-Orbit Coupling
-------------

Select the ``bdf.out`` file, right-click open with containing folder to open the ``bdf.out`` file. In the file, search for ``converged in``. The structure output under ``Molecular Cartesian Coordinates (X,Y,Z) in Angstrom :`` immediately following is the optimized T₁ excited state structure. Save it as ``Irppy3_t1_soc.xyz`` file:

.. code-block:: python

    61

      Ir          0.00713728       0.02772384       0.06844143 
      C           2.49525480      -1.44901550      -0.61634342 
      C           2.18832036       0.30085414      -2.14613716 
      C           3.68634391      -1.80881598      -1.26572189 
      C           1.93194560      -2.11689508       0.55823360 
      C           3.35838993      -0.00562745      -2.82371008 
      H           1.54555778       1.13535499      -2.43828057 
      C           4.11644204      -1.08671357      -2.36826138 
      H           4.27131595      -2.65056635      -0.89578008 
      C           2.53568350      -3.23676194       1.15281696 
      H           3.66807720       0.59265321      -3.68133338 
      H           5.04582829      -1.36185464      -2.87261245 
      C           0.15985754      -2.20796739       2.19060975 
      C           1.95468524      -3.83725789       2.26057143 
      H           3.46642195      -3.64596143       0.75209976 
      C           0.76249168      -3.31842903       2.77624738 
      H          -0.76777546      -1.81381956       2.61329026 
      H           2.42616559      -4.70662836       2.72403491 
      H           0.30108846      -3.78788395       3.64972556 
      C          -1.72817262       0.21988877       1.05055833 
      C          -2.80684294      -0.57231379       0.57552059 
      C          -1.98377974       1.07446425       2.13652018 
      C          -4.07348284      -0.50293868       1.17614116 
      C          -2.51722058      -1.44616477      -0.55935718 
      C          -3.24105830       1.13344573       2.72846833 
      H          -1.17254968       1.69178400       2.52835606 
      C          -4.29332764       0.34509124       2.25152759 
      H          -4.89835192      -1.11318656       0.80076906 
      C          -3.42583031      -2.33456216      -1.15446766 
      H          -3.44731484       1.80444609       3.66217358 
      H          -5.27935386       0.39610056       2.71819787 
      C          -0.85701735      -2.13799807      -2.04878703 
      C          -3.02057249      -3.12865177      -2.21547404 
      H          -4.44525951      -2.39959512      -0.77498376 
      C          -1.70631730      -3.03592702      -2.67708276 
      H           0.18295061      -1.95736074      -2.36320871 
      H          -3.72428268      -3.82273458      -2.68079360 
      H          -1.34337957      -3.64618311      -3.50492143 
      N          -1.25281509      -1.36491844      -1.03498749 
      C           0.05749757       2.91146589      -0.57266019 
      C          -1.32777267       1.80183369      -2.13392316 
      C          -0.20378718       4.13789922      -1.23242993 
      C           0.84833732       2.74053836       0.60027468 
      C          -1.62207961       2.97568834      -2.79963589 
      H          -1.76529075       0.85235254      -2.45705604 
      C          -1.02279372       4.18710974      -2.33345871 
      H           0.25619858       5.05119986      -0.85064151 
      C           0.99228869       1.37116718       1.10523883 
      C           1.50408647       3.78492492       1.29091761 
      H          -2.29824567       2.96275979      -3.65460398 
      H          -1.21968527       5.13470890      -2.83803374 
      C           1.79964051       1.14876808       2.23660071 
      C           2.27478596       3.51131149       2.40946143 
      H           1.40861651       4.81693356       0.94742301 
      C           2.43450283       2.19478112       2.89597173 
      H           1.90681895       0.12796182       2.60984200 
      H           2.77105979       4.33756351       2.92655136 
      H           3.04508360       2.00761950       3.78145403 
      N          -0.50508694       1.73366277      -1.08285478 
      N           1.77567220      -0.40171722      -1.08777429 
      C           0.72548984      -1.57229627       1.07484739 

Based on the T₁ excited state structure, perform spin-orbit coupling (SOC) calculation between S₀ and T₁. Drag Irppy3_t1_soc.xyz into Device Studio, select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select TDDFT-SOC for Calculation Type, choose PBE0 for Functional, uncheck Use Dispersion Correction. Select sf-X2C for Hamiltonian, and choose x2c-SVPall basis set under All Electron type in Basis.

.. figure:: /Irppy3-example/fig4.3-1.png

In the TDDFT Settings panel, check "Including Ground State" in the Spin-Orbit Coupling section.

.. figure:: /Irppy3-example/fig4.3-2.png

Use recommended default values for other parameters in Basic Settings, SCF Settings, and TDDFT Settings without modification. Then click Generate files to create the corresponding input file. Select the generated ``bdf.inp`` file, right-click and choose open with to open it as shown below:

The generated input file ``bdf.inp`` is:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run to submit the job. After the job completes, the result files ``bdf.out`` and ``bdf.scf.molden`` will appear in the Project. Select ``bdf.out``, right-click and choose show view. In the TDDFT panel, select Spinor, and identify the 2nd, 3rd, and 4th states as the three components of T₁ in Dominant Excitations.

.. figure:: /Irppy3-example/fig4.3-3.png

Click the bdf.out file, right-click and choose Open Containing Folder to enter the folder. Open bdf.out, search for ``*** List of SOC-SI results ***``, and read the ExEnergies for states 2, 3, and 4 as: 2.1906 eV, 2.1961 eV, and 2.2052 eV respectively.

.. code-block:: python

  *** List of SOC-SI results ***
 
  No.      ExEnergies            Dominant Excitations         Esf        dE      Eex(eV)     (cm^-1) 
 
    1      -0.0054 eV    99.8%  Spin: |Gs,1>    0-th    A    0.0000   -0.0054    0.0000         0.00
    2       2.1906 eV    43.5%  Spin: |S+,3>    1-th    A    2.2232   -0.0326    2.1961     17712.45
    3       2.1961 eV    75.0%  Spin: |S+,2>    1-th    A    2.2232   -0.0272    2.2015     17756.09
    4       2.2052 eV    42.1%  Spin: |S+,1>    1-th    A    2.2232   -0.0180    2.2106     17829.67
    5       2.5334 eV    49.1%  Spin: |So,1>    1-th    A    2.6854   -0.1520    2.5388     20477.15
    6       2.5861 eV    42.4%  Spin: |S+,3>    2-th    A    2.6312   -0.0452    2.5915     20901.71
    7       2.6064 eV    82.9%  Spin: |S+,2>    2-th    A    2.6312   -0.0248    2.6118     21065.69

Search for ``E_tot`` and read the corresponding energy as -19265.29575859. The energies of the three sub-states of T₁ are obtained by adding E_tot and ExEnergies energies. For the second sub-state (state 2), the calculation is: -19265.29575859 + 2.1906/27.2114 = -19265.215256 au. The energy of the third sub-state is -19265.215053 au. The energy of the fourth sub-state is -19265.214719 au.   

.. code-block:: python

   Final scf result
   E_tot =            -19265.29575859
   E_ele =            -25841.98940694
   E_nn  =              6576.69364834
   E_1e  =            -39510.05277256
   E_ne  =            -66428.66809936
   E_kin =             26918.61532681
   E_ee  =             14091.21945939
   E_xc  =              -423.15609377
  Virial Theorem      1.715687

Using the same method and basis set, calculate SOC for the S₀ ground state structure. In bdf.out, search for ``E_tot`` and read the corresponding energy as: -19265.30415493 au.

.. code-block:: python

   Final scf result
   E_tot =            -19265.30415493
   E_ele =            -25838.09048037
   E_nn  =              6572.78632544
   E_1e  =            -39502.28526599
   E_ne  =            -66421.04136762
   E_kin =             26918.75610162
   E_ee  =             14087.38176801
   E_xc  =              -423.18698239
  Virial Theorem      1.715683

The energies of the three T₁ sub-states relative to S₀ are obtained by subtracting the S₀ state energy from the three sub-state energies: 0.088899 au, 0.089102 au, and 0.089436 au respectively. In the SOC calculation output file for the T₁ structure, search for ``[tddft_soc_matrso]:``, which outputs the energies and transition dipole moments of each excited state relative to the ground state after considering SOC.

.. code-block:: python

     [tddft_soc_matrso]: Print selected matrix elements of [dpl] 
 
  No.  ( I , J )   |rij|^2       E_J-E_I         fosc          rate(s^-1)
 -------------------------------------------------------------------------------
   1     1    2   0.104E-02    2.196064924    0.000056149     0.117E+05
   Details of transition dipole moment with SOC (in a.u.):
                   <I|X|J>       <I|Y|J>       <I|Z|J>        (also in debye) 
          Real=   0.279E-01     0.161E-01    -0.216E-02     0.0710   0.0409  -0.0055
          Imag=   0.123E-07    -0.291E-07    -0.867E-08     0.0000  -0.0000  -0.0000
          Norm=   0.279E-01     0.161E-01     0.216E-02
 
  No.  ( I , J )   |rij|^2       E_J-E_I         fosc          rate(s^-1)
 -------------------------------------------------------------------------------
   2     1    3   0.354E-03    2.201474871    0.000019090     0.401E+04
   Details of transition dipole moment with SOC (in a.u.):
                   <I|X|J>       <I|Y|J>       <I|Z|J>        (also in debye) 
          Real=   0.587E-02     0.179E-01     0.126E-03     0.0149   0.0454   0.0003
          Imag=  -0.108E-06    -0.357E-07     0.361E-07    -0.0000  -0.0000   0.0000
          Norm=   0.587E-02     0.179E-01     0.126E-03
 
  No.  ( I , J )   |rij|^2       E_J-E_I         fosc          rate(s^-1)
 -------------------------------------------------------------------------------
   3     1    4   0.259E-01    2.210597826    0.001400915     0.297E+06
   Details of transition dipole moment with SOC (in a.u.):
                   <I|X|J>       <I|Y|J>       <I|Z|J>        (also in debye) 
          Real=   0.905E-08    -0.356E-07    -0.418E-08     0.0000  -0.0000  -0.0000
          Imag=  -0.535E-01     0.148E+00     0.316E-01    -0.1360   0.3771   0.0802
          Norm=   0.535E-01     0.148E+00     0.316E-01
 
  No.  ( I , J )   |rij|^2       E_J-E_I         fosc          rate(s^-1)
 -------------------------------------------------------------------------------
   4     1    5   0.154E+00    2.538843563    0.009594212     0.268E+07
   Details of transition dipole moment with SOC (in a.u.):
                   <I|X|J>       <I|Y|J>       <I|Z|J>        (also in debye) 
          Real=  -0.236E+00     0.158E+00     0.271E+00    -0.5998   0.4010   0.6899
          Imag=  -0.271E-06     0.183E-06     0.310E-06    -0.0000   0.0000   0.0000
          Norm=   0.236E+00     0.158E+00     0.271E+00
 
  No.  ( I , J )   |rij|^2       E_J-E_I         fosc          rate(s^-1)
 -------------------------------------------------------------------------------
   5     1    6   0.275E-02    2.591483156    0.000174312     0.508E+05
   Details of transition dipole moment with SOC (in a.u.):
                   <I|X|J>       <I|Y|J>       <I|Z|J>        (also in debye) 
          Real=   0.339E-01     0.292E-01     0.273E-01     0.0861   0.0743   0.0693
          Imag=  -0.132E-07     0.447E-07     0.428E-07    -0.0000   0.0000   0.0000
          Norm=   0.339E-01     0.292E-01     0.273E-01

Here, ``1  2`` represents the transition dipole moment between the first and second spinor states, and so on. We need the excitation energies and transition dipole moments for the 1st, 2nd, and 3rd excited states.

The transition dipole moment data is listed in ``Details of transition dipole moment with SOC (in a.u.):``. The first three columns are dipole moments in atomic units (au), and the next three columns are in Debye.

To obtain the transition dipole moment for each state, take the square root of the sum of squares of the six numbers in Debye units. Alternatively, take the square root of the sum of squares of the three Norm values and multiply by 2.5417. This gives transition dipole moments of 0.082058 Debye, 0.047881 Debye, and 0.407979 Debye for the 1st, 2nd, and 3rd excited states respectively.

These six parameters will be used in MOMAP software for phosphorescence emission rate calculations.

At this point, all necessary files and parameters for MOMAP's phosphorescence radiative rate calculation for :math:`\rm Ir(ppy)_3` are complete, including BDF's structural optimization frequency result files, spin-orbit coupling calculation result files, and parameters.

Phosphorescence Radiative Rate
-------------

Next, we begin calculating the phosphorescence radiative rate of :math:`\rm Ir(ppy)_3` using MOMAP.

First, to calculate the T₁→S₀ phosphorescence radiative rate, start with electron-vibration coupling (EVC) calculation. This calculation is based on molecular vibration frequencies and force constant matrices output from quantum calculations. It computes mode displacements, Huang-Rhys factors, reorganization energies, and Duschinsky rotation matrices between initial and final states of molecular transitions in both internal and Cartesian coordinates.

Rename the optimized frequency calculation files for :math:`\rm Ir(ppy)_3`'s ground state from BDF to ``irppy3_s0.out``, and the T₁ optimized frequency calculation file to ``irppy3_t1.out``. Place both in the EVC calculation folder.

The input file for EVC calculation ``momap.inp`` is:

.. code-block:: python

    do_evc=1

    &evc
	    ffreq(1)="irppy3_s0.out"
	    ffreq(2)="irppy3_t1.out"
	    proj_reorg=.t.
    /

Submit the script file ``momap.slurm`` to run the job. After successful completion, use ``evc.cart.dat`` for subsequent T₁→S₀ phosphorescence emission rate calculations. Perform calculations for each of T₁'s three states. For the first sub-state (state 2), the input file ``momap.inp`` is:

.. code-block:: python

    do_spec_tvcf_ft   = 1
    do_spec_tvcf_spec = 1
    
    &spec_tvcf
      DUSHIN        = .t. 
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs  
      Ead           = 0.088899 au
      EDMA          = 1 debye
      EDME          = 0.082058 debye
      FreqScale     = 1
      DSFile        = "evc.cart.dat"
      Emax          = 0.3 au
      dE            = 0.00001 au
      logFile       = "spec.tvcf.log"
      FtFile        = "spec.tvcf.ft.dat"
      FoFile        = "spec.tvcf.fo.dat"
      FoSFile       = "spec.tvcf.spec.dat"
    /

Submit the script file ``momap.slurm`` to run the job. After completion, verify if the correlation function converges.

Open ``spec.tvcf.log``. The phosphorescence radiative rate is read from the first and second numbers, in a.u. and s⁻¹ units respectively. The third number is the lifetime in ns.

For the second sub-state (state 3), the input file ``momap.inp`` is:

.. code-block:: python

    do_spec_tvcf_ft   = 1
    do_spec_tvcf_spec = 1
    
    &spec_tvcf
      DUSHIN        = .t. 
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs  
      Ead           = 0.089102 au
      EDMA          = 1 debye
      EDME          = 0.047881 debye
      FreqScale     = 1
      DSFile        = "evc.cart.dat"
      Emax          = 0.3 au
      dE            = 0.00001 au
      logFile       = "spec.tvcf.log"
      FtFile        = "spec.tvcf.ft.dat"
      FoFile        = "spec.tvcf.fo.dat"
      FoSFile       = "spec.tvcf.spec.dat"
    /

Submit the script file ``momap.slurm`` to run the job.

For the third sub-state (state 4), the input file ``momap.inp`` is:

.. code-block:: python

    do_spec_tvcf_ft   = 1
    do_spec_tvcf_spec = 1
    
    &spec_tvcf
      DUSHIN        = .t. 
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs  
      Ead           = 0.089436 au
      EDMA          = 1 debye
      EDME          = 0.407979 debye
      FreqScale     = 1
      DSFile        = "evc.cart.dat"
      Emax          = 0.3 au
      dE            = 0.00001 au
      logFile       = "spec.tvcf.log"
      FtFile        = "spec.tvcf.ft.dat"
      FoFile        = "spec.tvcf.fo.dat"
      FoSFile       = "spec.tvcf.spec.dat"
    /

Finally, weight the phosphorescence emission rates of the three sub-states according to their Boltzmann distribution based on relative energies (refer to http://sobereva.com/462 and http://sobereva.com/165 for details and corresponding Excel templates). Sum them to obtain the final T₁ state phosphorescence emission rate.