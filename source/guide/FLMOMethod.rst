iOI-SCF calculation and FLMO method for large systems
========================================

For large systems (e.g., systems with more than 300 atoms), traditional SCF calculation methods are often no longer suitable because, in addition to the longer time required to build the Fock matrix at each step, the following factors are included:

 * The Fock matrix diagonalization time increases as a proportion of the total computational time. When the system is large enough, the construction time of each step of the Fock matrix is proportional to the square of the system size, but the Fock matrix is proportional to the diagonalization time and the cubic of the system size, so for particularly large systems (e.g., thousands of atoms), the proportion of Fock matrix diagonalization to the total computation time will be considerable.
 * Large systems have more local stable wave functions, which reduces the probability of the large system SCF computation converging to the desired state. In other words, the SCF may converge to many different solutions, only one of which is what the user wants, thus increasing the time overhead of the user judging whether the SCF solution is the solution they want, and (if it converges to an undesired solution) resubmitting the computation.
 * SCF convergence is more difficult for large systems than for small systems, requiring more iteration steps, or even no convergence at all. In addition to the fact that there are many local stable solutions mentioned above, this is partly due to the fact that the mass of the general atomic density-based SCF deteriorates as the system increases.
 
One solution to the above problem is to divide the system into several fragments (this process is called sharding; These fragments can overlap each other), SCF is done for each fragment separately, and then the convergent wave function of all fragments is summarized as the initial guess of the total system SCF calculation. The FLMO method (Fragment localized molecular orbital) of BDF is a shard-based method, in which after the SCF of each fragment converges, the program localizes the wave function of each fragment, and then uses the obtained local orbit to generate the initial guess of the total system calculation. Doing so has some additional benefits compared to a sharding approach that doesn't rely on local tracks:

 * The SCF iteration can be carried out on the local orbital base, and the Fock matrix does not need to be fully diagonalized under the local orbital base, but only needs to be diagonalized by blocks, that is, the orbit can be rotated so that the occupy-empty block is zero, and the computational effort of this step is smaller than that of full diagonalization.
 * The occupancy-empty blocks of the Fock matrix under the local orbital base are very sparse, and this sparsity can be used to further reduce the computational cost of the diagonalization of the blocks.
 * The user can specify the number of occupancy of a local orbit before the global SCF calculation, so as to selectively obtain the occupied or unoccupied electronic states of the local orbital, for example, calculate the metal cluster composed of one Fe(II) and one Fe(III), and control which Fe converges to the bivalent configuration and which Fe converges to the trivalent configuration by specifying the occupancy number of the Fe 3d orbital. In the current version of BDF, there is actually another approach that directly specifies the formal oxidation and spin states of atoms (see below). For the sake of convenience, it is generally recommended that the user specify which electronic state to converge to directly from the oxidation state and spin state of the atom.
 * The SCF calculation directly obtains the convergent local orbit, instead of only the regular orbit as in the general SCF calculation. If the user needs to obtain the convergent local orbit for wave function analysis, then the FLMO method can save a lot of computational time compared with the traditional method of obtaining the regular orbit first and then localizing it, and can also avoid the problem of many iterations of localized and easy non-convergence of large systems.

FLMO has been used to obtain localized orbitals of molecules, iOI-SCF, FLMO-MP2, O(1)-NMR, etc., and can also calculate the singlet state of open shells, which is used to study problems such as single-molecule magnets.

Computation of Fragmented Localized Molecular Orbital FLMO (Manual Sharding)
--------------------------------------------

In order to give users an intuitive understanding of FLMO, we give an example of FLMO calculation. Here, we need to calculate the localized orbitals of the 1,3,5,7-octatetraene:math:'\ce{C8H10}' molecule by FLMO method.
Let's start by counting 4 molecular sheets, each of which is composed of a central atom, a buffer atom (marked with a "B" after the atomic coordinates, note that there must be at least one space between the "B" and the atomic coordinates), and a linked H atom (marked by adding an "L" after the atomic coordinates, note that there must be at least one space between the "L" and the atomic coordinates). Because the molecular structure is relatively simple, the molecular sheet here is obtained by manual fragmentation, that is, the central atom of each molecular sheet is a C=C double bond and all the hydrogen atoms connected to it, and the buffer atom is the C=C double bond directly connected to the C=C double bond and the hydrogen atom it carries, that is, the molecular sheet 1 and molecular sheet 4 are 1,3-butadiene, and the molecular sheet 2 and molecular sheet 3 are 1,3,5-hexamethylene. After the calculation and convergence of the molecular slice SCF, the molecular slice localization orbit was obtained by the Boys localization method. After all the molecular slice calculations were completed, the localized orbitals of the four molecular slices were used to synthesize the pFLMO (primitive fragment localized molecular orbital) of the whole molecule. The pFLMO was used to make an initial guess, and the entire :math:'\ce{C8H10}' molecule was calculated, and the localized FLMO was obtained. An example of the input is as follows:

