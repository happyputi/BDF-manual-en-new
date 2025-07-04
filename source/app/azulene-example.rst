.. _azulene-example:

Quantum Theoretical Study of the Anti-Kasha Rule Fluorescence Mechanism in Azulene
=====================================================

According to Kasha's rule, molecular fluorescence or phosphorescence originates from the lowest singlet or triplet state due to rapid non-radiative transitions between higher excited states. Azulene is a classic example that violates Kasha's rule. The fluorescence of azulene originates from the S₂ state, which can be attributed to the large energy gap between S₂→S₁ that reduces the S₂→S₁ internal conversion rate. Additionally, the relatively small energy gap between S₁ and S₀ results in a high internal conversion rate, thereby reducing the fluorescence quantum efficiency of S₁→S₀, making S₁→S₀ fluorescence difficult to observe. Here, using the BDF and MOMAP software, we calculate the radiative rate and internal conversion rate of azulene's S₁→S₀ transition to explain the experimental observation that the extremely low quantum efficiency of azulene's first excited state makes its fluorescence difficult to detect.

The MOMAP calculation for azulene's S₁→S₀ radiative rate and internal conversion rate requires the structural optimization frequency results file, non-adiabatic coupling results file, and parameters from the BDF quantum software. First, we complete the BDF calculation part.

BDF Calculation Part
----------------

Prepare the xyz file of azulene's molecular structure:

.. code-block:: python

    18

    C                 -0.48100000    0.74480000    0.00000000
    C                 -0.56240000   -0.71320000    0.00020000
    C                 -1.75790000    1.17860000   -0.00030000
    C                 -1.96510000   -1.08880000    0.00000000
    C                  0.66870000    1.60890000    0.00030000
    C                  0.45100000   -1.58850000    0.00030000
    C                 -2.66930000    0.05180000   -0.00010000
    C                  1.95140000    1.22210000    0.00020000
    C                  1.86730000   -1.29960000   -0.00020000
    C                  2.49720000   -0.11610000   -0.00040000
    H                 -2.09080000    2.20560000   -0.00040000
    H                 -2.35750000   -2.09240000    0.00010000
    H                  0.46620000    2.67860000    0.00070000
    H                  0.22090000   -2.65340000    0.00040000
    H                 -3.74370000    0.14050000   -0.00030000
    H                  2.70720000    2.00650000    0.00050000
    H                  2.49320000   -2.19150000   -0.00060000
    H                  3.58670000   -0.13930000   -0.00080000

Open Device Studio, click File → New Project, name it ``fluorescence.hpf``, drag ``azulene.xyz`` into the Project, and double-click ``azulene.hzw`` to get the interface shown below.

.. figure:: /azulene-example/fig5.1-1.png

First, perform structural optimization and frequency calculation of azulene using BDF. Select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select Opt+Freq for Calculation Type, use the default GB3LYP functional for method, and select 6-31G(d,p) for basis set under All Electron type in Basis. Other parameters in the Basic Settings interface and parameters in panels like SCF Settings, OPT Settings, Freq Settings use recommended default values without modification. Then click Generate files to generate the input file for the corresponding calculation.

.. figure:: /azulene-example/fig5.1-2.png

Select the generated ``bdf.inp`` file, right-click and choose open with to open the file, as shown below:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run, the following interface pops up:

.. figure:: /azulene-example/fig5.1-3.png

Click Run to submit the job, and the real-time output of the result file will automatically pop up.

.. figure:: /azulene-example/fig5.1-4.png

After the job ends, three result files ``bdf.out``, ``bdf.out.tmp``, and ``bdf.scf.molden`` will appear in the Project.

.. figure:: /azulene-example/fig5.1-5.png

Select ``bdf.out``, right-click show view, in the Optimization dialog box, it shows that the structure has met the convergence criteria.

.. figure:: /azulene-example/fig5.1-6.png

In the Frequency dialog box, check the frequencies; if no imaginary frequencies exist, it proves the structure has been optimized to a minimum point.

.. figure:: /azulene-example/fig5.1-7.png

In the Summary dialog box, Total Energy is -385.87807600 a.u., which is the required single-point energy of the ground state azulene.

