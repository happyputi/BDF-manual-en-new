# Gaussian Basis Sets
================================================

To solve Hartree-Fock or Kohn-Sham DFT equations, molecular orbitals are expanded as linear combinations of one-electron basis functions:

.. math::
    \varphi_{i}(r) = C_{1,i}\chi_{1}(r) + C_{2,i}\chi_{2}(r) + C_{3,i}\chi_{3}(r) + \dots + C_{N,i}\chi_{N}(r)

In quantum chemistry calculations, basis functions are mathematical constructs without physical meaning. More basis functions yield higher accuracy, but depend on proper selection. With infinite basis functions (complete basis set limit, CBS), molecular orbitals can be perfectly expanded. Practical calculations use finite basis sets, introducing basis set incompleteness error.

Common quantum chemistry basis functions:

#. **Gaussian Type Orbitals (GTOs)**: Used by most quantum chemistry programs due to computational efficiency for two-electron integrals.
#. **Slater Type Orbitals (STOs)**: Used in semi-empirical methods and programs like ADF. More accurate radial behavior than GTOs but harder to compute.
#. **Plane Waves**: Primarily for periodic systems, less efficient for isolated molecules.
#. **Numerical Atomic Orbitals (NAOs)**: Supported by few programs (e.g., Dmol3, Siesta), defined discretely without analytical form.

BDF initially used STOs but now primarily uses GTOs.

For angular momentum *L* > *p* (e.g., *d*, *f*), GTOs have two representations:
1. **Cartesian functions**:
   .. math::
      N x^{lx} y^{ly} z^{lz} {\rm exp}(-\alpha r^2),  \qquad L=lx+ly+lz
   With :math:`(L+1)(L+2)/2` components (e.g., *d*: xx, yy, zz, xy, xz, yz).
2. **Spherical harmonics (pure functions)**:
   .. math::
      N Y^L_m r^L {\rm exp}(-\alpha r^2)
   With :math:`2L+1` components (e.g., *d*: -2, -1, 0, +1, +2).

Cartesian functions facilitate integral calculations but contain redundancies. Spherical harmonics correspond directly to magnetic quantum numbers, so integrals are typically computed in Cartesian form then transformed :cite:`schlegel1995`.

.. attention::
  1. Most modern basis sets are optimized for spherical harmonics.
  2. Spherical harmonics offer better accuracy and numerical stability (especially in relativistic calculations), so BDF uses them exclusively.
  3. Results differ between Cartesian and spherical bases. Reproducing BDF results requires matching structure, method, basis set, and spherical basis usage.

