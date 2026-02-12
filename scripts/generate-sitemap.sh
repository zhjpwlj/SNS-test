#!/usr/bin/env bash
set -euo pipefail
BASE_URL="${1:-https://gamma.f5.si}"
cat > sitemap.xml <<XML
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>${BASE_URL}/</loc></url>
  <url><loc>${BASE_URL}/index.html</loc></url>
  <url><loc>${BASE_URL}/404.html</loc></url>
</urlset>
XML
