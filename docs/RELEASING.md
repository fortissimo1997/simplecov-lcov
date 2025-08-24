# Releasing & Publishing

This repository uses:

- **Conventional Commits** (`feat:`, `fix:`, `chore:` ...)
- **release-please** to open automated Release PRs
- **RubyGems Trusted Publishing** via `rubygems/release-gem@v1`

## Normal flow

1. Merge changes to `main` using Conventional Commits.
2. `release-please` creates a **Release PR** (bumps `lib/simplecov/lcov/version.rb` and updates `CHANGELOG.md`).
3. Merge the Release PR → a GitHub Release and tag `vX.Y.Z` are created.
4. The **Publish** workflow runs on `release: published` and pushes the gem to RubyGems.

## One-time setup on RubyGems.org

1. As the gem owner, add a **Trusted Publisher** on RubyGems.org:
   - Select this GitHub repository
   - Specify the workflow name: `Publish gem on GitHub Release`
2. No `RUBYGEMS_API_KEY` is required (OIDC-based).

## Notes

- **Single source of truth (SSOT)** for version is `SimpleCov::Lcov::VERSION` in `lib/simplecov/lcov/version.rb`.
- Do **not** manually edit `CHANGELOG.md`; it's auto-generated.
- Protect `main` branch and require CI checks to pass before merge.
- If you ever need a manual release, you can trigger `release-please` via `workflow_dispatch`.
