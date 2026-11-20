#!/usr/bin/env bash
# Prepares token-reducer in Claude Code on the web (cloud) sessions.
# Local sessions already have it installed, so this does nothing there.
[ "$CLAUDE_CODE_REMOTE" = "true" ] || exit 0

# Commit of Madhan230205/token-reducer that was reviewed before adoption.
# Bump deliberately after reviewing a newer version.
PINNED_COMMIT="1a0a11dfc8fc8645e465abbd505d46addc025ccb"
DEST="$HOME/.token-reducer"

PKGS="typer>=0.12.0 pydantic>=2.0.0 tree-sitter>=0.21.0 tree-sitter-python tree-sitter-javascript \
tree-sitter-typescript tree-sitter-java tree-sitter-go tree-sitter-rust tree-sitter-c tree-sitter-cpp tree-sitter-ruby"

PY=python3; command -v "$PY" >/dev/null 2>&1 || PY=python
# shellcheck disable=SC2086
"$PY" -m pip install --quiet --user $PKGS >/dev/null 2>&1 \
  || "$PY" -m pip install --quiet --user --break-system-packages $PKGS >/dev/null 2>&1 \
  || "$PY" -m pip install --quiet $PKGS >/dev/null 2>&1 \
  || echo "token-reducer: could not install Python packages" >&2

# Fallback copy of the pipeline, pinned, in case the plugin itself is not loaded.
if [ ! -f "$DEST/scripts/context_pipeline.py" ]; then
  rm -rf "$DEST"
  git init -q "$DEST" \
    && git -C "$DEST" fetch -q --depth 1 https://github.com/Madhan230205/token-reducer "$PINNED_COMMIT" \
    && git -C "$DEST" checkout -q FETCH_HEAD \
    || echo "token-reducer: could not fetch pipeline" >&2
fi

exit 0
