# kasemsit.github.io

Personal academic homepage of Kasemsit Teeyapan, built with the
[al-folio](https://github.com/alshedivat/al-folio) Jekyll theme and deployed to
GitHub Pages via GitHub Actions (`.github/workflows/deploy.yml`).

## Editing content

- **Bio / landing page:** `_pages/about.md`
- **Publications:** `_bibliography/papers.bib` — grouped by the `category` field
  (`intl_journal`, `intl_conf`, `short_conf`, `national_journal`); add
  `selected={true}` to feature a paper on the landing page.
- **CV:** `_data/cv.yml` is the single source of truth (rendered at `/cv/`).
  After editing it, regenerate the downloadable PDF with `bash bin/make-cv-pdf.sh`
  (writes `assets/pdf/cv.pdf` from the rendered page using the print styles in
  `_layouts/cv.liquid`). Long lists use Markdown sub-bullets inside a `bullet:` field.
- **Teaching:** `_pages/teaching.md`
- **Senior projects:** `_pages/senior-projects.md`
- **News:** `_news/*.md`
- **Site settings / social links:** `_config.yml`, `_data/socials.yml`

## Local preview

Requires Ruby (+ `ruby-dev`), Node.js, Python, and ImageMagick.

First time only — install dependencies:

```bash
bundle install
npm ci
```

Run the dev server (auto-reloads on file changes):

```bash
bundle exec jekyll serve --livereload
# open http://localhost:4000/
```

> If `bundle` is not found, it was installed via `gem install --user-install`.
> Put it on your PATH for the session (or add to `~/.bashrc`):
>
> ```bash
> export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
> ```

## Deploy

1. Commit and push to the `master` branch.
2. GitHub Actions (`.github/workflows/deploy.yml`) builds the site and publishes
   it to the `gh-pages` branch automatically.
3. One-time setup: in the GitHub repo **Settings → Pages**, set the source to the
   `gh-pages` branch. The site is served at <https://kasemsit.github.io>.
