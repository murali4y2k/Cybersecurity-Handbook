# Security Policy

Thank you for helping keep the **Cybersecurity Handbook** secure.

This document explains how to responsibly report security issues related to this repository and its associated infrastructure.

---

# Supported Versions

| Version | Supported |
|----------|-----------|
| v0.1.x | ✅ Yes |
| Earlier Releases | ❌ No |

Only the latest release receives security updates.

---

# Scope

This repository primarily contains:

- Documentation
- Markdown files
- Images
- Diagrams
- Lab guides
- Example code
- Templates

Although the project is educational, security remains important.

---

# Reporting a Vulnerability

If you discover a security issue involving this repository, please **do not create a public GitHub Issue**.

Instead, contact the maintainers privately.

Include:

- Description of the issue
- Impact
- Steps to reproduce
- Affected files or components
- Suggested remediation (if available)

---

# Responsible Disclosure

Please:

- Allow reasonable time for investigation.
- Do not publicly disclose vulnerabilities before they are addressed.
- Avoid sharing exploit details publicly until a fix is available.

---

# What to Report

Examples include:

- Malicious dependencies
- Compromised GitHub Actions
- Secret or credential exposure
- Supply chain risks
- Repository misconfigurations
- Website vulnerabilities (future)
- CI/CD pipeline security issues (future)

---

# What Not to Report

The following are generally **not** considered security vulnerabilities:

- Grammar mistakes
- Broken links
- Formatting issues
- Typographical errors
- Educational examples that intentionally demonstrate insecure code (when clearly labeled)

Please use GitHub Issues for these instead.

---

# Secure Development Practices

This project aims to follow:

- Secure SDLC
- Least Privilege
- Defense in Depth
- Zero Trust principles where applicable
- Dependency review before adoption

---

# Dependency Management

When software components are added:

- Review licenses
- Check for known CVEs
- Prefer actively maintained projects
- Remove unused dependencies

---

# Secrets Management

Never commit:

- API keys
- Passwords
- Access tokens
- SSH private keys
- Cloud credentials
- Certificates
- Sensitive personal information

Use environment variables or secret management solutions where appropriate.

---

# GitHub Security Features

The project intends to enable:

- Dependabot Alerts
- Dependabot Security Updates
- Secret Scanning
- Code Scanning (CodeQL)
- Branch Protection Rules
- Required Pull Request Reviews

---

# Security Reviews

Major changes should be reviewed for:

- Documentation integrity
- Build process security
- Third-party dependencies
- Automation workflows
- Supply chain risks

---

# Security Contact

Project Maintainer:

Murali Konduru

For private security reports, please contact the maintainer through the repository's preferred communication channel once published.

---

# Acknowledgements

We appreciate responsible disclosure and thank security researchers and contributors who help improve the project's security.

---

# Version History

| Version | Notes |
|----------|-------|
| 0.1.0 | Initial Security Policy |
