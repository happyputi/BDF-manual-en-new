BDF Software Introduction
================================================   

BDF (Beijing Density Functional) is an independent, fully self-developed quantum chemistry software package with complete intellectual property rights. It is the world's first fully relativistic density functional program based on modern density functional theory capable of accurately calculating the total ground-state energy of molecular systems (earlier similar programs failed to compute total energies accurately due to poor numerical integration precision).

The development of BDF began in 1993 and was officially named in 1997 :cite:`doi:10.1007/s002140050207`. Initially focused on high-precision calculations for small molecular systems involving rare earths, actinides, transition metals, and superheavy elements to study relativistic effects, it employed fully relativistic density functional theory (4C-DFT) based on the Dirac operator and a near-complete basis set "numerical basis + STO" (Slater-type orbital). Consequently, BDF's results for heavy-element systems have served as benchmarks for validating other approximate relativistic methods. Its electronic and molecular structure calculations for heavy elements have been experimentally verified over 20 times.

In 2009, analytical integrals based on Gaussian basis functions were introduced, marking a new development phase for BDF.

Undoubtedly, BDF was designed from the outset as a platform for developing new theories, methods, and algorithms, making it a "research software." Theoretical and methodological developments based on BDF include:
- Relativistic time-dependent density functional theory (4C/ZORA/X2C-TDDFT) :cite:`doi:10.1063/1.1788655,doi:10.1063/1.1940609,doi:10.1063/1.2047554,doi:10.1016/j.chemphys.2008.10.011,doi:10.1007/s11426-009-0279-5,doi:10.1080/00268976.2013.785611`
- Exact two-component (X2C) relativistic theory :cite:`doi:10.1063/1.2137315,doi:10.1063/1.3159445,doi:10.1063/1.2222365`
- Quasi-four-component (Q4C) relativistic theory :cite:`doi:10.1063/1.2222365,doi:10.1063/1.2772856`
- Spin-free X2C relativistic theory (sf-X2C+so-DKHn) :cite:`doi:10.1063/1.4758987,doi:10.1063/1.4891567`
- Many-body effective quantum electrodynamics (eQED) :cite:`doi:10.1063/1.4811795,doi:10.1016/j.physrep.2013.11.006`
- Relativistic NMR theory (4C/X2C-NMR) :cite:`doi:10.1063/1.2565724,doi:10.1063/1.2736702,doi:10.1063/1.3110602,doi:10.1063/1.3283036,doi:10.1063/1.3216471,doi:10.1063/1.4764042,doi:10.1021/ct400950g,doi:10.1063/1.4813594`
- Relativistic nuclear spin-rotation theory (4C-NSR) :cite:`doi:10.1063/1.4813594,doi:10.1063/1.4797496,doi:10.1063/1.4898631`
- Relativistic band theory (X2C-PBC) :cite:`doi:10.1063/1.4940140`
- X2C analytical gradients and Hessians :cite:`doi:10.1021/acs.jctc.9b01120`
- Excited-state HF/KS methods (mom) :cite:`doi:10.1021/ct500066t`
- Fragment-based orbital localization schemes (FLMO) :cite:`doi:10.1021/ct500066t,doi:10.1021/ct200225v,doi:10.1021/ar500082t`
- Sublinear-scaling TDDFT (FLMO-TDDFT) :cite:`doi:10.1063/1.4977929`
- Sublinear-scaling NMR (FLMO-NMR) :cite:`doi:10.1063/1.5083193`
- Iterative orbital interaction "bottom-up" SCF method (iOI) :cite:`doi:10.1021/acs.jctc.1c00445`
- Spin-adapted open-shell TDDFT (SA-TDDFT) :cite:`doi:10.1063/1.3463799,doi:10.1063/1.3573374,doi:10.1063/1.3660688,doi:10.1021/acs.jctc.5b01158,doi:10.1021/acs.jctc.5b01219`
- Spin-flip TDDFT (SF-TDDFT) :cite:`doi:10.1063/1.3676736`
- Ground/excited-state non-adiabatic coupling TDDFT (NAC-TDDFT) :cite:`doi:10.1063/1.4885817,doi:10.1063/1.4903986,doi:10.1021/acs.accounts.1c00312`
- TDDFT analytical energy gradients :cite:`doi:10.1063/5.0025428`
- Arbitrary single/double-valued point group symmetrization :cite:`doi:10.1002/qua.22078`

