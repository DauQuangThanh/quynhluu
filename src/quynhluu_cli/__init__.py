#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "typer",
#     "rich",
#     "platformdirs",
#     "readchar",
#     "httpx",
# ]
# ///
"""
Quynhluu CLI - Setup tool for Quynhluu projects

Usage:
    uvx quynhluu-cli.py init <project-name>
    uvx quynhluu-cli.py init .
    uvx quynhluu-cli.py init --here

Or install globally:
    uv tool install --from quynhluu-cli.py quynhluu-cli
    quynhluu init <project-name>
    quynhluu init .
    quynhluu init --here
"""

# Import UI app which has all the CLI configuration
from .ui import app

# Import commands to register them with the app
# The @app.command() decorators in commands.py register them automatically
from . import commands as _commands  # noqa: F401 - imported for side effects

# Re-export key items for external use
from .config import AGENT_CONFIG, BANNER, TAGLINE
from .github import ssl_context
from .ui import console, show_banner

__all__ = [
    "app",
    "console",
    "show_banner",
    "AGENT_CONFIG",
    "BANNER",
    "TAGLINE",
    "ssl_context",
]


def main():
    """Main entry point for the CLI."""
    app()


if __name__ == "__main__":
    main()
