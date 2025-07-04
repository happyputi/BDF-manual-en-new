Other techniques for self-consistent field calculations
=====================================

Initial guess of the self-consistent field calculation
------------------------------------------------
The initial guess orbit of the self-consistent field calculation has a great influence on the convergence of the calculation. BDF supports a variety of initial guesses, as follows:

  * Atom : Combine molecular density matrix guessing with atomic density matrix, default option.
  * Huckel: Semi-empirical Huckel method guessing;
  * Hcore : Diagonalized single electron Hamiltonian guess;
  * Readmo : Read into the molecular orbital as an initial guess;

By default, BDF uses Atom to guess. In concise input mode, the initial guess of the BDF can be changed using the keyword ''guess'', as shown below

.. code-block:: bdf

    #! ch3cho.sh
    HF/6-31G guess=Hcore unit=Bohr
    
    geometry    # notice: unit in Bohr 
    C       0.1727682300       -0.0000045651       -0.8301598059
    C      -2.3763311896        0.0000001634        0.5600567139
    H 0.0151760290 0.0000088544 -2.9110013387
    H -2.0873396672 0.0000037621 2.5902220967
    H -3.4601725077 -1.6628370597 0.0320271859
    H -3.4601679801 1.6628382651 0.0320205364
    O       2.2198078005        0.0000024315        0.2188182082
    end geometry

Here, in the second line, we use the keyword ''guess=Hcore''' to specify the use of ''Hcore''' to guess. SCF iterated 18 convergences.

.. code-block:: 

  Iter. idiis vshift  SCF Energy    DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S) 
   1    0   0.000 -130.488739529 174.680929376  0.401531162  5.325668770  0.0000   0.03
   2    1   0.000 -115.595786784  14.892952744  0.407402695  5.323804678  0.0000   0.02
   3    2   0.000 -126.823748834 -11.227962049  0.115300517  1.591646800  0.0000   0.03
   4    3   0.000 -150.870636785 -24.046887951  0.011394798  0.154813426  0.0000   0.02
   5    4   0.000 -151.121829169  -0.251192384  0.004498398  0.037875784  0.0000   0.03
   6    5   0.000 -150.900123989   0.221705180  0.008483436  0.119865266  0.0000   0.02
   7    6   0.000 -151.582006133  -0.681882144  0.011892345  0.122063906  0.0000   0.02
   8    7   0.000 -152.441656890  -0.859650757  0.007907887  0.062113717  0.0000   0.03
   9    8   0.000 -152.729229838  -0.287572947  0.003318529  0.037884676  0.0000   0.02
  10    2   0.000 -152.795374919  -0.066145081  0.005951772  0.054625652  0.0000   0.02
  11    3   0.000 -152.839276725  -0.043901806  0.000860488  0.010210210  0.0000   0.03
  12    4   0.000 -152.841131472  -0.001854746  0.000733951  0.007678730  0.0000   0.02
  13    5   0.000 -152.841752921  -0.000621449  0.000348937  0.003519950  0.0000   0.02
  14    6   0.000 -152.841816238  -0.000063316  0.000053288  0.000787592  0.0000   0.03
  15    7   0.000 -152.841819180  -0.000002942  0.000021206  0.000157533  0.0000   0.02
  16    8   0.000 -152.841819505  -0.000000325  0.000004796  0.000031694  0.0000   0.02
  17    2   0.000 -152.841819522  -0.000000016  0.000000698  0.000005497  0.0000   0.03
  18    3   0.000 -152.841819522  -0.000000000  0.000000236  0.000002276  0.0000   0.02
  diis/vshift is closed at iter =  18
  19    0   0.000 -152.8418195227 -0.000000000  0.000000078  0.000000848  0.0000   0.03

.. warning:: 
   In this example, the unit of the numerator's input coordinates is Bohr, and the length unit of the coordinates must be specified as ''Bohr'' using the keyword ''unit=Bohr'''.

The high-level input for this study is 

.. code-block:: bdf

   $compass
   geometry
     C 0.1727682300 -0.0000045651 -0.8301598059
     C -2.3763311896 0.0000001634 0.5600567139
     H 0.0151760290 0.0000088544 -2.9110013387
     H -2.0873396672 0.0000037621 2.5902220967
     H -3.4601725077 -1.6628370597 0.0320271859
     H -3.4601679801 1.6628382651 0.0320205364
     O 2.2198078005 0.0000024315 0.2188182082
   end geometry
   unit # set unit of coordinates as Bohr
     bohr
   basis
     6-31g
   $end

   $xuanyuan
   $end

   $scf
   rhf
   guess # ask for hcore guess
     hcore
   $end
 
.. note::

 In the vast majority of cases, Huckel and Hcore are not the best choice, so try not to use Huckel and Hcore (especially the latter) unless you absolutely absolutely have to.

Read into the initial guess track
------------------------------------------------------------------------------------------
By default, the SCF calculation of BDF uses the atomic density matrix to construct the molecular density matrix to generate the initial guessed orbital. In the actual calculation, the user can read in the convergent SCF molecular orbital as the initial guess orbital for the current SCF calculation. In this example, we first compute a neutral :math:'\ce{H2O}' molecule, and after obtaining the convergence orbital, we use it as the initial guess orbital of the :math:'\ce{H2O+}' ion.

In the first step, calculate the :math:'\ce{H2O}' molecule, prepare the input file, and name it h2o.inp. It reads as follows:

.. code-block:: bdf

    #!bdf.sh
    RKS/B3lyp/cc-pvdz     
    
    geometry
    Or
    H 1 R1
    H 1 R1 2 109.
    
    R1=1.0     # OH bond length in angstrom 
    end geometry

After the computation is performed, the working directory generates a readable file 'h2o.scforb'' that saves the orbit of the convergence of the SCF calculation.


In the second step, using the convergence orbital of the :math:'\ce{H2O}' molecule as the initial guess of the :math:'\ce{H2O+}' ion calculation, prepare the input file h2o+.inp as follows:

.. code-block:: bdf

    #!bdf.sh
    ROKS/B3lyp/cc-pvdz guess=readmo charge=1
    
    geometry
    Or
    H 1 R1
    H 1 R1 2 109.
    
    R1=1.0     # OH bond length in angstrom
    end geometry
    
    %cp $BDF_WORKDIR/h2o.scforb $BDF_TMPDIR/${BDFTASK}.inporb


