# appcenter_release_manager

## Releases & Changelog

Releases are automated with [release-please](https://github.com/googleapis/release-please). **Do not edit `CHANGELOG.md`, the `version` in `pubspec.yaml` or `.release-please-manifest.json` by hand.**

The **pull request title** (or, without squash merging, each commit) must be a [Conventional Commit](https://www.conventionalcommits.org). It becomes the changelog entry and decides the version bump:

| Title | Release |
|-------|---------|
| `fix: ...` | patch (0.0.x) |
| `feat: ...` | minor (0.x.0) |
| `feat!: ...` | major (x.0.0) |
| `docs:`, `ci:`, `chore:`, `refactor:`, `test:` | no release on their own |

How a release happens:

1. Every push to `main` runs `.github/workflows/release.yml`. release-please keeps one open **release PR** (`chore(main): release x.y.z`) that bumps `pubspec.yaml`, `.release-please-manifest.json` and prepends the new section to `CHANGELOG.md`.
2. Merging that PR creates the GitHub release and pushes the tag `vX.Y.Z`.
3. The tag push runs `.github/workflows/publish_to_pubdev.yaml`, which publishes to pub.dev.

`release.yml` uses the `IMPAKTFULL_GITHUB_PAT` secret instead of `GITHUB_TOKEN`: a tag pushed with `GITHUB_TOKEN` does not trigger other workflows, and pub.dev only accepts publishes triggered by a tag push. The token needs Contents, Pull requests and Issues as "Read and write" on this repository.

To force a specific version, set `"release-as": "x.y.z"` in `release-please-config.json` and remove it again after that release is merged.
