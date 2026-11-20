#!/bin/sh
# Build the DPS8M simulator from the vendored source into bin/dps8.
# Needs only a C compiler and GNU make.  If the system has no libuv
# development package, the vendored libuv is built and linked statically.
set -eu

ROOT=$(cd "$(dirname "$0")" && pwd)
SRC="$ROOT/simulator/dps8"
BUILD="$ROOT/simulator/build"
MAKE=${MAKE:-make}
command -v gmake >/dev/null 2>&1 && MAKE=gmake
JOBS=${JOBS:-2}

mkdir -p "$ROOT/bin" "$BUILD"

if [ -z "${USE_VENDORED_LIBUV:-}" ] && pkg-config --exists libuv 2>/dev/null; then
    echo "==> Using system libuv"
    (cd "$SRC" && $MAKE -j"$JOBS")
else
    UV="$BUILD/libuv"
    if [ ! -f "$UV/lib/libuv.a" ]; then
        echo "==> Building vendored libuv"
        rm -rf "$BUILD/libuv-src"
        mkdir -p "$BUILD/libuv-src"
        tar xzf "$ROOT"/simulator/third_party/libuv-*-dist.tar.gz \
            -C "$BUILD/libuv-src" --strip-components=1
        (cd "$BUILD/libuv-src" &&
            ./configure --prefix="$UV" --disable-shared --enable-static >/dev/null &&
            $MAKE -j"$JOBS" >/dev/null && $MAKE install >/dev/null)
    fi
    echo "==> Building dps8 against vendored libuv"
    (cd "$SRC" &&
        C_INCLUDE_PATH="$UV/include${C_INCLUDE_PATH:+:$C_INCLUDE_PATH}" \
        $MAKE -j"$JOBS" LIBUV="$UV/lib/libuv.a -lpthread -ldl")
fi

for t in dps8/dps8 prt2pdf/prt2pdf punutil/punutil tap2raw/tap2raw; do
    [ -f "$SRC/src/$t" ] && cp "$SRC/src/$t" "$ROOT/bin/"
done
echo "==> Built: $ROOT/bin/dps8"
