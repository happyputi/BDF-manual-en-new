.. _mossbauer:

Mössbauer Spectroscopy
================================================

In 1958, R. L. Mössbauer discovered the *Mössbauer effect* while studying γ-ray resonance absorption phenomena. The isomer shift (δᴵˢ) is one of the important observable parameters in Mössbauer spectroscopy, originating from the Coulomb interaction between atomic nuclei of finite size and the surrounding electron distribution. When atoms are in different external environments, the Coulomb energy near the nucleus changes, and δᴵˢ is extremely sensitive to this change, making it useful for studying atomic oxidation states, spin states, and coordination environments. Another important observable parameter is the nuclear quadrupole splitting (ΔE_Q), which arises from the interaction between the electric quadrupole moment (eQ; where e is the proton charge and Q is the nuclear quadrupole moment, NQM) of nuclei with spin quantum number I > 1/2 and the electric field gradient (EFG) around the nucleus. Additionally, when atoms are placed in an external magnetic field, Mössbauer spectra undergo further Zeeman splitting due to the nuclear magnetic moment.

δᴵˢ can be expressed as a linear function of the change in "effective contact density" (ED) or "contact density" (CD) between the test system A and the reference system R:

.. math::
    \delta^{IS} &= \alpha(\rho_{A}-\rho_{R}) \\
    &= \alpha(\rho_{A}-C)+\beta

These two formulas are called *calibration equations*, where δᴵˢ is the experimental isomer shift of test system A relative to reference system R. The ED or CD values ρ_A and ρ_R can be obtained through theoretical calculations. α and β are parameters to be fitted, with α also known as the nuclear calibration constant. C is an arbitrary constant, usually taken as the integer part of ED or CD. Considering potential errors in the theoretical value of ρ_R, the latter formula is generally used for fitting.

.. note::

    CD assumes a uniform distribution of electron density near the nucleus and thus uses the density at a single point (usually the nuclear center, though some programs use weighted averages of multiple points). ED considers the non-uniform distribution of electron density and is theoretically more reasonable. Many programs calculate CD, while BDF calculates ED. The two are approximately convertible (see Tables S2 and S3 in reference :cite:`ecd2020`), and the conversion factor can be absorbed into α.

To accurately calculate ED and its relative changes, two factors must be considered:

* Atomic nuclei have finite size distributions, and the default point-charge approximation may lead to errors of several orders of magnitude! Set ``nuclear=1`` in the ``xuanyuan`` module to address this.
* Relativistic effects must be considered. This is obvious for heavy elements, but even for some light elements it's essential. Non-relativistic *p* electrons have no distribution near the nucleus (see Table S6 in reference :cite:`ecd2020`), leading to qualitatively wrong ED for *p*-block elements. In BDF, scalar relativistic effects can be included using the sf-X2C Hamiltonian or its local variants, specified via ``heff=21`` (standard sf-X2C), ``22`` (sf-X2C-AXR), or ``23`` (sf-X2C-AU) in the ``xuanyuan`` module.

Effective Contact Density of Iron ( :math:`\ce{^{57}Fe}` ) Compounds
------------------------------------------------

The probability of γ-ray absorption and emission is proportional to :math:`\exp(-E_\gamma^2)`. When nuclear excitation energy E_γ exceeds 200 keV, Mössbauer spectroscopy becomes difficult to observe, limiting its application to only a few isotopes. :math:`\ce{^{57}Fe}` is one such suitable isotope, though theoretical calculations generally don't distinguish between isotopes.

Calculating ED requires extremely steep *s*-type Gaussian basis functions to accurately describe electron distribution near the iron nucleus. For *p*-block elements with *p* valence electrons, very steep *p*-type Gaussian basis functions are also needed, which standard contracted basis sets typically lack. We recommend using all-electron relativistic basis sets like cc-pVnZ or ANO, with their *s* functions (and *p* functions for *p*-block elements) uncontracted. In the following all-electron relativistic calculations, iron uses the ANO-R2 basis set (triple-ζ accuracy) with *s* functions uncontracted (remove contraction coefficients and set contraction degree to 0), saved under a different name (e.g., ANO-R2-ED). Since iron has no 4*p* valence electrons, *p* functions don't need modification. Copy ANO-R2-ED to the $BDF_WORKDIR directory for subsequent calculations (download link: :download:`ano-r2-ed.zip </files/ano-r2-ed.zip>`). Note: For non-standard basis sets, all letters in the basis set name must be uppercase.

We perform relativistic density functional theory calculations for a series of iron model compounds using the PBE0 functional and sf-X2C-AU relativistic Hamiltonian. Light elements other than iron use the def2-TZVPP basis set, which is all-electron for elements before Kr and suitable for relativistic calculations of the first 18 elements. Spin multiplicities and molecular coordinates are from reference :cite:`neese2009`. For :math:`\ce{FeF6^{4-}}`, the input is:

