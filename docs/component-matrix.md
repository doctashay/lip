# Component Matrix

This is the initial planning matrix. Replace `TBD` values as upstreams are pinned and imported.

| Component | Area | Goal | Upstream Source | Leopard Baseline | Donor Version | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| xnu | kernel | stability, security, PPC fixes | `https://github.com/aosm/xnu.git` | `mac-os-x-1058` | `1228.15.4` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| bootx | boot | boot UX, recovery, alternate kernel selection | `https://github.com/aosm/BootX.git` | `mac-os-x-1058` | `81` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| dyld | runtime | startup behavior, loader fixes, compatibility | `https://github.com/aosm/dyld.git` | `mac-os-x-1058` | `97.1` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| objc4 | runtime | Objective-C runtime viability, ARC research dependency | `https://github.com/aosm/objc4.git` | `mac-os-x-1058` | `371.2` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| cctools | toolchain | developer viability and buildability | `https://github.com/aosm/cctools.git` | `mac-os-x-1058` | `667.3` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| ld64 | toolchain | linker compatibility and ports viability | `https://github.com/aosm/ld64.git` | `mac-os-x-1058` | `77.1` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| launchd | userland | service management stability and QoL | `https://github.com/aosm/launchd.git` | `mac-os-x-1058` | `258.25` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| configd | networking | modern network reliability and config behavior | `https://github.com/aosm/configd.git` | `mac-os-x-1058` | `212.2` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| security | trust/security | trust, code-signing-related groundwork, hardening | `https://github.com/aosm/Security.git` | `mac-os-x-1058` | `36371` | blocked | Windows checkout blocked by invalid path names in the upstream tree |
| libsecurity_ssl | crypto | TLS improvements and compatibility | `https://github.com/aosm/libsecurity_ssl.git` | `mac-os-x-1058` | `36371` | imported | submodule added and pinned to Leopard 10.5.8 tag |
| mDNSResponder | networking | discovery, DNS, and local network behavior | `https://github.com/aosm/mDNSResponder.git` | `mac-os-x-1058` | `176.3` | imported | submodule added and pinned to Leopard 10.5.8 tag |

## Status Definitions

- `planned`: candidate component not yet imported
- `imported`: source tree added and documented
- `building`: builds in project environment but not yet validated
- `validated`: built and tested on target systems
- `shipping`: included in a released channel
- `blocked`: known import blocker on the current host platform or filesystem