Beyond relativistic/non-relativistic DFT and TDDFT, BDF also includes wavefunction-based electron correlation methods based on the "static first, then dynamic, then static again" (SDS) philosophy: SDSPT2 :cite:`doi:10.1007/s00214-014-1481-x`, SDSCI :cite:`doi:10.1007/s00214-014-1481-x`, iCI :cite:`doi:10.1021/acs.jctc.5b01099`, iCIPT2 :cite:`doi:10.1021/acs.jctc.9b01200,doi:10.1021/acs.jctc.0c01187`, iCAS :cite:`doi:10.1021/acs.jctc.1c00456`, iCISCF :cite:`doi:10.1021/acs.jctc.1c00781`, SOC-iCI, iCI-SOC, and the iVI method for directly solving interior eigenvalues of large matrices :cite:`doi:10.1002/jcc.24907,doi:10.1002/jcc.25569`.

In July 2021, BDF signed an agreement with Hongzhiwei Technology (Shanghai) Co., Ltd. for commercial promotion. Given BDF's current status, the initial commercial version focuses on luminescence mechanisms and material design for fluorescent/phosphorescent materials, excluding 4C/X2C relativity, wavefunction electron correlation, solid-state band/NMR, etc. The first commercial BDF release emphasizes DFT and TDDFT features, including:

 * Ground and excited-state energies (via ΔSCF): Hartree-Fock, Kohn-Sham DFT (LDA, GGA, meta-GGA, range-separated, hybrid, double-hybrid functionals), dispersion correction.
 * Excited-state calculations: TDDFT/TDA (including FLMO-TDDFT, SF-TDDFT, X-TDDFT, XAS-TDDFT), mom method for ΔSCF.
 * TDDFT excited-state dipole moments.
 * Spin-orbit coupling: SA-TDDFT/SOC.
 * Excited-state non-adiabatic coupling: NAC-TDDFT.
 * Analytical gradients and semi-numerical Hessians (vibrational frequencies) for ground states, ΔSCF excited states, SA-TDDFT excited states.
 * Structure optimization: stable structure optimization, transition state optimization, minimum energy crossing points (MECP), conical intersections.
 * Energy/electron transfer integrals.
 * QM/MM.
 * Implicit solvation models.
 * FLMO-NMR, localized orbital (FLMO) property calculation/analysis.

The development of BDF remains a long-term endeavor. Its success depends not only on sustained R&D efforts but also on the encouragement and support of its user community.

Feature Updates
================================================   

2024A Release (2024.1)

  * Solvent model updates: Support for multiple implicit solvation models (IEFPCM, COSMO, CPCM, SS(V)PE, ddCOSMO, SMD). Enables ground-state solvent effect single-point energies, gradients, Hessians; linear-response solvation theory (LR-TDDFT) excited-state energies, gradients, and structural optimization; non-equilibrium solvent-based absorption/emission spectra calculations; corrected linear-response (noneq-cLR-TDDFT) and state-specific (noneq-SS-TDDFT) methods.
  * Support for analytical Hessians with Meta-GGA and pseudopotentials.
  * Excited-state calculations: Fast approximate methods for large-system absorption spectra (sTDA, sTDDFT); electronic circular dichroism (ECD) spectra; localized excited states.
  * Extended support for GGA, hybrid GGA, Meta-GGA functionals from libxc library.
  * BSSE correction: Flexible dummy atom handling (multiple types, customizable basis sets).
  * Hybrid optimization algorithms: Combines RFO, RFO-GDIIS, and GEDIIS methods.
  * Second-order (approximate) SCF methods: Enhanced SCF convergence.
  * Polarizability calculations.

2023A Release (2023.2)

  * Updated second-order analytical Hessian: Supports Hartree-Fock, LDA, GGA, global hybrid, range-separated functionals, ECP basis sets in DFT. Applicable to transition state search, frequency analysis, thermodynamics.
  * Added IEFPCM and COSMO solvent models: Ground-state energy/gradients; TDDFT/TDA: PTD energy/gradients, linear-response energy (closed-shell).
  * Added Dimer method for transition state structure optimization.
  * Added reaction path validation/analysis: Intrinsic reaction coordinate (IRC) calculation.
  * Added automatic imaginary frequency elimination during optimization.
  * Added approximate methods for large-system excited states: sTDA, sTDDFT.
  * Added X2C relativistic electric field gradient (EFG) method.
  * Fixed issues with aMPEC+COSX algorithm in ground-state optimization and TDDFT.
  * Improved error messages for user troubleshooting.

Free Trial of BDF
================================================   

Interested users can register for a Hongzhiwei Cloud account at https://iresearch.net.cn/web/personal-space/activity-page to apply for a free trial. Alternatively, send a trial request email to sales@hzwtech.com or call 021-50550302.