.. code-block:: bdf

  ###### Fragment 1
  %echo "-------CHECKDATA: Calculate the 1st fragment -------------"
  $COMPASS 
  Title
   Fragment 1
  Basis
   6-31G
  Geometry
   c   0.5833330000  0.0   0.0000000000   
   c   1.9203330000  0.0   0.0000000000   
   h 0.0250410000 0.0 -0.9477920000   
   h 0.0250620000 0.0 0.9477570000   
   h 2.4703130000 0.0 -0.9525920000   
   c   2.6718330000  0.0   1.3016360000    B
   c   4.0088330000  0.0   1.3016360000    B
   h 4.7603330000 0.0 2.6032720000 L
   h   2.1218540000  0.0   2.2542280000    B 
   h   4.5588130000  0.0   0.3490440000    B
  End geometry
  $END
  
  $XUANYUAN
  $END
  
  $SCF
  RHF
  iprtmo
   2
  $END
  
  $localmo
  FLMO
  $end
  
  # copy pFLMO punch file
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_TMPDIR/fragment1
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_WORKDIR/fragment1
  
  ##### Fragment 2
  %echo "-------CHECKDATA: Calculate the 2nd fragment -------------"
  $COMPASS 
  Title
   Fragment 2
  Basis
   6-31G
  Geometry
   c   0.5833330000  0.0   0.0000000000    B
   c   1.9203330000  0.0   0.0000000000    B
   h 0.0250410000 0.0 -0.9477920000 L
   h   0.0250620000  0.0   0.9477570000    B
   h   2.4703130000  0.0  -0.9525920000    B
   c   2.6718330000  0.0   1.3016360000     
   c   4.0088330000  0.0   1.3016360000
   h 2.1218540000 0.0 2.2542280000
   h 4.5588130000 0.0 0.3490440000
   c   4.7603330000  0.0   2.6032720000    B
   c   6.0973330000  0.0   2.6032720000    B
   h   4.2103540000  0.0   3.5558650000    B
   h   6.6473130000  0.0   1.6506800000    B
   h 6.8488330000 0.0 3.9049090000 L
  End geometry
  $END
  
  $XUANYUAN
  $END
  
  $SCF
  RHF
  iprtmo
   2
  $END
  
  $localmo
  FLMO
  $end
  
  # copy pFLMO punch file
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_TMPDIR/fragment2
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_WORKDIR/fragment2
  %ls -l $BDF_TMPDIR
  %rm -rf $BDF_TMPDIR/$BDFTASK.*
  
  # Fragment 3
  %echo "-------CHECKDATA: Calculate the 3rd fragment -------------"
  $COMPASS 
  Title
   Fragment 3
  Basis
   6-31G
  Geometry
    c   2.6718330000  0.0   1.3016360000  B
    c   4.0088330000  0.0   1.3016360000  B
    h 1.9203330000 0.0 0.0000000000 L
    h   2.1218540000  0.0   2.2542280000  B
    h   4.5588130000  0.0   0.3490440000  B
    c   4.7603330000  0.0   2.6032720000  
    c   6.0973330000  0.0   2.6032720000
    h 4.2103540000 0.0 3.5558650000
    h 6.6473130000 0.0 1.6506800000
    c   6.8488330000  0.0   3.9049090000  B
    c   8.1858330000  0.0   3.9049090000  B
    h   6.2988540000  0.0   4.8575010000  B
    h 8.7441260000 0.0 4.8527010000 L
    h   8.7441050000  0.0   2.9571520000  B
  End geometry
  $END
  
  $XUANYUAN
  $END
  
  $SCF
  RHF
  iprtmo
   2
  $END
  
  # flmo_coef_gen=1, iprt=2, ipro=(6,7,8,9), icut=(3,13),
  $localmo
  FLMO
  $end
  
  # copy pFLMO punch file
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_TMPDIR/fragment3
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_WORKDIR/fragment3
  %ls -l $BDF_TMPDIR
  %rm -rf $BDF_TMPDIR/$BDFTASK.*
  
  # Fragment 4
  %echo "-------CHECKDATA: Calculate the 4th fragment -------------"
  $COMPASS 
  Title
   Fragment 4
  Basis
   6-31G
  Geometry
    h 4.0088330000 0.0 1.3016360000 L
    c   4.7603330000  0.0   2.6032720000  B
    c   6.0973330000  0.0   2.6032720000  B
    h   4.2103540000  0.0   3.5558650000  B
    h   6.6473130000  0.0   1.6506800000  B
    c   6.8488330000  0.0   3.9049090000  
    c   8.1858330000  0.0   3.9049090000
    h 6.2988540000 0.0 4.8575010000
    h 8.7441260000 0.0 4.8527010000
    h 8.7441050000 0.0 2.9571520000
  End geometry
  $END
  
  $XUANYUAN
  $END
  
  $SCF
  RHF
  iprtmo
   2
  $END
  
  # flmo_coef_gen=1, iprt=1, ipro=(6,7,8,9,10), icut=(1) 
  $localmo
  FLMO
  $end
  
  # copy pFLMO punch file
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_TMPDIR/fragment4
  %cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_WORKDIR/fragment4
  %ls -l $BDF_TMPDIR
  %rm -rf $BDF_TMPDIR/$BDFTASK.*
  
  # Whole Molecule calculation
  %echo "--------CHECKDATA: From fragment to molecular SCF calculation---------------"
  $COMPASS 
  Title
   Whole Molecule calculation
  Basis
   6-31G
  Geometry
    c   0.5833330000  0.0   0.0000000000
    c   1.9203330000  0.0   0.0000000000
    h 0.0250410000 0.0 -0.9477920000
    h 0.0250620000 0.0 0.9477570000
    h 2.4703130000 0.0 -0.9525920000
    c   2.6718330000  0.0   1.3016360000
    c   4.0088330000  0.0   1.3016360000
    h 2.1218540000 0.0 2.2542280000
    h 4.5588130000 0.0 0.3490440000
    c   4.7603330000  0.0   2.6032720000
    c   6.0973330000  0.0   2.6032720000
    h 4.2103540000 0.0 3.5558650000
    h 6.6473130000 0.0 1.6506800000
    c   6.8488330000  0.0   3.9049090000
    c   8.1858330000  0.0   3.9049090000
    h 6.2988540000 0.0 4.8575010000
    h 8.7441260000 0.0 4.8527010000
    h 8.7441050000 0.0 2.9571520000
  End geometry
  Nfragment
   4
  Group
   C(1)
  $END
  
  $XUANYUAN
  $END
  
  $SCF
  RHF
  FLMO
  iprtmo
   2
  sylv
  threshconv
   1.d-8 1.d-6
  $END
  
  &DATABASE
  fragment 1  9        # Fragment 1 with 9 atoms
   1 2 3 4 5 6 7 8 9   # atom number in the whole molecule
  fragment 2 12
   1 2 4 5 6 7 8 9 10 11 12 13
  fragment 3 12
   6 7 8 9 10 11 12 13 14 15 16 18 
  fragment 4 9
   10 11 12 13 14 15 16 17 18 
  &END