Named collections of optimized GTOs for different elements/conditions are called **Gaussian Basis Sets**. BDF's basis sets primarily come from:
* [Basis Set Exchange](https://www.basissetexchange.org/) :cite:`bse2019` (all-electron, scalar ECPs)
* [Stuttgart/Cologne Pseudopotentials](http://www.tc.uni-koeln.de/PP/clickpse.en.html) (SOECPs, f-in-core)
* [Turbomole Basis Sets](http://www.cosmologic-services.de/basis-sets/basissets.php)
* [Dyall Relativistic Basis Sets](http://dirac.chem.sdu.dk/basisarchives/dyall/index.html)
* [Sapporo Basis Sets](http://sapporo.center.ims.ac.jp/sapporo/)
* [Clarkson University ECPs](https://people.clarkson.edu/~pchristi/reps.html)
* [ccECP Library](https://pseudopotentiallibrary.org/) (scalar ECPs, SOECPs beyond Kr)
* [Molpro Basis Library](https://www.molpro.net/info/basis.php)
* [ccRepo Basis Library](http://www.grant-hill.group.shef.ac.uk/ccrepo/) (correlation-consistent basis sets)

Additional basis sets from original publications include Dirac-RPF-4Z :cite:`dasilva2014,dasilva2014a,dasilva2017`, DKH2 basis sets :cite:`peterson2007`, Pitzer pseudopotentials :cite:`pitzer2000`, CRENBL/CRENBS :cite:`ermler1991,ermler1994,ermler1997,ermler1999`, and Stuttgart-ECPMDFSO-QZVP :cite:`dolg2009,dolg2014`.

BDF users can use standard basis sets or custom definitions.

## All-Electron Basis Sets
------------------------------------------------
Classified as **uncontracted** (suitable for relativistic/non-relativistic calculations) and **contracted** (non-relativistic/relativistic-specific).

Relativistic calculations (DKH, ZORA, X2C - see :ref:`Relativistic Effects<relativity>`) require specially optimized basis sets (e.g., cc-pVnZ-DK, SARC, ANO-RCC). BDF supports:
* Scalar X2C Hamiltonian with X2C-relativistic, DKH3, or DKH2 (pre-5d elements) basis sets
* Non-relativistic basis sets for pre-3d elements

Some relativistic basis sets account for finite nuclear size effects (significant for *s*/*p* functions), requiring :ref:`finite nuclear models<finite-nuclear>` in integral calculations.

Standard basis sets optimize valence/semi-core properties. Nuclear property calculations (e.g., :ref:`Mössbauer spectroscopy<mossbauer>`) require specialized basis sets like:
* `x2c-TZVPPall-CD` for contact density
* `x2c-TZVPPall-EFG` for EFG/quadrupole splitting
* `x2c-TZVPPall-CDEFG` for both

### Standard All-Electron Basis Sets in BDF
.. table:: 
    :widths: auto
    :class: longtable


+------------------------+-----------------------------+----------------------------------------+------------------------+
    | Basis Set Type | Basis Set Name             | Supported Elements          | Remarks |
|----------------|----------------------------|-----------------------------|---------|
| Pople      | STO-3G                     | 1-54                        |         |
|                | STO-6G                     |                             |         |
|                | 3-21G                      | 1-55                        |         |
|                | 3-21++G                    | 1, 3-20                     |         |
|                | 6-31G                      | 1-36                        |         |
|                | 6-31G(d,p)                 |                             |         |
|                | 6-31GP                     |                             |         |
|                | 6-31GPP                    |                             |         |
|                | 6-31++G                    | 1-20                        |         |
|                | 6-31++GP                   |                             |         |
|                | 6-31++GPP                  |                             |         |
|                | 6-31+G                     |                             |         |
|                | 6-31+GP                    |                             |         |
|                | 6-31+GPP                   |                             |         |
|                | 6-31G(2df,p)              | 1-18                        |         |
|                | 6-31G(3df,3pd)            |                             |         |
|                | 6-311++G                  | 1, 3-20                     |         |
|                | 6-311++G(2d,2p)           |                             |         |
|                | 6-311++GP                 |                             |         |
|                | 6-311++GPP                |                             |         |
|                | 6-311+G                   | 1-20                        |         |
|                | 6-311+G(2d,p)             |                             |         |
|                | 6-311+GP                  |                             |         |
|                | 6-311+GPP                 |                             |         |
|                | 6-311G                    | 1-20, 31-36, 53             |         |
|                | 6-311G(d,p)               |                             |         |
|                | 6-311GP                   |                             |         |
|                | 6-311GPP                  |                             |         |
|                | 6-31++GPP-J               | 1, 6-8                      |         |
|                | 6-31+GP-J                 |                             |         |
|                | 6-31G-J                   |                             |         |
|                | 6-311++GPP-J              |                             |         |
|                | 6-311+GP-J                |                             |         |
|                | 6-311G-J                  |                             |         |
|                | 6-311G(2df,2pd)           | 1-10, 19-20                 |         |
|                | 6-311++G(3df,3pd)         | 1, 3-18                     |         |
| Basis Set Type          | Basis Set Name             | Supported Elements          | Remarks                          |
|-------------------------|----------------------------|-----------------------------|----------------------------------|
| **Correlation Consistent** | aug-cc-pVDZ              | D: 1-18, 19-36              |                                  |
|                         | aug-cc-pVTZ              | T: 1-18, 19-36              |                                  |
|                         | aug-cc-pVQZ              | Q: 1-18, 19-36              |                                  |
|                         | aug-cc-pV5Z              | 5: 1-18, 21-36              |                                  |
|                         | aug-cc-pV6Z              | 6: 1-2, 5-10, 13-18         |                                  |
|                         | aug-cc-pV7Z              | 7: 1-2, 5-10, 13-17         |                                  |
|                         | cc-pVDZ                   | D: 1-18, 19-36              |                                  |
|                         | cc-pVTZ                   | T: 1-18, 19-36              |                                  |
|                         | cc-pVQZ                   | Q: 1-18, 19-36              |                                  |
|                         | cc-pV5Z                   | 5: 1-18, 20-36              |                                  |
|                         | cc-pV6Z                   | 6: 1-2, 4-10, 13-18         |                                  |
|                         | cc-pV7Z                   | 7: 1-2, 5-10, 13-18         |                                  |
|                         | aug-cc-pCVDZ              | D: 1-18, 31-36              |                                  |
|                         | aug-cc-pCVTZ              | T: 1-18, 31-36              |                                  |
|                         | aug-cc-pCVQZ              | Q: 1-18, 31-36              |                                  |
|                         | aug-cc-pCV5Z              | 5: 3-18, 31-36              |                                  |
|                         | aug-cc-pCV6Z              | 6: 5-10, 13-18              |                                  |
|                         | cc-pCVDZ                  | D: 1-18, 20, 31-36          |                                  |
|                         | cc-pCVTZ                  | T: 1-18, 20, 31-36          |                                  |
|                         | cc-pCVQZ                  | Q: 1-18, 20, 31-36          |                                  |
|                         | cc-pCV5Z                  | 5: 3-18, 31-36              |                                  |
|                         | cc-pCV6Z                  | 6: 5-10, 13-18              |                                  |
|                         | aug-cc-pV(D+d)Z           | 1-18, 21-36                 |                                  |
|                         | aug-cc-pV(T+d)Z           |                             |                                  |
|                         | aug-cc-pV(Q+d)Z           |                             |                                  |
|                         | aug-cc-pV(5+d)Z           |                             |                                  |
|                         | cc-pV(D+d)Z               | 1-18, 20-36                 |                                  |
|                         | cc-pV(T+d)Z               |                             |                                  |
|                         | cc-pV(Q+d)Z               |                             |                                  |
|                         | cc-pV(5+d)Z               |                             |                                  |
|                         | aug-cc-pwCVDZ             | D: 3-20, 31-36              |                                  |
|                         | aug-cc-pwCVTZ             | T: 3-36                     |                                  |
|                         | aug-cc-pwCVQZ             | Q: 3-36                     |                                  |
|                         | aug-cc-pwCV5Z             | 5: 3-18, 21-36              |                                  |
|                         | cc-pwCVDZ                 | D: 3-20, 31-36              |                                  |
|                         | cc-pwCVTZ                 | T: 3-36                     |                                  |
|                         | cc-pwCVQZ                 | Q: 3-36                     |                                  |
|                         | cc-pwCV5Z                 | 5: 3-18, 21-36              |                                  |
|                         | aug-cc-pVDZ-RIFIT         | 1-2, 4-10, 12-18, 21-36     | Auxiliary Basis Set              |
|                         | aug-cc-pVTZ-RIFIT         |                             |                                  |
|                         | aug-cc-pVQZ-RIFIT         |                             |                                  |
|                         | aug-cc-pV5Z-RIFIT         | 5: 1-10, 13-18, 21-36       | Auxiliary Basis Set              |
|                         | aug-cc-pV6Z-RIFIT         | 6: 1-2, 5-10, 13-18         |                                  |
|                         | aug-cc-pVTZ-J             | 1, 5-9, 13-17, 21-30, 34    | Auxiliary Basis Set              |
|                         | aug-cc-pVDZ-DK            | D: 1-38                     | DKH2 Relativistic                |
|                         | aug-cc-pVTZ-DK            | T: 1-54, 72-86              |                                  |
|                         | aug-cc-pVQZ-DK            | Q: 1-38, 49-54              |                                  |
|                         | aug-cc-pV5Z-DK            | 5: 1-2, 5-18, 21-36         |                                  |
|                         | aug-cc-pCVDZ-DK           | 3-18, 31-36                 | DKH2 Relativistic                |
|                         | aug-cc-pCVTZ-DK           |                             |                                  |
|                         | aug-cc-pCVQZ-DK           |                             |                                  |
|                         | aug-cc-pCV5Z-DK           |                             |                                  |
|                         | aug-cc-pwCVDZ-DK          | D: 3-20, 31-38              | DKH2 Relativistic                |
|                         | aug-cc-pwCVTZ-DK          | T: 3-54, 72-86              |                                  |
|                         | aug-cc-pwCVQZ-DK          | Q: 3-38, 49-54, 81-86       |                                  |
|                         | aug-cc-pwCV5Z-DK          | 5: 3-18, 21-36              |                                  |
|                         | aug-cc-pVDZ-DK3           | D: 55-56, 78, 79, 87-88     | DKH3 Relativistic                |
|                         | aug-cc-pVTZ-DK3           | T: 49-56, 72-88             |                                  |
|                         | aug-cc-pVQZ-DK3           | Q: 49-56, 78, 79, 81-88     |                                  |
|                         | aug-cc-pwCVDZ-DK3         |                             |                                  |
|                         | aug-cc-pwCVTZ-DK3         |                             |                                  |
|                         | aug-cc-pwCVQZ-DK3         |                             |                                  |
|                         | aug-cc-pCVDZ-X2C          | 5-10, 13-18                 | X2C Relativistic                 |
|                         | aug-cc-pCVTZ-X2C          |                             |                                  |
|                         | aug-cc-pCVQZ-X2C          |                             |                                  |
|                         | aug-cc-pCV5Z-X2C          |                             |                                  |
|                         | aug-cc-pCV6Z-X2C          |                             |                                  |
|                         | aug-cc-pVDZ-X2C           | 1-2, 5-10, 13-20, 31-38, 55-56, 87-88 | X2C Relativistic         |
|                         | aug-cc-pVTZ-X2C           |                             |                                  |
|                         | aug-cc-pVQZ-X2C           |                             |                                  |
|                         | aug-cc-pV5Z-X2C           | 1-2, 5-10, 13-18, 31-36     | X2C Relativistic                 |
|                         | aug-cc-pV6Z-X2C           | 1-2, 5-10, 13-18            |                                  |
|                         | aug-cc-pwCVDZ-X2C         | 5-10, 13-20, 31-38, 55-56, 87-88 | X2C Relativistic          |
|                         | aug-cc-pwCVTZ-X2C         |                             |                                  |
|                         | aug-cc-pwCVQZ-X2C         |                             |                                  |
|                         | aug-cc-pwCV5Z-X2C         | 5-10, 13-18, 31-36          | X2C Relativistic                 |
|                         | cc-pVDZ-DK                | D: 1-38                     | DKH2 Relativistic                |
|                         | cc-pVTZ-DK                | T: 1-54, 72-86              |                                  |
|                         | cc-pVQZ-DK                | Q: 1-38, 49-54              |                                  |
|                         | cc-pV5Z-DK                | 5: 1-18, 21-36              |                                  |
|                         | cc-pCVDZ-DK               | 3-18, 31-36                 | DKH2 Relativistic                |
|                         | cc-pCVTZ-DK               |                             |                                  |
|                         | cc-pCVQZ-DK               |                             |                                  |
|                         | cc-pCV5Z-DK               |                             |                                  |
|                         | cc-pwCVDZ-DK              | D: 3-20, 31-38              | DKH2 Relativistic                |
|                         | cc-pwCVTZ-DK              | T: 3-54, 72-86              |                                  |
|                         | cc-pwCVQZ-DK              | Q: 3-38, 49-54, 81-86       |                                  |
|                         | cc-pwCV5Z-DK              | 5: 3-18, 21-36              |                                  |
|                         | cc-pVDZ-DK3               | D: 55-71, 78, 79, 87-103    | DKH3 Relativistic                |
|                         | cc-pVTZ-DK3               | T: 49-103                   |                                  |
|                         | cc-pVQZ-DK3               | Q: 49-71, 78, 79, 81-103    |                                  |
|                         | cc-pwCVDZ-DK3             |                             |                                  |
|                         | cc-pwCVTZ-DK3             |                             |                                  |
|                         | cc-pwCVQZ-DK3             |                             |                                  |
|                         | cc-pCVDZ-X2C              | 5-10, 13-18                 | X2C Relativistic                 |
|                         | cc-pCVTZ-X2C              |                             |                                  |
|                         | cc-pCVQZ-X2C              |                             |                                  |
|                         | cc-pCV5Z-X2C              |                             |                                  |
|                         | cc-pCV6Z-X2C              |                             |                                  |
|                         | cc-pVDZ-X2C               | 1-2, 5-10, 13-20, 31-38, 55-71, 87-103 | X2C Relativistic         |
|                         | cc-pVTZ-X2C               |                             |                                  |
|                         | cc-pVQZ-X2C               |                             |                                  |
|                         | cc-pV5Z-X2C               | 1-2, 5-10, 13-18, 31-36     | X2C Relativistic                 |
|                         | cc-pV6Z-X2C               | 1-2, 5-10, 13-18            |                                  |
|                         | cc-pwCVDZ-X2C             | 5-10, 13-20, 31-38, 55-71, 87-103 | X2C Relativistic          |
|                         | cc-pwCVTZ-X2C             |                             |                                  |
|                         | cc-pwCVQZ-X2C             |                             |                                  |
|                         | cc-pwCV5Z-X2C             | 5-10, 13-18, 31-36          | X2C Relativistic                 |
|                         | cc-pVDZ-FW_fi             | 1-2, 5-10, 13-18, 31-36     | NESC Relativistic, Finite Nucleus |
|                         | cc-pVTZ-FW_fi             |                             |                                  |
|                         | cc-pVQZ-FW_fi             |                             |                                  |
|                         | cc-pV5Z-FW_fi             |                             |                                  |
|                         | cc-pVDZ-FW_pt             | 1-2, 5-10, 13-18, 31-36     | NESC Relativistic                |
|                         | cc-pVTZ-FW_pt             |                             |                                  |
|                         | cc-pVQZ-FW_pt             |                             |                                  |
|                         | cc-pV5Z-FW_pt             |                             |                                  |
| **Atomic Natural Orbital (ANO)** | ADZP-ANO         | 1-103                       |                                  |
|                         | ANO-DK3                   | 1-10                        | DKH3 Relativistic                |
|                         | ANO-R                     | R: 1-86                     | X2C Relativistic, Finite Nucleus;<br>2021 revised version;<br>2020 version with suffix -old |
|                         | ANO-R0                    | R0: MB (minimal basis)      |                                  |
|                         | ANO-R1                    | R1: VDZP                    |                                  |
|                         | ANO-R2                    | R2: VTZP                    |                                  |
|                         | ANO-R3                    | R3: VQZP                    |                                  |
|                         | ANO-RCC                   | 1-96                        | DKH2 Relativistic                |
|                         | ANO-RCC-VDZ               |                             |                                  |
|                         | ANO-RCC-VDZP              |                             |                                  |
|                         | ANO-RCC-VTZP              |                             |                                  |
|                         | ANO-RCC-VQZP              |                             |                                  |
|                         | ANO-RCC-VTZ               | 3-20, 31-38                 | DKH2 Relativistic                |
+------------------------+-----------------------------+----------------------------------------+------------------------+
| Ahlrichs           | Def2 series                |                             | Mixed all-electron non-relativistic basis sets and pseudopotential basis sets, see :ref:`Pseudopotential Basis Sets<ecp-bas>` |
|                         | jorge-DZP                  | D: 1-103                    |         |
|                         | jorge-TZP                  | T: 1-103                    |         |
|                         | jorge-QZP                  | Q: 1-54                     |         |
|                         | jorge-DZP-DKH              | D: 1-103                    | DKH2 relativistic, finite nucleus |
|                         | jorge-TZP-DKH              | T: 1-103                    |         |
|                         | jorge-QZP-DKH              | Q: 1-54                     |         |
|                         | SARC-DKH2                  | 57-86, 89-103               | DKH2 relativistic |
|                         | SARC2-QZV-DKH2             | 57-71                       | DKH2 relativistic |
|                         | SARC2-QZVP-DKH2            |                             |         |
|                         | x2c-SV(P)all               | 1-86                        | X2C relativistic, finite nucleus |
|                         | x2c-SVPall                 |                             |         |
|                         | x2c-TZVPall                |                             |         |
|                         | x2c-TZVPPall               |                             |         |
|                         | x2c-QZVPall                |                             |         |
|                         | x2c-QZVPPall               |                             |         |
|                         | x2c-SV(P)all-2c            |                             |         |
|                         | x2c-SVPall-2c              |                             |         |
|                         | x2c-TZVPall-2c             |                             |         |
|                         | x2c-TZVPPall-2c            |                             |         |
|                         | x2c-QZVPall-2c             |                             |         |
|                         | x2c-QZVPPall-2c            |                             |         |
|                         | x2c-TZVPall-f              | 1-20                        | X2C relativistic, finite nucleus |
|                         | x2c-TZVPPall-f             |                             |         |
| **Sapporo**             | Sapporo-DZP                | 1-54                        | 2012 is the new version |
|                         | Sapporo-TZP                |                             |         |
|                         | Sapporo-QZP                |                             |         |
|                         | Sapporo-DZP-2012           |                             |         |
|                         | Sapporo-TZP-2012           |                             |         |
|                         | Sapporo-QZP-2012           |                             |         |
|                         | Sapporo-DZP-dif            |                             |         |
|                         | Sapporo-TZP-dif            |                             |         |
|                         | Sapporo-QZP-dif            |                             |         |
|                         | Sapporo-DZP-2012-dif       |                             |         |
|                         | Sapporo-TZP-2012-dif       |                             |         |
|                         | Sapporo-QZP-2012-dif       |                             |         |
|                         | Sapporo-DKH3-DZP           | 1-54                        | DKH3 relativistic |
|                         | Sapporo-DKH3-TZP           |                             |         |
|                         | Sapporo-DKH3-QZP           |                             |         |
|                         | Sapporo-DKH3-DZP-dif       |                             |         |
|                         | Sapporo-DKH3-TZP-dif       |                             |         |
|                         | Sapporo-DKH3-QZP-dif       |                             |         |
|                         | Sapporo-DKH3-DZP-2012      | 19-86                       | DKH3 relativistic, finite nucleus |
|                         | Sapporo-DKH3-TZP-2012      |                             |         |
|                         | Sapporo-DKH3-QZP-2012      |                             |         |
|                         | Sapporo-DKH3-DZP-2012-dif  |                             |         |
|                         | Sapporo-DKH3-TZP-2012-dif  |                             |         |
|                         | Sapporo-DKH3-QZP-2012-dif  |                             |         |
| **Uncontracted**        | UGBS                       | 1-90, 94-95, 98-103         | Universal for relativistic and non-relativistic |
|                         | Dirac-RPF-4Z               | 1-118                       | Universal for relativistic and non-relativistic |
|                         | Dirac-aug-RPF-4Z           |                             |         |
|                         | Dirac-Dyall.2zp            | 1-118                       | Universal for relativistic and non-relativistic |
|                         | Dirac-Dyall.3zp            |                             |         |
|                         | Dirac-Dyall.4zp            |                             |         |
|                         | Dirac-Dyall.ae2z           |                             |         |
|                         | Dirac-Dyall.ae3z           |                             |         |
|                         | Dirac-Dyall.ae4z           |                             |         |
|                         | Dirac-Dyall.cv2z           |                             |         |
|                         | Dirac-Dyall.cv3z           |                             |         |
|                         | Dirac-Dyall.cv4z           |                             |         |
|                         | Dirac-Dyall.v2z            |                             |         |
|                         | Dirac-Dyall.v3z            |                             |         |
|                         | Dirac-Dyall.v4z            |                             |         |
|                         | Dirac-Dyall.aae2z          | 1-2, 5-10, 13-18, 31-36, 49-54, 81-86, 113-118 | Universal for relativistic and non-relativistic |
|                         | Dirac-Dyall.aae3z          |                             |         |
|                         | Dirac-Dyall.aae4z          |                             |         |
|                         | Dirac-Dyall.acv2z          |                             |         |
|                         | Dirac-Dyall.acv3z          |                             |         |
|                         | Dirac-Dyall.acv4z          |                             |         |
|                         | Dirac-Dyall.av2z           |                             |         |
|                         | Dirac-Dyall.av3z           |                             |         |
|                         | Dirac-Dyall.av4z           |                             |         |
| **Other**               | SVP-BSEX                   | 1, 3-10                     |         |
|                         | DZP                        | 1, 6-8, 16, 26, 42          |         |
|                         | DZVP                       | 1, 3-9, 11-17, 19-20, 31-35, 49-53 |         |
|                         | TZVPP                      | 1, 6-7                      |         |
|                         | IGLO-II                    | 1, 5-9, 13-17               |         |
|                         | IGLO-III                   |                             |         |
|                         | Sadlej-pVTZ                | 1, 6-8                      |         |
|                         | Wachters+f                 | 21-29                       |         |
+------------------------+-----------------------------+----------------------------------------+------------------------+

.. _ecp-bas:
   
# Pseudopotential Basis Sets
------------------------------------------------

Effective Core Potentials (ECPs) include Pseudopotentials (PP) and Model Core Potentials (MCP). 
In quantum chemistry calculations, PPs are fundamentally similar to those in plane-wave calculations but expressed in concise analytical form. 
Most quantum chemistry software, including BDF, supports PPs, while fewer support MCPs. Therefore, the terms ECP and PP can be used interchangeably when unambiguous.

Pseudopotential basis sets are used in conjunction with pseudopotentials, with basis functions describing only the atom's valence electrons. For systems involving heavy atoms, pseudopotential basis sets can be applied to these atoms while other atoms use standard non-relativistic all-electron basis sets. 
This approach significantly reduces computation time while effectively incorporating scalar relativistic effects. Basis sets like the Lan series, Stuttgart series, and cc-pVnZ-PP series belong to this category. For convenience, pseudopotential basis sets for lighter elements (before the 5th period) are essentially non-relativistic all-electron basis sets, such as the Def2 series.

## Scalar vs. Spin-Orbit Coupling Pseudopotentials
------------------------------------------------
Pseudopotential basis sets are categorized into **scalar pseudopotential basis sets** and **spin-orbit coupling pseudopotential (SOECP) basis sets** based on whether they include spin-orbit coupling terms.

### Standard Pseudopotential Basis Sets in BDF
.. table:: 
    :widths: auto
    :class: longtable

    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | Basis Type                  | Basis Set                   | Elements                               | Notes                  |
    +=============================+=============================+========================================+========================+
    | **Correlation-Consistent**  | aug-cc-pVDZ-PP series       | 19,20,29-56,72-88                      | SOECP                  |
    |                             | cc-pVnZ-PP series           | 19,20,29-56,72-88,90-92                | SOECP                  |
    |                             | ccECP variants              | Selected elements                      | SOECP (Z>36)           |
    |                             | Pitzer series               | 3-18                                   | SOECP                  |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | **Clarkson**                 | CRENBL                      | 1 (all-electron), 3-118                | SOECP, small core      |
    |                             | CRENBS                      | 21-36,39-54,57,72-86,104-118           | SOECP, large core      |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | **Ahlrichs**                 | Def2 series (old/G16)       | 1-86 (mixed AE/ECP)                    | "-old" original,       |
    |                             | DHF series                  | 37-56,72-86                            | SOECP for DHF          |
    |                             | ma-Def2 series              | Selected elements                      | Modified versions      |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | **LAN**                      | LANL2DZ series              | 1,3-10,11-57,72-83,92-94 (mixed AE/ECP)|                        |
    |                             | Modified LANL variants      | 21-29,39-47,57,72-79                   |                        |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | **SBKJC**                    | SBKJC-VDZ series            | 1-2 (AE), 3-58,72-86                   |                        |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+
    | **Stuttgart**                | Stuttgart-RLC/RSC series   | 3-20,30-38,49-56,80-86,89-103          | Large/small core      |
    |                             | SDB-cc-pVnZ series          | 31-36,49-54                            | Large core            |
    |                             | Stuttgart-ECP variants      | 19-20,37-38,55-56,87-92,111-120        | SOECP, small core     |
    +-----------------------------+-----------------------------+----------------------------------------+------------------------+

### Notes on Def2 Basis Sets
.. note:: 
    1. Def2 basis sets were developed for Turbomole. "Def2" stands for "second default basis set".
    2. Original Def2 series (suffix **-old**) had deficiencies fixed in Turbomole 7.3+ versions:
        - Added f polarization for Ba (g functions in some QZ sets)
        - Reoptimized I's f/g functions in Def2-QZVPD/QZVPPD
        - Added missing f functions for Mn in Def2-QZVPPD
        - Added support for lanthanides
    3. Def2 uses truncated Stuttgart/Cologne PPs for post-Kr elements. This causes 0.1-1 mHartree energy differences. Gaussian 16 uses standard PPs (denoted by **-G16** suffix).
    4. Use Def2-... or Def2-...-G16 normally; DHF-... for SOECP calculations. To match Gaussian 16 results for post-Kr elements, use Def2-...-G16. Avoid Def2-...-old unless reproducing early Mn/I/Ba calculations.

## f-in-Core Pseudopotential Basis Sets
------------------------------------------------
For lanthanides and actinides, "f-in-core" (FIC) basis sets incorporate f electrons into the pseudopotential. BDF includes these FIC scalar pseudopotential basis sets optimized for common oxidation states, with scalar relativistic effects (MWB) accounted for in reference data.

### FIC Pseudopotential Basis Sets in BDF
.. table:: 
    :widths: auto
    :class: longtable

    +-----------------------------+------------------------+----------------------------------------+
    | Basis Set                   | Elements               | Core Electrons                         |
    +=============================+========================+========================================+
    | MWB-FIC series               | 57-71 (Ln)             | [Kr](4d)¹⁰(4f)ⁿ                       |
    | MWB-FIC-AVnZ series         | 89-103 (An)            | [Xe](4f)¹⁴(5d)¹⁰(5f)ⁿ                 |
    | MWB-FICp1 series            | 57-70 (Ln)             | [Kr](4d)¹⁰(4f)ⁿ⁺¹                     |
    | MWB-FICp1-AVnZ series       | 94-102 (An)            | [Xe](4f)¹⁴(5d)¹⁰(5f)ⁿ⁺¹               |
    | MWB-FICm1/m2/m3-AVnZ series | Selected Ln/An        | [Xe](4f)¹⁴(5d)¹⁰(5f)ⁿ⁻ᵐ (m=1,2,3)     |
    +-----------------------------+------------------------+----------------------------------------+

## Aliases and Abbreviations for Standard Basis Sets
------------------------------------------------
Some basis sets support aliases:
- Pople 6- series: Suffixes P/PP can be replaced with * (e.g., `6-311++G**` = `6-311++GPP`)
- Def2 series: Hyphens can be omitted (e.g., `def2-SVP` = `def2SVP`)
- Correlation-consistent: 
  - `cc-pVnZ` → `vnz` (e.g., `vdz` = `cc-pVDZ`)
  - `aug-cc-pVnZ` → `avnz` (e.g., `avtz` = `aug-cc-pVTZ`)
  - `aug-cc-pwCVnZ-DK` → `awcvtz-dk`
  
.. warning:: Use these abbreviations **only in BDF input files**, not in formal publications.

## Custom Basis Set Files
------------------------------------------------
BDF supports non-built-in basis sets via custom text files placed in the working directory. The filename (all uppercase) serves as the basis set name.

### Example: `MYBAS-1`
```text
# Custom basis for He and Al
****
He      2    1
S      4    2
        3.836000E+01
        5.770000E+00
        1.240000E+00
        2.976000E-01
       2.380900E-02   0.000000E+00
       1.548910E-01   0.000000E+00
       4.699870E-01   0.000000E+00
       5.130270E-01   1.000000E+00
P      2    2
        1.275000E+00
        4.000000E-01
       1.0000000E+00  0.000000E+00
       0.0000000E+00  1.000000E+00
****
Al     13    2
(Section for Al - similar format)
In addition to the above standard names, some base groups in the base group library can also use their aliases and abbreviations. The basic rules are as follows:

* In the Pople base set of the 6-series, the suffixes P and PP representing the polarization function can be indicated by an asterisk. For example, 6-311 G** is equivalent to 6-311 GPP.
* The hyphen "-" for the def2-series base group can be omitted. For example, def2-SVP can be written as def2SVP.
* In the association consistency base group, "cc-pV", "cc-pCV", and "cc-pwCV" can be abbreviated as V, CV, WCV, respectively.
The prefix "aug-" for the diffusion function can be abbreviated as A (case-insensitive).
For example, vdz stands for cc-pVDZ, awcvtz-dk stands for aug-cc-pwCVTZ-DK, and so on. It should be noted that this abbreviation of the base group name is limited to BDF input.
Do not use it in formal papers and reports to avoid confusion among readers.


.. _SelfdefinedBasis:

Customize the base group file
------------------------------------------------
BDF can use non-built-in base groups, in this case, you need to save the base group data in text format in the base group file, put it in the calculation directory, and the file name is the base group name to be referenced in BDF.

.. warning::

The file name of the custom base group file must be **all caps**! However, when referenced in the input file, the case is arbitrary.

For example, create a text file MYBAS-1 in the computing directory (note: if you create a text file under the Windows operating system, the system may omit the extension *.txt*, so the actual name is MYBAS-1.txt) and read:

.. code-block::

   # This is my basis set No. 1.               # Any blank lines, and comment lines that start with #
   # Supported elements: He and Al

   ****                                        # The line preceding with 4 asterisks, followed by a base group of elements
   He      2    1                              # Element symbol, nuclear charge number, highest angular momentum of the basis function 1
   S      4    2                               # S-type GTO basis functions, 4 original functions are reduced to 2
                  3.836000E+01                 # Exponents of 4 S-type Gaussian primitive functions
                  5.770000E+00
                  1.240000E+00
                  2.976000E-01
         2.380900E-02           0.000000E+00   # Two columns of shrinkage factors, corresponding to the two shrinkage S-type GTO basis functions
         1.548910E-01           0.000000E+00
         4.699870E-01           0.000000E+00
         5.130270E-01           1.000000E+00
   P      2    2                               # P-type GTO basis functions, the 2 original functions are reduced to 2
                  1.275000E+00
                  4.000000E-01
         1.0000000E+00           0.000000E+00
         0.0000000E+00           1.000000E+00
   ****                       # 4 asterisks end the base group of He, followed by the base group of another element, or end
   Al     13    2
   (omitted)

In the above base group, the P function is not contracted, and can also be written in the following form:

.. code-block::

(S-function, omitted)

  P      2    0              # 0 indicates non-contraction, and a contraction factor is not required at this time
                  1.275000E+00
                  4.000000E-01
   ****
   (omitted)

For pseudopotential basis groups, ECP data also needs to be provided after the valence basis function. For example

.. code-block::

   ****                                              # For the valence basis function part, the note is id
   Al     13    2
   S       4    3
              14.68000000
               0.86780000
               0.19280000
               0.06716000
       -0.0022368000     0.0000000000     0.0000000000
       -0.2615913000     0.0000000000     0.0000000000
        0.6106597000     0.0000000000     1.0000000000
        0.5651997000     1.0000000000     0.0000000000
   P       4    2
               6.00100000
               1.99200000
               0.19480000
               0.05655000
       -0.0034030000     0.0000000000
       -0.0192089000     0.0000000000
        0.4925534000    -0.2130858000
        0.6144261000     1.0000000000
   D       1    1
               0.19330000
        1.0000000000
   ECP                     # The valence function is immediately followed by the keyword ECP (all caps), indicating that the ECP data part is followed
   Al    10    2    2      # Same element symbol, core electron number, ECP highest angular momentum, optional SOEPP highest angular momentum
   D potential  4                                    # The number of potential functions of the highest angular momentum (D function) of the ECP
      2      1.22110000000000     -0.53798100000000  # Power of R, exponent, factor (the same below)
      2      3.36810000000000     -5.45975600000000
      2      9.75000000000000    -16.65534300000000
      1     29.26930000000000     -6.47521500000000
   S potential  5                                    # The number of S projections
      2      1.56310000000000    -56.20521300000000
      2      1.77120000000000    149.68995500000000
      2      2.06230000000000    -91.45439399999999
      1      3.35830000000000      3.72894900000000
      0      2.13000000000000      3.03799400000000
   P potential  5                                    # The number of P projections
      2      1.82310000000000     93.67560600000000
      2      2.12490000000000   -189.88896800000001
      2      2.57050000000000    110.24810400000000
      1      1.75750000000000      4.19959600000000
      0      6.76930000000000      5.00335600000000
   P so-potential  5                                 # The number of P-SO projections, scalar ECP does not have this part
      2      1.82310000000000      1.51243200000000  # Scalar ECP does not have this part
      2      2.12490000000000     -2.94701800000000  # Scalar ECP does not have this part
      2      2.57050000000000      1.64525200000000  # Scalar ECP does not have this part
      1      1.75750000000000     -0.08862800000000  # Scalar ECP does not have this part
      0      6.76930000000000      0.00681600000000  # Scalar ECP does not have this part
   D so-potential  4                                 # The number of D-SO projections, scalar ECP does not have this part
      2      1.22110000000000     -0.00138900000000  # Scalar ECP does not have this part
      2      3.36810000000000      0.00213300000000  # Scalar ECP does not have this part
      2      9.75000000000000      0.00397700000000  # Scalar ECP does not have this part
      1     29.26930000000000      0.03253000000000  # Scalar ECP does not have this part

For scalar ECP, the highest angular momentum of SOEPP is 0 (can be omitted and not written), and the data of the SO projection part is not required.

Once the above data is saved, the MYBAS-1 base group can be called in the BDF input file, which needs to be implemented by the following mixed input modes:

.. code-block:: bdf

    #!bdfbasis.sh
    HF/genbas 

    Geometry
     .....
    End geometry

    $Compass
    Basis
       mybas-1         # Gives the name of the base group file in the current directory, which is not case-sensitive
    $End

Custom basesets must be entered with BDF's blend mode. In the second line, enter the base group set to **genbas**, and the custom base group file name needs to use the keyword '''Basis'' in the **COMPASS** module, and the value is ''mybas-1''', which means that the base group file named ''MYBAS-1'' is called.

Assignment of the base group
------------------------------------------------
**Use the same BDF built-in base set for all atoms**

The concise input mode is specified in either Method/Functional/Base Group or Method/Base Group. Here ''Base Group'' is the built-in base group name of the BDF listed in the previous sections, and the input character is not case sensitive, as follows:

.. code-block:: bdf

   #! basisexample.sh
   TDDFT/PBE0/3-21g

   Geometry
   H   0.000   0.000    0.000
   Cl  0.000   0.000    1.400
   End geometry


.. code-block:: bdf

   #! basisexample.sh
   HF/lanl2dz 

   Geometry
   H   0.000   0.000    0.000
   Cl  0.000   0.000    1.400
   End geometry

In the case of advanced input mode, the basis group used for the calculation is specified in the compass module using the keyword ''basis'', for example

.. code-block:: bdf

  $compass
  Basis
   lanl2dz
  Geometry
    H   0.000   0.000    0.000
    Cl  0.000   0.000    1.400
  End geometry
  $end

where lanl2dz calls the built-in LanL2DZ basegroup (registered in the basisname) file, which is not case-sensitive.

**Specify different base groups for different elements**

Concise input does not support custom or mixed base groups, you must use mixed input mode, that is, set the base group to genbas in the method/functional/base group, and add the **COMPASS** module input, using the "basis-block" keyword to specify the base group.

If you specify a base group with different names for different elements, you need to put it in the "basis-block" ... "end basis" block of the **COMPASS module,
The first line is the default base group, and the following lines specify other base groups for different elements, in the format *element=basegroupname* or *element1, element2, ..., elementn=basegroupname*.

For example, in mixed input mode, the following is an example of using different base groups for different atoms:

.. code-block:: bdf

  #! multibasis.sh
  HF/genbas 

  Geometry
  H   0.000   0.000    0.000
  Cl  0.000   0.000    1.400
  End geometry

  $compass
  Basis-block
   lanl2dz
   H = 3-21g
  End Basis
  $end

In the example above, H uses the 3-21G base group, while Cl without additional definition uses the default LanL2DZ base group.

If it's an advanced input, look like this:

.. code-block:: bdf

  $compass
  Basis-block
   lanl2dz
   H = 3-21g
  End Basis
  Geometry
    H   0.000   0.000    0.000
    Cl  0.000   0.000    1.400
  End geometry
  $end

**Specify different base groups for different atoms of the same element**

BDF can also specify different named base groups for different atoms in the same element, which need to be distinguished by an arbitrary number after the element symbol. For example


.. code-block:: bdf

  #! CH4.sh
  RKS/B3lyp/genbas

  Geometry
    C       0.000   -0.000    0.000
    H1     -0.000   -1.009   -0.357
    H2     -0.874    0.504   -0.457
    H1      0.874    0.504   -0.357
    H2      0.000    0.000    1.200
  End geometry

  $compass
  Basis-block
   6-31g
   H1= cc-pvdz
   H2= 3-21g
  End basis
  $end

In the example above, the cc-pVDZ group is used for the two hydrogen atoms of type H1, the 3-21G group is used for the two hydrogen atoms of type H2, and the 6-31G group is used for the carbon atom. It should be noted that symmetric equivalent atoms must use the same basis set, which will be checked by the program;
If symmetric equivalents must use different base groups, you can set a lower point group symmetry by Group, or turn off symmetry with Nosymm.

Auxiliary base group
------------------------------------------------
The method of using the density fitting approximation (RI) requires a secondary base group. The Ahlrichs family of base groups and Dunning-related consistency groups as well as other individual base groups have specially optimized auxiliary groups. In the BDF, it is possible to specify the auxiliary base group in the compass by the keywords "RI-J", "RI-K", and "RI-C". where ''RI-J'' is used to specify the coulomb-fitting base group, ''RI-K'' is used to specify the coulomb-related fitting base group, and ''RI-C'' is used to specify the coulomb-related fitting base group. The auxiliary base groups supported by BDF are stored in the corresponding folder in the $BDFHOME/basis_library directory.

High-level density fitting basesets can be used on low-level basesets, e.g. cc-pVTZ/C can be used to make RI-J on cc-pVTZ, and for pople series basesets that do not have a standard auxiliary baseset, such as 6-31G**, they can also be used for cc-pVTZ/J or RIJCOSX. On the other hand, the combination of high-level orbital base groups and low-level auxiliary base sets will bring more obvious errors.

. code-block:: bdf

  $Compass
  Basis
    DEF2-SVP
  RI-J
    DEF2-SVP
  Geometry
    C          1.08411       -0.01146        0.05286
    H          2.17631       -0.01146        0.05286
    H          0.72005       -0.93609        0.50609
    H          0.72004        0.05834       -0.97451
    H          0.72004        0.84336        0.62699
  End Geometry
  $End

In the example above, the methane molecule is computed using the def2-SVP basis set and accelerated by using the def2-SVP standard coulomb-fitting base set.

.. hint::
The RI calculation function of BDF is used to accelerate the calculation methods of wave functions such as MCSCF and MP2, and it is not recommended for users to use them in the calculations of SCF and TDDFT, and users can use the multi-stage expansion Coulomb potential (MPEC) method, which does not rely on auxiliary base groups, and the calculation speed and accuracy are comparable to those of the RI method.