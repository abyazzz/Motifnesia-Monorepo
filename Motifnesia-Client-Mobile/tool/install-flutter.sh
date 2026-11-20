#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
tooling_dir="$project_dir/.tooling"
sdk="$tooling_dir/flutter/bin/flutter"

if [[ -x "$sdk" ]]; then
    printf '%s\n' "$sdk"
    exit 0
fi
if [[ "$(uname -s)" != Linux || "$(uname -m)" != x86_64 ]]; then
    printf '%s\n' 'Installer ini untuk Linux x86_64. Gunakan SDK Flutter sesuai platform Anda.' >&2
    exit 1
fi

mkdir -p "$tooling_dir"
staging=$(mktemp -d "$tooling_dir/sdk-download.XXXXXXXX")
trap 'rm -rf -- "$staging"' EXIT
curl -fsSL --connect-timeout 10 --retry 1     https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json     -o "$staging/releases.json"

mapfile -t release < <(python3 - "$staging/releases.json" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as source:
    index = json.load(source)
stable = index["current_release"]["stable"]
item = next(release for release in index["releases"]
            if release["hash"] == stable and release["channel"] == "stable"
            and release.get("dart_sdk_arch", "x64") == "x64")
print(index["base_url"] + "/" + item["archive"])
print(item["sha256"])
PY
)
if [[ "${#release[@]}" -ne 2 || ! "${release[0]}" =~ ^https://storage\.googleapis\.com/flutter_infra_release/ ]]; then
    printf '%s\n' 'Rilis Flutter stabil tidak ditemukan.' >&2
    exit 1
fi

curl -fSL --connect-timeout 15 --retry 2 "${release[0]}" -o "$staging/flutter.tar.xz"
printf '%s  %s\n' "${release[1]}" "$staging/flutter.tar.xz" | sha256sum -c -
tar -xJf "$staging/flutter.tar.xz" -C "$staging"
test -x "$staging/flutter/bin/flutter"
test ! -e "$tooling_dir/flutter"
mv -- "$staging/flutter" "$tooling_dir/flutter"
printf '%s\n' "$sdk"
