# Build Book Script (PowerShell)
# Compiles the Cybersecurity Handbook from source markdown files

Write-Host "Building Cybersecurity Handbook..."
Write-Host "Version: v0.1"

# Validate directory structure
Write-Host "Validating handbook structure..."
if (-not (Test-Path "handbook/v0.1")) {
    Write-Error "Error: handbook/v0.1 not found"
    exit 1
}

# Generate table of contents
Write-Host "Generating table of contents..."
python scripts/generate-toc.py

# Export assets
Write-Host "Exporting assets..."
python scripts/export-assets.py

# Validate links
Write-Host "Validating internal links..."
python scripts/validate-links.py

Write-Host "Build complete!"