Here, the keyword ''guess=readmo'' is used to specify the initial guess track to be read. The initial guess track is a copy command guided by %''
The h2o.scforb file in the folder defined by the environment variable BDF_WORKDIR is copied as the ${BDFTASK}.inporb file in BDF_TMPDIR.
Here, BDF_WORKDIR is the directory where the computing task is executed, and BDF_TMPDIR is the directory where the BDF stores temporary files.


Transfer molecular orbitals with other quantum chemistry procedures
------------------------------------------------
Molecular orbital files calculated by different quantum chemical programs can be converted to each other in principle. BDF's SCF module supports reading and storing molecular orbital data in the scforb file format, which can be accessed
The MOKIT(https://gitlab.com/jxzou/mokit) program converts molecular orbital files to transfer molecular orbital data to and from other quantum chemistry programs.

Whether the transformed molecular orbital file can be used normally depends not only on the atomic order, coordinate orientation, and point group symmetry, but also on the form and ordering of the contraction function.
If there is a discrepancy, it will lead to problems in the transformed molecular orbital data, and the purpose of accelerated convergence cannot be achieved. In terms of base groups, even if it is a base group with the same name, due to the different sources of the original data and the difference in the base group version,
The calculated molecular orbital data may also be different, so it is important to carefully compare whether the basis sets used by different procedures are exactly the same. The following takes the s contraction function in the cc-pVTZ base group of H atom as an example, and lists some points to note when comparing the base group.

.. code-block::

   ****
   H 1 2
   S      5    3
                  3.387000E+01
                  5.095000E+00
                  1.159000E+00
                  3.258000E-01
                  1.027000E-01
         6.068000E-03 0.000000E+00 0.000000E+00
         4.530800E-02 0.000000E+00 0.000000E+00
         2.028220E-01 0.000000E+00 0.000000E+00
         0.0000000E+00 1.000000E+00 0.000000E+00
         0.0000000E+00 0.000000E+00 1.000000E+00
   P 2 2
   (omitted)

.. attention::

 * Is the order of the contraction function consistent in both programs? ** If the three columns of contraction factors of the s-function are interchanged, the order of the molecular orbital factors is different.
 Is the contraction form of each contraction function consistent in both programs? ** The first column of shrinkage factors contains only the first three s primitive functions, i.e., (3s)/[1s], while in many programs it is (4s)/[1s], so there will be some differences in the corresponding orbital factors.
 Is the shrinkage factor phase consistent in both programs? ** This is usually found in factor 1.0 of the non-contraction function (see columns 2 and 3), and the built-in base set of individual programs may write the contraction factor of 1.0 as -1.0, resulting in a negative negative sign for the orbital factor.
 When using pseudo-potential base groups, is the data of the pseudo-potential consistent in both programs? The most typical of these is 'def2-problem> 'The problem of the Def2 family of base sets <def2-problem'.

In order to maintain the consistency of the baseset, it is recommended to output the baseset with ExpBas in the Compass module for use by other quantum chemistry programs. Currently, BDF supports the output of five base group formats: Molpro, Molcas, Gaussian, ORCA, and CFour.

In addition to the above factors, some quantum chemistry programs will give priority to the temporary data files in the draft folder in order to speed up the calculation, and if different basis sets or molecular structures happen to be used in the previous calculations, the molecular orbital files will be read abnormally.
In order to avoid such problems in BDF calculations, it is generally necessary to empty the draft folder at the beginning of the calculation, or use random numbers to generate a new draft folder.


Extend the small base group convergence orbit to a large base group initial guess
------------------------------------------------
The initial guess orbital can be generated from different basis sets, which can also accelerate computational convergence. This requires an extension of the initial guess track file.
The orbit expansion should adopt the base group of the same group, such as cc-pVXZ series, ANO-RCC series and other base groups.
Orbit Extensions currently only supports advanced input modes. For the :math:'\ce{CH3CHO}' molecule, first compute with cc-pVDZ, and then expand the orbital to the initial guessed orbital computed by the cc-pVQZ basis set,
Enter the following:

.. code-block:: bdf

    # First SCF calculation using small basis set cc-pvdz
    $compass
    geometry
    C       0.1727682300       -0.0000045651       -0.8301598059
    C      -2.3763311896        0.0000001634        0.5600567139
    H 0.0151760290 0.0000088544 -2.9110013387
    H -2.0873396672 0.0000037621 2.5902220967
    H -3.4601725077 -1.6628370597 0.0320271859
    H -3.4601679801 1.6628382651 0.0320205364
    O       2.2198078005        0.0000024315        0.2188182082
    end geometry
    basis
     cc-pvdz
    unit # set unit of coordinates as Bohr
     Bohr
    $end
     
    $xuanyuan
    $end
     
    $scf
    rhf
    $end
    
    #change chkfil name into chkfil1
    %mv $BDF_WORKDIR/$BDFTASK.chkfil $BDF_WORKDIR/$BDFTASK.chkfil1
    
    $compass
    geometry
    C       0.1727682300       -0.0000045651       -0.8301598059
    C      -2.3763311896        0.0000001634        0.5600567139
    H 0.0151760290 0.0000088544 -2.9110013387
    H -2.0873396672 0.0000037621 2.5902220967
    H -3.4601725077 -1.6628370597 0.0320271859
    H -3.4601679801 1.6628382651 0.0320205364
    O       2.2198078005        0.0000024315        0.2188182082
    end geometry
    basis
     cc-pvqz
    unit
     Bohr
    $end
    
    # change chkfil to chkfil1. notice, should use cp command since we will use
    # "$BDFTASK.chkfil" in the next calculation
    %cp $BDF_WORKDIR/$BDFTASK.chkfil $BDF_WORKDIR/$BDFTASK.chkfil2
    
    # copy converged SCF orbital as input orbital of the module expandmo
    %cp $bdf_workdir/$bdftask.scforb $bdf_workdir/$bdftask.inporb
    
    # Expand orbital to large basis set. The output file is $BDFTASK.exporb
    $expandmo
    overlap
    $end
     
    $xuanyuan
    $end
    
    # use expanded orbital as initial guess orbital
    %cp $BDF_WORKDIR/$BDFTASK.exporb $BDF_WORKDIR/$BDFTASK.scforb
    $scf
    RHF
    guess
     readmo
    iprtmo
     2
    $end

In the input above, the first RHF calculation is performed using the cc-pVDZ base set, and then the convergence orbit of the first SCF calculation is extended to the cc-pVQZ base set using the expandmo module.
Finally, guess=readmo'' is used as the initial guess track to be read into the SCF.

The output of the expandmo module is,

.. code-block:: 

    |******************************************************************************|
    
        Start running module expandmo
        Current time   2021-11-29  22:20:50
    
    |******************************************************************************|
     $expandmo                                                                                                                                                                                                                                                       
     overlap                                                                                                                                                                                                                                                         
     $end                                                                                                                                                                                                                                                            
     /Users/bsuo/check/bdf/bdfpro/ch3cho_exporb.chkfil1
     /Users/bsuo/check/bdf/bdfpro/ch3cho_exporb.chkfil2
     /Users/bsuo/check/bdf/bdfpro/ch3cho_exporb.inporb
      Expanding MO from small to large basis set or revise ...
    
     1 Small basis sets
    
     Number of  basis functions (NBF):      62
     Maxium NBF of shell :        6
    
     Number of basis functions of small basis sets:       62
    
     2 Large basis sets
    
     Number of  basis functions (NBF):     285
     Maxium NBF of shell :       15
    
      Overlap expanding :                     1
     Read guess orb
     Read orbital title:  TITLE - SCF Canonical Orbital
    nsbas_small  62
    nsbas_large 285
    ipsmall   1
    iplarge   1
      Overlap of dual basis ...
      Overlap of large basis ...
     Write expanded MO to scratch file ...
    |******************************************************************************|
    
        Total cpu     time:          0.42  S
        Total system  time:          0.02  S
        Total wall    time:          0.47  S
    
        Current time   2021-11-29  22:20:51
        End running module expandmo
    |******************************************************************************|

It can be seen that the small base group has 62 orbitals and the large base group has 285 orbitals, and expandmo reads the regular orbit of the SCF convergence, expands to the large base group and writes to the temporary file.

The output of the second SCF calculation is,

.. code-block:: 

    /Users/bsuo/check/bdf/bdfpro/ch3cho_exporb.scforb
    Read guess orb:  nden=1  nreps= 1  norb=  285  lenmo=  81225
    Read orbital title:  TITLE - orthognal Expand CMO
    Orbitals initialization is completed.
 
    ........
  Iter. idiis vshift  SCF Energy    DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S)
   1    0   0.000 -152.952976892 122.547522034  0.002218985  0.246735859  0.0000  16.30
   2    1   0.000 -152.983462881  -0.030485988  0.000367245  0.026196100  0.0000  16.83
   3    2   0.000 -152.983976045  -0.000513164  0.000086429  0.006856831  0.0000  17.18
   4    3   0.000 -152.984012062  -0.000036016  0.000016763  0.001472939  0.0000  17.02
   5    4   0.000 -152.984019728  -0.000007666  0.000010400  0.001012788  0.0000  17.42
   6    5   0.000 -152.984021773  -0.000002045  0.000003396  0.000328178  0.0000  17.28
   7    6   0.000 -152.984022197  -0.000000423  0.000001082  0.000075914  0.0000  17.40
   8    7   0.000 -152.984022242  -0.000000044  0.000000154  0.000008645  0.0000  17.28
   9    8   0.000 -152.984022243  -0.000000001  0.000000066  0.000005087  0.0000  19.38
  diis/vshift is closed at iter =   9
  10    0   0.000 -152.984022243  -0.000000000  0.000000007  0.000000584  0.0000  18.95
    
      Label              CPU Time        SYS Time        Wall Time
     SCF iteration time:       517.800 S        0.733 S      175.617 S


