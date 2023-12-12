#!/bin/bash

for i in libquick libquick_mpi
do
  sed -i -e 's/-Wl,--no-undefined//g' \
         -e 's/-lfj90i -lfj90fmt_sve -lfj90f -lfjsrcinfo//g' \
    AmberTools/src/quick/src/CMakeFiles/${i}.dir/link.txt
done
 
for i in mm_pbsa/CMakeFiles/mm_pbsa_nabnmode amberlite/CMakeFiles/ffgbsa amberlite/CMakeFiles/mdnab amberlite/CMakeFiles/minab \
         cpptraj/src/CMakeFiles/cpptraj     rism/CMakeFiles/rism3d.snglpnt     \
         cpptraj/src/CMakeFiles/cpptraj.MPI rism/CMakeFiles/rism3d.snglpnt.MPI 
do
  sed -i -e 's/-lfj90i -lfj90fmt_sve -lfj90f -lfjsrcinfo/--linkfortran/g' \
    AmberTools/src/${i}.dir/link.txt
done

for i in ambpdb/CMakeFiles/ambpdb etc/CMakeFiles/molsurf \
         pbsa/CMakeFiles/simplepbsa     mdgx/CMakeFiles/mdgx     \
         pbsa/CMakeFiles/simplepbsa.MPI mdgx/CMakeFiles/mdgx.MPI
do
  sed -i -e 's/-lfj90i -lfj90fmt_sve -lfj90f -lfjsrcinfo//g' \
    AmberTools/src/${i}.dir/link.txt
done

for i in cphstats cestats
do
  sed -i -e 's/-lfj90i -lfj90fmt_sve -lfj90f -lfjsrcinfo//g' \
         -e 's/-Nclang/-Nclang -stdlib=libc++/g' \
    AmberTools/src/cphstats/CMakeFiles/${i}.dir/link.txt
  sed -i -e 's/-Nclang/-Nclang -stdlib=libc++/g' \
    AmberTools/src/cphstats/CMakeFiles/${i}.dir/flags.make
done

for i in libsander libsanderles \
         sander_base_obj     sander.LES     \
         sander_base_obj_mpi sander.LES.MPI
do
  sed -i -e '/remd.F90/s/-O3/-O0/g' \
    AmberTools/src/sander/CMakeFiles/${i}.dir/build.make
done

sed -i -e 's/C_FLAGS =/C_FLAGS = -Nclang -fsigned-char/g' \
       -e 's/Fortran_FLAGS =/Fortran_FLAGS = -Ksimd_nouse_multiple_structures -Nalloc_assign -fw/g' \
  AmberTools/src/quick/src/libxc/CMakeFiles/xc.dir/flags.make

for i in octree octree_mpi
do
  sed -i -e 's/CXX_FLAGS =/CXX_FLAGS = -Nclang -fsigned-char/g' \
    AmberTools/src/quick/src/octree/CMakeFiles/${i}.dir/flags.make
done

for i in quick     libquick     test-api     \
         quick.MPI libquick_mpi test-api.MPI
do
  sed -i -e 's/Fortran_FLAGS =/Fortran_FLAGS = -Nalloc_assign -fw/g' \
    AmberTools/src/quick/src/CMakeFiles/${i}.dir/flags.make
done

for i in quick test-api
do
  sed -i -e 's/libquick.so/libquick.so --linkstl=libstdc++/g' \
    AmberTools/src/quick/src/CMakeFiles/${i}.dir/link.txt
done

for i in quick.MPI test-api.MPI
do
  sed -i -e 's/libquick_mpi.so/libquick_mpi.so --linkstl=libstdc++/g' \
    AmberTools/src/quick/src/CMakeFiles/${i}.dir/link.txt
done

