#!/bin/sh
# Boot Multics MR12.8.  On first use this unpacks the pristine disk image
# into run/ and builds the simulator if needed.
#
#   ./run.sh           boot the system (console in this terminal)
#   ./run.sh --reset   discard run/ and start again from the pristine image
#
# Then, from another terminal:  telnet localhost 6180
set -eu

ROOT=$(cd "$(dirname "$0")" && pwd)
RUN="$ROOT/run"

if [ "${1:-}" = "--reset" ]; then
    rm -rf "${ROOT:?}/run"
    shift
fi

[ -x "$ROOT/bin/dps8" ] || "$ROOT/build.sh"

mkdir -p "$RUN"
if [ ! -f "$RUN/root.dsk" ]; then
    echo "==> Unpacking disk image"
    cat "$ROOT"/system/root.dsk.xz.part-* | xz -dc > "$RUN/root.dsk.tmp"
    want=$(cut -d' ' -f1 "$ROOT/system/root.dsk.sha256")
    got=$(sha256sum "$RUN/root.dsk.tmp" | cut -d' ' -f1)
    [ "$want" = "$got" ] || { echo "root.dsk checksum mismatch" >&2; exit 1; }
    mv "$RUN/root.dsk.tmp" "$RUN/root.dsk"
fi
[ -f "$RUN/12.8MULTICS.tap" ]  || cp "$ROOT/system/12.8MULTICS.tap" "$RUN/"
[ -f "$RUN/MR12.8_boot.ini" ]  || cp "$ROOT/system/MR12.8_boot.ini" "$RUN/"
[ -f "$RUN/site_setup.sh" ]    || cp "$ROOT/system/site_setup.sh" "$RUN/"

cd "$RUN"
exec "$ROOT/bin/dps8" "${1:-MR12.8_boot.ini}"
