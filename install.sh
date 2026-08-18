#!/bin/sh
set -eu

REPO="BeforeWave/dshusage"
BRANCH="${DSHUSAGE_BRANCH:-main}"
INSTALL_DIR="${DSHUSAGE_INSTALL_DIR:-$HOME/.local/bin}"
SOURCE="${DSHUSAGE_SOURCE:-https://raw.githubusercontent.com/${REPO}/${BRANCH}/dshusage}"
TARGET="$INSTALL_DIR/dshusage"

command -v curl >/dev/null 2>&1 || {
  echo "dshusage: curl is required" >&2
  exit 1
}

mkdir -p "$INSTALL_DIR"
tmp="$(mktemp "${TMPDIR:-/tmp}/dshusage.XXXXXX")"
trap 'rm -f "$tmp"' EXIT HUP INT TERM

curl -fsSL "$SOURCE" -o "$tmp"
chmod 0755 "$tmp"
mv "$tmp" "$TARGET"
trap - EXIT HUP INT TERM

echo "Installed dshusage -> $TARGET"
case ":$PATH:" in
  *":$INSTALL_DIR:"*) ;;
  *)
    echo "Add this directory to PATH if needed:"
    echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
    ;;
esac

echo "Try: dshusage"
