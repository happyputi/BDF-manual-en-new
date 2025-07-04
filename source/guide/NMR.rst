Nuclear Magnetic Resonance Shielding Constants
================================================

BDF supports the calculation of nuclear magnetic resonance shielding constants (NMR) for Restricted Hartree-Fock (RHF) and Restricted Kohn-Sham (RKS) methods.  
The gauge origin problem for the external vector potential can be addressed using either the Common Gauge method or Gauge-Including Atomic Orbitals (GIAO).

.. warning::
    NMR calculations require the libcint library. Add this line to your calculation script:  
    `export USE_LIBCINT=yes`

NMR Calculation Example
----------------------------------------------------------
Input file for calculating NMR shielding constants of a methane molecule:

.. code-block:: bdf

  $COMPASS  # Molecular coordinates and symmetry analysis
  Title
  CH4 Molecule NR-DFT-NMR       # Job title
  Basis
  CC-PVQZ                       # Basis set
  Geometry
  C  0.000   0.0000    0.000     # Molecular geometry (coordinates)
  H  1.196   1.196    1.196
  H -1.196  -1.196    1.196
  H -1.196   1.196   -1.196
  H  1.196  -1.196   -1.196
  END geometry
  nosymm                        # NMR module currently does not support symmetry
  UNIT
    BOHR                        # Input geometry in Bohr units
  $END

  $xuanyuan # Integral calculation settings
  $end

  $SCF      # Self-consistent field calculation module
  RKS       # Restricted Kohn-Sham
  DFT
    b3lyp
  $END

  $NMR      # NMR shielding constant calculation module
  icg
   1        # 0: Skip Common Gauge; 1: Perform Common Gauge calculation (default=0)
  igiao
   1        # 0: Skip GIAO; 1: Perform GIAO calculation (default=0)
  $END

The calculation sequentially executes the ``compass``, ``xuanyuan``, ``scf``, and ``nmr`` modules.  
The ``scf`` module performs the RKS calculation, followed by the ``nmr`` module which calculates isotropic and anisotropic NMR shielding constants for all atoms using both Common Gauge and GIAO methods.

Common Gauge Method
----------------------------------------------------------
Control Common Gauge calculations with the ``icg`` keyword:

.. code-block:: bdf 

  $NMR
  icg
    1        # Enable Common Gauge calculation
  $END

* Default: ``0`` (disabled)  
* ``1``: Perform calculation

**Customizing the Gauge Origin**  
By default, the gauge origin is at (0,0,0). Customize it using:  
* ``igatom``: Place origin on a specific atom  
* ``cgcoord``: Set origin to custom coordinates  

.. code-block:: bdf 

  $NMR
  icg
    1
  igatom
    3             # Place origin on atom 3 (0 = reset to (0,0,0))
  cgcoord
    1.0 0.0 0.0   # Set origin to (1.0, 0.0, 0.0)
  cgunit
    angstrom      # Coordinate units (default=Bohr; options: angstrom, bohr, au)
  $END

**Output Example**  
Results appear under ``[nmr_nr_cg]`` in the output:  

.. code-block:: 

  [nmr_nr_cg]
    Doing nonrelativistic-CG-DFT nmr...
    [nmr_set_common_gauge]
      Gauge origin: 0.000000 0.000000 0.000000 (default)

  Isotropic/anisotropic constant by atom type:
    atom-C
      186.194036      0.000003    # Isotropic (ppm) | Anisotropic (ppm)
    atom-H
       31.028177      9.317141
       31.028176      9.317141
       31.028177      9.317141
       31.028177      9.317141

GIAO (Gauge-Including Atomic Orbitals)
----------------------------------------------------------
Control GIAO calculations with the ``igiao`` keyword:

.. code-block:: bdf 

  $NMR
  igiao
    1        # Enable GIAO calculation
  $END

* Default: ``0`` (disabled)  
* ``1``: Perform calculation  

.. warning::
  At least one of ``icg`` or ``igiao`` must be set to ``1``. If both are ``0``, no NMR results will be generated.

**Output Example**  
Results appear under ``[nmr_nr_giao]`` in the output:  

.. code-block:: 

  [nmr_nr_giao]
    Doing nonrelativistic-GIAO-DFT nmr...

  Isotropic/anisotropic constant by atom type:
    atom-C
      186.461988      0.000019    # Isotropic (ppm) | Anisotropic (ppm)
    atom-H
      31.204947      9.070916
      31.204944      9.070916
      31.204947      9.070921
      31.204946      9.070920

.. warning::
The keyword ''Isotropic/anisotropic constant by atom type'' in the output is exactly the same as COMMON GAUGE for GIAO, and it should be noted whether it is after ''[nmr_nr_cg]''' or ''[nmr_nr_giao]''' when reading the result to distinguish between the result of COMMON GAUGE and the result of GIAO