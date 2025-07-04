# Relativistic Effects
================================================

Relativistic effects mainly include scalar relativistic effects and spin-orbit coupling (SOC).  
These effects are crucial in studying organic light-emitting mechanisms. For example, SOC induces intersystem crossing between electronic states and changes spin states in transition states and products.  
The innermost core electrons of atoms are most strongly affected by relativity but least sensitive to chemical changes. Therefore, two main approaches exist: all-electron relativistic methods and effective core potentials (ECP).

1. **All-Electron Methods**  
   All core electrons are variationally treated. Common all-electron relativistic Hamiltonians include:  
   - Zeroth-order regular approximation (ZORA)  
   - Second-order Douglas-Kroll-Hess (DKH2)  
   - Exact two-component (X2C) method proposed by Wenjian Liu et al.  
   ZORA and DKH2 offer no significant advantages in accuracy or efficiency and are not recommended.

2. **ECP**  
   Core electrons of heavy atoms are replaced with pre-fitted effective potentials. For systems with multiple heavy atoms, ECPs significantly reduce variational freedom and improve computational efficiency.  
   Based on whether valence wavefunctions have nodes in the core region, ECPs are classified into:  
   - Pseudopotentials (PP)  
   - Model core potentials (MCP)  
   MCPs require extensive Gaussian functions to reproduce nodal structures, reducing computational efficiency gains. Thus, they are less commonly used.  
   In BDF, "ECP" refers exclusively to PP.

BDF's basis set library provides extensive :ref:`all-electron relativistic basis sets<all-e-bas>` and :ref:`ECP basis sets<ecp-bas>`.

.. warning::
    1. Do not combine X2C Hamiltonians with ECP basis sets.  
    2. X2C relativistic calculations must use uncontracted basis sets or specially optimized contracted basis sets (though elements ≤18 are exempt from strict optimization requirements).

---

## Scalar Relativistic Effects  
------------------------------------------------