.. code-block:: bdf

  $compass
   title
     FeF_6^4-
   basis-block
     def2-tzvpp
     Fe = ANO-R2-ED
   end basis
   geometry  # Cartesian coordinates in Ångstroms
     Fe -0.000035  0.000012  0.000014
     F   2.116808 -0.003546  0.032360
     F  -2.116824  0.001611 -0.030945
     F  -0.003602  2.164955  0.001902
     F   0.001648 -2.165219 -0.003295
     F   0.032586  0.003638  2.109790
     F  -0.030580 -0.001452 -2.109825
   end geometry
   MPEC+cosx        # Use MPEC+COSX acceleration
  $end
  
  $xuanyuan
   heff      # sf-X2C-AU; must choose 21-23 for ED
     23
   nuclear   # Gaussian finite nucleus model; must set to 1 for ED
     1
  $end
  
  $scf
   charge
     -4
   spinmulti
     5
   uks
   dft functional
     pbe0
   grid             # Precision grid required for ED calculation
     ultra fine
   reled
     26             # Calculate ED only for Fe (integers 10-26 equivalent here)
  $end

After calculation, ED results appear after SCF population analysis:

.. code-block::

  Relativistic effective contact densities for the atoms with Za > 25
  ----------------------------------------------------------------
        No.     Iatm       Za       RMS (fm)            Rho (a.u.)
  ----------------------------------------------------------------
          1        1       26        3.76842           14552.65555
  ----------------------------------------------------------------

Following this example, complete ED calculations for other iron compound molecules (input file download: :download:`ed-fe.zip </files/ed-fe.zip>`). ED results and experimental δᴵˢ values :cite:`neese2009` are listed below:

.. table:: δᴵˢ and Effective Contact Density for Selected Iron Compounds
    :widths: auto

    +------------------------------+------+----------------------------+--------------------------+
    | Molecule                     | 2S+1 | δᴵˢ (mm/s)                 | ED (bohr⁻³)             |
    +==============================+======+============================+==========================+
    | :math:`\ce{FeCl4^{2-}}`      | 5    | +0.90                      | 14551.76                |
    | :math:`\ce{Fe(CN)6^{4-}}`    | 1    | -0.02                      | 14555.78                |
    | :math:`\ce{FeF6^{4-}}`       | 5    | +1.34                      | 14552.68                |
    | :math:`\ce{FeCl4^-}`         | 6    | +0.19                      | 14553.98                |
    | :math:`\ce{Fe(CN)6^{3-}}`    | 2    | -0.13                      | 14556.08                |
    | :math:`\ce{FeF6^{3-}}`       | 6    | +0.48                      | 14553.01                |
    | :math:`\ce{Fe(H2O)6^{3+}}`   | 6    | +0.51                      | 14554.12                |
    | :math:`\ce{FeO4^{2-}}`       | 3    | -0.87                      | 14558.17                |
    | :math:`\ce{Fe(CO)5}`         | 1    | -0.18                      | 14556.37                |
    +------------------------------+------+----------------------------+--------------------------+

Fitting this data yields the calibration equation:

.. math::
    \delta^{IS} = -0.29226 (\rho_{A} - 14550) + 1.6089, \quad R^2 =0.85

The significant fitting error may stem from:
1. Small sample size
2. Mössbauer spectra are measured for solid-state systems, inconsistent with gaseous ion models. Cluster models, solvation models :cite:`papai2013`, or embedding models :cite:`autschbach2021` may be more appropriate.
3. Strong correlation in some iron compounds requires testing other functionals or methods suitable for strongly correlated systems.

Using this calibration equation, we can predict δᴵˢ for iron systems. For example, staggered ferrocene :cite:`holland2017` yields ED = 14554.25 a.u. through DFT, giving δᴵˢ = 0.37 mm/s, close to the experimental value of 0.53 mm/s :cite:`holland2017`.

Notes for Calculating Effective Contact Density in Heavy-Element Compounds
------------------------------------------------

For elements beyond 4d, default Gaussian exponents are insufficient to describe electron distribution near the nucleus. Additional steeper exponents are needed. For example, select the steepest 4-6 *s*-type Gaussian exponents α from standard cc-pVnZ or ANO basis sets (also consider *p*-type for *p*-block heavy elements). These approximately satisfy:

.. math::
    \ln\alpha_i = A + i\,B, \qquad i = 1, 2, \ldots

Linear fitting yields parameters A and B. Extrapolation (using intervals of -0.5 or -1 for i) provides steeper Gaussian exponents. Adding 2-5 steeper *s* functions and 1-3 steeper *p* functions is usually sufficient, but avoid exponents > 10¹¹ to prevent numerical instability.

