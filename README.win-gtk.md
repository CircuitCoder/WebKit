# Building GTK port on Windows (x86-64)

Install msys2, install mingw64 **clang and lld**. Also cmake and other build & runtime dependencies from `qtwebkit`.

Additionally, the following dependencies needs to be installed:
- Install msys2 perl, and package `perl-File-Copy-Recursive`. I had no luck with `cpan install File::Copy::Recursive`.

Inside a build directory, run the following commands:

```
export CC=clang
export CXX=clang++
/mingw64/bin/cmake -GNinja -DCMAKE_INSTALL_PREFIX=/mingw64 -DCMAKE_CXX_FLAGS="-fuse-ld=lld" -DCMAKE_C_FLAGS="-fuse-ld=lld" -DPORT=GTK -DCMAKE_BUILD_TYPE=RelWIthDebInfo -DENABLE_GAMEPAD=off -DUSE_LIBDRM=off -DENABLE_SPEECH_SYNTHESIS=off -DUSE_JPEGXL=off -DENABLE_JOURNALD_LOG=OFF -DUSE_SYSTEM_MALLOC=ON -DUSE_LIBBACKTRACE=OFF -DENABLE_UNIFIED_BUILDS=OFF ..
```

Some dependencies may still be missing, but should all be found in mingw64 repository.

Then just `ninja`

## Progress
- WTF, PAL, ANGLE, Skia and dependencies should build.
- JSC should build, and can be ran without JIT on example JS scripts. Try with `bin/jsc.exe`. Full test not ran yet.
- WebCore should build.

## Potential problems

- Frame pointer address might not be correctly retrieved. JIT may not work.
- xdgmime is disabled.
