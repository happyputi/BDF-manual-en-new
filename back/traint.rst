traint Module
================================================
The Traint module transforms atomic orbital integrals into molecular orbital integrals. Only supports symmetry-adapted integral transformations. When using Traint, the Compass module must not contain the Skeleton keyword. Primarily used in conjunction with post-Hartree-Fock calculations to provide MO integrals for Post-HF methods.

:guilabel:`Frozen` Parameter Type: Integer Array
---------------------------------------------------
Specifies number of frozen doubly-occupied molecular orbitals per irreducible representation.

:guilabel:`UTDDFT` Parameter Type: Boolean
------------------------------------------------
For MO-TDDFT algorithm: Performs integral transformation based on UKS orbitals. MO-TDDFT is inefficient and used only for testing/benchmarking.

:guilabel:`TDDFT` Parameter Type: Boolean
---------------------------------------------------
For MO-TDDFT algorithm: Performs integral transformation based on RKS orbitals. MO-TDDFT is inefficient and used only for testing.

:guilabel:`alpha & beta` Parameter Type: Integer Array
------------------------------------------------
Specifies occupied alpha/beta orbitals per irreducible representation for MO-UTDDFT.

:guilabel:`Occupy` Parameter Type: Integer Array
---------------------------------------------------
Specifies occupied orbitals per irreducible representation for MO-TDDFT calculations.

:guilabel:`Orbital` Parameter Type: String
------------------------------------------------
Options: hforb, mcorb, Orbtxt

Specifies MO source:
- hforb: Reads MOs from SCF calculation
- mcorb: Reads MOs from MCSCF calculation
- Orbtxt: Reads MOs from text file

:guilabel:`FCIDUMP` Parameter Type: Boolean
---------------------------------------------------
Transforms MO integrals and stores in FCIDUMP file.

:guilabel:`Symmetry` Parameter Type: Integer
------------------------------------------------
Specifies spatial symmetry of molecular state.

:guilabel:`Nelectron` Parameter Type: Integer
---------------------------------------------------
Specifies number of electrons for Full CI calculation.

:guilabel:`Spin` Parameter Type: Integer
------------------------------------------------
Specifies spin multiplicity (2S+1) of electronic state.