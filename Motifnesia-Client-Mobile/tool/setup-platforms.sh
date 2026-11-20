#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
project_dir=$PWD
if [[ -x "$project_dir/.tooling/flutter/bin/flutter" ]]; then
    export PATH="$project_dir/.tooling/flutter/bin:$PATH"
fi
export PUB_CACHE="$project_dir/.tooling/pub-cache"

flutter create . --project-name motifnesia_mobile --org id.motifnesia     --platforms=android,ios,web --no-pub

python3 - <<'PY'
from pathlib import Path

android = Path("android/app/src/main/AndroidManifest.xml")
manifest = android.read_text()
permission = '    <uses-permission android:name="android.permission.INTERNET" />'
if permission not in manifest:
    manifest = manifest.replace("    <application", permission + "\n    <application", 1)
manifest = manifest.replace('android:label="motifnesia_mobile"', 'android:label="Motifnesia"')
android.write_text(manifest)
PY

flutter pub get