In the input, we give a comment. The calculation of each molecular slice consists of four modules: ''compass'', ''xuanyuan'', ''scf'' and ''localmo''. The four steps of preprocessing, integration calculation, SCF calculation and molecular orbital localization are performed respectively, and the shell command is inserted after the localmo module
''cp $BDF_WORKDIR/$BDFTASK.flmo $BDF_TMPDIR/fragment*''
Copy the file **$BDFTASK.flmo** where the localized track is stored to the directory where the **$BDF_TMPDIR is located. After the 4 molecular fragments are calculated, it is the calculation of the whole molecule, and the input is from
``# Whole Molecule calculation``
Begin. In ''compass'', there is the keyword '''Nfragment 4''', which indicates that 4 molecular pieces are to be read, and the molecular fragment information is defined in the '&DATABASE'' field.

For the SCF calculation of the whole molecule, the localized orbitals of the four molecular slices will be read into the pFLMO to construct the pFLMO, and the orbital elongation coefficient Mos (molecular orbital spread) (the larger the Mos of a localized orbital is, the more delocalized the localized orbital is, and vice versa, the more localized the localized orbital), as follows:

.. code-block:: bdf

   Reading fragment information and mapping orbitals ... 

   Survived FLMO dims of frag( 11):       8      17       0      46       9
   Survived FLMO dims of frag( 15):       8      16       0      66      12
   Survived FLMO dims of frag( 15):       8      16       0      66      12
   Survived FLMO dims of frag( 11):       8      17       0      46       9
   Input Nr. of FLMOs (total, occ., soc., vir.) :   98   32   0   66
    nmo != nbas 
                     98                   92
    Local Occupied Orbitals Mos and Moc 
   Max_Mos:    1.89136758 Min_Mos:    0.31699600 Aver_Mos:    1.32004368
    Local Virtual Orbitals Mos and Moc 
   Max_Mos:    2.46745638 Min_Mos:    1.46248295 Aver_Mos:    2.14404812
   The prepared  Nr. of pFLMOs (total, occ., vir.) :   98   32   0   66
  
   Input Nr. of FLMOs (total, double-occ., single-occ, vir.) :   98   32   0   66
   No. double-occ orbitals:        29
   No. single-occ orbitals:         0
   No. virtual    orbitals:        63
  
  iden= 1 29 63 32 66
   Transfer dipole integral into Ao basis ...
  
   Transfer quadrupole integral into Ao basis ...
  
    Eliminate the occupied linear-dependent orbitals !
   Max_Mos:    1.89136758 Min_Mos:    0.31699600 Aver_Mos:    1.32004368
        3 linear dependent orbitals removed by preliminary scan
   Initial MO/AO dimension are :      29     92
    Finally                    29  orbitals left. Number of cutted MO    0
   Max_Mos:    1.89136758 Min_Mos:    0.31699600 Aver_Mos:    1.29690971
   Perform Lowdin orthonormalization to occ pFLMOs
   Project pFLMO occupied components out of virtual FLMOs
   Max_Mos:    2.46467150 Min_Mos:    1.46222542 Aver_Mos:    2.14111949
        3 linear dependent orbitals removed by preliminary scan
   Initial NO, NV, AO dimension are :     29     63     92
    Finally                    92  orbitals left. Number of cutted MO    0
   Max_Mos:    2.46467150 Min_Mos:    1.46222542 Aver_Mos:    2.15946681
   Perform Lowdin orthonormalization to virtual pFLMOs                  63
    Local Occupied Orbitals Mos and Moc 
   Max_Mos:    1.88724854 Min_Mos:    0.31689707 Aver_Mos:    1.29604628
    Local Virtual Orbitals Mos and Moc 
   Max_Mos:    2.53231018 Min_Mos:    1.46240853 Aver_Mos:    2.16493518
   Prepare FLMO time :       0.03 S      0.02 S       0.05 S
   Finish FLMO-SCF initial ...

It can be seen that the maximum Mos of pFLMO of the whole molecule is less than 2.6, and the pFLMO is localized regardless of occupancy or imaginary orbital. The pFLMO was used to make the initial guess of the whole molecule, and the SCF iteration was entered, and the block diagonalization method was used to maintain the minimum perturbation of the orbit, and the output was as follows:

