gallery_dir := "./gallery"

package target:
  ./scripts/package "{{target}}"

install:
  ./scripts/package "@local"

gallery:
  #!/usr/bin/env bash
  set -euxo pipefail

  for f in "{{gallery_dir}}"/*.typ; do
    typst c "$f" --format png "${f/.typ}-{n}.png" --root ./
  done

check-format:
  ./scripts/check-format