.. _momMethod:

The maximal occupancy of molecular orbitals (MOM) method calculates the excited states
------------------------------------------------
MOM (maximum occupation method) is a ΔSCF method that can be used to calculate excited states. Note that this method is abbreviated as full lowercase letters, which distinguishes it from the MOM (maximum overlap method) method, another ΔSCF method.
                                    
.. code-block:: bdf

    #----------------------------------------------------------------------
    # 
    # mom method: J. Liu, Y. Zhang, and W. Liu, J. Chem. Theory Comput. 10, 2436 (2014).
    #
    # gs  = -169.86584128
    # from = -169.62226127
    # T = -169.62483480
    # w(S)= 6.69eV
    #----------------------------------------------------------------------
    $COMPASS 
    Title
     mom
    Basis
     6-311++GPP
    Geometry
     C       0.000000    0.418626    0.000000
     H -0.460595 1.426053 0.000000
     O       1.196516    0.242075    0.000000
     N -0.936579 -0.568753 0.000000
     H -0.634414 -1.530889 0.000000
     H -1.921071 -0.362247 0.000000
    End geometry
    Check
    $END
    
    $XUANYUAN
    $END
    
    $SCF
    DOOR
    DFT
    B3LYP
    alpha
      10 2
    beta
      10 2
    $END
    
    %cp ${BDFTASK}.scforb $BDF_TMPDIR/${BDFTASK}.inporb

    # delta scf with mom
    $SCF
    DOOR
    DFT
    B3LYP
    guess
     readmo
    alpha
     10 2
    beta
     10 2
    ifpair
    hpalpha
     1
     10 0 
     11 0 
    iStructure
     2
    $END
   
    # pure delta scf for triplet
    $SCF
    DOOR
    DFT
    B3LYP
    alpha
      11 2
    beta
      9 2
    $END

In this example, three SCF calculations are performed.