.. code-block:: bdf

   Check initial pFLMO orbital MOS
    Local Occupied Orbitals Mos and Moc 
   Max_Mos:    1.88724854 Min_Mos:    0.31689707 Aver_Mos:    1.29604628
    Local Virtual Orbitals Mos and Moc 
   Max_Mos:    2.53231018 Min_Mos:    1.46240853 Aver_Mos:    2.16493518
    DNR!! 
   Final iter :   79 Norm of Febru  0.86590E-06
   X --> U time: 0.000 0.000 0.000
   Block Diag 0.017 0.000 0.017
    block norm :    2.3273112079137773E-004

    1    0   0.000 -308.562949067 397.366768902  0.002100841  0.027228292  0.0000   0.53
    DNR!! 
   Final iter :   57 Norm of Febru  0.48415E-06
   X --> U time: 0.000 0.000 0.017
   Block Diag 0.000 0.000 0.017
    block norm :    1.3067586006786384E-004

    2    1   0.000 -308.571009930  -0.008060863  0.000263807  0.003230630  0.0000   0.52
    DNR!! 
   Final iter :   43 Norm of Febru  0.64098E-06
   X --> U time: 0.000 0.000 0.000
   Block Diag 0.017 0.000 0.017
    block norm :    3.6831175797520882E-005

After the SCF converges, the system will print the Mos information of the molecular orbital again.

.. code-block:: bdf

   Print pFLMO occupation for checking ...
   Occupied alpha obitals ...
    Local Occupied Orbitals Mos and Moc 
   Max_Mos:    1.91280597 Min_Mos:    0.31692300 Aver_Mos:    1.30442588
    Local Virtual Orbitals Mos and Moc 
   Max_Mos:    2.53288468 Min_Mos:    1.46274299 Aver_Mos:    2.16864691
    Write FLMO coef into scratch file ...               214296
    Reorder orbital via orbital energy ...                    1                    1

It can be seen that the Mos of the final FLMO does not change much compared with pFLMO, and the locality is very good.

THE ABOVE MANUAL FRAGMENTATION METHOD IS CUMBERSOME FOR MOLECULES WITH MORE COMPLEX STRUCTURES, BECAUSE IT IS NOT ONLY NECESSARY TO MANUALLY GIVE THE DEFINITION OF EACH MOLECULAR SHEET, BUT ALSO NEED TO GIVE THE CORRESPONDENCE BETWEEN THE ATOMIC NUMBER OF EACH MOLECULAR SHEET AND THE TOTAL SYSTEM IN THE '&DATABASE'' DOMAIN. In contrast, a more convenient approach is to use the following automatic sharding method.

Calculation of Open Shell Singlet State Using FLMO (Automatic Sharding)
--------------------------------------------

In the study of single-molecule magnets and some catalytic systems, the so-called antiferromagnetic coupling state is often encountered, in which two electrons with opposite spins occupy different atomic centers in the form of an open shell (open shell singlet state), but multiple single electrons may also be involved. BDF can be combined with the FLMO method to calculate the open-shell singlet state. For example, the following example uses the FLMO method to calculate the spin-breaking ground state of a system containing Cu(II) and nitrogen-oxygen stable radicals:

.. code-block::

  $autofrag
  method
   flmo
  nprocs
   2  # ask for 2 parallel processes to perform FLMO calculation
  spinocc
  # Set +1 spin population on atom 9 (O), set -1 spin population on atom 16 (Cu)
   9 +1 16 -1
  # Add no buffer atoms, except for those necessary for saturating dangling bonds.
  # Minimizing the buffer radius helps keeping the spin centers localized in
  # different fragments
  radbuff
   0
  $end
  
  $compass
  Title
   antiferromagnetically coupled nitroxide-Cu complex
  Basis
   LANL2DZ
  Geometry
   C                 -0.16158257   -0.34669203    1.16605797
   C                  0.02573099   -0.67120566   -1.13886544
   H 0.90280854 -0.26733412 1.24138440
   H -0.26508467 -1.69387001 -1.01851639
   C                 -0.81912799    0.50687422    2.26635740
   H -0.52831123 1.52953831 2.14600864
   H -1.88351904 0.42751668 2.19103081
   N -0.38402395 0.02569744 3.58546820
   O                  0.96884699    0.12656182    3.68120994
   C                 -1.01167974    0.84046608    4.63575398
   H -0.69497152 0.49022160 5.59592309
   H -0.72086191 1.86312982 4.51540490
   H -2.07607087 0.76110974 4.56042769
   N -0.40937388 -0.19002965 -2.45797639
   C                 -0.74875417    0.18529223   -3.48688305
   Cu -1.32292113 0.82043400 -5.22772307
   F-1.43762557 -0.29443417 -6.57175160
   F -1.72615042 2.50823941 -5.45404079
   H -0.45239892 -1.36935628 1.28640692
   H 1.09012199 -0.59184704 -1.06353906
   O                 -0.58484750    0.12139125   -0.11715881
  End geometry
  $end
  
  $xuanyuan
  $end
  
  $scf
  door
  dft
   PBE0
  spinmulti
   1
  D3
  Molden
  $end
  
  $localmo
  FLMO
  Pipek # Pipek-Mezey localization, recommended when pure sigma/pure pi LMOs are needed.
        # Otherwise Boys is better
  $end

