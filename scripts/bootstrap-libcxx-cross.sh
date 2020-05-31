destdir=`pwd`/dist-win
builddir=`pwd`/build-libcxx-cross
arch=x86_64

rm -rf ${builddir}
mkdir ${builddir}

type=static

        if [ "$type" = "shared" ]; then
            LIBCXX_VISIBILITY_FLAGS="-D_LIBCXXABI_BUILDING_LIBRARY"
            SHARED=1
            STATIC=0
        else
            LIBCXX_VISIBILITY_FLAGS="-D_LIBCXXABI_DISABLE_VISIBILITY_ANNOTATIONS"
            SHARED=0
            STATIC=1
        fi
        cd ${builddir} && cmake \
            -G Ninja \
            -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${destdir} \
    -DCMAKE_C_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-clang \
    -DCMAKE_CXX_COMPILER=$HOME/local/llvm-mingw-20191230-ubuntu-16.04/bin/x86_64-w64-mingw32-clang++ \
            -DCMAKE_CROSSCOMPILING=TRUE \
            -DCMAKE_SYSTEM_NAME=Windows \
            -DCMAKE_C_COMPILER_WORKS=TRUE \
            -DCMAKE_CXX_COMPILER_WORKS=TRUE \
            -DLLVM_COMPILER_CHECKED=TRUE \
            -DLIBCXX_USE_COMPILER_RT=ON \
            -DLIBCXX_INSTALL_HEADERS=ON \
            -DLIBCXX_ENABLE_EXCEPTIONS=ON \
            -DLIBCXX_ENABLE_THREADS=ON \
            -DLIBCXX_HAS_WIN32_THREAD_API=ON \
            -DLIBCXX_ENABLE_MONOTONIC_CLOCK=ON \
            -DLIBCXX_ENABLE_SHARED=$SHARED \
            -DLIBCXX_ENABLE_STATIC=$STATIC \
            -DLIBCXX_SUPPORTS_STD_EQ_CXX11_FLAG=TRUE \
            -DLIBCXX_HAVE_CXX_ATOMICS_WITHOUT_LIB=TRUE \
            -DLIBCXX_ENABLE_EXPERIMENTAL_LIBRARY=OFF \
            -DLIBCXX_ENABLE_FILESYSTEM=OFF \
            -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE \
            -DLIBCXX_CXX_ABI=libcxxabi \
            -DLIBCXX_CXX_ABI_INCLUDE_PATHS=../libcxxabi/include \
            -DLIBCXX_CXX_ABI_LIBRARY_PATH=../build-libcxxabi-cross/lib \
            -DLIBCXX_LIBDIR_SUFFIX="" \
            -DLIBCXX_INCLUDE_TESTS=FALSE \
            -DCMAKE_CXX_FLAGS="$LIBCXX_VISIBILITY_FLAGS" \
            -DCMAKE_SHARED_LINKER_FLAGS="-lunwind" \
            -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE \
  ../libcxx