* For the first SCF, the ground state of the formamide molecule was calculated using the UKS method. The input uses the keywords alpha and beta to specify the occupancy of the alpha and beta tracks, respectively. The ground state of the formamide molecule is the haplet state S0, and the alpha and beta occupancy specified here are the same. ''10 2''' specifies irreducible means that A' and A' have 10 and 2 orbits, respectively. The SCF module will fill the orbital with electrons according to the construction principle from low to high orbital energy.
* In the second SCF, the S1 state of the formamide molecule was calculated using the UKS and mom methods. The key points here are: 1. Use guess=readmo to specify the convergence orbit of the previous UKS read; 2. The number of occupancy of each symmetry orbital was set by using alpha and beta keywords; 3. The variable ifpair is set, which needs to be used in conjunction with hpalpha and hpbeta to specify the electron excitation of hole-particle - HP orbital pairs. 4 The hpalpha variable is set to specify the excitation of the HP orbital pairs. The number 1 indicates the excitation of a pair of HP orbitals, the following two rows specify the excitation of the orbitals, and the first column indicates that the electrons of the 10th alpha orbital are excited to the 11th alpha orbital in the first irreducible representation; The elements of the second column are all zero, indicating that the second irreducible orbital is not excited; 5 The iaufbau variable is set to 2 to specify that the MOM calculation is to be performed.
* For the third SCF, the T1 state of the formamide molecule was calculated using the UKS method. In the input, we use the alpha and beta keywords to specify the orbital occupancy, where the alpha orbital occupies 11 2'', which means that the alpha orbital with symmetry A' and A" has 11 and 2 electrons occupied, respectively, and the beta orbital occupies ''9 2''. Since the state of the required solution is the state with the lowest energy for a given number of orbital occupancy, there is no need to specify iaufbau.

Here, the convergence result of the first SCF calculation is,

.. code-block:: 

     Superposition of atomic densities as initial guess.
     skipaocheck T F
     Solve HC=EC in pflmo space. F       12       75
     Initial guess energy =   -169.2529540680
    
     [scf_cycle_init_ecdenpot]
    Meomory for coulpotential         0.00  G
    
     Start SCF iteration......
    
    Iter. idiis vshift  SCF Energy    DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S)
     1    0   0.000 -169.411739263  -0.158785195  0.005700928  0.163822560  0.0000   0.20
    Turn on DFT calculation ...
     2    1   0.000 -169.743175119  -0.331435856  0.008905349  0.340815886  0.0000   0.42
     3    2   0.000 -169.232333660   0.510841459  0.006895796  0.296788710  0.0000   0.43
     4    3   0.000 -169.863405142  -0.631071482  0.000364999  0.015732911  0.0000   0.43
     5    4   0.000 -169.863345847   0.000059295  0.000209771  0.009205878  0.0000   0.42
     6    5   0.000 -169.865811301  -0.002465454  0.000027325  0.000606909  0.0000   0.43
     7    6   0.000 -169.865831953  -0.000020651  0.000008039  0.000357726  0.0000   0.43
     8    7   0.000 -169.865833199  -0.000001246  0.000003927  0.000114311  0.0000   0.42
     9    8   0.000 -169.865833401  -0.000000201  0.000000182  0.000004399  0.0000   0.43
    diis/vshift is closed at iter =   9
    10    0   0.000 -169.865833402  -0.000000000  0.000000139  0.000003885  0.0000   0.43
    
      Label              CPU Time        SYS Time        Wall Time
     SCF iteration time:         8.650 S        0.700 S        4.050 S
    
     Final DeltaE = -4.4343551053316332E-010
     Final DeltaD = 1.3872600382452641E-007 5.00000000000000000002E-005
    
     Final scf result
       E_tot =              -169.86583340
       E_ele =              -241.07729109
       E_nn  =                71.21145769
       E_1e  =              -371.80490197
       E_ne  =              -541.14538673
       E_kin =               169.34048477
       E_ee  =               148.48285541
       E_xc  =               -17.75524454
      Virial Theorem      2.003102

It can be seen that the first SCF calculation uses an atom guess, and the energy of S0 is calculated to be -169.8658334023 a.u. The second SCF calculation is read into the convergence orbit of the first SCF,
And use the mom method to do SCF calculation, the output file first prompts the reading of molecular orbitals, and gives the occupancy situation.

.. code-block::

      [Final occupation pattern: ]

   Irreps: A' A'' 
  
   detailed occupation for iden/irep:      1   1
      1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00
   detailed occupation for iden/irep:      1   2
      1.00 1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00
   Alpha 10.00 2.00

Here, the 10th alpha orbital of ''A''' irreducible representation is the occupying orbit and the 11th orbital is the empty orbit. The second SCF calculation reads in the converging orbital of the first SCF and uses the mom method to do the SCF calculation, and the input requires the electrons of the 10th orbital represented by ''A''' to be excited to the 11th orbital. The output file first prompts the reading of molecular orbitals and gives the occupancy situation.

.. code-block:: 

   Read initial orbitals from user specified file.
  
   /tmp/20117/mom_formamide.inporb
   Read guess orb:  nden=2  nreps= 2  norb=   87  lenmo=   4797
   Read orbital title:  TITLE - SCF Canonical Orbital
  
   Initial occupation pattern: iden=1  irep= 1  norb(irep)=   66
      1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 0.00
      1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00
  
  
   Initial occupation pattern: iden=1  irep= 2  norb(irep)=   21
      1.00 1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00
  
  
   Initial occupation pattern: iden=2  irep= 1  norb(irep)=   66
      1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00
  
  
   Initial occupation pattern: iden=2  irep= 2  norb(irep)=   21
      1.00 1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
      0.00
    
Here, iden=1 is the alpha orbital, and irep=1 refers to the first irreducible representation, and there are a total of norb=66 orbitals, of which the 10th orbital occupies 0.00 and the 11th orbital occupies 1.00. After 14 SCF iterations, the convergent energy of the S1 state is -169.6222628003 a.u., as follows:

.. code-block:: 

    Iter. idiis vshift  SCF Energy    DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S)
     1    0   0.000 -169.505632070 125.031578610  0.020428031  1.463174456  0.0000   0.45
     2    1   0.000 -169.034645773   0.470986296  0.036913522  1.562284831  0.0000   0.43
     3    2   0.000 -165.750862892   3.283782881  0.032162782  1.516480990  0.0000   0.43
     4    3   0.000 -169.560678610  -3.809815718  0.008588866  0.807859419  0.0000   0.43
     5    4   0.000 -169.596211021  -0.035532411  0.003887621  0.367391029  0.0000   0.42
     6    5   0.000 -169.620128518  -0.023917496  0.001826050  0.172456003  0.0000   0.43
     7    6   0.000 -169.621976725  -0.001848206  0.000486763  0.044630527  0.0000   0.43
     8    7   0.000 -169.622245116  -0.000268391  0.000113718  0.004980035  0.0000   0.43
     9    8   0.000 -169.622261269  -0.000016153  0.000112261  0.009715905  0.0000   0.42
    10    2   0.000 -169.622262553  -0.000001284  0.000043585  0.004092668  0.0000   0.42
    11    3   0.000 -169.622262723  -0.000000169  0.000031601  0.002792075  0.0000   0.42
    12    4   0.000 -169.622262790  -0.000000067  0.000010125  0.000848297  0.0000   0.43
    13    5   0.000 -169.622262798  -0.000000007  0.000003300  0.000273339  0.0000   0.43
     diis/vshift is closed at iter =  13
    14    0   0.000 -169.622262800  -0.000000002  0.000001150  0.000079378  0.0000   0.42
    
      Label              CPU Time        SYS Time        Wall Time
     SCF iteration time:        13.267 S        0.983 S        6.000 S
    
     Final DeltaE = -1.8403909507469507E-009
     Final DeltaD = 1.1501625138328933E-006 5.00000000000000000002E-005
    
     Final scf result
       E_tot =              -169.62226280
       E_ele =              -240.83372049
       E_nn  =                71.21145769
       E_1e  =              -368.54021347
       E_ne  =              -537.75897296
       E_kin =               169.21875949
       E_ee  =               145.28871749
       E_xc  =               -17.58222451
      Virial Theorem      2.002385
    
    
     [Final occupation pattern: ]
    
     Irreps: A' A'' 
    
     detailed occupation for iden/irep:      1   1
        1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 1.00 0.00
        1.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
        0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
        0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
        0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
        0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
        0.00 0.00 0.00 0.00 0.00 0.00
    
After the SCF converges, the orbital occupation is printed again, and it can be seen that the 10th orbital of ''A'''' in the alpha** orbital is irreducibly represented by no electrons, and the 11th orbital has one electron occupancy.

