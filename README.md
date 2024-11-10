# pre-commit-sbom-check

[Pre-commit](https://pre-commit.com/) hook for checking a [software bill of materials (SBOM)](https://en.wikipedia.org/wiki/Software_supply_chain) within a repository.
SBOM files (`sbom.json`) may be placed in the root of a repository to help declare dependencies used inside a project.

We use [Syft](https://github.com/anchore/syft) to generate and check the existing `sbom.json` file.
If no `sbom.json` file exists, the pre-commit hook will generate it (the pre-commit hook fails).
If the `sbom.json` file exists but is not up to date (checked with [`sbomdiff`](https://github.com/anthonyharrison/sbomdiff)), the pre-commit hook will replace the existing file (the pre-commit hook fails).
If the `sbom.json` file exists and is up to date, no action is taken and the pre-commit hook passes.

## Installation

Install this pre-commit hook into your project with a block like the following:

```yaml
repos:
  - repo: https://github.com/d33bs/pre-commit-sbom-check
    rev: v0.0.1
    hooks:
        - id: generate-sbom
```
