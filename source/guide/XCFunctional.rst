# Exchange-Correlation Functionals Supported in BDF
===============================================
BDF's Density Functional Theory (DFT) supports **Restricted (RKS)**, **Unrestricted (UKS)**, and **Restricted Open-Shell (ROKS)** Kohn-Sham calculations. The input format is similar to RHF, UHF, and ROHF, with the key requirement being the specification of the exchange-correlation functional. BDF supports LDA, GGA, Meta-GGA, Hybrid, RS Hybrid, and Hybrid Meta-GGA functionals.

.. table:: Functionals Supported in BDF
    :widths: 40 60

    ========================================  ====================================================
     Functional Type                          Functionals
    ========================================  ====================================================
     Local Density Approximation (LDA)        LSDA, SVWN5, SAOP
     Generalized Gradient Approximation (GGA)  BP86, BLYP, PBE, PW91, OLYP, KT2
     Meta-GGA (with kinetic energy density)    TPSS, M06L, M11L, MN12L, MN15L, SCAN, r2SCAN
     Hybrid GGA                                B3LYP, GB3LYP, BHHLYP, PBE0, B3PW91, HFLYP, VBLYP
     Range-Separated Hybrid GGA                wB97, wB97X, wB97X-D, CAM-B3LYP, LC-BLYP
     Hybrid Meta-GGA                          TPSSh, M062X, PW6B95
     Double Hybrid                             B2PLYP
    ========================================  ====================================================

.. attention::
    1. B3LYP uses VWN5 for LDA correlation, while GB3LYP corresponds to Gaussian's B3LYP using VWN3.
    2. For non-integral-direct SCF calculations with range-separated functionals, manually set the ``rs`` value in the ``Xuanyuan`` module (see :ref:`xuanyuan module keywords<xuanyuan>`). rs values: wB97=0.40, wB97X=0.30, wB97X-D=0.20, CAM-B3LYP=0.33, LC-BLYP=0.33.
    3. For double hybrid functionals, add an ``MP2`` module after ``SCF`` (see test116 in :doc:`examples<Example>`), and read final results from ``MP2`` output.
    4. Use ``facex`` and ``facco`` keywords in ``SCF`` to adjust HF exchange and MP2 correlation ratios for custom functionals (see :doc:`SCF module keywords<scf>`).
    5. BDF uses libxc and theoretically supports all libxc functionals. Additional functionals can be added upon user request.

While all functionals support ground-state single-point energies (without dispersion correction), certain features are limited to specific functionals:

.. table:: Functionals Supported for Different Calculation Types
    :widths: 30 70

    ======================== ===================================================================================================
     Calculation Type        Supported Functionals
    ======================== ===================================================================================================
     TDDFT Single-Point/SOC   All except double hybrids
     TDDFT Transition Dipole LSDA, SVWN5, BP86, BLYP, PBE, OLYP, B3LYP, GB3LYP, BHHLYP, PBE0, HFLYP, CAM-B3LYP, LC-BLYP
     Ground State Gradient   All LDA/GGA/hybrid GGA/meta-GGA/hybrid meta-GGA except SAOP, PW91, KT2, B3PW91, VBLYP, SF5050
     Excited State Gradient/NAC  All LDA/GGA/hybrid GGA except SAOP, PW91, KT2, B3PW91, VBLYP, SF5050
     Energy/Electron Transfer All functionals (B2PLYP results are approximate, missing MP2 correlation contribution)
     NMR                      All LDA, GGA and hybrid GGA functionals
     Dispersion Correction    BP86, BLYP, PBE, B3LYP, GB3LYP, BHHLYP, B3PW91, PBE0, CAM-B3LYP, B2PLYP, wB97X-D
    ======================== ===================================================================================================