.. figure:: /azulene-example/fig5.1-8.png

Click the calculation task in Job Manager, click the server, which has entered the folder where the task is located, enter ``/data/hzwtech/DS-BDF_2022A/sbin/optgeom2xyz.py bdf.optgeom``, press Enter to generate the ``bdf.xyz`` file. Click the file transfer tool, enter the folder, drag out the ``bdf.xyz`` file, which is the input file needed for the next excited state structure optimization. Rename it to ``azulene_s0.xyz``, open the folder, remove the second line of description, and drag it into Device Studio.

Perform S₁ excited state structure optimization and frequency calculation of azulene using BDF. Select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select TDDFT-OPT+Freq for Calculation Type, use the default GB3LYP functional for method, and select 6-31G(d,p) for basis set under All Electron type in Basis. In SCF Settings and TDDFT Settings panels, uncheck the default Use MPEC+COSX Acceleration. Other parameters in Basic Settings, SCF Settings, TDDFT Settings interfaces and parameters in panels like OPT Settings, Freq Settings use recommended default values without modification. Then click Generate files to generate the input file for the corresponding calculation.

.. figure:: /azulene-example/fig5.1-9.png
.. figure:: /azulene-example/fig5.1-10.png
.. figure:: /azulene-example/fig5.1-11.png

Select the generated ``bdf.inp`` file, right-click and choose open with to open the file, as shown below:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run to submit the job. After the job ends, three result files ``bdf.out``, ``bdf.out.tmp``, and ``bdf.scm.molden`` will appear in the Project.

Select ``bdf.out``, right-click show view, in the Optimization dialog box, it shows that the structure has met the convergence criteria.

.. figure:: /azulene-example/fig5.1-12.png

In the Frequency dialog box, check the frequencies; if no imaginary frequencies exist, it proves the structure has been optimized to a minimum point.

.. figure:: /azulene-example/fig5.1-13.png

Select ``bdf.out.tmp``, right-click open with containing folder, open ``bdf.out.tmp``, and find the first tddft calculation module ``module tddft`` at the beginning of the file. According to the ``Ground to excited state Transition electric dipole moments (Au)`` in the tddft module, get the EDMA parameter needed by MOMAP from State 1's transition electric dipole moment. Calculation method: :math:`\sqrt{(0.3456)^2+(-0.1159)^2+(-0.0000)^2} = 0.3646` a.u. Convert units from a.u. to Debye: EDMA = 0.3646 * 2.5417 = 0.9267 Debye.

.. code-block:: bdf

    [File content unchanged - same as original]

At the end of the file, find the first tddft calculation module ``module tddft``. According to the ``Ground to excited state Transition electric dipole moments (Au)`` in the tddft module, get the EDME parameter needed by MOMAP from State 1's transition electric dipole moment. Calculation method: :math:`\sqrt{(-0.2427)^2+(0.0816)^2+(-0.0000)^2} = 0.2560` a.u. Convert units from a.u. to Debye: EDME = 0.2560 * 2.5417 = 0.6507 Debye.

.. code-block:: bdf

    [File content unchanged - same as original]

In this ``tddft`` module's ``Statistics for [dvdson_rpa_block]:``, read the energy of state No. 1 as -385.8030480568 a.u., which is the single-point energy of S₁ state.

.. code-block:: bdf

    [File content unchanged - same as original]

Subtract the S₁ state's single-point energy from S₀ state's single-point energy to get the energy difference parameter Ead = 0.07502 a.u. needed by MOMAP.

Based on the ground state structure, perform non-adiabatic coupling calculation between S₀ and S₁. Click ``azulene_s0.hzw``, right-click and click copy, set new file name to nacme, and ``nacme.hzw`` appears in the Project. Double-click ``nacme.hzw``, use BDF to perform azulene's non-adiabatic coupling calculation. Select Simulator → BDF → BDF, set parameters in the interface. In the Basic Settings interface, select TDDFT-NAC for Calculation Type, use the default GB3LYP functional for method, and select 6-31G(d,p) for basis set under All Electron type in Basis. In SCF Settings and TDDFT Settings panels, uncheck the default Use MPEC+COSX Acceleration. In the Non-Adiabatic Coupling content box in the TDDFT Settings panel, under the default Coupling between Ground and Excited-State, click the "+" sign. Other parameters in Basic Settings, SCF Settings, TDDFT Settings interfaces and parameters in panels like OPT Settings, Freq Settings use recommended default values without modification. Then click Generate files to generate the input file for the corresponding calculation.

