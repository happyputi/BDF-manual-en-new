mrci Module
================================================
The MRCI module, used in conjunction with the DRT module, performs uncontracted MRCI calculations.

:guilabel:`Nrroots` Parameter Type: Integer
------------------------------------------------
Specifies the number of roots for MRCI calculation.

:guilabel:`PrintThresh` Parameter Type: Floating-point
------------------------------------------------
Default: 0.05

Specifies the threshold for printing CSF configurations.

:guilabel:`Convergence` Parameter Type: Floating-point Array
------------------------------------------------
Default: 1.D-8, 1.D-6, 1.D-8

Specifies convergence thresholds for MRCI calculations. Input three floating-point numbers controlling:
1. Energy convergence threshold
2. Wavefunction convergence threshold
3. Residual vector convergence threshold

:guilabel:`Maxiter` Parameter Type: Integer
------------------------------------------------
Specifies the maximum number of iterations for MRCI calculation.

:guilabel:`Cipro` Parameter Type: Integer
------------------------------------------------
Specifies calculation of the one-electron reduced density matrix and related properties (e.g., dipole moment).