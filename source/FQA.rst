Frequently Asked Questions
************************************

**How to restart an interrupted calculation?**
=================================

BDF supports restarting several common types of calculations from a checkpoint, including:
  
1. SCF Single Point Energy: Use the ``guess`` keyword to read the molecular orbitals from the last SCF iteration of the interrupted job as the initial guess. Specifically, set the initial guess to ``readmo`` in the `$scf` module and rerun the input file.

  .. code-block:: bdf

    $scf
    ...
    guess
     readmo
    $end


.. _tddftrestart:

2. TDDFT Single Point Energy: When a TDDFT job is interrupted and `idiag` ≠ 2, you can read the TDDFT excitation vectors from the last iteration of the interrupted job (Davidson iteration when `idiag=1`, iVI iteration when `idiag=3`) as the initial guess. Note: when `idiag=3`, restart is only possible for calculations with C(1) symmetry.

   To restart a TDDFT job:
   - Use the ``guess readmo`` keyword in the `$scf` module to read the converged SCF wavefunction from the interrupted job.
   - Use the ``iguess`` keyword in the `$tddft` module to specify reading the TDDFT excitation vectors from the interrupted job. For example, suppose the original input file contained:

   .. code-block:: bdf
   
     $scf
     ...
     $end
     
     $tddft
     ...
     iguess
      21
     $end

   Here, `iguess=21` (`2` indicates tight-binding initial guess; `1` writes excitation vectors at each iteration to files: `.dvdsonvec*` for `idiag=1` or `.tdx` for `idiag=3`). If this job is interrupted, modify the input file as follows for restart:

   .. code-block:: bdf
   
     $scf
     ...
     guess
      readmo
     $end
     
     $tddft
     ...
     iguess
      11 # or 10 if sure the job won't be interrupted again
     $end

   `guess readmo` reads the previous SCF orbitals to avoid redoing SCF. `iguess=11` (`1` reads excitation vectors from files). See the :doc:`tddft` section for details on `iguess` options.

   Important Notes:
   - (1) Due to the nature of Davidson/iVI methods, restarting saves fewer TDDFT iterations compared to SCF. Restarting may not save iterations unless the previous TDDFT run was near convergence.
   - (2) TDDFT does not save intermediate excitation vectors by default. Specify `iguess=1`, `11`, or `21` to enable saving. Not enabling this in the original run prevents restart. Saving vectors increases disk I/O; users must weigh this trade-off.

3. Geometry Optimization: Add the ``restart`` keyword in the `$compass` module. See the :doc:`compass` section.
4. Numerical Frequency Calculation: Add the ``restarthess`` keyword in the `$bdfopt` module. See the :doc:`bdfopt` section.

**How to cite BDF?**
=================================

When using BDF, cite the original BDF papers :cite:`doi:10.1007/s002140050207,doi:10.1063/1.5143173,doi:10.1142/S0219633603000471,doi:10.1142/9789812794901_0009`. Additionally, cite the relevant papers for specific features used; see the :doc:`Cite` section.

**TDDFT: Imaginary/Complex Excitation Energies**
=================================================================