EFG Calculation for Iron ( :math:`\ce{^{57}Fe}` ) Compounds
------------------------------------------------

EFG calculations have similar relativistic Hamiltonian requirements as ED calculations but different basis set requirements:

* Only *s* electrons and a few *p* electrons have non-zero distribution near the nucleus, so ED calculations only need modified *s* and *p* basis functions.
* Nuclear deformation quadrupole moments only interact with EFG from electrons with orbital angular momentum L > 0, so *s* basis functions don't need modification. Uncontract *p* functions (remove contraction coefficients and set contraction degree to 0), and add 1-2 steep *p*-type Gaussian functions. For transition elements with *d* valence orbitals (lanthanides/actinides also have *f*), uncontract *d* (and *f*) functions. Since *d* and *f* orbitals are farther from the nucleus, steeper *d*/*f* functions aren't needed.
* When calculating both ED and EFG, basis function modifications must satisfy both requirements.

The keyword for EFG calculation is ``relefg``. For example, to calculate both ED and EFG, modify the **SCF** module input as:

.. code-block:: bdf

  $scf
   charge
     -4
   spinmulti
     5
   uks
   dft functional
     pbe0
   grid             # Precision grid required for EFG
     ultra fine
   relefg
     26             # Calculate EFG tensor only for Fe
   reled
     26             # Calculate ED only for Fe
  $end

After calculation, EFG tensor results appear after SCF population analysis and ED results:

.. code-block::

  Relativistic electric field gradients for the atoms with Za > 25
  -----------------------------------------------------------------------------
        No.     Iatm       Za       RMS (fm)            EFG tensor (a.u.)
  -----------------------------------------------------------------------------
          1        1       26        3.76842      -0.1061    -0.0023     0.1850
                                                  -0.0023     0.0395    -0.0018
                                                   0.1850    -0.0018     0.0666

                                       eta           Vaa        Vbb        Vcc
                                     0.64736       0.0395     0.1844    -0.2239

                   NQCC =         -8.4172 MHz with Q(ISO-057) =    160.00 mbarn

  -----------------------------------------------------------------------------

Among the 9 components of the EFG tensor, the 6 off-diagonal elements are symmetric. The sum of the 3 diagonal elements is zero. In a special coordinate system :math:`\{\vec{a},\vec{b},\vec{c}\}` (principal axes/eigenvectors of the EFG tensor), off-diagonal elements vanish, and diagonal elements (eigenvalues) satisfy :math:`|V_{aa}| \le |V_{bb}| \le |V_{cc}|`. The EFG tensor can then be described by two parameters: principal value :math:`V_{cc}` and asymmetry parameter :math:`\eta = |(V_{aa} − V_{bb})/V_{cc}|` (0 ≤ η ≤ 1). When η = 0, the EFG tensor is axially symmetric. Here, η = 0.64736 and :math:`V_{cc}` = -0.2239 a.u.

.. attention::

  1. For molecules in non-Abelian degenerate states, :math:`V_{cc}` and η from a single branch are generally meaningless. Calculate EFG tensors for all degenerate branches (by specifying occupations in SCF), average them, then compute :math:`V_{cc}` and η.
  2. For isolated atoms, :math:`V_{aa} = V_{bb} = V_{cc} = 0`. For linear molecules (including diatomic), :math:`V_{cc} = V_{zz}` (z-axis along molecular axis). BDF can correct EFG results for open-shell atoms and linear molecules in degenerate states using this property.

The interaction between nuclear quadrupole moment and EFG is typically measured by the nuclear quadrupole coupling constant (NQCC, :math:`eQq`), defined as:

.. math::
    eQq = 234.96478 ~Q ~V_{cc}

where :math:`V_{cc}` is in atomic units, nuclear quadrupole moment Q is in Barn (1 Barn = 1.0e-28 m²), and :math:`eQq` is in MHz. When the experimental Q value is known, the program prints :math:`eQq`, here -8.4172 MHz.

The nuclear quadrupole splitting ΔE_Q measured by Mössbauer spectroscopy relates to NQCC. For :math:`\ce{^{57}Fe}` I=1/2 → I=3/2 nuclear excitation transition (γ-ray energy 14.412497 KeV ≈ 34.85e11 MHz):

.. math::
    \Delta E_{Q} = \frac{1}{2} eQq \left(1+\frac{\eta^2}{3}\right)^{1/2} 

with unit conversion factor 1 mm/s = 11.6248 MHz. Theoretical ΔE_Q can be directly compared with experimental Mössbauer values and combined with ED results to verify iron oxidation state assignments.