.. figure:: /azulene-example/fig5.1-14.png
.. figure:: /azulene-example/fig5.1-15.png

Select the generated ``bdf.inp`` file, right-click and choose open with to open the file, as shown below:

.. code-block:: bdf

    [File content unchanged - same as original]

Select the ``bdf.inp`` file, right-click and choose Run to submit the job. After the job ends, two result files ``bdf.out`` and ``bdf.scf.molden`` will appear in the Project.

At this point, the BDF quantum software calculation part required for MOMAP's calculation of azulene's S₁→S₀ radiative rate and internal conversion rate—including structural optimization frequency result files, non-adiabatic coupling result files, and parameter parts—are all completed.

MOMAP Calculation Part
-----------------

After completing the structural optimization, frequency calculation, and non-adiabatic coupling calculation of azulene using BDF quantum software and calculating the parameters needed in the MOMAP input file, we will use MOMAP software to calculate the radiative rate and internal conversion rate of azulene's S₁→S₀ transition. By comparing the radiative rate and internal conversion rate, we explain why azulene's S₁→S₀ fluorescence is difficult to observe.

First, calculate the fluorescence radiative rate of S₁→S₀. The first step is to perform electron-vibration coupling (EVC) calculation. This calculation is based on the molecular vibration frequencies and force constant matrices output from quantum calculations, and computes the mode displacement, Huang-Rhys factor, reorganization energy, and Duschinsky rotation matrix between the initial and final states of molecular transitions in both internal and Cartesian coordinates.

Rename BDF's S₀ optimization frequency calculation result to ``azulene-s0.out`` and S₁ calculation result to ``azulene-s1.out``, and place them in the EVC calculation folder. The input file ``momap.inp`` for EVC calculation is:

.. code-block:: python

    do_evc          = 1

    &evc
      ffreq(1)      = "azulene-s0.out"
      ffreq(2)      = "azulene-s1.out"
      proj_reorg = .t.
    /

Submit the script file ``momap.slurm``. After the job runs, the following files are generated:

.. figure:: /azulene-example/fig5.2-1.png

``evc.cart.dat`` contains the results of mode displacement, Huang-Rhys factor, reorganization energy, and Duschinsky rotation matrix calculated using Cartesian coordinates; while ``evc.dint.dat`` contains results of mode displacement and Huang-Rhys factor calculated using internal coordinates, and reorganization energy and Duschinsky rotation matrix calculated using Cartesian coordinates.

Open the ``evc.cart.dat`` file to view the total reorganization energy value:

.. code-block:: python

    --------------------------------------------------------------------------------------------------------------------------------------------
      Total reorganization energy      (cm-1):         4032.869339       5126.265767
    --------------------------------------------------------------------------------------------------------------------------------------------

Compare with the value in the ``evc.dint.dat`` file:

.. code-block:: python

    --------------------------------------------------------------------------------------------------------------------------------------------
      Total reorganization energy      (cm-1):         4070.407661       5114.173064
    --------------------------------------------------------------------------------------------------------------------------------------------

Compare the reorganization energies in the ``evc.cart.dat`` and ``evc.dint.dat`` files. If the reorganization energies are not significantly different (< :math:`1000 cm^{-1}`), use the ``evc.cart.dat`` file for subsequent calculations. If they differ significantly (generally ``evc.cart.dat`` > ``evc.dint.dat``), use the ``evc.dint.dat`` file. Here they are relatively close and reasonable (< :math:`10000 cm^{-1}`), so we use ``evc.cart.dat`` for the next step of S₁→S₀ fluorescence radiative rate calculation.

Additionally, more post-processing can be done based on the EVC calculation result files.

