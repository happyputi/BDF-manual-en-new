Concise Input Keywords
===============================

### Required Parameters: :guilabel:`Method/Functional/Basis`, :guilabel:`Functional/Basis`, :guilabel:`Method/Basis`
----------------------------------------------------------------------------------------
Required parameters in concise input mode are used to set computational methods, functionals for DFT/TDDFT calculations, basis sets, etc. Currently supported computational methods include:

+-------------------+------------------------------------------------------------------+
| Method              | Functionality                                                     |
+-------------------+------------------------------------------------------------------+
|HF                 | Hatree-Fock                                                      |
+-------------------+------------------------------------------------------------------+
|RHF                | Restricted Hatree-Fock                                           |
+-------------------+------------------------------------------------------------------+
|UHF                | Unrestricted Hartree-Fock                                        |
+-------------------+------------------------------------------------------------------+
|ROHF               | Restricted open-shell Hatree-Fock                                |
+-------------------+------------------------------------------------------------------+
|KS                 | Kohn-Sham                                                        |
+-------------------+------------------------------------------------------------------+
|RKS                | Restricted Kohn-Sham                                             |
+-------------------+------------------------------------------------------------------+
|UKS                | Unrestricted Kohn-Sham                                           |
+-------------------+------------------------------------------------------------------+
|TDDFT              | Time-dependent density functional theory                         |
+-------------------+------------------------------------------------------------------+
|TDA                | Tamm-Dancoff Approximation                                       |
+-------------------+------------------------------------------------------------------+
|X-TDDFT            | Extended spin-adapted TDDFT                                      |
+-------------------+------------------------------------------------------------------+
|X-TDA              | Extended spin-adapted TDA                                        |
+-------------------+------------------------------------------------------------------+
|TDDFT-SOC          | TDDFT with spin-orbit coupling                                   |
+-------------------+------------------------------------------------------------------+
|TDA-SOC            | TDA with spin-orbit coupling                                     |
+-------------------+------------------------------------------------------------------+
|X-TDDFT-SOC        | Extended spin-adapted TDDFT with spin-orbit coupling             |
+-------------------+------------------------------------------------------------------+
|X-TDA-SOC          | Extended TDA with SOC                                            |
+-------------------+------------------------------------------------------------------+
|TDDFT-NAC          | TDDFT with non-adabatic coupling                                 |
+-------------------+------------------------------------------------------------------+
|TDA-NAC            | TDA with non-adabatic coupling                                   |
+-------------------+------------------------------------------------------------------+
|X-TDDFT-NAC        | X-TDDFT with non-adabatic coupling                               |
+-------------------+------------------------------------------------------------------+
|X-TDA-NAC          | X-TDA with non-adabatic coupling                                 |
+-------------------+------------------------------------------------------------------+
|MP2                | Mollor-Plesset second order perturbation theory                  |
+-------------------+------------------------------------------------------------------+
|RI-MP2             | MP2 using Resolution of Identity                                 |
+-------------------+------------------------------------------------------------------+

**Hamiltonian and Spin-Orbit Coupling**

### :guilabel:`hamilton` Parameter Type: String, Optional
----------------------------------------------------
Set the relativistic Hamiltonian for calculation

Default: `nonrel` (uses `sf-X2C` when relativistic basis sets are employed)

Options: `sf-X2C`, `sf-X2C-AXR`, `sf-X2C-AU`

### :guilabel:`SOC` Parameter Type: Bool, Optional
------------------------------------------------
Request spin-orbit coupling (SOC) calculation and set corresponding SOC operator. If method is TDDFT, performs SOC calculation based on TDDFT; if method is TDA, performs SOC calculation based on TDA.

Default: `DKH1e+mf1c`

Options: `DKH1e+mf1c`, `DKH1e`, `BP`; `DKH1e+mf1c` for all-electron calculations, `BP` operator for relativistic effective potentials.

.. note::
  * **Default Principle**: If Hamiltonian is specified, BDF will select appropriate Hamiltonian based on basis functions. For all-electron basis sets considering relativistic effects or non-relativistic all-electron basis sets, scalar terms use **sf-X2C** Hamiltonian, spin-orbit coupling operator uses **DKH1e+mf1c**. Users can forcibly set to **DKH1e**, but this may introduce significant errors for light elements. For relativistic effective potentials and basis sets, the potential already includes relativistic effects, so no Hamiltonian needs to be set; SOC operator defaults to BP.
  * User input `TDDFT/functional/basis SOC` (using SOC keyword) is equivalent to setting `X-TDDFT/functional/basis`, with Hamiltonian and SOC operators set according to default principles.

**Coordinate Units, Charge, and Spin Multiplicity**

### :guilabel:`unit` Parameter Type: String, Optional
------------------------------------------------
Atomic coordinate units

Default: `angstrom`

Options: `angstrom`, `Bohr`

### :guilabel:`spinmulti` Parameter Type: Integer, Optional
------------------------------------------------
Spin multiplicity, `2S+1`

Default: `1` for even-electron systems, `2` for odd-electron systems

### :guilabel:`charge` Parameter Type: Integer, Optional
------------------------------------------------
Charge number

Default: `0`

**Spin-Adapted TDDFT and TDA**

### :guilabel:`SpinAdapt`
------------------------------------------------
Set spin-adapted TDDFT or TDA. `TDDFT/functional/basis SpinAdapt` is equivalent to `X-TDDFT/functional/basis` or `X-TDA`. Only meaningful for open-shell systems.

**Non-Adiabatic Coupling**

### :guilabel:`NAC` Parameter Type: Bool, Optional
------------------------------------------------
Non-adiabatic coupling (NAC) calculation based on time-dependent density functional theory (TDDFT)

Default: `False`

**Potential Energy Surfaces and Structural Optimization**

### :guilabel:`opt` Parameter Type: Bool, Optional
------------------------------------------------
Molecular geometry optimization for stable points.

Default: `False`

### :guilabel:`opt+freq` Parameter Type: Bool, Optional
------------------------------------------------
Molecular geometry optimization for stable points, followed by frequency calculation.

Default: `False`

### :guilabel:`ts+freq` Parameter Type: Bool, Optional
------------------------------------------------
Transition state optimization, followed by frequency calculation.

Default: `False`

### :guilabel:`freq` Parameter Type: Bool, Optional
------------------------------------------------
Frequency calculation.

Default: `False`

### :guilabel:`scan` Parameter Type: Bool, Optional
------------------------------------------------
Molecular potential energy surface scan, requires internal coordinate input.

Default: `False`

### :guilabel:`scan+opt` Parameter Type: Bool, Optional
------------------------------------------------
Flexible molecular potential energy surface scan (optimizes other coordinate parameters while fixing certain internal coordinate parameters), requires internal coordinate input.

Default: `False`

**Acceleration Algorithms**

### :guilabel:`MPEC+COSX` Parameter Type: Bool, Optional 
------------------------------------------------
Accelerate `SCF`, `TDDFT` energy and gradient calculations using `Multipole Expansion of Coulomb Potential` (MPEC) and `Chain-Of-Spheres Exchange` (COSX).

Default: `False`

### :guilabel:`RI` Parameter Type: Bool, Optional 
------------------------------------------------
Accelerate `SCF`, `TDDFT` or `MP2` calculations using Resolution of Identity (RI), requires auxiliary basis sets.

Default: `False`

.. tip::
  * RI in BDF is mainly used to accelerate MP2 calculations. For SCF and TDDFT, MPEC+COSX is preferred. This method is unique to BDF, offers comparable accuracy to RI, and does not require auxiliary basis sets.