# Building GTK port on Windows (64-bit)

Install msys2, install mingw64 **clang and lld**. Also cmake and other build & runtime dependencies from `qtwebkit`.

Inside a build directory, run the following cmake command:

```
/mingw64/bin/cmake -G"MSYS Makefiles" -DCMAKE_INSTALL_PREFIX=/mingw64 -DCMAKE_CXX_FLAGS="-fuse-ld=lld" -DCMAKE_C_FLAGS="-fuse-ld=lld" -DPORT=GTK -DCMAKE_BUILD_TYPE=RelWIthDebugInfo -DENABLE_GAMEPAD=off -DUSE_LIBDRM=off -DENABLE_SPEECH_SYNTHESIS=off -DUSE_JPEGXL=off -DENABLE_JOURNALD_LOG=OFF -DUSE_SYSTEM_MALLOC=ON -DUSE_LIBBACKTRACE=OFF -DENABLE_UNIFIED_BUILDS=OFF ..
```

Some dependencies may still be missing, but should all be found in mingw64 repository.

Then just `make`

## Potential problems

- Frame pointer address might not be correctly retrieved. JIT may not work.
- xdgmime is disabled.