The third SCF calculation gives the energy of the T1 state as -169.6248370697 a.u., and the output is as follows:

.. code-block:: 

    Iter. idiis vshift  SCF Energy    DeltaE     RMSDeltaD    MaxDeltaD   Damping Times(S)
     1    0   0.000 -169.411739263  -0.158785195  0.083821477  9.141182225  0.0000   0.17
     Turn on DFT calculation ...
     2    1   0.000 -169.480549474  -0.068810211  0.066700318  6.978728919  0.0000   0.40
     3    2   0.000 -169.277735673   0.202813801  0.014778190  0.648183923  0.0000   0.42
     4    3   0.000 -169.613991196  -0.336255522  0.005923909  0.621843348  0.0000   0.42
     5    4   0.000 -169.620096778  -0.006105582  0.001967168  0.164506160  0.0000   0.40
     6    5   0.000 -169.623636999  -0.003540220  0.002722812  0.246425639  0.0000   0.42
     7    6   0.000 -169.624704514  -0.001067515  0.001064536  0.098138798  0.0000   0.42
     8    7   0.000 -169.624814882  -0.000110368  0.000525436  0.046392861  0.0000   0.42
     9    8   0.000 -169.624834520  -0.000019637  0.000179234  0.012966641  0.0000   0.42
    10    2   0.000 -169.624836694  -0.000002174  0.000063823  0.004902276  0.0000   0.42
    11    3   0.000 -169.624836922  -0.000000227  0.000017831  0.001440089  0.0000   0.43
    12    4   0.000 -169.624837025  -0.000000103  0.000034243  0.002618897  0.0000   0.42
    13    5   0.000 -169.624837065  -0.000000039  0.000006158  0.000466001  0.0000   0.40
    14    6   0.000 -169.624837068  -0.000000003  0.000003615  0.000354229  0.0000   0.42
    diis/vshift is closed at iter =  14
    15    0   0.000 -169.624837069  -0.000000001  0.000000966  0.000070404  0.0000   0.42
   
     Label              CPU Time        SYS Time        Wall Time
    SCF iteration time:        13.150 S        0.950 S        5.967 S
   
    Final DeltaE = -1.1375220765330596E-009
    Final DeltaD = 9.6591808698539483E-007 5.000000000000000002E-005
   
    Final scf result
      E_tot =              -169.62483707
      E_ele =              -240.83629476
      E_nn  =                71.21145769
      E_1e  =              -368.57834907
      E_ne  =              -537.80483706
      E_kin =               169.22648799
      E_ee  =               145.32683246
      E_xc  =               -17.58477815
     Virial Theorem      2.002354

.. note::

 For the mom calculation of some systems, the SMH convergence algorithm enabled by default in BDF may hinder convergence, so you can try to add the NoSMH keyword to the $scf block, which has a certain probability of causing the SCF to converge. If it still doesn't work, you can refer to the method of solving the SCF non-convergence problem in the next section to solve the convergence problem of mom calculation.

.. _SCFConvProblems:

Deal with the non-convergence problem of self-consistent field calculations
------------------------------------------------
When the SCF calculation is completed, the user must check whether the SCF is converging, and only under the premise of convergence can the results of the SCF calculation (energy, population analysis, orbital energy, etc.) be used and subsequent calculations can be performed. Note that whether the SCF converges cannot be judged only by whether there is an error at the end of the output file, because even if the SCF does not converge, the program will not exit immediately, but only after the output of the SCF iteration and before the output of the SCF energy, prompting:

.. code-block::

    Warning !!! Total energy not converged!
    
EVEN IN THIS CASE, THE PROGRAM WILL STILL PRINT THE ENERGY, ORBITAL INFORMATION, AND DISTRIBUTION ANALYSIS RESULTS AFTER THIS INFORMATION, WITH THE SCF ENERGY FOLLOWED BY THE WORD "NOT CONVERGED". Although these results cannot be used as formal calculations, they can be helpful in analyzing the reasons for the non-convergence of SCF.

