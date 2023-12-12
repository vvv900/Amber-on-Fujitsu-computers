*******> Amber22 + AmberTools22 patch

 Authors: Mr. Hirosuke Hotta and Dr. V. Vassiliev
 E-mails: hotta.hirosuke@fujitsu.com
          vvv900@nci.org.au

 Date: December 8, 2023

 Description: A cumulative patch for the original Amber22 + AmberTools22 for the A64FX platform
              Targets Fujitsu compilers tcsds-1.2.38 and cp-1.0.21.04

 Apply patch in amber22_src directory as 
	patch -p0 -N -r patch_rejects < amber22-a64fx-final.patch

1) Building Amber Using CMake
	a) Use the latest Fujitsu-aware CMake (cmake-3.25.1, 3.26.3 or later)

	b) Building the serial and parallel versions in one step

mkdir build-mpi	
CD build-mpi

AMBER_PREFIX=$(dirname $(dirname `pwd`))
rm -rf *

BASE_DIR=/opt/FJSVxtclanga/tcsds-1.2.37
export PATH=$BASE_DIR/bin:$PATH
export LD_LIBRARY_PATH=$BASE_DIR/lib64:$LD_LIBRARY_PATH

cmake $AMBER_PREFIX/amber22_src \
  -DFortranCInterface_GLOBAL__SUFFIX=TRUE \
  -DFortranCInterface_GLOBAL__CASE=TRUE \
  -DCMAKE_INSTALL_PREFIX=$AMBER_PREFIX/amber22 \
  -DCOMPILER=FUJITSU -DUSE_FFT=TRUE -DBUILD_GUI=FALSE \
  -DMPI=TRUE -DCUDA=FALSE -DINSTALL_TESTS=TRUE \
  -DCMAKE_C_COMPILER=fcc \
  -DCMAKE_CXX_COMPILER=FCC \ 
  -DCMAKE_Fortran_COMPILER=frt \
  -DMPI_C_COMPILER=mpifcc \
  -DMPI_CXX_COMPILER=mpiFCC \
  -DMPI_Fortran_COMPILER=mpifrt \
  -DCMAKE_CXX_FLAGS_RELEASE="-Kfast" \
  -DDOWNLOAD_MINICONDA=FALSE -DBUILD_PYTHON=FALSE \
  -DCMAKE_VERBOSE_MAKEFILE=TRUE -DBUILD_QUICK=TRUE \
  -DCMAKE_C_FLAGS="-Nclang -fsigned-char -fpic" \
  -DCMAKE_CXX_FLAGS="-Nclang -fsigned-char -fpic" \ 
  -DCMAKE_Fortran_FLAGS="-Kfast -Ksimd_nouse_multiple_structures -Kpic -Nalloc_assign -fw" \
  -DSTATIC=TRUE --trace-expand \
  2>&1 | tee cmake.log

	run modify.sh script:

/path/to/modify.sh

make install -j8