``evc.dx.x.com`` and ``evc.dx.x.xyz`` are molecular superposition diagrams of the two electronic states. ``evc.dx.x.com`` can be opened with GaussView. Select Tube type under View → Display Format → Molecule, displayed as:

.. figure:: /azulene-example/fig5.2-2.png

``evc.dx.x.xyz`` can be opened with Jmol software, displayed as:

.. figure:: /azulene-example/fig5.2-3.png

``evc.dx.v.xyz`` is also a molecular state superposition diagram. Open it with Jmol software, select Display → Vector → 0.1A, displayed as:

.. figure:: /azulene-example/fig5.2-4.png

``evc.cart.abs`` is the Duschinsky matrix file, which can be used to plot the Duschinsky matrix 2D diagram. In Device Studio, select Simulator → momap → analysis, open the ``evc.cart.abs`` file, displayed as:

.. figure:: /azulene-example/fig5.2-5.png

Similarly, open the ``evc.dint.abs`` file. You can select the display color in the ColorType drop-down box, displayed as:

.. figure:: /azulene-example/fig5.2-6.png

Both Duschinsky matrices are calculated using Cartesian coordinates—choose either.

Place the ``evc.vib1.xyz`` and ``evc.vib2.xyz`` files in the same path as the ``evc.cart.dat`` file. In Device Studio, select Simulator → momap → analysis, open the ``evc.cart.dat`` file, and diagrams of reorganization energy and Huang-Rhys factors corresponding to each vibration mode in ground and excited states appear, displayed as:

.. figure:: /azulene-example/fig5.2-7.png
.. figure:: /azulene-example/fig5.2-8.png
.. figure:: /azulene-example/fig5.2-9.png
.. figure:: /azulene-example/fig5.2-10.png

Click Choose Color to change line colors; change the value in Set Width to change line thickness. Clicking on lines in the diagram displays the corresponding vibration mode on the right structure. Vibration speed can be adjusted via Animation Frequency; vibration amplitude can be displayed via Displacement Amplitude.

Next, perform fluorescence spectrum and fluorescence radiative rate calculation for S₁→S₀. This calculation requires the evc.*.dat file from the EVC calculation as input. As mentioned earlier, place ``evc.cart.dat`` in the fluorescence spectrum and radiative rate calculation folder. The input file ``momap.inp`` is:

.. code-block:: python

    do_spec_tvcf_ft   = 1
    do_spec_tvcf_spec = 1
    
    &spec_tvcf
      DUSHIN        = .t. 
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs  
      Ead           = 0.07502 au
      EDMA          = 0.9267 debye
      EDME          = 0.6507 debye
      FreqScale     = 0.70
      DSFile        = "evc.cart.dat"
      Emax          = 0.3 au
      dE            = 0.00001 au
      logFile       = "spec.tvcf.log"
      FtFile        = "spec.tvcf.ft.dat"
      FoFile        = "spec.tvcf.fo.dat"
      FoSFile       = "spec.tvcf.spec.dat"
    /

Submit the script file ``momap.slurm``. After the job completes, the following files are generated:

.. figure:: /azulene-example/fig5.2-11.png

spec.tvcf.ft.dat is the correlation function file, with content like:

.. code-block:: python

    [File content unchanged - same as original]

After calculation, first confirm if the correlation function converges. Drag ``spec.tvcf.ft.dat`` into Origin, select columns 1 and 2 to plot:

.. figure:: /azulene-example/fig5.2-12.png

Tending to 0 over time indicates convergence of the absorption spectrum calculation. Select columns 1 and 4 to plot:

.. figure:: /azulene-example/fig5.2-13.png

Tending to 0 over time indicates convergence of the emission spectrum calculation.

``spec.tvcf.spec.dat`` is the spectrum file:

.. code-block:: python

    [File content unchanged - same as original]

Drag ``spec.tvcf.spec.dat`` into Origin, select columns 3 and 5 to plot, obtaining the absorption spectrum:

.. figure:: /azulene-example/fig5.2-14.png

Select columns 3 and 6 to plot, obtaining the emission spectrum:

.. figure:: /azulene-example/fig5.2-15.png

Open spec.tvcf.log, the file outputs the fluorescence radiative rate value at the end:

.. code-block:: python

    radiative rate     (0):     7.21227543E-12    2.98165371E+05 /s,    3353.84 ns

The fluorescence radiative rate is read from the first and second numbers, with units a.u. and :math:`s^{-1}` respectively. The third number is the fluorescence lifetime in ns. Here, azulene's S₁→S₀ fluorescence radiative rate is 2.98165371E+05 /s, and fluorescence lifetime is 3353.84 ns.

Next, calculate azulene's internal conversion rate. The first step is EVC vibrational analysis calculation.

The EVC vibrational analysis calculation for internal conversion rate requires the non-adiabatic coupling calculation result file. Rename the non-adiabatic coupling calculation result file to ``azulene-nacme.out``, and place it with ``azulene-s0.out`` and ``azulene-s1.out`` in the internal conversion rate calculation folder. The input file ``momap.inp`` is:

.. code-block:: python

    do_evc          = 1

    &evc
      ffreq(1)      = "azulene-s0.log"
      ffreq(2)      = "azulene-s1.log"
      fnacme        = "azulene-nacme.log"
      proj_reorg = .t.
    /

Submit the script file ``momap.slurm``. After the job completes, the following files are generated:

.. figure:: /azulene-example/fig5.2-16.png

Compared to the previous EVC calculation for fluorescence radiative rate, there is an additional ``evc.cart.nac`` file, which will be used together with the ``evc.cart.dat`` file for the subsequent internal conversion rate calculation.

The input file for internal conversion rate ``momap.inp`` is:

.. code-block:: python

    do_ic_tvcf_ft   = 1
    do_ic_tvcf_spec = 1
    
    &ic_tvcf
      DUSHIN        = .t. 
      Temp          = 300 K
      tmax          = 1000 fs
      dt            = 1   fs  
      Ead           = 0.07502 au
      FreqScale     = 0.40
      DSFile        = "evc.cart.dat"
      CoulFile      = "evc.cart.nac"
      Emax          = 0.3 au
      logFile       = "ic.tvcf.log"
      FtFile        = "ic.tvcf.ft.dat"
      FoFile        = "ic.tvcf.fo.dat"
    /

After calculation, the following files are generated:

.. figure:: /azulene-example/fig5.2-17.png

``ic.tvcf.ft.dat`` is the correlation function file, with content like:

.. code-block:: python

    [File content unchanged - same as original]

After calculation, first confirm if the correlation function converges. Drag ``ic.tvcf.ft.dat`` into Origin, select columns 1 and 2 to plot:

.. figure:: /azulene-example/fig5.2-18.png

Tending to 0 over time indicates convergence of the correlation function.

``ic.tvcf.fo.dat`` is the spectral function file, with content like:

.. code-block:: python

    [File content unchanged - same as original]

To check if it satisfies the energy gap law, drag ``ic.tvcf.fo.dat`` into Origin, select columns 3 and 7 to plot:

.. figure:: /azulene-example/fig5.2-19.png

Additionally, columns 1 and 6 in the ``ic.tvcf.fo.dat`` file represent the non-radiative rates at different Ead values.

In the ``ic.tvcf.log`` file at the end, read the non-radiative rate value of S₁→S₀:

.. code-block:: python

     #1Energy(Hartree)       2Energy(eV) 3WaveNumber(cm-1)   4WaveLength(nm)    5radi-spectrum      6kic(s^{-1})         7log(kic)         8time(ps)
    7.50036029E-02    2.04095275E+00    1.64613880E+04    6.07482186E+02    6.54396018E-07    2.70536301E+10    1.04322255E+01       36.96361624

Here, the S₁→S₀ non-radiative rate is 2.70536301E+10 :math:`s^{-1}`.

Comparing azulene's fluorescence radiative rate and non-radiative rate: fluorescence radiative rate is 2.98165371E+05 /s, non-radiative rate is 2.70536301E+10 :math:`s^{-1}`. The non-radiative rate is five orders of magnitude higher than the fluorescence radiative rate, thereby reducing the fluorescence quantum efficiency of azulene's S₁→S₀ transition and making the S₁→S₀ fluorescence difficult to observe. This results in the anti-Kasha rule fluorescence phenomenon.