FLMO calculations do not currently support concise inputs. In this example, the autofrag module is used to automatically shard the molecule and generate the basic input for the FLMO calculation. BDF first generates molecular fragments based on the molecular structure and parameter definition information of autofrag in the compass module, as well as input files for the calculation of molecular fragment localized orbitals. Then, the pFLMO (primitive fragment Local Molecular Orbital) of the whole molecule was assembled with the localized orbital of the molecular fragment as the initial guess orbital for the global SCF calculation, and then the open-shell singlet state of the whole molecule was obtained through the global SCF calculation under the premise of maintaining the localization of each step of the iterative orbital. In the calculation, for the sake of brevity, the output of the molecular fragment calculation is saved as ${BDFTASK}.framgmentN.out'', **N** is the fragment number, and the standard output only prints the output of the whole molecular calculation.

The output will give information about the molecular sharding,

.. code-block::

 ----------- Buffered molecular fragments ----------
  BMolefrag 1: [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 19, 20, 21], [], [14], [14, 15], 0.0, 1.4700001016690913]
  BMolephragm 2: [[14, 15, 16, 17, 18], [2, 4, 20], [21], [21], 0.0, 1.4700001016690913]
 --------------------------------------------------------------------
 Automatically assigned charges and spin multiplicities of fragments:
 --------------------------------------------------------------------
    Fragment  Total No. of atoms  Charge  SpinMult  SpinAlignment
           1 17 0 2 Alpha
           2                   9       0         2           Beta
 --------------------------------------------------------------------
   
    Generate BDF input file ....

