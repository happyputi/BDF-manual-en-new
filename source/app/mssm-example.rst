.. _mssm:

Studying Spin-Forbidden Multi-State Reactions with the MSSM Model
================================================

In most chemical reaction processes, the system starts from reactants, passes through one or more transition states and intermediates, and finally reaches products—all occurring on the ground-state potential energy surface. However, in some cases, reactants, transition states, intermediates, or products may reside on potential energy surfaces of different spin states. Such reactions are termed **spin-forbidden reactions** or **multi-state reactions**, hereafter abbreviated as **multi-state reactions**. These reactions occur due to spin-orbit coupling and pose theoretical challenges.

.. note::

    * Most multi-state reactions involve only two spin states and are sometimes called **two-state reactions** in the literature.
    * Spin-conserved chemical reactions may also occur on two (or more) potential energy surfaces of the same spin state, but this is difficult to detect without IRC optimization. Such cases can be handled by conventional theoretical methods and are not classified as multi-state reactions.

Strictly incorporating spin-orbit coupling in chemical reactions requires two-component or four-component relativistic methods (especially two/four-component relativistic density functional theory, which has analytic gradients implemented in some quantum chemistry programs). However, due to practical difficulties, these methods are rarely applied. If spin-orbit coupling is weak, the minimum energy crossing point (MECP) method can approximate the lowest energy intersection between spin-state potential energy surfaces (see :ref:`MECP<CI_MECP>`). Although widely used, MECP has limitations: (1) If MECP corresponds to a new transition state, its vibrational frequencies and thermochemical properties cannot be obtained since MECP is not a true stationary point; (2) MECP cannot handle simultaneous crossings of more than two spin states or crossings within small regions; (3) For 3d elements, MECP positions and energies can deviate significantly from two-component relativistic results :cite:`Ricciarelli2020`; (4) MECP is unsuitable for actinide systems; its applicability to unsaturated-bonded 5d systems is questionable.

In 2018, Truhlar et al. proposed the two-state spin-mixing (TSSM) model to simulate spin-orbit coupling between two spin states during chemical reactions :cite:`Truhlar2018`. Recently, we generalized it to the multi-state spin-mixing (MSSM) model, applicable to multiple spin states. MSSM avoids the first three drawbacks of MECP and is suitable for elements up to 5d :cite:`Zhao2023`. Tests on 5d compound reactions show that MSSM-DFT reaction energies and transition state barriers differ by less than 3 kcal/mol from two-component DFT results (for unsaturated-bonded 5d compounds, two/four-component single-point energy corrections are needed).

As an example, we use the MSSM model to repeat Truhlar's TSSM study of the dehydrogenation reaction in a tungsten complex: :math:`W(CH_3)(n-C_3H_7)(OH)_2 \rightarrow WH(CH_3)(=CHC_2H_5)(OH)_2` :cite:`Truhlar2018`. In the literature, this system approximates a heterogeneous tungsten catalyst for atomic layer deposition, where the support skeleton is replaced by two OH groups. The reaction schematic is shown below: blue lines indicate the singlet reaction path, red lines the triplet path, black lines the lowest energy path after spin mixing, and yellow lines the singlet contribution to the lowest mixed state. During the reaction, tungsten's oxidation state changes from +4 to +6. In the reactant, tungsten is partially coordinated, making the triplet state lowest in energy (spin-mixed ground state dominated by triplet). In the product, tungsten is fully coordinated, making the closed-shell singlet lowest (spin-mixed ground state dominated by singlet). The triplet-singlet crossing point and the transition state of the spin-mixed ground state are separated (though energetically close), with the singlet contributing ~90% at the transition state—a key difference from MECP where spins mix 1:1.

.. figure:: /images/mssm-w.png

Generally, before MSSM calculations, conventional scalar methods should optimize reactant, product, transition state, and intermediate structures for all possible spin states to identify critical spin states and initial structures for MSSM optimization. Since this reaction is well-studied :cite:`Truhlar2018`, we skip this step and directly optimize reactant, product, and transition state structures on the spin-mixed ground-state potential energy surface using MSSM, then compute vibrational frequencies. Initial coordinates are taken from the literature. Basis sets: def2-TZVP for W, 6-31G* for other atoms. The empirical SOC parameter is 302 meV (2436 :math:`\rm cm^{-1}`) from the literature. We replace M06L with B3LYP for better numerical stability. Results are compared with TSSM :cite:`Truhlar2018` and two-component relativistic data :cite:`Zhao2023`:

.. table:: Transition state imaginary frequency (:math:`\rm cm^{-1}`) and reaction energies (kcal/mol; reactant energy as zero).
    :widths: auto

    +-------------+--------+--------+--------+
    | Method      | TS Ener| Prod Ener| Im Freq|
    +=============+========+========+========+
    | MSSM-B3LYP  |   25.6 |    3.2 |   924i |
    +-------------+--------+--------+--------+
    | TSSM-M06L   |   28.3 |    3.2 |   962i |
    +-------------+--------+--------+--------+
    | 2c-M06L     |   25.8 |    0.0 |        |
    +-------------+--------+--------+--------+

More applications can be found in the Takayanagi group's series of papers. They used TSSM to study numerous two-state reactions involving 3d/4d elements (see :cite:`Takayanagi2018` and its citations).


BDF Calculation Input
----------------

Input for optimizing the spin-mixed ground state reactant is shown below. For command explanations, see comments in the :ref:`ZnS spin-mixed state example<MultiStateMix>`.

