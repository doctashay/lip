# Roadmap

## Mission

Ship a community-maintained enhancement layer for OS X Leopard on PowerPC that improves safety, stability, performance, interoperability, and developer viability while staying grounded in rebuildable, legally redistributable source.

## Product Definition

Leopard Improvement Project is not a full rewrite of Leopard and not a one-off patch bundle. It is a maintained collection of upstream forks, patchsets, packaging work, and release engineering for a more usable PPC Leopard platform.

## Guiding Principles

- prefer rebuildable Apple OSS components over opaque hacks
- ship practical wins before deep research projects
- separate stable improvements from experimental features
- track provenance for every backport and inferred fix
- keep recovery and rollback paths available for risky changes

## Strategic Pillars

### 1. Secure Leopard

- backport CVE and hardening fixes where source is available
- improve certificate trust, crypto, and network security defaults
- add optional stricter runtime and kernel extension policies

### 2. Stable Leopard

- backport safe kernel, VM, scheduler, and I/O fixes
- reduce crashers, deadlocks, sleep/wake failures, and upgrade breakage
- improve diagnostics and last-known-good recovery behavior

### 3. Fast Leopard

- tune responsiveness on G4 and G5 systems
- reduce swap pressure and common UI stalls
- improve storage, boot, and launch-time behavior

### 4. Refined Leopard

- modernize boot and recovery UX
- provide clearer diagnostics, safer updates, and better first-run defaults
- deliver optional visual polish that still feels like Leopard

### 5. Viable Leopard

- keep the platform buildable for community developers
- improve toolchain, runtime, SDK, and ports compatibility
- evaluate ARC-related work as a dedicated initiative rather than a core blocker

## Workstreams

### A. Kernel and Low-Level Platform

- XNU stability backports
- PowerPC correctness fixes
- VM and scheduler tuning
- boot argument and recovery improvements
- experimental hardening features such as KASLR research

### B. Boot and Startup

- BootX rework
- graphical startup profile selection
- alternate kernel selection
- better diagnostics and fallback boot logic
- exploratory support for non-Apple PPC boot paths

### C. Security and Trust

- Security framework backports
- certificate store and validation improvements
- TLS modernization through rebuildable components and companion packages
- optional kext integrity and stricter loading policies

### D. Networking and Interoperability

- configd and network service reliability
- DNS and service discovery improvements
- modern TLS and cipher support
- WPA2 Enterprise improvements where the stack is open enough to patch
- WPA3 as a research track until source and driver boundaries are mapped

### E. Toolchain and Developer Viability

- cctools and ld64 maintenance
- Objective-C runtime and compiler compatibility work
- SDK cleanup and packaging
- ports-facing build fixes
- ARC backport proof-of-concept as a separate experimental program

### F. Packaging, Installer, and Updates

- reproducible build scripts
- installable release artifacts
- recovery tooling
- update channels for stable and experimental users

## Phase Plan

### Phase 0: Foundation

Goal: define the project, pin upstreams, and make builds reproducible.

Deliverables:

- repository structure in place
- component matrix with ownership and source provenance
- documented build environments for each selected upstream
- stable branch policy and experimental branch policy

Exit criteria:

- at least 4 candidate upstreams pinned to known source drops
- at least 2 upstreams buildable end-to-end in the project environment

### Phase 1: Alpha Baseline

Goal: ship the first useful, low-risk improvements.

Deliverables:

- rebuilt Leopard PPC kernel with selected stability and security fixes
- BootX quality-of-life improvements
- companion TLS modernization package
- documented install, rollback, and recovery flow

Exit criteria:

- alpha installer or package set produced
- smoke tests passing on at least one G4 and one G5 target
- recovery path validated after a failed or reverted update

### Phase 2: Stable Core

Goal: make the platform feel materially better for daily use.

Deliverables:

- broader kernel and system service backports
- improved diagnostics and safer defaults
- initial system preferences or control-panel surface for project features
- updated certificates, networking fixes, and interoperability work

Exit criteria:

- stable channel defined
- issue triage and crash-report intake process established
- compatibility notes published for major changes

### Phase 3: Modernization Layer

Goal: add features users immediately notice.

Deliverables:

- visual polish pack consistent with Leopard
- graphical boot profile selector
- optional secure mode profile
- improved maintenance and troubleshooting tooling

Exit criteria:

- stable update path from prior releases
- documented feature flags and fallback behavior

### Phase 4: Research Tracks

Goal: pursue deeper features without blocking the mainline.

Candidate items:

- ARC backport
- stricter library validation
- KASLR on PPC
- WPA3 support
- non-Apple PPC boot support

Rule:

- research-track work must remain optional until build, test, and recovery stories are credible

## Release Channels

- `stable`: low-risk, reversible improvements only
- `preview`: broader testing for upcoming stable changes
- `experimental`: research features and invasive platform work

## Immediate Next Steps

1. Pin the initial upstream set in `docs/component-matrix.md`.
2. Decide the first alpha scope and what is explicitly out of scope.
3. Import the first upstream source trees into `forks/`.
4. Write build notes and provenance docs for each imported fork.
5. Stand up validation targets for at least one G4 and one G5 machine profile.
