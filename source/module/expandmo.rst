Orbital Expansion with Different Basis Sets - EXPANDMO Module
================================================
The EXPANDMO module is used to expand molecular orbitals (MOs) calculated with a small basis set into MOs for a larger basis set. The expanded MOs can serve as initial guesses for SCF calculations or be used in dual-basis calculations. Additionally, EXPANDMO can utilize the atomic valence active space to automatically construct the active space and initial guess orbitals for MCSCF calculations.

:guilabel:`Overlap` Parameter Type: Boolean
------------------------------------------------
Specifies the use of overlap integrals between the small and large basis sets to expand the molecular orbitals.

The EXPANDMO module depends on the following files:

+------------------+------------------------------------------------+------------+----------+
| Filename         | Description                                     | File Format| I/O      |
+------------------+------------------------------------------------+------------+----------+
| $BDFTASK.chkfil1 | Checkpoint file from small basis set calculation| Binary     | Input    |
+------------------+------------------------------------------------+------------+----------+
| $BDFTASK.chkfil2 | Checkpoint file from large basis set calculation| Binary     | Input    |
+------------------+------------------------------------------------+------------+----------+
| inporb           | MO file generated from small basis set calculation| Text       | Input    |
+------------------+------------------------------------------------+------------+----------+
| $BDFTASK.exporb  | Expanded MO coefficient file, stored in        | Text       | Output   |
|                  | BDF_WORKDDIR                                    |            |          |
+------------------+------------------------------------------------+------------+----------+

.. code-block:: bdf

     # Calculate CH2 molecule using cc-pVDZ basis set and expand molecular orbitals to aug-cc-pVDZ basis set for SCF initial guess
     # First we perform a small basis set calculation using CC-PVDZ.
     $COMPASS
     Title
       CH2 Molecule test run, cc-pvdz
     Basis
       cc-pvdz
     Geometry
     C     0.000000        0.00000        0.31399
     H     0.000000       -1.65723       -0.94197
     H     0.000000        1.65723       -0.94197
     End geometry
     UNIT
       Bohr
     Check
     $END

     $XUANYUAN
     $END

     $SCF
     RHF
     Occupied
     3  0  1  0
     $END

     # Change the name of the checkpoint file
     %mv $BDF_WORKDIR/ch2.chkfil $BDF_WORKDIR/ch2.chkfil1
     # Copy the converged SCF orbitals to the working directory as inporb
     %mv $BDF_WORKDIR/ch2.scforb $BDF_WORKDIR/ch2.inporb

     # Then we initialize a large basis set calculation using aug-CC-PVDZ
     $COMPASS
     Title
       CH2 Molecule test run, aug-cc-pvdz
     Basis
       aug-cc-pvdz
     Geometry
     C     0.000000        0.00000        0.31399
     H     0.000000       -1.65723       -0.94197
     H     0.000000        1.65723       -0.94197
     End geometry
     UNIT
       Bohr
     Check
     $END