* **All-Electron Methods**  
  BDF incorporates scalar relativistic effects via the spin-free X2C Hamiltonian (sf-X2C) and its localized variants: sf-X2C-AXR and sf-X2C-AU. Example input:  

  .. code-block:: bdf  

    $xuanyuan  
    heff  
      23  
    nuclear  
      1  
    $end  

  Here, ``heff`` selects the scalar relativistic Hamiltonian:  
  - sf-X2C (options 3, 4, or 21)  
  - sf-X2C-AXR (atomic X-matrix approximation, option 22)  
  - sf-X2C-AU (atomic U-transformation approximation, option 23)  
  Options 21, 22, and 23 support analytic derivatives.  

  .. _finite-nuclear:  

  Setting ``nuclear=1`` enables the finite nucleus model, which is generally optional. However, it is required when:  
  - Using relativistic contracted basis sets accounting for nuclear size effects (e.g., ANO-R)  
  - Calculating electron properties near the nucleus  

  **Comparison of sf-X2C Variants:**  
  - **sf-X2C**: Solves the one-electron spin-free Dirac equation rigorously for the **X** matrix (standard method). Diagonalization becomes a bottleneck for systems with >1000 basis functions.  
  - **sf-X2C-AXR**/**sf-X2C-AU**: Leverage atomic locality of the **X** matrix. Solve small Dirac equations for atomic L-shells, then assemble the molecular **X** matrix, dramatically reducing computational cost.  
    - For systems without heavy-element (≥5d) bonds, **sf-X2C-AU** offers optimal efficiency without accuracy loss (recommended).  
    - Otherwise, use **sf-X2C** (small molecules) or **sf-X2C-AXR** (any system size). :cite:`doi:10.1021/acs.jctc.9b01120`  

  .. warning:  
      When using ``heff=21/22/23``, BDF prioritizes reading derivative data from :ref:`BDF_TMPDIR<run-bdfpro>` temporary files. If these files come from other calculations, results may be erroneous!  
      Always use an empty BDF_TMPDIR directory unless atomic ordering, coordinates, and basis sets are identical between calculations.

* **ECP**  
  ECPs must be paired with non-relativistic Hamiltonians. Relativistic effects are implicitly included in pseudopotential parameters.  

.. important::  
   * Supported calculations with sf-X2C variants: Single-point energy, analytic gradients/geometry optimization, analytic Hessians/vibrational frequencies, and select :ref:`first-order one-electron properties<1e-prop>`. Second-order properties are under development.  
   * Supported calculations with ECPs: Single-point energy, analytic gradients/geometry optimization, analytic Hessians/vibrational frequencies, and select :ref:`one-electron properties<1e-prop>`.  

---

## Spin-Orbit Coupling (SOC)  
------------------------------------------------  
BDF treats SOC between electronic states of different spin multiplicities using the state interaction (SI) method within TDDFT single-point calculations. Specify SOC integral computation via the ``hsoc`` keyword in the :ref:`xuanyuan<xuanyuan>` module. See examples in the :ref:`TDDFT<TD>` section.  
For approximating SOC in chemical reaction simulations, see :ref:`spin-mixed state<MultiStateMix>` calculations.

SOC methods are also classified as all-electron or ECP-based.

* **All-Electron Methods**  
  Although two-electron SOC integrals contribute less than one-electron terms, their impact on SOC can reach 20-30% and cannot be neglected. Two treatments exist:  
  1. **Explicit two-electron SOC integrals** (with approximations to reduce cost). Compatible with sf-X2C scalar Hamiltonians or non-relativistic Hamiltonians for light elements.  
  2. **Approximating two-electron SOC from one-electron terms**, e.g., screened nuclear :cite:`snso2000,msnso2013` or effective nuclear charge :cite:`zeff1995` corrections. Faster but less accurate; may cause unpredictable errors for core electron properties.  

  BDF supports only the first approach. Use **one-electron SOC integrals + mean-field two-electron SOC with one-center approximation (so1e + SOMF-1c)** by setting ``hsoc=2`` in the :ref:`xuanyuan<xuanyuan>` module.

.. _so1e-zeff:  

* **ECP**  
  Two treatments:  
  1. **Spin-orbit ECPs (SOECPs)**: Require adding SO potential functions to scalar ECPs. Use :ref:`SOECP basis sets<soecp-bas>` from the basis set library.  
  2. **Effective nuclear charges** :cite:`zeff1995,zeff1998`: Compatible with scalar ECPs or non-relativistic all-electron basis sets, but with limited element support (see table below).  

  Both methods incorporate two-electron SOC effects into parameters, requiring only one-electron SOC integrals.  
  BDF automatically uses both treatments based on basis sets by setting ``hsoc=10`` in the :ref:`xuanyuan<xuanyuan>` module.  

  .. note::  
      Effective nuclear charge has limited element/basis support:  
      - For all-electron basis sets: Only main-group elements ≤ Xe (excluding Ne, Ar, Kr).  
      - For scalar ECPs: Supported elements must match core electron counts (NCore) in the table below. Results are unreliable for unsupported elements/basis sets.  

.. table:: Effective Nuclear Charge Parameters and Required Core Electron Counts (NCore)  
    :widths: auto  

    +-----------------------------+----------------------------------------+-------+  
    | Elements                    | Atomic Numbers (ZA)                   | NCore |  
    +=============================+========================================+=======+  
    | Li-F                        | 3-9                                    | 2     |  
    +-----------------------------+----------------------------------------+-------+  
    | Na-Cl, Sc-Cu, Zn, Ga        | 11-17, 21-29, 30, 31                   | 10    |  
    +-----------------------------+----------------------------------------+-------+  
    | K-Ca                        | 19-20                                  | 18    |  
    +-----------------------------+----------------------------------------+-------+  
    | Ge-Br, Y-Ag, Cd, In         | 32-35, 39-47, 48, 49                   | 28    |  
    +-----------------------------+----------------------------------------+-------+  
    | Rb-Sr                       | 37-38                                  | 36    |  
    +-----------------------------+----------------------------------------+-------+  
    | Sn-I, La                    | 50-53, 57                              | 46    |  
    +-----------------------------+----------------------------------------+-------+  
    | Cs-Ba                       | 55-56                                  | 54    |  
    +-----------------------------+----------------------------------------+-------+  
    | Hf-Au, Hg, Tl               | 72-79, 80, 81                          | 60    |  
    +-----------------------------+----------------------------------------+-------+  
    | Pb-At                       | 82-85                                  | 78    |  
    +-----------------------------+----------------------------------------+-------+  

For details (parameters, references), see source file `soint_util/zefflib.F90`.