
destdir=`pwd`/dist-win

rm -rf build-libunwind-cross
mkdir build-libunwind-cross

SHARED=1
STATIC=0

#            -DCMAKE_AR="$PREFIX/bin/llvm-ar" \
#            -DCMAKE_RANLIB="$PREFIX/bin/llvm-ranlib" \

cd build-libunwind-cross && cmake \
            -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_INSTALL_PREFIX=$destdir \
   -DCMAKE_C_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-clang \
   -DCMAKE_CXX_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-clang++ \
            -DCMAKE_CROSSCOMPILING=TRUE \
            -DCMAKE_SYSTEM_NAME=Windows \
            -DCMAKE_C_COMPILER_WORKS=TRUE \
            -DCMAKE_CXX_COMPILER_WORKS=TRUE \
            -DLLVM_COMPILER_CHECKED=TRUE \
            -DCXX_SUPPORTS_CXX11=TRUE \
            -DCXX_SUPPORTS_CXX_STD=TRUE \
            -DLIBUNWIND_USE_COMPILER_RT=TRUE \
            -DLIBUNWIND_ENABLE_THREADS=TRUE \
            -DLIBUNWIND_ENABLE_SHARED=$SHARED \
            -DLIBUNWIND_ENABLE_STATIC=$STATIC \
            -DLIBUNWIND_ENABLE_CROSS_UNWINDING=FALSE \
            -DCMAKE_CXX_FLAGS="-Wno-dll-attribute-on-redeclaration" \
            -DCMAKE_C_FLAGS="-Wno-dll-attribute-on-redeclaration" \
  ../libunwind
