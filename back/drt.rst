drt module
================================================
The drt module is used in conjunction with the mrci module to perform uncontracted multireference configuration interaction with single and double excitations (MRCISD) based on the hole-particle symmetry graphical unitary group approach (HP-GUGA). The drt module generates the Distinct Row Tabular (DRT) for the active space based on the HP-GUGA method.

:guilabel:`Title` Parameter type: string
------------------------------------------------
Input title; this does not affect the calculation and is solely used to label the computational task.

:guilabel:`Spin` Parameter type: integer
------------------------------------------------
Specify the spin multiplicity of the electronic state to be calculated, given by the value 2S+1.

:guilabel:`Symmetry` Parameter Type: Integer
------------------------------------------------
Specifies the symmetry of the electronic state, i.e., the irreducible representation to which the electronic state belongs.

:guilabel:`Electron` Parameter Type: Integer
------------------------------------------------
Specifies the total number of electrons in the CI calculation. Electrons not included in the frozen orbitals specified in traint.

:guilabel:`Nactel` Parameter Type: Integer
------------------------------------------------
Specifies the number of active electrons in the MRCI calculation.

:guilabel:`Inactive` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of doubly occupied orbitals for each irreducible representation in the MRCI calculation.

:guilabel:`Active` Parameter Type: Integer Array
------------------------------------------------
Specifies the number of active orbitals for each irreducible representation in the MRCI calculation.

:guilabel:`Reference` Parameter Type: Integer Array
------------------------------------------------
Specify the reference state for the MRCI calculation.

:guilabel:`Ciall` parameter type: integer array
------------------------------------------------
Generate the reference state using the CAS approach.