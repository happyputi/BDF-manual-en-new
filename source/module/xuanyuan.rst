.. _xuanyuan:

One- and Two-Electron Integral Calculation - XUANYUAN Module
================================================
The XUANYUAN module primarily calculates one- and two-electron integrals and other necessary integrals, storing them to files.

:guilabel:`Direct` Parameter Type: Boolean
--------------------------------------
Specifies using integral-direct SCF calculations. This is now the default option and does not require user setting.

Integral-direct SCF does not store two-electron integrals. It pre-screens integrals using the Schwartz inequality based on their contribution to the Fock matrix. For systems with more than ~300 basis functions, it efficiently utilizes integral recomputation to avoid I/O operations and supports OpenMP multi-core parallelization. Most BDF modules requiring Fock-like matrices (J and K), such as SCF and TDDFT, implement integral-direct calculations.

.. note::

    Integral-direct SCF also requires the :ref:`Skeleton<compass.skeleton>` keyword in the compass module, which is now the default.
    To disable integral-direct SCF, use the :ref:`Saorb<compass.saorb>` keyword in the compass module.

:guilabel:`Maxmem` Parameter Type: String
--------------------------------------
Specifies the cache size for non-integral-direct SCF two-electron integral calculations. Larger caches reduce integral sorting frequency. Format: number + `MW` or `GW`. 1 Word = 2 Bytes, so 512MW = 1024 MB.

.. code-block:: bdf
    
     $xuanyuan
     Maxmem
       512MW
     $end


.. _xuanyuan_rsomega:

:guilabel:`RSOMEGA` / :guilabel:`RS` Parameter Type: Floating-point
------------------------------------------------------
Specifies the :math:`\omega` parameter (sometimes denoted :math:`\mu` in literature) for range-separated functionals (e.g., CAM-B3LYP).
``RS`` is a synonym for ``RSOMEGA``. Required if using a range-separated DFT functional. Recommended values:

.. table:: Standard :math:`\omega` values for common range-separated functionals
    :widths: auto

    +------------------+--------------------+
    | Functional       | :math:`\omega`     |
    +==================+====================+
    | CAM-B3LYP        | 0.33               |
    +------------------+--------------------+
    | LC-BLYP          | 0.33               |
    +------------------+--------------------+
    | wB97             | 0.40               |
    +------------------+--------------------+
    | wB97X            | 0.30               |
    +------------------+--------------------+

.. code-block:: bdf
    
     $xuanyuan
     RSOMEGA
       0.33
     $end
     
     $scf
       dft
         cam-b3lyp
     $end

:guilabel:`Heff` Parameter Type: Integer
-------------------------------------------------
 * Default: 0
 * Options: 0, 1, 2, 3/4, 5, 21, 22, 23

Specifies the scalar relativistic Hamiltonian:

 * 0: Non-relativistic (including cases using ECPs)
 * 1: sf-ZORA (not recommended for general users)
 * 2: sf-IORA (not recommended for general users)
 * 3, 4: sf-X2C (different implementations; generally use 3)
 * 5: sf-X2C + so-DKH3 (no spin-orbit part; requires ``Hsoc``; accuracy under further testing) :cite:`doi:10.1063/1.4758987`
 * 21: sf-X2C (similar to 3/4, supports analytical derivatives & some one-electron properties) :cite:`doi:10.1021/acs.jctc.9b01120`
 * 22: sf-X2C-aXR (atomic X-matrix approximated sf-X2C; supports analytical derivatives & some properties) :cite:`doi:10.1021/acs.jctc.9b01120`
 * 23: sf-X2C-aU (atomic unitary transformation approximated sf-X2C; supports analytical derivatives & some properties) :cite:`doi:10.1021/acs.jctc.9b01120`

.. code-block:: bdf
    
     $xuanyuan
     Heff
       3
     $end

:guilabel:`Hsoc` Parameter Type: Integer
----------------------------------------------------
 * Options: 0, 1, 2, 3, 4, 5

Specifies the type of spin-orbit (SO) integrals:

 * 0: so-1e - Only one-electron SO integrals.
 * 1: so-1e + SOMF - Two-electron SO integrals via the effective Fock operator. Most accurate for all-electron calculations.
 * 2: so-1e + SOMF-1c - SOMF with one-center approximation. Recommended for large molecules with all-electron calculations.
 * 3: so-1e + SOMF-1c / no soo - Disables spin-other-orbit (SOO) contributions in option 2.
 * 4: so-1e + SOMF-1c / no soo + WSO_XC - Uses DFT to calculate SOO contributions.
 * 5: so-1e + somf-1c / no soo + WSO_XC-2x - Multiplies DFT part by -2 to model SOO (suggestion by Neese).
 * Adding 10 to any option uses the BP approximation operator.
 * For ECP basis sets (scalar ECP, SOECP, or mixed with all-electron non-relativistic), the only accepted value is 10 (default). This uses BP so-1e: SOECP integrals for SOECP atoms, effective nuclear charge for scalar ECP and non-relativistic all-electron atoms (limited element/basis support - see `soint_util/zefflib.F90`).

.. code-block:: bdf
    
     $xuanyuan
     Hsoc
       1
     $end

:guilabel:`Nuclear` Parameter Type: Integer
---------------------------------------------------
 * Default: 0
 * Options: 0, 1

Specifies the nuclear charge distribution model:
* 0: Point charge model
* 1: Gaussian charge model.
For elements up to 110 (Ds), root-mean-square (RMS) nuclear radii are from Visscher and Dyall :cite:`visscher1997`.
For elements Ds and beyond, RMS nuclear radii are estimated from the mass number A (in fermi):

.. math::
   \left<r^2\right> \approx 0.57 + 0.836 \, A^{1/3}

The mass number A is approximated from the nuclear charge Z using :cite:`andrae2000,andrae2002`:

.. math::
   A \approx 0.004467 \, Z^2 + 2.163 \, Z - 1.168

:guilabel:`NuclearRadii` Input Block
---------------------------------------------------
Specifies nuclear radii. This block only takes effect if the finite nucleus model is enabled (`nuclear=1`). Unspecified atoms use default values. Input format follows the `AtomMass` block in the `Compass` module.