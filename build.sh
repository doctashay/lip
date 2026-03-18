#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "$0")" && pwd)"

modules=(
  xnu
  bootx
  dyld
  objc4
  cctools
  ld64
  launchd
  configd
  libsecurity_ssl
  mDNSResponder
)

blocked_modules=(
  "security: upstream checkout is blocked on Windows due to invalid path names"
)

usage() {
  cat <<'EOF'
Usage:
  ./build.sh               # interactive module selection
  ./build.sh all           # build all available modules
  ./build.sh <module> ...  # build one or more modules
  ./build.sh --list        # list buildable modules
EOF
}

list_modules() {
  printf 'Buildable modules:\n'
  for module in "${modules[@]}"; do
    printf '  %s\n' "$module"
  done
  printf '\nBlocked modules:\n'
  for entry in "${blocked_modules[@]}"; do
    printf '  %s\n' "$entry"
  done
}

build_one() {
  local module="$1"
  local script_path="$repo_root/forks/$module/build.sh"

  if [[ ! -f "$script_path" ]]; then
    printf 'Missing build script for %s at %s\n' "$module" "$script_path" >&2
    return 1
  fi

  printf '\n==> Building %s\n' "$module"
  bash "$script_path"
}

build_many() {
  local failures=0
  local module

  for module in "$@"; do
    if ! build_one "$module"; then
      failures=$((failures + 1))
      printf 'Build failed for %s\n' "$module" >&2
    fi
  done

  if (( failures > 0 )); then
    printf '\n%d module build(s) failed.\n' "$failures" >&2
    return 1
  fi

  printf '\nAll requested module builds completed.\n'
}

interactive_select() {
  local options=("${modules[@]}" "all" "quit")
  local i=1
  local choice

  printf 'Select module to build:\n'
  for choice in "${options[@]}"; do
    printf '  %d) %s\n' "$i" "$choice"
    i=$((i + 1))
  done
  printf '\nBlocked:\n'
  for choice in "${blocked_modules[@]}"; do
    printf '  - %s\n' "$choice"
  done

  while true; do
    printf '\n> '
    IFS= read -r choice

    case "$choice" in
      '' )
        ;;
      [0-9]* )
        if (( choice >= 1 && choice <= ${#modules[@]} )); then
          build_many "${modules[$((choice - 1))]}"
          return
        fi
        if (( choice == ${#modules[@]} + 1 )); then
          build_many "${modules[@]}"
          return
        fi
        if (( choice == ${#modules[@]} + 2 )); then
          return
        fi
        printf 'Invalid selection.\n' >&2
        ;;
      all )
        build_many "${modules[@]}"
        return
        ;;
      quit|q|exit )
        return
        ;;
      * )
        printf 'Invalid selection.\n' >&2
        ;;
    esac
  done
}

main() {
  local arg
  local selected=()

  if (( $# == 0 )); then
    interactive_select
    return
  fi

  for arg in "$@"; do
    case "$arg" in
      --help|-h )
        usage
        return
        ;;
      --list|list )
        list_modules
        return
        ;;
      all )
        build_many "${modules[@]}"
        return
        ;;
      * )
        selected+=("$arg")
        ;;
    esac
  done

  if (( ${#selected[@]} == 0 )); then
    usage
    return 1
  fi

  for arg in "${selected[@]}"; do
    if [[ ! " ${modules[*]} " =~ [[:space:]]${arg}[[:space:]] ]]; then
      printf 'Unknown module: %s\n' "$arg" >&2
      usage >&2
      return 1
    fi
  done

  build_many "${selected[@]}"
}

main "$@"
