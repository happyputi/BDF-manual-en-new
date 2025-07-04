Energy and Charge Transfer - ELECOUP Module
================================================
The primary functions of the ELECOUP module are:

#. Calculating coupling integrals between two electronic states of the same molecule based on Hartree-Fock (HF) theory;
#. Computing charge transfer integrals between two molecular fragments;
#. Calculating energy transfer integrals between excited states of two molecular fragments.

.. note::

    **Calculating coupling integrals between two excited states of the same molecule using HF theory requires the ΔSCF method, typically utilizing the MOM (Maximum Overlap Method) functionality within the SCF module.**

:guilabel:`Iprt` Parameter Type: Integer
------------------------------------------------
Print control parameter, used only for debugging purposes.

:guilabel:`UHF` Parameter Type: Boolean
------------------------------------------------
Specifies that coupling integrals between two electronic states are calculated based on Unrestricted Hartree-Fock (UHF) wavefunctions.

:guilabel:`Nexcit` Parameter Type: Integer
------------------------------------------------
Specifies the number of excited states for each molecule.

:guilabel:`GSApr` Parameter Type: Boolean
------------------------------------------------
Specifies whether a ground-state approximation (GSA) should be applied.

**Keywords for Calculating Charge Transfer Integrals**

:guilabel:`Electrans` Parameter Type: Integer Array
------------------------------------------------
This is a multi-line parameter used to specify pairs of Donor and Acceptor molecular orbitals for which charge transfer integrals should be calculated. Format:

First line: Input an integer `n`, specifying the number of orbital pairs for which transfer integrals should be calculated.

Lines 2 to `n+1`: Input three integers `i j k`:
* `i`: The `i`-th orbital of the Donor
* `j`: The `j`-th orbital of the Acceptor
* `k`: Value `1` or `2`, specifying alpha orbitals (1) or beta orbitals (2).

:guilabel:`Dft` Parameter Type: String
------------------------------------------------
Specifies the exchange-correlation functional to use for calculating charge transfer integrals. If this parameter is not input, the functional used in the Kohn-Sham calculation will be used by default.

**Localized Excited States**

:guilabel:`locales` Parameter Type: Integer
------------------------------------------------
Specifies the method for obtaining localized excited states.

 * Default: 0  
 * Options: 0, 1  
   * `0`: Boys localization method  
   * `1`: Ruedenberg localization method