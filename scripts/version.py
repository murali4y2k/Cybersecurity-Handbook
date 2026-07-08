#!/usr/bin/env python3
"""
Version Management
Manages and retrieves version information
"""

import os
import sys

VERSION = "0.1.0"
EDITION = "Foundations Edition"

def get_version():
    """Return current version."""
    return VERSION

def get_edition():
    """Return current edition name."""
    return EDITION

if __name__ == "__main__":
    print(f"Cybersecurity Handbook v{VERSION} - {EDITION}")
