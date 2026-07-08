#!/bin/bash
# Build Book Script
# Compiles the Cybersecurity Handbook from source markdown files

set -e

echo "Building Cybersecurity Handbook..."
echo "Version: v0.1"

# Validate directory structure
echo "Validating handbook structure..."
[ -d "handbook/v0.1" ] || { echo "Error: handbook/v0.1 not found"; exit 1; }

# Generate table of contents
echo "Generating table of contents..."
python3 scripts/generate-toc.py

# Export assets
echo "Exporting assets..."
python3 scripts/export-assets.py

# Validate links
echo "Validating internal links..."
python3 scripts/validate-links.py

echo "Build complete!"
