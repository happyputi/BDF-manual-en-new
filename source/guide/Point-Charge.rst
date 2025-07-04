Point Charge Model
================================================
BDF supports incorporating MM region atomic charges as point charges in calculations. Point charges are input through a file named `$BDFTASK.extcharge` (same name as the calculation task). The format is as follows:

.. code-block:: bdf

  $COMPASS
  Title
  water molecule in background of external charges
  Basis
    6-31g
  Geometry
  O   0.000000   0.000000   0.106830
  H   0.000000   0.785178  -0.427319
  H   0.000000  -0.785178  -0.427319
  End Geometry
  Extcharge  # Indicates point charges will be input
    point      # Specifies point charge type
  $END
  
  $XUANYUAN
  $END

  $SCF
  RHF
  $END

Point charge input file (e.g., `h2o.extcharge`):

.. code-block:: bdf

    External charge, Point charge   # Header/description line
    6                               # Number of point charges 
    C1     -0.732879     0.000000     5.000000     0.114039  # Label, x, y, z, charge
    C2      0.366440     0.000000     5.780843    -0.456155 
    C3      0.366440     0.000000     4.219157    -0.456155
    C4     -0.732879     0.000000    10.000000     0.114039 
    C5      0.366440     0.000000    10.780843    -0.456155 
    C6      0.366440     0.000000     9.219157    -0.456155

**Default Format:**  
`Atom_label  x  y  z  Charge`  
*Coordinates default to Angstrom units.*

**Bohr Units Format:**  
Specify units in the second line:

.. code-block:: bdf

    External charge, Point charge   
    6    Bohr                      # Unit: Bohr  
    C1     -0.732879    0.000000    5.000000    0.114039 
# omitted #

.. End of this section