#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${LIP_BUILD_COMMON_SOURCED:-}" ]]; then
  return 0 2>/dev/null || exit 0
fi
readonly LIP_BUILD_COMMON_SOURCED=1

lip_note() {
  printf '[lip] %s\n' "$*"
}

lip_die() {
  printf '[lip] error: %s\n' "$*" >&2
  exit 1
}

lip_require_cmd() {
  command -v "$1" >/dev/null 2>&1 || lip_die "required command not found: $1"
}

lip_default_sdkroot() {
  local candidate

  if [[ -n "${SDKROOT:-}" ]]; then
    printf '%s\n' "$SDKROOT"
    return
  fi

  for candidate in \
    /Developer/SDKs/MacOSX10.5.sdk \
    /Developer/SDKs/MacOSX10.5.Internal.sdk
  do
    if [[ -d "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return
    fi
  done

  printf '\n'
}

lip_init_module() {
  local module_name="$1"
  local module_root="$2"

  export LIP_MODULE_NAME="$module_name"
  export LIP_MODULE_ROOT="$module_root"
  export SRCROOT="${SRCROOT:-$module_root}"
  export OBJROOT="${OBJROOT:-$module_root/build/obj}"
  export SYMROOT="${SYMROOT:-$module_root/build/sym}"
  export DSTROOT="${DSTROOT:-$module_root/build/dst}"
  export ARCHS="${ARCHS:-ppc}"
  export RC_ARCHS="${RC_ARCHS:-ppc}"
  export VALID_ARCHS="${VALID_ARCHS:-ppc}"
  export MACOSX_DEPLOYMENT_TARGET="${MACOSX_DEPLOYMENT_TARGET:-10.5}"

  if [[ -z "${SDKROOT:-}" ]]; then
    local detected_sdkroot
    detected_sdkroot="$(lip_default_sdkroot)"
    if [[ -n "$detected_sdkroot" ]]; then
      export SDKROOT="$detected_sdkroot"
    fi
  fi

  mkdir -p "$OBJROOT" "$SYMROOT" "$DSTROOT"

  lip_note "module=$LIP_MODULE_NAME archs=$ARCHS deployment=$MACOSX_DEPLOYMENT_TARGET"
  if [[ -n "${SDKROOT:-}" ]]; then
    lip_note "sdkroot=$SDKROOT"
  else
    lip_note "sdkroot=<host default>"
  fi
  lip_note "objroot=$OBJROOT"
  lip_note "symroot=$SYMROOT"
  lip_note "dstroot=$DSTROOT"
}

lip_run() {
  printf '[lip] run:'
  while (( $# > 0 )); do
    printf ' %q' "$1"
    shift
  done
  printf '\n'
  "$@"
}
