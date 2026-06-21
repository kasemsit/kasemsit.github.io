#!/usr/bin/env bash
# Regenerate assets/pdf/cv.pdf from the rendered /cv/ page.
# The CV's single source of truth is _data/cv.yml; run this after editing it
# so the downloadable PDF stays in sync. Uses the print styles from
# _layouts/cv.liquid so the output is clean (no navbar/footer/sidebar).
#
# Requires: bundler, a local Chrome (google-chrome-stable), and `npm ci` done
# (provides node_modules/playwright-core).
set -euo pipefail

cd "$(dirname "$0")/.."
export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
export JEKYLL_ENV=production

CHROME="${CHROME:-$(command -v google-chrome-stable || command -v google-chrome || command -v chromium || true)}"
if [ -z "$CHROME" ]; then
  echo "No Chrome/Chromium found. Set CHROME=/path/to/chrome and retry." >&2
  exit 1
fi

echo "Building site..."
bundle exec jekyll build >/dev/null

echo "Starting preview server..."
bundle exec jekyll serve --no-watch --skip-initial-build --port 4000 >/dev/null 2>&1 &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT
until curl -s -o /dev/null -w "%{http_code}" http://localhost:4000/cv/ 2>/dev/null | grep -q 200; do sleep 0.3; done

echo "Generating assets/pdf/cv.pdf..."
CHROME="$CHROME" node -e '
const { chromium } = require("./node_modules/playwright-core");
(async () => {
  const b = await chromium.launch({ executablePath: process.env.CHROME });
  const p = await b.newPage();
  await p.goto("http://localhost:4000/cv/", { waitUntil: "networkidle" });
  await p.emulateMedia({ media: "print" });
  await p.pdf({ path: "assets/pdf/cv.pdf", format: "A4", printBackground: true, preferCSSPageSize: true });
  await b.close();
})();
'
echo "Done: assets/pdf/cv.pdf"