.. code-block:: bdf

    $compass
    title
       W system: reactant
    basis-block
     6-31G*
     W=def2-tzvp
    end basis
    # geom from PCCP 2018, 20, 4129
    geometry
    C  -2.50599000   0.80875000   0.27831700
    H  -2.42978000   0.87169600   1.37614800
    H  -3.29329400   1.52978300   0.00369300
    C  -1.17932200   1.22962500  -0.35262900
    H  -1.30089800   1.27432600  -1.45149600
    W   0.49596700  -0.04848100   0.05050100
    H  -0.94880200   2.26591700  -0.04284700
    C  -2.96148400  -0.58790000  -0.11445500
    H  -2.28153800  -1.36238600   0.26893400
    H  -3.96244500  -0.81403100   0.27115200
    H  -2.98974600  -0.70153100  -1.20640700
    O   1.64397700   1.44403300  -0.35823300
    H   1.22595200   2.31740600  -0.43846900
    O   0.49410200  -0.94895200   1.73966100
    H  -0.19914300  -0.83307900   2.40480100
    C   0.26970600  -1.43014300  -1.54486300
    H  -0.59187900  -2.09433400  -1.38019500
    H   0.07131900  -0.88842400  -2.48170400
    H   1.15657400  -2.06035000  -1.71035900
    end geometry
    nosymm
    $end

    $bdfopt
    multistate
     2soc  2436
    solver
     1
    hess
     final
    $end

    $xuanyuan
    $end

    %cp $BDF_WORKDIR/$BDFTASK.scforb.1   $BDF_WORKDIR/$BDFTASK.scforb    2>/dev/null || :
    $scf
    rks
    dft
     b3lyp
    grid
     fine
    $end
    %cp $BDF_WORKDIR/$BDFTASK.scforb     $BDF_WORKDIR/$BDFTASK.scforb.1

    $resp
    geom
    $end
    %cp $BDF_WORKDIR/$BDFTASK.egrad1     $BDF_WORKDIR/$BDFTASK.egrad.1   2>/dev/null || :
    %cp $BDF_WORKDIR/$BDFTASK.hess       $BDF_WORKDIR/$BDFTASK.hess.1    2>/dev/null || :

    %cp $BDF_WORKDIR/$BDFTASK.scforb.2   $BDF_WORKDIR/$BDFTASK.scforb    2>/dev/null || :
    $scf
    uks
    dft
     b3lyp
    spinmulti
     3
    grid
     fine
    $end
    %cp $BDF_WORKDIR/$BDFTASK.scforb     $BDF_WORKDIR/$BDFTASK.scforb.2

    $resp
    geom
    $end
    %cp $BDF_WORKDIR/$BDFTASK.egrad1     $BDF_WORKDIR/$BDFTASK.egrad.2   2>/dev/null || :
    %cp $BDF_WORKDIR/$BDFTASK.hess       $BDF_WORKDIR/$BDFTASK.hess.2    2>/dev/null || :

Input for optimizing the spin-mixed ground state product is similar. Only the ``compass`` module is shown below; other sections match the reactant input.

.. code-block:: bdf

    $compass
    title
       W system: product
    basis-block
     6-31G*
     W=def2-tzvp
    end basis
    # geom from PCCP 2018, 20, 4129
    geometry
    W  -0.42387000  -0.03021600  0.04243900
    O  -0.54695900  -1.59597800 -1.06031400
    H  -1.38476400  -2.05907900 -0.89227700
    O  -2.07683400  -0.36779800  1.01946300
    H  -2.09920000  -0.45365300  1.97932500
    C  -1.19429700   1.74966400 -0.81144000
    H  -1.16507500   2.46066600  0.03099700
    H  -0.64596000   2.20075800 -1.64296300
    H  -2.24817300   1.61217900 -1.08859500
    H   0.10061200   0.01381000  1.68243000
    C   1.39659000   0.37442700 -0.02642700
    H   1.22850000   0.24599300 -1.14781000
    C   2.78803600   0.62890000  0.40356700
    H   2.79144700   0.71717400  1.49877400
    H   3.12713400   1.60782200  0.02677600
    C   3.77244700  -0.45270200 -0.03426000
    H   4.78897300  -0.22737400  0.30879300
    H   3.48486900  -1.42988500  0.36906600
    H   3.80168700  -0.54392400 -1.12680400
    end geometry
    nosymm
    $end

For the spin-mixed ground state transition state, modify only the ``compass`` and ``bdfopt`` modules in the reactant input:

.. code-block:: bdf

    $compass
    title
       W system: TS
    basis-block
     6-31G*
     W=def2-tzvp
    end basis
    # geom from PCCP 2018, 20, 4129
    geometry
    C   2.75476500  -0.49692100  0.66265200
    H   2.66846800  -0.03811600  1.65776400
    H   3.19563100  -1.49505600  0.81976100
    C   1.39220000  -0.59199800  0.03929900
    H   1.40125200  -1.14322200 -0.93707500
    W  -0.48542700  -0.04574900 -0.00978200
    H   0.62772500  -0.92650400  1.07995600
    C   3.68608400   0.33536600 -0.20966500
    H   3.29355400   1.35035000 -0.34119700
    H   4.68482600   0.40829800  0.23538400
    H   3.79640600  -0.10658300 -1.20747300
    O  -1.41339700  -1.47110300 -0.89277200
    H  -1.32731100  -2.36616000 -0.52320400
    O  -1.79388100   0.67727500  1.22320500
    H  -1.75031500   0.44148600  2.15765700
    C  -0.22357400   1.89123400 -0.83239900
    H   0.11804400   2.54791300 -0.01489800
    H   0.44852800   2.01363400 -1.68618700
    H  -1.23385200   2.22393900 -1.11944000
    end geometry
    nosymm
    $end

    $bdfopt
    multistate
     2soc  2436
    solver
     1
    hess
     init+final
    iopt
     10
    $end