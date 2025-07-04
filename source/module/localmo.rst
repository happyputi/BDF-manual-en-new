Molecular Orbital Localization - LOCALMO Module
================================================
The LOCALMO module is used to generate localized molecular orbitals, incorporating methods such as Boys, Pipek-Mezey, and modified Boys localization. It is also utilized to generate initial fragment-localized orbitals for the FLMO (Fragment Localized Molecular Orbital) method.

**Basic Control Parameters**

:guilabel:`Boys` Parameter Type: Boolean
------------------------------------------------
Specifies using the Boys localization method for orbitals. Boys is the default method for the Localmo module.

:guilabel:`Mboys` Parameter Type: Integer
------------------------------------------------
Specifies using a modified Boys localization method. The next line must contain an integer defining the exponent factor for the modified Boys method.

:guilabel:`Pipek` Parameter Type: Boolean
------------------------------------------------
Specifies using the Pipek-Mezey localization method. By default, Mulliken charges are used. If the `Lowdin` parameter is set, Pipek-Mezey will use Löwdin charges instead. This method defaults to Jacobi rotations for orbital localization. To use the Trust-Region method, the `Trust` keyword must be specified.

:guilabel:`Mulliken` Parameter Type: Boolean
------------------------------------------------
Specifies that the Pipek-Mezey method should use Mulliken charges. This is the default option.

:guilabel:`Lowdin` Parameter Type: Boolean
------------------------------------------------
Specifies that the Pipek-Mezey method should use Löwdin charges.

:guilabel:`Jacobi` Parameter Type: Boolean
------------------------------------------------
Specifies that the Pipek-Mezey method should use Jacobi rotations for orbital localization.

:guilabel:`Trust` Parameter Type: Boolean
------------------------------------------------
Specifies that the Pipek-Mezey method should use the Trust Region method for orbital localization.

:guilabel:`Hybridboys` Parameter Type: Integer
------------------------------------------------
Options: -100, 100

Specifies a hybrid approach combining Jacobi rotations and the Trust Region method for Pipek-Mezey or Boys localization. By default, no hybrid method is used. If this parameter is specified, the next line must contain an integer:
- -100: Only virtual orbitals undergo initial Jacobi rotation localization for 100 cycles or until convergence threshold `Hybridthre` is reached, then switch to Trust Region method.
- 100: Both occupied and virtual orbitals undergo initial Jacobi rotation localization for 100 cycles or until convergence threshold `Hybridthre` is reached, then switch to Trust Region method.

:guilabel:`Hybridthre` Parameter Type: Floating-point
------------------------------------------------
Specifies the transition threshold for the hybrid localization method.

:guilabel:`Thresh` Parameter Type: Floating-point
------------------------------------------------
Specifies the convergence threshold for the localization method. Requires input of two floating-point numbers.

:guilabel:`Tailcut` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.D-2

Specifies the threshold for ignoring FLMO (Fragment Localized Molecular Orbital) tails.

:guilabel:`Threshpop` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.D-1

Specifies the Löwdin population threshold.

:guilabel:`Maxcycle` Parameter Type: Integer
------------------------------------------------
Specifies the maximum number of iterations allowed for Boys localization.

:guilabel:`Rohfloc` Parameter Type: Boolean
------------------------------------------------
Specifies localization of ROHF (Restricted Open-shell Hartree-Fock) or ROKS (Restricted Open-shell Kohn-Sham) orbitals.

:guilabel:`orbital` Parameter Type: String
------------------------------------------------
Specifies the file from which molecular orbitals are read.

.. code-block:: bdf

     $LocalMO
     Orbital
     hforb       # Specifies reading orbitals from the hforb file stored by the SCF calculation
     $End

:guilabel:`Orbread` Parameter Type: Boolean
------------------------------------------------
Specifies reading molecular orbitals from the text file `inporb` located in **BDF_TMPDIR**.

:guilabel:`Flmo` Parameter Type: Boolean
------------------------------------------------
Specifies projecting LMOs (Localized Molecular Orbitals) to pFLMO (projected Fragment Localized Molecular Orbitals).

:guilabel:`Frozocc` Parameter Type: Integer
------------------------------------------------
Specifies the number of occupied orbitals that should *not* be localized.

:guilabel:`Frozvir` Parameter Type: Integer
------------------------------------------------
Specifies the number of virtual orbitals that should *not* be localized.

:guilabel:`Analyze` Parameter Type: Boolean
------------------------------------------------
Specifies analysis of user-provided localized orbitals. Calculates the number of occupied-virtual orbital pairs and MOS (Molecular Orbital Spread). Analysis requires reading a file named `bdftask.testorb` from **BDF_TMPDIR**, which must be in the same text format as SCF's `bdftask.scforb` orbital file.

:guilabel:`Iapair` Parameter Type: Floating-point
------------------------------------------------
Specifies the threshold for counting overlapping occupied-virtual orbital pairs. By default, only pairs with absolute overlap > 1.0×10⁻⁴ are counted.

:guilabel:`Directgrid` Parameter Type: Boolean
------------------------------------------------
Specifies using direct numerical integration to compute the absolute overlap of occupied-virtual orbital pairs.

:guilabel:`Nolmocls` Parameter Type: Integer
------------------------------------------------
Specifies the number of SCF occupied orbitals that should *not* be localized.

:guilabel:`Nolmovir` Parameter Type: Integer
------------------------------------------------
Specifies the number of SCF virtual orbitals that should *not* be localized.

:guilabel:`Moprt` Parameter Type: Integer
------------------------------------------------
Specifies printing coefficients of localized molecular orbitals.