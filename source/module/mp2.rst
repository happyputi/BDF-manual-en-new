Møller–Plesset Second-Order Perturbation - MP2 Module
================================================
The Møller-Plesset second-order perturbation theory calculation module, primarily used to implement double-hybrid DFT calculations.
For symmetry-adapted orbital SCF algorithms based on integral-direct methods (see :ref:`Saorb<compass.saorb>` keyword), MP2 supports both RHF and UHF reference wavefunctions;
For integral-direct SCF algorithms (default, see :ref:`Skeleton<compass.skeleton>` keyword), MP2 only supports RHF reference wavefunctions.

:guilabel:`Nature` Parameter Type: Boolean
------------------------------------------------
Computes the reduced density matrix and outputs natural orbitals.

:guilabel:`Molden` Parameter Type: Boolean
---------------------------------------------------
Outputs natural orbitals in molden format file.

:guilabel:`Iprtmo` Parameter Type: Integer
------------------------------------------------
Controls the orbital output printing mode.

:guilabel:`Fss, Fos` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.0

Spin component scaling parameters used in SCS-MP2 and certain double-hybrid functionals. After computing the MP2 energy, the program multiplies the same-spin component by Fss and the opposite-spin component by Fos.