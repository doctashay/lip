# Leopard Improvement Project

Leopard Improvement Project is a community-focused effort to improve OS X Leopard for PowerPC systems with practical security, stability, performance, and usability work built on Apple-released open source components and companion OSS where appropriate.

This repository is organized around a simple rule:

- the root is a git monorepo
- each upstream OSS codebase we maintain lives under `forks/` as its own git submodule where practical
- project-wide planning and policy live under `docs/`
- packaging, release, and installer work live outside the fork directories

Start here:

- `docs/roadmap.md`
- `docs/project-structure.md`
- `docs/component-matrix.md`
