#!/bin/bash

# Generate SBOM using Anchore Syft via Docker
docker run --rm -v \
  "$(pwd)":/workspace anchore/syft:latest scan dir:/workspace \
  --output spdx-json > sbom-new.json

# If an existing SBOM file doesn't exist, save the new one as the baseline
if [ ! -f sbom.json ]; then
  echo "No existing SBOM found. Creating baseline SBOM."
  mv sbom-new.json sbom.json
  exit 1
fi

# Use sbomdiff (assumed to be installed via pre-commit) to check for changes
if ! sbomdiff sbom-new.json sbom.json; then
  echo "SBOM has changed! Please review and commit the updated SBOM."
  mv sbom-new.json sbom.json
  exit 1
else
  echo "SBOM is up-to-date."
  rm sbom-new.json
  exit 0
fi
