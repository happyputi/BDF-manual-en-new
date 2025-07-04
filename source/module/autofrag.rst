Molecular Automatic Fragmentation, FLMO and iOI Calculation - AUTOFRAG Module
================================================

The primary function of the `autofrag` module is to automatically fragment large molecules and generate inputs for FLMO calculations. It also serves as the computational engine for iOI-SCF, coordinating other SCF modules to perform iOI calculations. The main workflow of the `autofrag` module is:

* Automatically generate atomic bonding information from molecular coordinates;
* Cleave specific bonds to generate appropriate molecular fragments;
* Add buffer atoms to molecular fragments;
* Add link H atoms or Projected Hybrid Orbitals (PHOs) at bond cleavage sites;
* Generate input files for subsystem fragment calculations using parallelized computation;
* Organize subsystem results and perform the overall molecular calculation.

``autofrag`` must be placed before ``compass``. Autofrag processes the molecular structure in the ``compass`` module to determine molecular bonds and perform fragmentation. Inputs after autofrag also serve as templates for generating fragment and overall calculation inputs. See :ref:`iOI-SCF Calculation Example<iOI-Example>` for a complete example using autofrag.

Note: When using the ``autofrag`` module, the ``compass`` module must define molecular coordinates in Cartesian format and cannot use the ``file=filename.xyz`` syntax to read coordinates from another file.

:guilabel:`Method` Parameter Type: String
------------------------------------------------
* Default: FLMO
* Options: FLMO, iOI

Sets the calculation method. FLMO - calculates Fragment Localized Molecular Orbitals; iOI - performs iOI-SCF calculation using molecular fragment synthesis for large systems. iOI currently only supports restricted self-consistent field calculations.

:guilabel:`nprocs` Parameter Type: Integer
------------------------------------------------
* Default: 1
* Options: Positive integer ≤ number of fragments

Sets the maximum number of processes available for iOI calculations. Since fragment calculations are independent and parallelizable, nprocs specifies the maximum number of fragments that can be calculated simultaneously. Note: when nprocs ≠ 1, the OMP_NUM_THREADS environment variable specifies the total OpenMP threads for iOI calculations, not per-process threads. Example: With OMP_NUM_THREADS=16 and nprocs=2, iOI will run 2 subsystems concurrently, each using 8 OpenMP threads.

:guilabel:`radcent` Parameter Type: Float
-----------------------------------------------
* Default: 3.0
* Options: Non-negative float

Sets the size of initial fragments (before adding buffers) in Ångstroms. Increasing radcent enlarges fragment size and reduces fragment count.

:guilabel:`radbuff` Parameter Type: Float
-----------------------------------------------
* Default: 2.0
* Options: Non-negative float

Sets fragment buffer radius in Ångstroms. Unlike radcent, increasing radbuff doesn't change fragment count but enlarges each fragment. For iOI calculations, radbuff defines the buffer size at macroiteration 0, which expands during subsequent iterations.

:guilabel:`iOIThresh` Parameter Type: Float
-----------------------------------------------
* Default: 0.1
* Options: Positive float

Sets convergence threshold for iOI-SCF fragment calculations. Decreasing iOIThresh increases macroiterations but improves initial orbitals for overall calculation, accelerating SCF convergence.

:guilabel:`NoPHO` Parameter Type: Bool
-----------------------------------------------

Disables **PHO** (Projected Hybrid Orbitals) and uses link **H** atoms instead to saturate cleaved bonds. This slightly reduces subsystem calculation cost compared to default PHO, but yields lower-quality subsystem orbitals, potentially increasing SCF iterations and total computation time.

:guilabel:`charge` Parameter Type: Integer Array
-----------------------------------------------
* Default: None

Sets atomic charges to assist in assigning fragment charges. When automatic electron count determination fails, users can specify charges to set fragment electron counts. Format:

.. code-block:: bdf
  
  charge
  10 +2 25 -1 78 -1

This sets atom 10 charge to +2, atom 25 to -1, and atom 78 to -1. Fragment charges will be determined based on these atomic charges.

:guilabel:`spinocc` Parameter Type: Integer Array
-----------------------------------------------
* Default: None

Sets formal atomic spins to guide calculation toward appropriate spin states. Input format matches ``charge``:

.. code-block:: bdf
  
  spinocc
  13 +1 17 -1

This sets atom 13 with +1 unpaired alpha electron and atom 17 with -1 unpaired beta electron. Note: All open-shell atoms should be specified. For example:
- A system with two Cu(II) centers: either specify both spins or neither (spin state becomes indeterminate)
- Cannot specify only one Cu atom's spin while omitting the other
- For Cu(I) centers (closed-shell), spin specification is optional
- For delocalized spins: use resonance structures to localize spins before assignment (e.g., ethylene radical cation: set one carbon spin to +1, the other to 0).

:guilabel:`maxiter` Parameter Type: Integer
-----------------------------------------------
* Default: 50

Sets maximum macroiteration count for iOI-SCF.

:guilabel:`Dryrun` Parameter Type: Bool
-----------------------------------------------
* Default: False

Generates FLMO or iOI-SCF input files without executing calculations.