#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd "$(dirname "$0")/.." && pwd)"
output_dir="$project_dir/release"
staging="$output_dir/docleaf-reader"
archive="$output_dir/docleaf-reader-github.zip"

mkdir -p "$output_dir"
rm -rf "$staging"
mkdir -p "$staging"

rsync -a "$project_dir/" "$staging/" \
  --exclude '.git/' \
  --exclude 'integrations/fqapp/.git/' \
  --exclude 'node_modules/' \
  --exclude 'work/' \
  --exclude 'dist/' \
  --exclude '.vinext/' \
  --exclude '.wrangler/' \
  --exclude 'release/' \
  --exclude 'integrations/fqapp/rust/target/' \
  --exclude 'integrations/fqapp/.docleaf-data/' \
  --exclude '.DS_Store'

chmod +x "$staging/一键启动.command" "$staging/scripts/start-with-fqapp.sh" "$staging/scripts/package-github.sh"
rm -f "$archive"
(cd "$output_dir" && COPYFILE_DISABLE=1 zip -X -q -r "$(basename "$archive")" docleaf-reader)
echo "已生成：$archive"
