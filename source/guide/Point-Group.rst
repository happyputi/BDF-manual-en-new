.. _Point-Group:

Symmetry and Molecular Point Groups
================================================

BDF supports consideration of molecular point group symmetry in calculations. With the exception of certain computational tasks (such as open-shell TDDFT, TDDFT/SOC, etc.) which only support :math:`\rm D_{2h}` and its subgroups (i.e., :math:`\rm C_1, C_i, C_s, C_2, D_2, C_{2h}, C_{2v}, D_{2h}`, collectively known as Abelian groups), most computational tasks support any real-representation point groups (all Abelian groups, and :math:`\rm C_{nv}, D_{n}, D_{nh}, D_{nd}, T_d, O, O_h, I, I_h`; while special point groups :math:`\rm C_{\infty v}, D_{\infty h}` are nominally supported, they are treated as :math:`\rm C_{20v}` and :math:`\rm D_{20h}` respectively, with single atoms treated as :math:`\rm O_{h}` group). Complex-representation point groups (:math:`\rm C_n, C_{nh} (n \ge 3); S_{2n} (n \ge 2); T, T_h`) are not supported. The program can automatically determine the molecular point group based on molecular coordinates input in the COMPASS module, and will automatically switch to an appropriate subgroup if the molecule belongs to a complex-representation point group. Once the point group is determined, the program generates group operation operators, character tables, irreducible representations, etc., for subsequent calculations. Using the ammonia molecule as an example:

.. code-block:: bdf

    #! NH3.sh
    HF/cc-pVDZ 

    geometry
     N                 -0.00000000   -0.00000000   -0.10000001
     H                  0.00000000   -0.94280900    0.23333324
     H                 -0.81649655    0.47140450    0.23333324
     H                  0.81649655    0.47140450    0.23333324
    end geometry

    $compass
    Title
      NH3
    thresh
      medium
    $end

For advanced input mode, the content in **COMPASS** would be:

.. code-block:: bdf

  $COMPASS
  Title
   NH3
  Basis
   cc-pvdz
  Geometry
   N                 -0.00000000   -0.00000000   -0.10000001
   H                  0.00000000   -0.94280900    0.23333324
   H                 -0.81649655    0.47140450    0.23333324
   H                  0.81649655    0.47140450    0.23333324
  End geometry
  thresh
   medium 
  $END

Note that since the initial structure does not strictly satisfy :math:`\rm C_{3v}` symmetry, ``thresh medium`` is used here to select a looser symmetry judgment threshold (default is ``tight``, and ``loose`` is also available). From the output file, we can see that the program automatically identifies the molecule as belonging to the :math:`\rm C_{3v}` point group:

.. code-block:: 

  gsym: C03V, noper=    6
   Exiting zgeomsort....
   Representation generated
    Point group name C(3V)                        6
    User set point group as C(3V)
    Largest Abelian Subgroup C(S)                         2

Note that subscripts in point group names must be enclosed in parentheses. Groups such as :math:`\rm C_{\infty v}, D_{\infty h}` must be written as C(LIN) and D(LIN). The program then prints information about irreducible representations, CG coefficient tables, etc. At the end of the COMPASS section output, the program lists the irreducible representations and the number of orbitals belonging to each:

.. code-block:: 

  |--------------------------------------------------|
            Symmetry adapted orbital

    Total number of basis functions:      29      29

    Number of irreps:   3
    Irrep :     A1        A2        E1
    Norb  :     10         1        18
  |--------------------------------------------------|
  
Ordering of Irreducible Representations
---------------------------------------------

Often, users need to specify in input files information such as orbital occupation numbers for each irreducible representation (specified in SCF module input) and the number of excited states to compute for each irreducible representation (specified in TDDFT module input). This information is typically provided in array form, e.g.:

.. code-block:: bdf

  $TDDFT
  Nroot
   3 1 2
  $END

This means: compute 3 excited states for the first irreducible representation, 1 for the second, and 2 for the third (see :ref:`TDDFT chapter<TD>` in this manual). This requires users to know the internal ordering of irreducible representations in BDF when preparing input files. Below is the ordering of irreducible representations for all point groups supported by BDF:

