Nuclear Magnetic Shielding Constant Calculation - NMR Module
==============================================

The NMR module is used to calculate nuclear magnetic shielding constants for molecules.

:guilabel:`igiao` Parameter Type: Integer
------------------------------------------------
Specifies whether to calculate GIAO (Gauge-Including Atomic Orbitals) NMR shielding constants. Accepts 0 (skip GIAO calculation) or 1 (perform GIAO calculation). Default is 0. Input format:

.. code-block:: bdf

  igiao
    1

:guilabel:`icg` Parameter Type: Integer
------------------------------------------------
Specifies whether to calculate COMMON GAUGE (CG) NMR shielding constants. Accepts 0 (skip CG calculation) or 1 (perform CG calculation). Default is 0. Input format:

.. code-block:: bdf

  icg
    1

:guilabel:`igatom` Parameter Type: Integer
------------------------------------------------
Specifies the gauge origin position for COMMON GAUGE calculations. Accepts:
- 0: Set gauge origin at spatial coordinate origin (default)
- 1 to number of atoms: Set gauge origin at the center of the igatom-th atom

Input format:

.. code-block:: bdf

  igatom
    3      # Set gauge origin at the center of the 3rd atom

:guilabel:`cgcoord` Parameter Type: Three real numbers
------------------------------------------------
Specifies the gauge origin position for COMMON GAUGE calculations at a specific spatial coordinate point. Default unit is atomic units (bohr/AU). Unit can be controlled by the ``cgunit`` parameter.

.. code-block:: bdf

  cgcoord
    1.0 0.0 0.0   # Three real numbers placing gauge origin at (1.0, 0.0, 0.0)

:guilabel:`cgunit` Parameter Type: String
------------------------------------------------
Specifies the unit for the ``cgcoord`` parameter:
- Default: Atomic units (bohr/AU)
- Input "angstrom" changes units to Ångstroms
- Other inputs (e.g., "bohr", "AU") maintain atomic units. Case-insensitive.

.. code-block:: bdf

  cgunit
    angstrom      # Unit for cgcoord coordinates (default: atomic units)
                 # Other inputs (e.g., bohr, AU) keep atomic units