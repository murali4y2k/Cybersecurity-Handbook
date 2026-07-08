# Build Guide

This document provides instructions for building, testing, and deploying the Cybersecurity Handbook.

**Table of Contents**
- [Prerequisites](#prerequisites)
- [Building the Handbook](#building-the-handbook)
- [Running Scripts](#running-scripts)
- [Validation & Testing](#validation--testing)
- [Deployment](#deployment)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Tools
- **Git** – Version control (2.30+)
- **Python** – Script automation (3.8+)
- **Bash** (Linux/macOS) or **PowerShell** (Windows)
- **Node.js** (optional) – For markdown linting via GitHub Actions

### Optional Tools
- **Pandoc** – Markdown to PDF/EPUB conversion
- **ImageMagick** – Image optimization and export
- **Draw.io CLI** – Diagram generation from source files
- **Mermaid CLI** – Mermaid diagram rendering

### Installation

#### macOS
```bash
brew install git python3 pandoc imagemagick
```

#### Ubuntu/Debian
```bash
apt-get update
apt-get install -y git python3 pandoc imagemagick
```

#### Windows
```powershell
choco install git python pandoc imagemagick
# or use Windows Package Manager:
winget install Git.Git Python.Python.3.11 Pandoc ImageMagick
```

---

## Building the Handbook

### Quick Start

```bash
# Clone the repository
git clone https://github.com/murali4y2k/Cybersecurity-Handbook.git
cd Cybersecurity-Handbook

# Make the build script executable
chmod +x scripts/build-book.sh

# Run the build
./scripts/build-book.sh
```

### Build on Windows

```powershell
# Navigate to the repository
cd Cybersecurity-Handbook

# Run the PowerShell build script
.\scripts\build-book.ps1
```

### Build Options

```bash
# Full build with all validations
./scripts/build-book.sh --full

# Build specific format
./scripts/build-book.sh --format pdf    # PDF output
./scripts/build-book.sh --format html   # HTML output
./scripts/build-book.sh --format epub   # EPUB output

# Build with verbosity
./scripts/build-book.sh --verbose

# Dry run (no actual build)
./scripts/build-book.sh --dry-run
```

### Output Locations

- **HTML Output**: `releases/v0.1/html/`
- **PDF Output**: `releases/v0.1/pdf/`
- **EPUB Output**: `releases/v0.1/epub/`
- **Build Logs**: `.build/logs/`

---

## Running Scripts

### Generate Table of Contents

```bash
python3 scripts/generate-toc.py --input handbook/v0.1 --output handbook/v0.1/TOC.md
```

**Options:**
- `--input` – Source directory (default: `handbook/v0.1`)
- `--output` – Output file path
- `--max-depth` – Max heading depth (default: 3)
- `--format` – Output format: `markdown`, `html`, `json`

### Export & Optimize Assets

```bash
python3 scripts/export-assets.py --source assets/ --output releases/v0.1/assets/
```

**Options:**
- `--source` – Assets source directory
- `--output` – Output directory
- `--format` – Export format: `png`, `svg`, `webp`, `all` (default: all)
- `--optimize` – Enable compression (default: true)
- `--quality` – Image quality 1-100 (default: 85)

### Validate Links

```bash
python3 scripts/validate-links.py --handbook handbook/v0.1 --check-external
```

**Options:**
- `--handbook` – Handbook directory to validate
- `--check-external` – Validate external URLs (slower)
- `--timeout` – URL check timeout in seconds (default: 5)
- `--report` – Output report format: `text`, `json`, `html`

### Version Management

```bash
# Show current version
python3 scripts/version.py --show

# Bump version
python3 scripts/version.py --bump patch    # 0.1.0 → 0.1.1
python3 scripts/version.py --bump minor    # 0.1.0 → 0.2.0
python3 scripts/version.py --bump major    # 0.1.0 → 1.0.0

# Set specific version
python3 scripts/version.py --set 0.2.0
```

---

## Validation & Testing

### Markdown Linting

Automated via GitHub Actions on push/PR:

```bash
# Local linting (requires Node.js)
npm install -g markdownlint-cli
markdownlint handbook/**/*.md
```

### Handbook Structure Validation

```bash
# Run build validation
./scripts/build-book.sh --validate-only

# This checks:
# - All markdown files exist
# - Asset references are valid
# - Links are not broken
# - YAML front-matter is valid
```

### Link Validation

```bash
python3 scripts/validate-links.py --handbook handbook/v0.1 --report json > link-report.json
```

### Manual Content Review

Use the review checklist:
```
handbook/v0.1/review/review-checklist.md
```

---

## Deployment

### GitHub Pages Deployment

```bash
# Build HTML output
./scripts/build-book.sh --format html

# Push to gh-pages branch
git checkout --orphan gh-pages
git rm -rf .
cp -r releases/v0.1/html/* .
git add .
git commit -m "publish: deploy handbook v0.1 to GitHub Pages"
git push origin gh-pages
```

Then enable GitHub Pages in repository settings to serve from `gh-pages` branch.

### Release to GitHub Releases

```bash
# Tag the release
git tag -a v0.1.0 -m "Release v0.1.0: Foundations Edition"

# Push the tag (triggers release.yml workflow)
git push origin v0.1.0
```

GitHub Actions will automatically:
1. Build all formats (PDF, EPUB, HTML)
2. Create a GitHub Release
3. Upload artifacts

### Docker Build (Optional)

For consistent build environments:

```dockerfile
# Dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y python3 git pandoc imagemagick
COPY . /handbook
WORKDIR /handbook
CMD ["./scripts/build-book.sh"]
```

Build and run:
```bash
docker build -t cybersecurity-handbook .
docker run --rm -v $(pwd)/releases:/handbook/releases cybersecurity-handbook
```

---

## Troubleshooting

### Build Fails: "Python not found"

```bash
# Check Python installation
python3 --version

# Install Python 3.8+
# macOS: brew install python3
# Ubuntu: apt-get install python3
# Windows: Download from python.org or use winget
```

### Build Fails: "Pandoc not found"

```bash
# Check Pandoc installation
pandoc --version

# Install Pandoc (see Prerequisites section)
```

### Asset Export Fails

```bash
# Verify ImageMagick is installed
convert --version

# Check source assets exist
ls -la assets/

# Run with verbose output
python3 scripts/export-assets.py --source assets/ --output releases/v0.1/assets/ --verbose
```

### Link Validation False Positives

```bash
# Skip external links (faster)
python3 scripts/validate-links.py --handbook handbook/v0.1

# Increase timeout for slow sites
python3 scripts/validate-links.py --handbook handbook/v0.1 --check-external --timeout 10
```

### GitHub Actions Workflow Not Triggering

1. Verify workflow file exists: `.github/workflows/build-book.yml`
2. Check trigger conditions in workflow YAML
3. Ensure commits are to `main` or `develop` branch
4. View workflow logs in repository: **Actions** tab

### Permission Denied on Shell Scripts

```bash
# Make script executable
chmod +x scripts/build-book.sh
chmod +x scripts/build-book.ps1

# Run again
./scripts/build-book.sh
```

### Out of Memory During Asset Export

```bash
# Reduce image quality or batch size
python3 scripts/export-assets.py --source assets/ --output releases/v0.1/assets/ --quality 60
```

---

## CI/CD Workflows

### Markdown Lint Workflow
**File**: `.github/workflows/markdown-lint.yml`  
**Trigger**: On push or PR to main/develop  
**Action**: Validates markdown syntax and style

### Build Handbook Workflow
**File**: `.github/workflows/build-book.yml`  
**Trigger**: On push or change to `handbook/` or `assets/` directories  
**Action**: Validates handbook structure and builds all formats

### Release Workflow
**File**: `.github/workflows/release.yml`  
**Trigger**: On git tag push (e.g., `v0.1.0`)  
**Action**: Creates GitHub Release with build artifacts

---

## Contributing

When contributing content or fixes:

1. **Before committing**: Run local validation
   ```bash
   ./scripts/build-book.sh --validate-only
   python3 scripts/validate-links.py --handbook handbook/v0.1
   ```

2. **Before pushing**: Ensure clean working tree
   ```bash
   git status
   git add .
   git commit -m "message"
   ```

3. **After pushing**: Monitor GitHub Actions workflows
   - Visit repository **Actions** tab
   - Confirm all checks pass

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed contribution guidelines.

---

## Support

For build issues or questions:
- Check [SUPPORT.md](../SUPPORT.md)
- Review GitHub Issues: https://github.com/murali4y2k/Cybersecurity-Handbook/issues
- Open a new issue with build logs

---

**Last Updated**: 2026-07-08  
**Version**: 0.1.0  
**Maintainer**: Murali Konduru