If the ground state wavefunction is unstable or the SCF converged to a non-ground state, TDDFT may produce imaginary excitation energies, rarely even complex ones. These lack physical meaning. 
- With the Davidson method (`idiag=1`), a **Warning: Imaginary Excitation Energy!** is issued, and the modulus of all imaginary/complex energies is printed upon convergence.
- With the iVI method (`idiag=3`), an **Error in ETDVSI: ABBA mat is not positive! Suggest to use nH-iVI.** warning is issued. Subsequent calculations only solve for real excitation energies (thus, convergence to real energies does *not* guarantee the absence of imaginary/complex states. 
Solution: Re-optimize the ground state to find a stable solution or use TDA for excitation energies.

**TDDFT J/K Operator Memory & Efficiency**
=================================================================

If solving for many roots, default TDDFT memory may be insufficient, reducing efficiency. The TDDFT keyword **MEMJKOP** sets the maximum memory for J/K operator calculation. Example output when requesting **4** roots:

.. code-block:: bdf

     Maximum memory to calculate JK operator:        1024.000 M
     Allow to calculate    2 roots at one pass for RPA ...
     Allow to calculate    4 roots at one pass for TDA ...

This indicates **1024 MB** (Megabytes) is available for J/K operators. For RPA (full TDDFT), 2 roots can be processed per integral evaluation pass; for TDA, 4 roots. For TDA, all roots are processed in one pass. For RPA, two passes are needed (reduced efficiency). Setting ``MEMJKOP`` to 2048MB allows processing all 4 roots in one pass (RPA). Note: Physical memory usage ≈ **2048MB * OMP_NUM_THREADS**.

**Segmentation Fault & Stack Memory Limits**
=================================================================

Most **segmentation faults** in BDF are caused by insufficient stack memory. On Linux, use the **ulimit** command to set stack size.

Check current limits:

.. code-block:: bash 

  ulimit -a

Example output:

.. code-block:: bash

    core file size          (blocks, -c) 0
    data seg size           (kbytes, -d) unlimited
    ... 
    stack size              (kbytes, -s) 4096 
    ...

Here, ``stack size ... 4096`` indicates a 4096 KB (4 MB) limit. Set to unlimited:

.. code-block:: bash

    ulimit -s unlimited

Note: Stack size has a **hard limit** set by the system. If ``ulimit -s unlimited`` fails:

.. code-block:: bash

    bash: ulimit: stack size: cannot modify limit: Operation not permitted

Contact your system administrator to increase the hard limit or use root privileges.

Sometimes, **segmentation faults** can also stem from insufficient OpenMP stack memory. Setting `ulimit` alone may not suffice; environment variables like `OMP_STACKSIZE` and `KMP_STACKSIZE` may also need adjustment. See section :ref:`OpenMP Stack Memory Size<OMP_stack_problem>`.

**OpenMP Parallel Computing**
=================================================================

BDF supports OpenMP parallelism. Set the number of threads in your run script:

.. code-block:: bash

    export OMP_NUM_THREADS=8

This allows up to 8 OpenMP threads.

.. _OMP_stack_problem::
**OpenMP Stack Memory Size**
=================================================================

Intel compilers (and others) place dynamic memory from parallel regions on the stack for efficiency. Users *must* set the per-thread stack size in the run script:

.. code-block:: bash

    export OMP_STACKSIZE=2048M

This sets 2048MB per thread. Total stack memory usage = **OMP_STACKSIZE * OMP_NUM_THREADS**.

.. important::
  `OMP_STACKSIZE` is a generic variable. Priority for OpenMP stack size environment variables is:
  
  `KMP_STACKSIZE` (Intel OpenMP) > `GOMP_STACKSIZE` (GNU OpenMP) > `OMP_STACKSIZE`
  
  Higher-priority variables set in the script will override `OMP_STACKSIZE`.

**Intel Fortran Compiler 2018**
=================================================================

The Intel 2018 Fortran compiler has known bugs. Avoid using it to compile BDF.

**SCF Non-Convergence**
=================================================================

See section :ref:`Handling SCF Convergence Problems<SCFConvProblems>` in the :doc:`SCFTech` chapter.

**SCF Energy Significantly Lower Than Expected (>1 Hartree) or Displayed as Asterisks**
=============================================================================

Usually caused by linear dependence in the basis set. See the discussion on basis set linear dependence under :ref:`Handling SCF Convergence Problems<SCFConvProblems>` in the :doc:`SCFTech` chapter. Note: While the chapter focuses on SCF non-convergence, the solutions also apply to cases where linear dependence causes incorrect SCF energies *without* preventing convergence.

**How to Use Custom Basis Sets**
=================================================================

See section :ref:`Custom Basis Set Files<SelfdefinedBasis>` in :doc:`Gaussian-Basis-Set`.

**Program Exits Without Performing Any Calculation**
==================================================================

If the program outputs "Warning!!! The following input line is skipped. You may need to check the input file!" and exits without calculation:

First check the input file for obvious errors, especially for concise input, the first line must start with ''#!''. If not, check to see if there are extra spaces in front of certain lines, especially the first line of the input file. When using concise input, there must be no spaces in front of the ''#!'' in the first line, if the user is copying the input file from elsewhere, it may copy some more spaces due to typography problems, and these spaces must be manually deleted.