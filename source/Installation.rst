Installation and Running
************************************

.. attention::

   Regular users can skip installation/compilation details and proceed directly to :ref:`Running BDF<run-bdfpro>` and :ref:`BDF Graphical Interface<run-bdfgui>`.

Installation Instructions
================================================

Hardware Requirements
-------------------------------------------------
BDF can be compiled/installed on Unix/Linux systems. It has been tested on common hardware/OS environments. For other platforms, users may encounter issues due to OS/compiler limitations. With correct compiler flags and system paths, BDF can typically be installed successfully.

- **Disk Space**: Minimum 2 GB free space for compilation (actual size ~1.3 GB post-install). For calculations, allocate ≥1 GB for intermediate data (depends on system size/integral method). Direct integral algorithms require less disk space (≥4 GB recommended).

Software Requirements
------------------------------------------------------------------------

Minimum requirements for source compilation:

 * Fortran compiler (supports Fortran 95+)
 * C++ compiler (supports C++03+)
 * C compiler
 * BLAS/LAPACK (64-bit integer interface)
 * CMake ≥3.15
 * Python ≥2.7 (Python 3 not fully supported)

GCC ≥4.6 is typically sufficient.

Optional:
 * Intel Parallel Studio XE (C/C++/Fortran)
 * Optimized BLAS/LAPACK (MKL, ACML, OpenBLAS)
 * OpenMPI ≥1.4.1 (parallel version)
 * OpenCL ≥1.5 + ROCm/CUDA (GPU version)

Compiling BDF with CMake
==========================================================================

1. Intel Fortran + GNU gcc/g++ + MKL + OpenMP
--------------------------------------------------------------------------------

.. code-block:: shell

    export FC=ifort
    export CC=gcc
    export CXX=g++
    ./setup --fc=${FC} --cc=${CC} --cxx=${CXX} --bdfpro --omp --int64 --mkl sequential $1
    cd build
    make -j4
    make install
    # Set environment:
    BDFHOME=/path/to/bdf-pkg-pro
    $BDFHOME/sbin/bdfdrv.py -r **.inp

2. GNU Compilers (gfortran/gcc/g++) + MKL + OpenMP
-------------------------------------------------------------------

.. code-block:: shell

    export FC=gfortran
    export CC=gcc
    export CXX=g++
    ./setup --fc=${FC} --cc=${CC} --cxx=${CXX} --bdfpro --omp --int64 --mkl sequential $1
    cd build
    make -j4
    make install
    # Usage same as above

3. Intel Compilers (ifort/icc/icpc) + MKL + OpenMP
-------------------------------------------------------------------

.. code-block:: shell

    export FC=ifort
    export CC=icc
    export CXX=icpc
    ./setup --fc=${FC} --cc=${CC} --cxx=${CXX} --bdfpro --omp --int64 --mkl sequential $1
    cd build
    make -j4
    make install
    # Usage same as above

.. Warning::
   1. Avoid mixing GCC ≥9.0 with Intel Fortran (OpenMP version conflict).
   2. Intel Fortran 2018 has known bugs - avoid.

4. Compiling BDFpro with Hongzhiwei License
-------------------------------------------------------------------

Add ``--hzwlic`` to setup command:

.. code-block:: shell

    ./setup --fc=${FC} --cc=${CC} --cxx=${CXX} --bdfpro --hzwlic --omp --int64 --mkl sequential $1

After ``make install``, run:

.. code-block:: shell

    /path/to/bdf-pkg-pro/bin/hzwlic.x /path/to/binary/install

Generates **LicenseNumber.txt** in ``license`` directory.

.. note::
   Create ``license`` manually if missing.

.. _run-bdfpro:

5. Intel Compilers + C++14 + MKL + OpenMP
---------------------------------------------------------------------

Enable C++14 with ``ALLOW_CXX14``:

.. code-block:: shell

    ./setup --fc=ifort --cc=icc --cxx=icpc --cmake-options="-DALLOW_CXX14=YES" \
              --bdfpro --omp --int64 --mkl sequential build
    cd build
    make && make install

.. Note::
   1. Use ``ALLOW_CXX17``/``ALLOW_CXX20`` for higher standards.
   2. Without flags, BDF compiles with C++11.
   3. ``ALLOW_CXX14=YES`` only *enables* higher standards (uses compiler default if unsupported).
   4. Some features require C++14+ (automatically disabled if unavailable).
   5. Intel compilers rely on GNU infrastructure - check compatibility.

