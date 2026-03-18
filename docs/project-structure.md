# Project Structure

## Repository Rule

The root repository is the project monorepo. Every upstream OSS codebase we fork or carry locally should get its own directory under `forks/`, ideally as a git submodule pinned to the Leopard baseline we are targeting.

This keeps provenance, patch review, syncing, and licensing clear.

## Top-Level Layout

```text
lip/
  README.md
  docs/
  forks/
  packages/
  scripts/
  tests/
```

## Directory Purposes

### `docs/`

Project-wide planning, scope, governance, release, and build documentation.

### `forks/`

One folder per upstream OSS codebase used by the project. In the normal case, each fork is imported as a git submodule. Each fork directory owns its source import, upstream notes, patches, and validation notes.

### `packages/`

Installers, metapackages, update bundles, compatibility packages, and release payload assembly.

### `scripts/`

Repo-level automation for fetch, patch application, building, signing, packaging, and test orchestration.

### `tests/`

Cross-component integration tests, smoke tests, hardware validation notes, and installer or updater validation assets.

## Required Structure Inside Each Fork

Every fork directory should converge on this layout:

```text
forks/<name>/
  README.md
  UPSTREAM.md
  patches/
  build/
  tests/
  notes/
```

## Required Files

### `README.md`

Brief summary of why this component exists in the project, what it produces, and where it sits in the roadmap.

### `UPSTREAM.md`

Must record:

- upstream project name
- source origin URL or archival source
- exact version, tag, or source drop
- Apple release or donor release being used
- licensing notes
- sync strategy

## Patch Policy

Patch content should be grouped by intent, not dumped as a single catch-all change.

Suggested categories:

- `patches/security/`
- `patches/stability/`
- `patches/performance/`
- `patches/ppc/`
- `patches/experimental/`

If a fork is still small, these can remain notes in `README.md` until real patches accumulate.

## Naming Conventions

- use the canonical upstream component name where possible
- prefer lowercase directory names
- keep names stable once published
- if multiple source drops exist, track the chosen one in `UPSTREAM.md`, not by renaming the folder

Examples:

- `forks/xnu`
- `forks/bootx`
- `forks/dyld`
- `forks/objc4`
- `forks/security`

## Ownership Model

Each fork should eventually declare:

- maintainer
- build status
- target architectures
- supported Leopard release baseline
- risk level

This can live in the fork `README.md` until a dedicated metadata file becomes necessary.

## Branching Guidance

- keep stable project work easy to identify and revert
- isolate research-track changes behind build flags, boot args, or separate branches
- do not land large inferred backports without provenance notes and validation steps

## Import Rules

When bringing in a new upstream fork:

1. create `forks/<name>/`
2. add it as a submodule when the upstream can be checked out on the host filesystem
3. pin it to the intended Leopard baseline tag or commit
4. document build prerequisites
5. document known closed-source or host-platform boundaries
6. define the first test target for the component

## Host Filesystem Caveats

Some Apple OSS drops contain filenames that cannot be checked out on Windows filesystems. Those components should be tracked in project docs as blocked on Windows rather than represented by a misleading partial checkout.

## Closed-Source Boundaries

Not every desired Leopard subsystem is fully open. If a component interacts with closed pieces, document that boundary explicitly rather than hiding it.

Examples:

- Airport stack integration limits
- firmware dependencies
- private frameworks or binary-only drivers

## Recommended Early Fork Set

These are strong initial candidates because they map well to the project goals and are likely to matter early:

- `xnu`
- `bootx`
- `dyld`
- `objc4`
- `cctools`
- `ld64`
- `launchd`
- `configd`
- `security`
- `libsecurity_ssl`
- `mDNSResponder`