.. table:: Ordering of Irreducible Representations in Different Point Groups
   :widths: 30 70

   ==================== ======================================================================================================
   C(1)                 A
   C(i)                 Ag, Au
   C(s)                 A', A"
   C(2)                 A, B
   C(2v)                A1, A2, B1, B2
   C(2h)                Ag, Bg, Au, Bu
   D(2)                 A, B1, B3, B2 (Note: In versions released after 2023.3.12, the order changed to A, B1, B2, B3)
   D(2h)                Ag, B1g, B3g, B2g, Au, B1u, B3u, B2u (Note: In versions released after 2023.3.12, the order changed to Ag, B1g, B2g, B3g, Au, B1u, B2u, B3u)
   C(nv) (n=2k+1, k>=1) A1, A2, E1, ..., Ek
   C(nv) (n=2k+2, k>=1) A1, A2, B1, B2, E1, ..., Ek
   D(n)  (n=2k+1, k>=1) A1, A2, E1, ..., Ek
   D(n)  (n=2k+2, k>=1) A1, A2, B1, B2, E1, ..., Ek
   D(nh) (n=2k+1, k>=1) A1', A2', E1', ..., Ek', A1", A2", E1", ..., Ek", 
   D(nh) (n=2k+2, k>=1) A1g, A2g, B1g, B2g, E1g, ..., Ekg, A1u, A2u, B1u, B2u, E1u, ..., Eku
   D(nd) (n=2k+1, k>=1) A1g, A2g, E1g, ..., Ekg, A1u, A2u, E1u, ..., Eku
   D(nd) (n=2k+2, k>=1) A1', A2', B1', B2', E1', ..., Ek', A1", A2", B1", B2", E1", ..., Ek"
   T(d)                 A1, A2, E, T1, T2
   O                    A1, A2, E, T1, T2
   O(h)                 A1g, A2g, Eg, T1g, T2g, A1u, A2u, Eu, T1u, T2u
   I                    A, T1, T2, F, H
   I(h)                 Ag, T1g, T2g, Fg, Hg, Au, T1u, T2u, Fu, Hu
   ==================== ======================================================================================================

Users can also force the program to compute in a subgroup of the molecular point group by using the `group` keyword in the COMPASS module input, e.g.:

.. code-block:: bdf

  #! N2.sh
  HF/def2-TZVP group=D(2h) 

  geometry
    N  0.00 0.00 0.00
    N  0.00 0.00 1.10
  end geometry

Or:

.. code-block:: bdf

  $COMPASS
  Title
   N2
  Basis
   def2-TZVP
  Geometry
   N 0.00 0.00 0.00
   N 0.00 0.00 1.10
  End geometry
  Group
   D(2h)
  $END

This forces the program to compute the :math:`\rm N_2` molecule in the :math:`\rm D_{2h}` point group, even though :math:`\rm N_2` actually belongs to :math:`\rm D_{\infty h}`. Note that the program automatically checks whether the user-specified point group is a subgroup of the actual molecular point group; if not, the program reports an error and exits.

Standard Orientation
---------------------------------------------

For computational convenience and ease of result analysis, after determining the point group for computation, the program rotates the molecule to a standard orientation. This aligns symmetry axes with coordinate axes where possible, and symmetry planes perpendicular to coordinate axes. This ensures many computed quantities are exactly zero (e.g., certain molecular orbital coefficients, certain gradient components, etc.), facilitating result analysis.

BDF determines the standard orientation according to the following rules:

1. Calculate the nuclear charge center by weighted averaging of all atomic coordinates (weighted by nuclear charge), then translate the molecule so this center is at the coordinate origin;
2. If the molecule has symmetry axes, rotate the highest-order symmetry axis (principal axis) to align with the z-axis;
3. If the molecule has :math:`\sigma_v` symmetry planes, rotate one :math:`\sigma_v` plane to align with the xz-plane, while preserving the principal axis direction;
4. If the molecule has additional twofold or fourfold axes besides the principal axis, rotate one such axis (if a fourfold axis exists, choose any; otherwise choose any twofold axis) to align with the x-axis, while preserving the principal axis direction;
5. If molecular symmetry is too low to uniquely determine orientation by the above rules, rotate the molecule so its inertia axes (eigenvectors of the moment of inertia) align with the coordinate axes.

For certain special cases, the above rules still cannot uniquely determine the molecular orientation. For example, molecules belonging to :math:`\rm C_{2v}` or :math:`\rm D_{2h}` point groups have two :math:`\sigma_v` symmetry planes. In rule 3 above, either plane might be rotated to the xz-plane. In BDF, planar :math:`\rm C_{2v}` molecules like water are rotated to the xz-plane:

.. code:: bdf

  |-----------------------------------------------------------------------------------|

   Atom   Cartcoord(Bohr)               Charge Basis Auxbas Uatom Nstab Alink  Mass
    O   0.000000  -0.000000   0.219474   8.00   1     0     0     0   E     15.9949
    H  -1.538455   0.000000  -0.877896   1.00   2     0     0     0   E      1.0073
    H   1.538455  -0.000000  -0.877896   1.00   2     0     0     0   E      1.0073

  |------------------------------------------------------------------------------------|

In contrast, other quantum chemistry programs might rotate the molecule to the yz-plane. This leads to another issue: by convention, in :math:`\rm C_{2v}` point group, the :math:`\mathbf{x}` operator belongs to B1 irreducible representation, and :math:`\mathbf{y}` to B2. Therefore, if a program rotates the molecule to the yz-plane, its B1 and B2 representations are swapped compared to BDF (i.e., its B1 corresponds to BDF's B2, and vice versa). For non-planar :math:`\rm C_{2v}` molecules (e.g., ethylene oxide), predicting whether BDF's standard orientation matches other software becomes more difficult. Thus, if users wish to compute :math:`\rm C_{2v}` or :math:`\rm D_{2h}` molecules and compare with results from other quantum chemistry programs (or reproduce literature results computed with other software), they must determine how that program's B1/B2 representations correspond to BDF's.