.. Hint::
   SecScf module (second-order SCF) requires C++14+ (C++17 recommended). Enable with ``ALLOW_CXX17=YES``.

Running BDF
==========================================================================

BDF runs in Linux terminals. Prepare input files (see later sections). Test examples are in ``tests/input``.

Environment Variables:

+---------------------+---------------------------------------------------+----------------------+
| Variable            | Description                                       | Required?            |
+=====================+===================================================+======================+
| BDFHOME             | BDF installation path                             | Yes                  |
+---------------------+---------------------------------------------------+----------------------+
| BDF_WORKDIR         | Job execution directory                           | Auto-set             |
+---------------------+---------------------------------------------------+----------------------+
| BDF_TMPDIR          | Temporary file storage                            | Yes                  |
+---------------------+---------------------------------------------------+----------------------+
| BDFTASK             | Job name (e.g., "h2o" for h2o.inp)                | Auto-set             |
+---------------------+---------------------------------------------------+----------------------+

Running BDF Locally (Shell Script)
---------------------------------------------
Example script (``run.sh``):

.. code-block:: shell

    #!/bin/bash
    export BDFHOME=/home/user/bdf-pkg-pro
    export BDF_WORKDIR=./
    export BDF_TMPDIR=/tmp/$RANDOM
    ulimit -s unlimited
    ulimit -t unlimited
    export OMP_NUM_THREADS=4
    export OMP_STACKSIZE=512M 
    $BDFHOME/sbin/bdfdrv.py -r $1

Execute:

.. code-block:: shell

    chmod +x run.sh
    mkdir test && cd test
    cp /path/to/ch2-hf.inp .
    ./run.sh ch2-hf.inp &> ch2-hf.out&

.. hint::
   Redirect output using ``>``.

Submitting BDF Jobs via PBS
------------------------------------------------

Example PBS script:

.. code-block:: shell

    #!/bin/bash
    #PBS -N jobname
    #PBS -l nodes=1:ppn=4
    #PBS -l walltime=1200:00:00
    #PBS -q batch
    #PBS -S /bin/bash
    export BDFHOME=/home/bbs/bdf-pkg-pro
    export BDF_TMPDIR=/tmp/$RANDOM
    export OMP_STACKSIZE=2G
    export OMP_NUM_THREADS=4
    cd $PBS_O_WORKDIR
    $BDFHOME/sbin/bdfdrv.py -r jobname.inp

Submitting BDF Jobs via Slurm
------------------------------------------------

Example Slurm script:

.. code-block:: shell

    #!/bin/bash
    #SBATCH --partition=v6_384
    #SBATCH -J bdf.slurm
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=48
    export BDFHOME=/home/bbs/bdf-pkg-pro
    export BDF_WORKDIR=./
    export BDF_TMPDIR=/tmp/$RANDOM
    export OMP_STACKSIZE=2G
    export OMP_NUM_THREADS=4
    $BDFHOME/sbin/bdfdrv.py -r jobname.inp

.. important::
    1. Set stack size: ``ulimit -s unlimited``.
    2. Set OpenMP threads: ``export OMP_NUM_THREADS=N``.
    3. Set per-thread stack memory: ``export OMP_STACKSIZE=1024M`` (total = OMP_STACKSIZE × OMP_NUM_THREADS).

QM/MM Environment Setup
-------------------------------------------------
.. _qmmmsetup:

Use Anaconda (`Official Site <https://www.anaconda.com>`_).

* Configure environment:

.. code-block:: shell

  conda create –name qmmm_env python=2.7
  conda activate qmmm_env
  conda install pyyaml cython 

* Install pDynamo-2:

BDF includes pDynamo-2 in ``sbin``. Install via:

.. code-block:: shell

  cd sbin/pDynamo_2.0.0/installation
  python ./install.py

Source generated environment files (e.g., ``environment_bash.com``) in ``.bashrc``.

.. note::
   On macOS, use Homebrew GCC (e.g., ``CC=gcc-8``). Versions >gcc-8 untested.

Add ``sbin`` to PATH:

.. code-block:: shell

  export PATH=/BDFPATH/sbin:$PATH

Set temporary directory:

.. code-block:: shell
  export PDYNAMO_BDFTMP=/path/to/tmp

Test installation:

.. code-block:: shell

  python /path/to/pDynamo_2.0.0/book/examples/RunExamples.py

Installation and Running (WSL)
************************************

Summary
========================================================================================================================
BDF can run on Windows via Windows Subsystem for Linux (WSL). This section documents creating/distributing BDF images (for developers). End users can skip image creation steps.

