builddir=`pwd`/build-cross
destdir=`pwd`/dist-win

rm -rf ${builddir}
mkdir ${builddir}

LLVM_TBLGEN_PATH=`pwd`/dist-host/bin/llvm-tblgen
CLANG_TBLGEN_PATH=`pwd`/dist-host/bin/clang-tblgen
LLVM_CONFIG_FILENAME=`pwd`/dist-host/bin/llvm-config

cd ${builddir} && cmake -G Ninja ../llvm \
   -DCMAKE_INSTALL_PREFIX=${destdir} \
   -DCMAKE_CROSSCOMPILING=True \
   -DCMAKE_SYSTEM_NAME=Windows \
   -DLLVM_TABLEGEN=${LLVM_TBLGEN_PATH} \
   -DCLANG_TABLEGEN=${CLANG_TBLGEN_PATH} \
   -DLLVM_CONFIG_PATH=${LLVM_CONFIG_FILENAME} \
   -DCMAKE_C_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-gcc \
   -DCMAKE_CXX_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-g++ \
   -DCMAKE_RC_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-windres \
   -DLLVM_ENABLE_PROJECTS="clang" \
   -DLLVM_TARGETS_TO_BUILD="X86" \
   -DLLVM_BUILD_TESTS=Off \
   -DLLVM_ENABLE_LIBXML2=Off \
   -DCMAKE_BUILD_TYPE=MinSizeRel \
   -DLLVM_BUILD_LLVM_DYLIB="YES" \
   -DLLVM_ENABLE_ASSERTIONS=ON
