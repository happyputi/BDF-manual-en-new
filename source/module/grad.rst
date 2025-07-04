Hartree-Fock Gradient - GRAD Module
================================================
The GRAD module is used to calculate analytical gradients for HF/MCSCF methods.
   
**Basic Keywords**   

:guilabel:`Nrootgrad` Parameter Type: Integer
------------------------------------------------
Specifies for which root the MCSCF gradient should be calculated.

:guilabel:`Maxiter` Parameter Type: Integer
------------------------------------------------
Specifies the maximum number of iterations for CPMCHF (Coupled Perturbed Multi-configuration Hartree-Fock) calculations.

:guilabel:`IntCre` Parameter Type: Integer
------------------------------------------------
Increases the memory allocated for storing AO (Atomic Orbital) integrals by: intcre × 256 × 1024 × 1024 Bytes.

:guilabel:`Ishell` Parameter Type: Integer
------------------------------------------------
[Note: Original documentation didn't specify functionality for this parameter]

:guilabel:`Cutcpm` Parameter Type: Floating-point
------------------------------------------------
 * Default: 1.D-6

Specifies the convergence threshold for solving the CPMCHF equations.

:guilabel:`Printgrad` Parameter Type: Integer
------------------------------------------------
 * Options: 0, 3, >99

Controls gradient printing:
* 0: Minimal output
* 3: Outputs contribution of one-electron terms to the gradient
* >99: Debug mode only