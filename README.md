# Multics

A complete, stand-alone, runnable [Multics](https://www.multicians.org/)
MR12.8 system: the DPS8M simulator source, a ready-to-boot disk image, the
full release tape set, and a large documentation archive, all in one
repository.

## Quick start

Requirements: a C compiler, GNU make, `xz`, and a telnet client.
(On Linux nothing else is needed; libuv is vendored.)

    ./run.sh

The first run builds the simulator (`bin/dps8`), unpacks the pristine disk
image into `run/`, and boots Multics. The terminal becomes the operator
console. When the boot settles, from another terminal:

    telnet localhost 6180

Press Enter to pick a channel, then log in:

    l Repair -cpw

The initial password is `repair`; `-cpw` makes you set a new one.

To shut down cleanly, press Esc at the console to get the operator prompt
(`M->`) and type `logout * * *`, then Esc again and `shut`; at the
`bce (boot)` prompt type `die` and answer `yes`. Ctrl-E gives the
simulator's `sim>` prompt, where `quit` exits.

`./run.sh --reset` throws away `run/` and starts again from the pristine
image. See `system/QuickStart_README.txt` for site customization
(`site_setup.sh`).

## Layout

| Path | Contents |
|------|----------|
| `run.sh`, `build.sh` | Boot the system; build the simulator |
| `simulator/dps8/` | DPS8M R3.1.0 source (unmodified release tarball) |
| `simulator/third_party/` | libuv source, used if the system has no libuv headers |
| `simulator/binaries/` | Official DPS8M R3.1.0 binaries for other platforms (macOS, Windows, BSDs, other Linux architectures, ...) |
| `system/` | MR12.8 QuickStart: `root.dsk` (xz, reassembled by `run.sh`), boot tape, boot script |
| `tapes/MR12.8/` | Full MR12.8 distribution tapes, including source and listings; run `unpack.sh` |
| `docs/release/` | MR12.8 Software Release / Installation Bulletins, system book, fixed tickets |
| `docs/dps8m/` | DPS8M Omnibus Documentation |
| `docs/bitsavers/` | Honeywell Multics manuals from bitsavers.org |
| `docs/multicians.org/` | Mirror of multicians.org (history, MTBs, MSPM, MSBs, MCRs, papers ...); open `index.html` |
| `docs/papers/` | Papers and reports linked from the multicians.org bibliography but hosted elsewhere |
| `licenses/` | License texts |

Files larger than GitHub's 100 MB limit are stored compressed and/or split
(`*.part-NN`); the scripts reassemble and checksum them.

## Rebuilding the system from tape

    ./build.sh
    cd tapes/MR12.8 && ./unpack.sh
    cd unpacked && ../../../bin/dps8 MR12.8_coldboot.ini

## Sources

- Simulator: <https://dps8m.gitlab.io/> (R3.1.0)
- Multics MR12.8 release: <https://multics-wiki.swenson.org/mr12-8>
- Documentation: <https://www.multicians.org/>, <https://bitsavers.org/pdf/honeywell/large_systems/multics/>

## Licenses

- Multics software: the Multics License (`licenses/MULTICS-LICENSE.txt`),
  Copyright MIT, Honeywell, Bull HN and Bull SAS.
- DPS8M: ICU License (`licenses/DPS8M-LICENSE.md`).
- libuv: MIT (`licenses/LIBUV-LICENSE.txt`).
- Documentation under `docs/` is archived here for preservation and remains
  the property of its respective authors and publishers. It is not covered
  by the licenses above. Rights holders who want something removed can open
  an issue.