Common causes of SCF non-convergence include:

 1. The HOMO-LUMO energy gap is too small, resulting in repeated changes in the occupancy of the front-line track. For example, in the Nth SCF iteration, :math:'\psi_1' and :math:'\psi_2', :math:'\psi_1' is the occupying orbit and :math:'\psi_2' is the empty orbital, but after constructing the Fock matrix and diagonalizing on the basis of such orbital occupancy, the orbital of the N+1st SCF iteration is that the orbital of :math:'\psi_1' is more energetic than :math:'\psi_2' higher, so electrons are transferred from :math:'\psi_1' orbital to :math:'\psi_2' orbital. However, in this way, the Fock matrix of the N+1st SCF iteration will change greatly compared with the Nth SCF iteration, resulting in a lower orbital energy of :math:'\psi_1' than :math:'\psi_2' in the N+2nd SCF iteration, so the orbital occupancy number of SCF iterations returns to the situation of the Nth SCF iteration, so the orbital occupancy number of SCF iterations is always changing and never converges. This is typically characterized by the SCF energy oscillating alternately between the two energies (or oscillating irregularly within a certain range) with an amplitude of around :math:'10^{-4} \sim 1' Hartree, and the number of orbital occupancy printed at the end of the SCF is not as expected.
 2. The HOMO-LUMO energy gap is small, although the number of orbital occupations in each iteration does not change, the orbital shape changes repeatedly, resulting in the non-convergence of SCF oscillation. The typical behavior of this situation is similar to the previous one, but the amplitude of the oscillation is generally slightly smaller, and the number of orbital occupancy printed after the end of the SCF is consistent with the expected qualitative characterization.
 3. The numerical integration grid is too small or the double electron integration accuracy is too low, resulting in a small amplitude oscillation of the SCF due to the numerical error and not converging. This is typically characterized by the irregular oscillation of the SCF energy in amplitude below :math:'10^{-4}' Hartree, and the number of orbital occupancy printed after the end of the SCF is consistent with the expected qualitative characterization.
 4. The base set is close to linear correlation, or the projection of the base set on the lattice point is close to linear correlation because the lattice points are too small. This is typically characterized by a change in the SCF energy in amplitude of more than 1 Hartree (not necessarily oscillating, but may be monotonic or basically monotonic), the SCF energy is much lower than expected, and the number of orbital occupancy printed after the end of the SCF is completely unrealistic. When the SCF energy is much lower than expected, the SCF energy may not even be displayed as a number, but as a string of asterisks.
 
The following are common workarounds for various types of SCF non-convergence issues (to some extent, for software other than BDF):

 1. Add energy level movement vshift, which is suitable for Type 1 and Type 2 cases, by adding the following to the $scf module of the input file:

.. code-block:: bdf

 vshift
  0.2

If a pronounced oscillation is still observed, gradually increase the vshift until it converges. vshift tends to make the convergence of SCF monotonous, but setting vshift too large increases the number of iterations of convergence used, so maxiter can be added when adding vshift. When vshift is increased to 1.0 and still fails to converge, other approaches should be considered.

 2. Increase the density matrix damping damp, which is suitable for the Type 2 case (and has a little effect on the Type 1 case as well) by adding the following to the $scf module of the input file:
 
.. code-block:: bdf

 damp
  0.7

Note that damp can be used in conjunction with vshift, and the effects of the two are mutually reinforcing to a certain extent. If the damping is set to 0.7 and a significant oscillation is still observed, then increase the damping with a guaranteed damping of less than 1, e.g. 0.9, 0.95, etc. Similar to vshift, damp also tends to improve the monotonicity of SCF convergence, but damp that is too large will cause the convergence to be slower, so maxiter can be increased. When damp to 0.99 still fails to converge, other methods should be considered.

 3. Disable DIIS for Category 1 and Category 2 cases, and the addition of vshift and damp does not converge. In most cases, DIIS will accelerate the convergence of SCF, but when the HOMO-LUMO energy gap is particularly small, it may slow down or even prevent the convergence, in the latter case, you can add the NoDIIS keyword to the $scf module to turn off DIIS, add maxiter, and set vshift and damp according to the convergence situation.
 4. Disable SMH, which is applicable to Category 1 and Category 2 cases, and the first 3 methods do not work, by adding the NoSMH keyword to the $scf module, adding maxiter, and setting vshift and damp according to the convergence situation. At present, it seems that at least for ground state calculations, there are very few cases where SMH does not converge or does not use SMH, but because SMH is a very new SCF convergence method :cite:'SMH', it cannot be ruled out that SMH can have a negative impact on convergence in rare cases, so turning off SMH can be an alternative.
 5. Switch to FLMO or iOI methods, which are suitable for Class 1 and Type 2 cases, when the molecule is large (e.g., greater than 50 atoms) and it is suspected that the SCF does not converge because the initial guess accuracy of the atom is too low or qualitative error is wrong. For instructions, see the section on FLMO and iOI methods <FLMOMethod.rst>.
 6. Calculate a similar system that is easier to converge, and then use the wave function of the system as the initial guess to converge the original system, which is applicable to the first and second types of cases. For example, the SCF calculation of a neutral transition metal complex does not converge, and the monovalent cation of its closed shell can be calculated, and the orbital of the monovalent cation is used as the initial guess to calculate the SCF of the neutral molecule after convergence (but note that because BDF does not yet support reading the RHF/RKS wave function as the first guess of UHF/UKS calculation, the monovalent cation of the closed shell should be calculated by UHF/UKS). In extreme cases, it is even possible to calculate the high-valent cation first, and then add a small number (e.g., 2) electrons to reconverge the SCF, and then add a small number of electrons, and so on until the wave function of the original neutral system is obtained. Another commonly used method is to perform SCF calculations under the small base group first, and then use the expandmo module <expandmo.rst>' to project the SCF orbitals of the small base group onto the primary base group, and then iterate the SCF under the original base group until convergence.
 7. Increase the grid points, which is applicable to Category 3 cases and is sometimes valid for Category 4 cases. This is done by using grid keywords such as:
 
.. code-block:: bdf

 grid
  end

