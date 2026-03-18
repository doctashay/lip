# Build System

This repository ships a root-level interactive builder and per-module `build.sh` wrappers for the imported Apple OSS components.

## Entry Points

- `./build.sh`
- `./build.sh all`
- `./build.sh <module>`
- `forks/<module>/build.sh`

## Build Assumptions

These scripts are intended to run on a Leopard PPC development environment with Apple developer tools available.

Expected tooling:

- `/bin/bash`
- `make`
- `xcodebuild` for Xcode-based source drops
- `/Developer/SDKs/MacOSX10.5.sdk` if present

If the 10.5 SDK is not present, the scripts fall back to the host default SDK/toolchain configuration and still force:

- `ARCHS=ppc`
- `RC_ARCHS=ppc`
- `VALID_ARCHS=ppc`
- `MACOSX_DEPLOYMENT_TARGET=10.5`

## Build Output Layout

Each module builds into its own local `build/` tree:

- `build/obj`
- `build/sym`
- `build/dst`

## Module Defaults

- `xnu`: `make TARGET_CONFIGS="RELEASE PPC DEFAULT"`
- `bootx`: `make RC_ARCHS=ppc`
- `dyld`: `xcodebuild -target all`
- `objc4`: `make ARCHS=ppc RC_ARCHS=ppc`
- `cctools`: `make RC_OS=macos RC_ARCHS=ppc`
- `ld64`: `xcodebuild -target all`
- `launchd`: `xcodebuild -target default`
- `configd`: `xcodebuild -target All`
- `libsecurity_ssl`: `xcodebuild -target security_ssl`
- `mDNSResponder`: `xcodebuild -target "Build Some"`

## Known Gaps

- The `Security` source drop is not checked out in this workspace because the upstream tree contains path names that cannot be materialized on Windows.
- These scripts are configured from project metadata and source layout, but they have not yet been executed on a real Leopard PPC toolchain from this workspace.