Prerequisites
========================================================================================================================
- WSL enabled/updated (WSL 2 recommended).
- Virtualization enabled in BIOS/UEFI.

.. note::
   - Install WSL: `Microsoft Guide <https://learn.microsoft.com/en-us/windows/wsl/install>`_.
   - WSL 1 requires extra steps (`ArchWSL Docs <https://wsldl-pg.github.io/ArchW-docs/Known-issues/>`_).
   - Compare WSL versions: `Microsoft Docs <https://learn.microsoft.com/en-us/windows/wsl/compare-versions>`_.

Creating a Distributable BDF Image
========================================================================================================================

1. Register BDF Distributable Blank as a WSL Distro
------------------------------------------------------------------------------------------------------------------------
In PowerShell:

.. code:: powershell

    wsl --import BdfServer <InstallPath> BdfDistributableBlank.vhdx --version 2 --vhd
    # OR
    wsl --import BdfServer <InstallPath> BdfDistributableBlank.tar.gz --version 2

Verify with ``wsl -l -v``.

.. note::
   - Download BdfDistributableBlank: `GitHub Releases <https://github.com/AndBrn743/BdfDistributableBlank/releases>`__.
   - Replace ``<InstallPath>``.

2. Download, Compile, and Install BDF
------------------------------------------------------------------------------------------------------------------------

2.1. Enter BdfServer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In PowerShell:

.. code:: powershell

   wsl -d BdfServer

2.2. Update System (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In Bash:

.. code:: bash

   pacman -Syyu

2.3. Copy BDF Source to BdfServer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In Bash:

.. code:: bash

   git clone user@server:/path/to/bdf-pkg
   # OR
   cp /mnt/d/path/to/bdf-pkg.tar.gz .

2.4. Compile and Install
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Run bundled script:

.. code:: bash

   compile_and_install_bdf  # Default path
   # OR
   compile_and_install_bdf /custom/path/to/bdf
   # With flags:
   compile_and_install_bdf -DENABLE_LICENSE=YES -DONLY_BDFPRO=YES

.. note::
   - Run as admin.
   - Script doesn't support custom install paths.
   - Delete sources/caches when prompted.

2.5. Cleanup
^^^^^^^^^^^^^^^^^^
- Remove build/source folders.
- Clear pacman cache: ``pacman -Scc``.
- Delete IDE caches.
- Remove temporary files.

3. Generate Distributable Image
------------------------------------------------------------------------------------------------------------------------

3.1. Close all programs connected to BdfServer.
3.2. Shut down WSL
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In PowerShell:

.. code:: powershell

   wsl --shutdown

3.3. Export Image
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

3.3.1. TAR Format
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
.. code:: powershell

   wsl --export BdfServer BdfServer.tar.gz

3.3.2. VHDX Format
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
.. code:: powershell

   wsl --export BdfServer BdfServer.vhdx --vhd

Deploying the Image
========================================================================================================================
In PowerShell:

.. code:: powershell

   wsl --import BdfServer <InstallPath> BdfServer.tar.gz --version 2
   # OR
   wsl --import BdfServer <InstallPath> BdfServer.vhdx --version 2 --vhd

.. note::
   Add a non-root user: `ArchWSL Guide <https://wsldl-pg.github.io/ArchW-docs/locale/zh-CN/How-to-Setup/#%E5%AE%8C%E6%88%90%E5%AE%89%E8%A3%85%E5%90%8E%E7%9A%84%E6%93%8D%E4%BD%9C>`__.

Common Commands
========================================================================================================================

- Run command in BdfServer:
  ``wsl -d BdfServer <command>``
- Run command in current Windows dir:
  ``wsl -d BdfServer ls``
- Run command in Linux dir:
  ``wsl -d BdfServer --cd ~/tasks ls``
- Copy file to BdfServer:
  ``wsl -d BdfServer cp MyFile.txt ~/tasks/``
- Copy file from BdfServer:
  ``wsl -d BdfServer cp ~/tasks/MyFile.txt .``
- Run BDF job:
  ``wsl -d BdfServer bdf input.inp``
- Open BdfServer dir in Explorer:
  ``wsl -d BdfServer --cd ~/tasks/ explorer.exe .``

.. attention::
   For WSL2, copy files to BdfServer filesystem before running (slow I/O between Windows/WSL).

Notes
========================================================================================================================

- **BDF Distributable Blank (BDB)**: Base image without BDF (smaller, reusable).
- **BDF Distributable Image (BDI)**: Contains BDF + dependencies (~10 GB, replace on updates).