Here we can see that we produce two molecular fragments, specifying that the molecular sheet **1** is composed of 17 atoms, and the spin multiplicity is referred to as 2, and the molecular sheet **2** is composed of 9 atoms, and the spin multiplicity is also referred to as 2, but the spin direction is the opposite of the molecular sheet **1**, i.e., the beta electron is one more than the alpha electron, and not the alpha electron is one more than the beta electron. The 2 molecular slices are then calculated separately with the following message (assuming the environment variable ''OMP_NUM_THREADS''' is set to 4):

.. code-block:: bdf

  Starting subsystem calculations ...
  Number of parallel processes:  2
  Number of OpenMP threads per process:  2
  Please refer to test117.fragment*.out for detailed output
  
  Total number of not yet converged subsystems:  2
  List of not yet converged subsystems:  [1, 2]
  Finished calculating subsystem   2 (  1 of   2)
  Finished calculating subsystem   1 (  2 of   2)
  
  Starting global calculation ...

This pays attention to the settings of the compute resources. The total computing resources are the product of the number of parallel processes and the number of OpenMP threads per process, where the number of processes is set by the nprocs keyword of the autofrag module, and the total computing resources are set by the environment variable OMP_NUM_THREADS. The number of threads per process is automatically calculated by dividing the total computing resources by the number of processes.

The computational output of the whole molecule is similar to the ordinary SCF calculation, but the method of diagonal Fock matrix is used to maintain the locality of the orbital.

.. code-block:: bdf

  Check initial pFLMO orbital MOS
   Openshell  alpha :
   Local Occupied Orbitals Mos and Moc
  Max_Mos:    1.89684048 Min_Mos:    0.25791767 Aver_Mos:    1.15865182
   Local Virtual Orbitals Mos and Moc
  Max_Mos:    8.01038107 Min_Mos:    1.56092594 Aver_Mos:    3.04393282
   Openshell  beta  :
   Local Occupied Orbitals Mos and Moc
  Max_Mos:    3.00463332 Min_Mos:    0.21757580 Aver_Mos:    1.24636228
   Local Virtual Orbitals Mos and Moc
  Max_Mos:    8.00411948 Min_Mos:    1.78248588 Aver_Mos:    3.04672070

 ...

    1    0   0.000 -849.642342776 1158.171170064 0.046853948  4.840619682  0.5000   3.54
   DNR!!
  SDNR: warning: rotation angle too large, aborting
  Final iter :    5 Norm of Febru  0.20133E+00
  X --> U time: 0.000 0.000 0.000
  Block Diag 0.000 0.000 0.000
   block norm :   0.290774097871744

   DNR!!
  Final iter :  359 Norm of Febru  0.82790E-06
  X --> U time: 0.000 0.000 0.000
  Block Diag 0.020 0.000 0.010
   block norm :   8.589840290871769E-003


The iteration starts with information about the orbital stretch (**Mos**), and the lower the number, the better the orbital localization. After the SCF converges, it prints **Mos** again. From the results of the Habitat analysis,

.. code-block:: bdf

 [Mulliken Population Analysis]
   Atomic charges and Spin densities :
      1C      -0.2481    0.0010
      2C      -0.1514    0.0013
      3H 0.2511 -0.0002
      4H 0.2638 -0.0006
      5C      -0.3618   -0.0079
      6H 0.2511 0.0240
      7H 0.2436 -0.0013
      8N 0.0128 0.3100
      9O      -0.2747    0.6562
     10C      -0.5938   -0.0092
     11H 0.2696 0.0040
     12H 0.2414 0.0242
     13H 0.2302 -0.0016
     14N 0.1529 -0.0202
     15C      -0.2730    0.0162
     16Cu 0.8131 -0.5701
     17Q -0.5019 -0.2113
     18Q -0.4992 -0.2143
     7 p.m. 0.2207 0.0008
     8 PM 0.2666 -0.0000
     21O      -0.3128   -0.0008
      Sum:    -0.0000    0.0000

It can be seen that the spin density of Cu atom is **-0.5701**, and the spin density of 9O atom is **0.6562**, and their signs are consistent with the prespecified spin, indicating that the calculation does converge to the required open-shell singlet state. Note that the absolute value of the spin density here is less than 1, indicating that the spin density on Cu and 9O is not strictly localized to these two atoms, but partially delocalized to the adjacent atoms.

In the above example, the autofrag module input seems complicated to write, but the spinocc and radbuff keywords are not necessary for the FLMO method, i.e., the input files for the following writing will still run successfully, but it cannot ensure that the spin orientations of Cu and O are user-specified:

.. code-block::

  $autofrag
  method
   flmo
  nprocs
   2
  $end

''nprocs'' means that the SCF computation of each subsystem is parallelized, taking the above example as an example, it is allowed to calculate multiple subsystems at the same time, and no more than 2 subsystems can be computed at any time. If the ''nprocs'' keyword is omitted, which is equivalent to setting ''nprocs'' to 1, the program will calculate all the subsystems in turn, each subsystem occupies 8 OpenMP threads, and each subsystem will be calculated after the calculation of one subsystem is completed. The result of the calculation will not be any different from using nprocs, but the computational efficiency may be reduced. Therefore, ''nprocs'' only affects the efficiency of the FLMO computation, but not its result, i.e. the following can also run successfully, but the computation time may be slightly longer than writing ''nprocs'':

.. code-block::

  $autofrag
  method
   flmo
  $end

It should be noted that setting nprocs is too large or too small, which may lead to an increase in computation time. For the sake of convenience, let's assume that in the FLMO calculation of a larger molecule, the environment variable ''OMP_NUM_THREADS'' is set to 8. rule

.. code-block::

  nprocs
   4

Denote:

 1. When the program starts to calculate the subsystem, it will call 4 concurrent BDF processes at the same time, and each process will calculate a subsystem. If the total number of subsystems N is less than 4, only N concurrent BDF processes are called.
 2. Each BDF process uses 2 OpenMP threads. When the total number of subsystems is less than four, some subsystems may use three or four OpenMP threads for computing, but the number of concurrent OpenMP threads for the entire computing task is always not more than eight.
 3. At the beginning of the computation, the entire computation uses exactly 8 OpenMP threads, but as the computation nears the end, when there are less than 4 subsystems left to complete the computation, the number of OpenMP threads used in the entire computation may be less than 8.

There are two main factors that determine the optimal value of nprocs:

 1. Since the parallel efficiency of OpenMP is generally less than 100%, if you run 4 tasks with the same time and use 2 OpenMP threads for each task, the time taken is generally less than the time it takes for each task to run sequentially and each task uses 8 OpenMP threads.
 2. The calculation time of each subsystem is not exactly the same, and there may even be several times of difference. If some tasks take a longer time than others, then computing these four subsystems at the same time, using 2 threads for each subsystem, may be slower than using 8 threads for each subsystem, because when these 4 subsystems are computed at the same time, some computing resources will be idle in the later stage of computing. This is known as the load balancing problem.

As a result, nprocs that are too small or too large can lead to reduced computational efficiency. Generally, it is more appropriate to set ''nprocs'' as about 1/5~1/3 of the total number of subsystems, if there is no proper estimate of the number of subsystems generated by the system before calculation, ''nprocs'' can also be simply set to 1, 2 and other small positive integers. The exception to this is if it is known that the subsystems of the calculation are similar in terms of computation, and nprocs can be set to be larger, for example, in the example at the beginning of this section, although there are only two subsystems, the smaller subsystem contains the transition metal atom Cu, and the larger subsystem is a pure organic system, so the calculation time of the two subsystems is similar and can be calculated at the same time.

.. note::

 When using the automatic sharding method for FLMO or iOI calculations, the molecular coordinates in the compass module must be entered as Cartesian coordinates, and the coordinates cannot be read from other xyz files using the file=filename.xyz method.

.. _iOI-Example:

iOI-SCF Method
----------------------------------------------------------

The iOI method can be seen as an improvement of the FLMO method. In the FLMO method, even with automatic sharding, the user still needs to specify the size of the molecular slice with keywords such as "radcent" and "radbuff", although both keywords have default values (3.0 and 2.0, respectively), neither the default value nor the user-specified value is guaranteed to be optimal for the current system. If the molecular sheet is too small, the quality of the obtained localized orbital is too poor; If the numerator is too large, it will lead to too much computational and non-convergence of localized iterations. In the iOI method, the algorithm starts from a relatively small molecular slice, continuously increases and fuses the molecular slice until the molecular slice just reaches the desired size, and then performs a global calculation. Each time the molecule is enlarged and fused, it is called a macro-iteration.
The following is an example:

.. code-block:: bdf

  $autofrag
  method
   ioi # To request a conventional FLMO calculation, change ioi to flmo
  nprocs
   2 # Use at most 2 parallel processes in calculating the subsystems
  $end
  
  $compass
  Title
   hydroxychloroquine (diprotonated)
  Basis
   6-31G(d)
  Geometry # snapshot of GFN2-xTB molecular dynamics at 298 K
  C    -4.2028   -1.1506    2.9497
  C    -4.1974   -0.4473    4.1642
  C    -3.7828    0.9065    4.1812
  C    -3.4934    1.5454    2.9369
  C    -3.4838    0.8240    1.7363
  C    -3.7584   -0.5191    1.7505
  H -4.6123 -0.8793 5.0715
  C    -3.3035    3.0061    2.9269
  H -3.1684 1.2214 0.8030
  H -3.7159 -1.1988 0.9297
  C    -3.1506    3.6292    4.2183
  C    -3.3495    2.9087    5.3473
  H -2.8779 4.6687 4.2878
  H -3.2554 3.3937 6.3124
  N -3.5923 1.5989 5.4076
  Cl -4.6402 -2.7763 3.0362
  H -3.8651 1.0100 6.1859
  N -3.3636 3.6632 1.7847
  H -3.4286 2.9775 1.0366
  C -3.5305 5.2960 -0.0482
  H -2.4848 5.4392 -0.0261
  H -3.5772 4.3876 -0.6303
  C -4.1485 6.5393 -0.7839
  H -3.8803 6.3760 -1.8559
  H -5.2124 6.5750 -0.7031
  C -3.4606 7.7754 -0.2653
  H -2.3720 7.6699 -0.3034
  H -3.7308 7.9469 0.7870
  N -3.8415 8.9938 -1.0424
  H -3.8246 8.8244 -2.0837
  C -2.7415 9.9365 -0.7484
  H -1.7736 9.4887 -0.8943
  H -2.8723 10.2143 0.3196
  C -2.7911 11.2324 -1.6563
  H -1.7773 11.3908 -2.1393
  H -3.5107 10.9108 -2.4646
  H -3.0564 12.0823 -1.1142
  C -5.1510 9.6033 -0.7836
  H -5.5290 9.1358 0.1412
  H -5.0054 10.6820 -0.6847
  C -6.2224 9.3823 -1.8639
  H -6.9636 10.1502 -1.7739
  H -5.8611 9.4210 -2.8855
  O    -6.7773    8.0861   -1.6209
  H -7.5145 7.9086 -2.2227
  C -4.0308 4.9184 1.3736
  H -3.7858 5.6522 2.1906
  C    -5.5414    4.6280    1.3533
  H -5.8612 3.8081 0.7198
  H -5.9086 4.3451 2.3469
  H -6.1262 5.5024 1.0605
  End geometry
  MPEC+cosx   # Accelerate the SCF iterations using MPEC+COSX. Not mandatory
  $end
  
  $xuanyuan
  rs # the range separation parameter omega (or mu) of wB97X
   0.3
  $end
  
  $scf
  rks
  dft
   wB97X
  iprt # Increase print level for more verbose output. Not mandatory
   2
  charge
   2
  $end
  
  $localmo
  FLMO
  $end

Note that in iOI calculation, the meaning of the keyword ''nprocs'' is the same as that of FLMO calculation, and the appropriate value needs to be selected according to the size of the molecule, and the different values of ''nprocs'' still only affect the calculation speed but not the calculation result. The difference between iOI calculation and FLMO calculation is that iOI calculation involves multi-step macro iteration (see below), and the number of subsystems of each step macro iteration is gradually reduced, so the optimal value of ''nprocs'' should be conservative, for example, it is taken as 1/10~1/5 of the number of subsystems of step 0 macro iteration.

At the beginning of the procedure, the molecule is divided into 5 molecular pieces:

.. code-block:: bdf

 ----------- Buffered molecular fragments ----------
  BMolephage 1: [[4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 18, 19], [1, 16, 2, 3, 7, 15, 17, 46, 47, 48, 49, 50, 51], [20], [20, 21, 22, 23], 2.0, 2.193]
  BMolefrag 2: [[20, 21, 22, 23, 24, 25, 26, 27, 28, 46, 47, 48, 49, 50, 51], [18, 19, 29, 30], [8, 31, 38], [8, 4, 11, 31, 32, 33, 34, 38, 39, 40, 41], 2.0, 2.037]
  BMolephragm 3: [[2, 3, 7, 15, 17], [1, 16, 4, 8, 5, 6, 9, 10, 11, 12, 13, 14], [18], [18, 19, 46], 2.0, 3.5]
  BMolephage 4: [[29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45], [23, 24, 25, 26, 27, 28, 20, 21, 22], [46], [46, 18, 47, 48], 2.0, 3.386]
  BMolephragm 5: [[1, 16], [2, 3, 7, 5, 6, 9, 10, 4, 8], [15, 11, 18], [15, 12, 17, 11, 13, 18, 19, 46], 2.0, 2.12]
 --------------------------------------------------------------------
 Automatically assigned charges and spin multiplicities of fragments:
 --------------------------------------------------------------------
    Fragment  Total No. of atoms  Charge  SpinMult  SpinAlignment
           1 26 1 1 N.A.
           2 22 1 1 N.A.
           3 18 1 1 N.A.
           4 27 1 1 N.A.
           5 14 1 1 N.A.
 --------------------------------------------------------------------

Here SpinAlignment is shown as N.A. because all the molecular sheets are closed-shell, so there is no problem with spin orientation.

After that, the subsystem calculation begins,

.. code-block:: bdf

 Starting subsystem calculations ...
 Number of parallel processes:  2
 Number of OpenMP threads per process:  2
 Please refer to test106.fragment*.out for detailed output

 Macro-iter 0:
 Total number of not yet converged subsystems:  5
 List of not yet converged subsystems:  [4, 1, 2, 3, 5]
 Finished calculating subsystem   4 (  1 of   5)
 Finished calculating subsystem   2 (  2 of   5)
 Finished calculating subsystem   1 (  3 of   5)
 Finished calculating subsystem   5 (  4 of   5)
 Finished calculating subsystem   3 (  5 of   5)
 Maximum population of LMO tail: 110.00000
 ======================================
 Elapsed time of post-processing: 0.10 s
 Total elapsed time of this iteration: 34.28 s

After that, the program fuses these 5 molecular pieces in pairs and expands the buffer to obtain 3 larger subsystems. The definitions of these 3 larger subsystems are given in ${BDFTASK}.ioienlarge.out:

.. code-block:: bdf

 Finding the optimum iOI merge plan...
 Initial guess merge plan...
 Iter 0 Number of permutations done: 1
 New center fragments (in terms of old center fragments):
 Fragment 1: 5 3
 NBas: 164,184
 Fragment 2: 2 4
 NBas: 164,174
 Fragment 3: 1
 NBas: 236
 Center fragment construction done, total elapsed time 0.01 s
 Subsystem construction done, total elapsed time 0.01 s

That is, the new subsystem 1 is obtained by the fusion (and expansion of the buffer) of the old subsystem 5 and 3, the new subsystem 2 is obtained by the fusion (and expansion of the buffer) of the old subsystem 2 and 4, and the new subsystem 3 is obtained directly by the expansion of the buffer by the old subsystem 1. Then, taking the convergent localized orbits of the original five smaller subsystems as the initial guess, the SCF calculations of these larger subsystems are carried out:

.. code-block:: bdf

 Macro-iter 1:
 Total number of not yet converged subsystems:  3
 List of not yet converged subsystems:  [2, 3, 1]
 Finished calculating subsystem   3 (  1 of   3)
 Finished calculating subsystem   1 (  2 of   3)
 Finished calculating subsystem   2 (  3 of   3)
 Fragment 1 has converged
 Fragment 2 has converged
 Fragment 3 has converged
 Maximum population of LMO tail: 0.04804
 ======================================

 *** iOI macro-iteration converged! ***

 Elapsed time of post-processing: 0.04 s
 Total elapsed time of this iteration: 33.71 s

At this time, the program automatically determines that the size of these subsystems is enough to converge the LMO of the system to the required accuracy, so the iOI macro is iteratively converged and the iOI is calculated globally. The output of the iOI global computation is similar to that of the FLMO global computation, but in order to further accelerate the block diagonalization of the Fock matrix, in the iOI global computation, some of the LMOs that have converged will be frozen, thus reducing the dimension of the Fock matrix that needs to be diagonalized by blocks, but also introducing a small error (generally in the order of :math:'10^{-6} \sim 10^{-5}' Hartree). Take the last step of the SCF iteration as an example:

.. code-block:: bdf

   DNR!!
      47 of     90 occupied and    201 of    292 virtual orbitals frozen
  SDNR. Preparation:         0.01      0.00      0.00
   norm and abs(maximum value) of Febru  0.35816E-03 0.11420E-03 gap =    1.14531
  Survived/total Fia =        472      3913
   norm and abs(maximum value) of Febru  0.36495E-03 0.11420E-03 gap =    1.14531
  Survived/total Fia =        443      3913
   norm and abs(maximum value) of Febru  0.16908E-03 0.92361E-04 gap =    1.14531
  Survived/total Fia =        615      3913
   norm and abs(maximum value) of Febru  0.11957E-03 0.21708E-04 gap =    1.14531
  Survived/total Fia =        824      3913
   norm and abs(maximum value) of Febru  0.68940E-04 0.15155E-04 gap =    1.14531
  Survived/total Fia =        965      3913
   norm and abs(maximum value) of Febru  0.56539E-04 0.15506E-04 gap =    1.14531
  Survived/total Fia =        737      3913
   norm and abs(maximum value) of Febru  0.30450E-04 0.62094E-05 gap =    1.14531
  Survived/total Fia =       1050      3913
   norm and abs(maximum value) of Febru  0.36500E-04 0.82498E-05 gap =    1.14531
  Survived/total Fia =        499      3913
   norm and abs(maximum value) of Febru  0.14018E-04 0.38171E-05 gap =    1.14531
  Survived/total Fia =       1324      3913
   norm and abs(maximum value) of Febru  0.43467E-04 0.15621E-04 gap =    1.14531
  Survived/total Fia =        303      3913
   norm and abs(maximum value) of Febru  0.12151E-04 0.26221E-05 gap =    1.14531
  Survived/total Fia =        837      3913
   norm and abs(maximum value) of Febru  0.15880E-04 0.82575E-05 gap =    1.14531
  Survived/total Fia =        185      3913
   norm and abs(maximum value) of Febru  0.52265E-05 0.71076E-06 gap =    1.14531
  Survived/total Fia =       1407      3913
   norm and abs(maximum value) of Febru  0.31827E-04 0.12985E-04 gap =    1.14531
  Survived/total Fia =        253      3913
   norm and abs(maximum value) of Febru  0.77674E-05 0.24860E-05 gap =    1.14531
  Survived/total Fia =        650      3913
   norm and abs(maximum value) of Febru  0.56782E-05 0.38053E-05 gap =    1.14531
  Survived/total Fia =        264      3913
  SDNR. Iter: 0.01 0.00 0.00
  Final iter :   16 Norm of Febru  0.25948E-05
  X --> U time: 0.000 0.000 0.000
  SDNR. XcontrU:       0.00      0.00      0.00
  Block Diag 0.020 0.000 0.000
   block norm :   2.321380955939448E-004

  Predicted total energy change:      -0.0000000659
    9      0    0.000   -1401.6261867529      -0.0011407955       0.0000016329       0.0000904023    0.0000     16.97

That is, 47 occupied orbits and 201 imaginary orbits were frozen.

After the convergence of the global calculation of the SCF of iOI, the output file of the general SCF calculation can be used to read the energy, distribution analysis and other information, which will not be repeated here.