Note: (1) For meta-GGA functionals, the default grid is already fine, so the grid should be set to ultra fine at this time; (2) Increasing the grid point will increase the time consumption of each step of SCF iteration; (3) Increasing the grid point will make the convergent energy incomparable with other calculations that do not change the grid, so if you want to compare this calculation with a previous calculation, or compare the energy/free energy obtained from this calculation with the results of other calculations, etc., you must recalculate all the relevant calculations that have been done with the same grid points as this input file, even if those calculations that have already been done can converge without increasing the grid points, you need to do so. If there is no improvement in the results after increasing the number of points, you should try other methods; If the results improve but still do not converge, further attempts can be made to change fine to ultra fine; If convergence is still not possible, the following approach should be considered.

 8. Set a strict threshold for double electron integration for Category 3 cases and sometimes for Category 4 cases. To do this, add the following to the SCF module:
 
.. code-block:: bdf

 optscreen
  1

This method will also increase the time taken by each step of the SCF iteration, and will also lead to the incomparability between the calculation results and the calculation results without optscreen. This method is only applicable to calculations that do not enable MPEC or MPEC+COSX.

 9. Loosen the threshold for determining the linear correlation of the base group for Category 4 cases. To do this, add the following to the $scf module:
 
.. code-block:: bdf

 checklin
 tollin
  1.d-6

This method results in calculations that are not comparable to those without these keywords. It is not recommended to set tollin to be larger than 1.d-5, otherwise it will introduce a large error, if tollin is set to 1.d-5 and still there is a category 4 non-convergence situation, then the above methods such as increasing the lattice point and changing the two-electron integration threshold should be considered.

Note that if one of the above methods does not make the SCF converge, but the SCF converges better than before, it should be used when trying the next method

.. code-block:: bdf

 guess
  readmo

Read the track of the last SCF iteration of the previous method as a preliminary guess. However, if the former method causes the SCF convergence to deteriorate, you should start with the atom guess again when trying the next method, or pick the orbit of the last iteration of the other method you have tried before (of course, this requires you to back up the orbits obtained by each SCF convergence method in advance).

Acceleration algorithm for self-consistent field computing
------------------------------------------------
.. _MPECCOSX:

An important feature of BDF is the use of the MPEC+COSX method to accelerate the energy and gradient calculations of SCF and TDDFT. To set up the MPEC+COSX calculation, enter the following inputs:

.. code-block:: bdf

    #! amylose2.sh
    HF/cc-pvdz  MPEC+COSX

    Geometry
    H -5.27726610038004 0.15767995434597 1.36892178079618
    H -3.89542800401751 -2.74423996083456 -2.30130324998720
    H -3.40930212959730 3.04543096108345 1.73325487719318
    O      -4.25161610042910    -0.18429704053319     1.49882079466485
    H -4.12153806480025 0.39113300040060 -0.47267019103680
    O      -3.93883902709049    -2.16385597983528    -1.37984323910654
    H -3.65755506365314 -2.55190701717719 0.56784675873394
    H -2.66688104102718 -3.13999999152083 -0.32869523309397
    O      -3.68737510690803     2.57255697808269     0.79063986197194
    H -2.16845111442446 1.40439897322928 1.59675986910159
    H -0.80004208156425 3.67692503357694 -0.87083105709857
    C      -3.47036908085237     0.21757398797107     0.38361581865084
    C      -3.08081604941874    -2.23618399620817    -0.25179522317288
    H -1.85215308213129 -1.05270701067006 0.92020982572454
    C      -2.73634509645279     1.50748698767418     0.67208385967460
    O      -0.95388209186676     2.93603601652216    -0.08659407523165
    H -2.34176605974133 2.08883703173396 -1.35500112054343
    C      -2.46637306624908    -0.89337899823852     0.07760781649778
    C      -1.77582007601201     1.83730601785282    -0.45887211416401
    O      -1.70216504605578    -0.48600696920536    -1.07005315975028
    H -0.26347504436884 0.90841605388912 -1.67304510231922
    C      -0.87599906000257     0.65569503172715    -0.80788211986139
    H 1.05124197574425 -4.08129295376550 -0.80486617677089
    H 1.91283792081157 2.93924205088598 -0.71300301703422
    O       0.07007992244287     0.29718501862843     0.19143889205868
    H 1.28488995808993 -0.48228594245462 -1.27588009910221
    O       0.83243796215244    -3.05225096122844    -0.51820416035526
    H 0.03099092283770 -2.15700599981123 1.08682384153403
    H 0.99725792474852 -3.21082099855794 1.38542783977374
    O       1.92550793896406     1.99389906198042    -1.25576903593383
    H 2.32288890226196 1.52348902475463 0.72949896259198
    H 5.42304993860699 1.71940008598879 -1.13583497057179
    C       1.35508593454345    -0.11004196264200    -0.25348109013556
    C       0.98581793175676    -2.43946398581436     0.75228585517262
    H 1.91238990103301 -0.83125899736406 1.66788890655085
    C       2.32240292575108     1.05122704465611    -0.25278704698785
    O       4.65571492366175     1.63248206459704    -0.36643098789343
    H 3.77658595927138 0.23304608296485 -1.60079803407907
    C       1.86060292384221    -1.20698497780059     0.68314589788694
    C       3.72997793572998     0.57134806164321    -0.56599702816882
    O       3.14827793673614    -1.62888795836893     0.20457391544942
    H 5.12279093584136 -0.96659193933436 0.00181296891020
    C       4.14403492674986    -0.60389595307832     0.31494395641232
    O       4.31314989648861    -0.29843197973243     1.69336596603165
    H 3.37540288537848 0.07856300492440 2.10071295465512
    End geometry

If you are in advanced input mode, you only need to add the keyword "MPEC+COSX" to the input of the COMPASS module, such as:

.. code-block:: bdf

    $compass
    Geometry
    H -5.27726610038004 0.15767995434597 1.36892178079618
    H -3.89542800401751 -2.74423996083456 -2.30130324998720
    H -3.40930212959730 3.04543096108345 1.73325487719318
    O      -4.25161610042910    -0.18429704053319     1.49882079466485
    H -4.12153806480025 0.39113300040060 -0.47267019103680
    O      -3.93883902709049    -2.16385597983528    -1.37984323910654
    H -3.65755506365314 -2.55190701717719 0.56784675873394
    H -2.66688104102718 -3.13999999152083 -0.32869523309397
    O      -3.68737510690803     2.57255697808269     0.79063986197194
    H -2.16845111442446 1.40439897322928 1.59675986910159
    H -0.80004208156425 3.67692503357694 -0.87083105709857
    C      -3.47036908085237     0.21757398797107     0.38361581865084
    C      -3.08081604941874    -2.23618399620817    -0.25179522317288
    H -1.85215308213129 -1.05270701067006 0.92020982572454
    C      -2.73634509645279     1.50748698767418     0.67208385967460
    O      -0.95388209186676     2.93603601652216    -0.08659407523165
    H -2.34176605974133 2.08883703173396 -1.35500112054343
    C      -2.46637306624908    -0.89337899823852     0.07760781649778
    C      -1.77582007601201     1.83730601785282    -0.45887211416401
    O      -1.70216504605578    -0.48600696920536    -1.07005315975028
    H -0.26347504436884 0.90841605388912 -1.67304510231922
    C      -0.87599906000257     0.65569503172715    -0.80788211986139
    H 1.05124197574425 -4.08129295376550 -0.80486617677089
    H 1.91283792081157 2.93924205088598 -0.71300301703422
    O       0.07007992244287     0.29718501862843     0.19143889205868
    H 1.28488995808993 -0.48228594245462 -1.27588009910221
    O       0.83243796215244    -3.05225096122844    -0.51820416035526
    H 0.03099092283770 -2.15700599981123 1.08682384153403
    H 0.99725792474852 -3.21082099855794 1.38542783977374
    O       1.92550793896406     1.99389906198042    -1.25576903593383
    H 2.32288890226196 1.52348902475463 0.72949896259198
    H 5.42304993860699 1.71940008598879 -1.13583497057179
    C       1.35508593454345    -0.11004196264200    -0.25348109013556
    C       0.98581793175676    -2.43946398581436     0.75228585517262
    H 1.91238990103301 -0.83125899736406 1.66788890655085
    C       2.32240292575108     1.05122704465611    -0.25278704698785
    O       4.65571492366175     1.63248206459704    -0.36643098789343
    H 3.77658595927138 0.23304608296485 -1.60079803407907
    C       1.86060292384221    -1.20698497780059     0.68314589788694
    C       3.72997793572998     0.57134806164321    -0.56599702816882
    O       3.14827793673614    -1.62888795836893     0.20457391544942
    H 5.12279093584136 -0.96659193933436 0.00181296891020
    C       4.14403492674986    -0.60389595307832     0.31494395641232
    O       4.31314989648861    -0.29843197973243     1.69336596603165
    H 3.37540288537848 0.07856300492440 2.10071295465512
    End geometry
    Basis
      CC-PVDZ
    MPEC+COSX # ask for the MPEC+COSX method
    $end

The SCF module will output a hint about whether MPEC+COSX is set to True:

.. code-block:: bdf

    --- PRINT: Information about SCF Calculation --- 
    ICTRL_FRAGSCF=  0
    IPRTMO= 1
    MAXITER= 100
    THRENE= 0.10E-07 THRDEN= 0.50E-05
    DAMP= 0.00 VSHIFT= 0.00
    IFDIIS= T
    THRDIIS= 0.10E+01
    MINDIIS= 2 MAXDIIS= 8
    iCHECK= 0
    iBUILD= 1
    INIGUESS= 0
    IfMPEC= T
    IfCOSX= T

Here, ''IfMPEC= T'' , and ''IfCOSX= T'' illustrate that the MPEC+COSX method is used for the calculation. The SCF iteration process is as follows:

.. code-block:: bdf

     [scf_cycle_init_ecdenpot]
    Meomory for coulpotential         0.02  G
    
     Start SCF iteration......
    
    
    Iter.   idiis  vshift       SCF Energy            DeltaE          RMSDeltaD          MaxDeltaD      Damping    Times(S) 
       1      0    0.000   -1299.6435521238     -23.7693069405       0.0062252375       0.2842668435    0.0000      2.69
       2      1    0.000   -1290.1030630508       9.5404890730       0.0025508000       0.1065204344    0.0000      1.65
       3      2    0.000   -1290.2258798561      -0.1228168053       0.0014087449       0.0742227520    0.0000      1.67
       4      3    0.000   -1290.4879683983      -0.2620885422       0.0002338141       0.0153879051    0.0000      1.64
       5      4    0.000   -1290.4955210658      -0.0075526675       0.0000713807       0.0049309441    0.0000      1.57
       6      5    0.000   -1290.4966349620      -0.0011138962       0.0000156009       0.0010663736    0.0000      1.51
       7      6    0.000   -1290.4966797420      -0.0000447800       0.0000043032       0.0002765334    0.0000      1.44
       8      7    0.000   -1290.4966810419      -0.0000012999       0.0000014324       0.0000978302    0.0000      1.37
       9      8    0.000   -1290.4966794202       0.0000016217       0.0000003030       0.0000173603    0.0000      1.40
      10      2    0.000   -1290.4966902283      -0.0000108081       0.0000000659       0.0000034730    0.0000      1.11
     diis/vshift is closed at iter =  10
      11      0    0.000   -1290.5003691464      -0.0036789181       0.0000225953       0.0009032949    0.0000      5.85
    
      Label              CPU Time        SYS Time        Wall Time
     SCF iteration time:       179.100 S        1.110 S       22.630 S
    
     Final DeltaE = -3.678918126752251E-003
     Final DeltaD = 2.259533940614071E-005 5.0000000000000000E-005
     
     Final scf result
       E_tot =             -1290.50036915
       E_ele =             -3626.68312754
       E_nn  =              2336.18275840
       E_1e  =             -6428.96436179
       E_ne  =             -7717.90756825
       E_kin =              1288.94320647
       E_ee  =              2802.28123424
       E_xc  =                 0.00000000
      Virial Theorem      2.001208

On a desktop with an i9-9900K CPU, 8 OpenMP threads took 22 seconds to compute in parallel. Under the same conditions, the SCF calculation is not accelerated by the MPEC+COSX method, and the calculation takes 110 seconds, which is about 5 times faster than the MPEC+COSX method.
