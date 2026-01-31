# 💻 Local Development Guide

**Work on Quynhluu CLI locally without publishing releases.**

> **Note:** All scripts come in both Bash (`.sh`) and PowerShell (`.ps1`) versions. The CLI auto-picks based on your OS unless you specify `--script sh|ps`.

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/dauquangthanh/quynhluu.git
cd quynhluu

# Work on a feature branch
git checkout -b your-feature-branch
```

---

### 2. Run CLI Directly (Fastest Way)

Test your changes instantly without installing:

```bash
# From repository root
python -m src.quynhluu_cli --help
python -m src.quynhluu_cli init demo-project --ai claude --ignore-agent-tools --script sh

# Multiple AI agents (comma-separated)
python -m src.quynhluu_cli init demo-project --ai claude,gemini,copilot --script sh

# Use local templates (no GitHub download)
python -m src.quynhluu_cli init demo-project --ai claude --local-templates --template-path . --script sh
```

**Alternative:** Run the script directly (uses shebang):

```bash
python src/quynhluu_cli/__init__.py init demo-project --script ps
```

---

### 3. Use Editable Install (Like Real Users)

Create an isolated environment that matches how users run Quynhluu:

```bash
# Create virtual environment (uv manages .venv automatically)
uv venv

# Activate it
source .venv/bin/activate  # Linux/macOS
# or on Windows PowerShell:
.venv\Scripts\Activate.ps1

# Install in editable mode
uv pip install -e .

# Now use 'quynhluu' command directly
quynhluu --help
```

**Benefit:** No need to reinstall after code changes—it updates automatically!

### 4. Test with uvx (Simulate User Experience)

Test how users will actually run Quynhluu:

**From local directory:**

```bash
uvx --from . quynhluu init demo-uvx --ai copilot --ignore-agent-tools --script sh
```

**From a specific branch (without merging):**

```bash
# Push your branch first
git push origin your-feature-branch

# Test it
uvx --from git+https://github.com/dauquangthanh/hanoi-quynhluu.git@your-feature-branch quynhluu init demo-branch-test --script ps
```

#### Run from Anywhere (Absolute Path)

Use absolute paths when you're in a different directory:

```bash
uvx --from /mnt/c/GitHub/hanoi-quynhluu quynhluu --help
uvx --from /mnt/c/GitHub/hanoi-quynhluu quynhluu init demo-anywhere --ai copilot --script sh
```

**Make it easier with an environment variable:**

```bash
# Set once
export RAINBOW_SRC=/mnt/c/GitHub/hanoi-quynhluu

# Use anywhere
uvx --from "$RAINBOW_SRC" quynhluu init demo-env --ai copilot --script ps
```

**Or create a shell function:**

```bash
quynhluu-dev() { uvx --from /mnt/c/GitHub/hanoi-quynhluu quynhluu "$@"; }

# Then just use
quynhluu-dev --help
```

---

### 5. Check Script Permissions

After running `init`, verify shell scripts are executable (Linux/macOS only):

```bash
ls -l scripts | grep .sh
# Expect: -rwxr-xr-x (owner execute bit set)
```

> **Note:** Windows PowerShell scripts (`.ps1`) don't need chmod.

---

### 6. Quick Sanity Check

Verify your code imports correctly:

```bash
python -c "import quynhluu_cli; print('Import OK')"
```

---

### 7. Build a Wheel (Optional)

Test packaging before publishing:

```bash
uv build
ls dist/
```

Install the built wheel in a fresh environment if needed.

### 8. Use a Temporary Workspace

Test `init --here` without cluttering your repo:

```bash
mkdir /tmp/quynhluu-test && cd /tmp/quynhluu-test
python -m src.quynhluu_cli init --here --ai claude --ignore-agent-tools --script sh
```

---

### 9. Debug Network Issues

Skip TLS validation during local testing (not for production!):

```bash
quynhluu check --skip-tls
quynhluu init demo --skip-tls --ai gemini --ignore-agent-tools --script ps
```

---

## � Repository Structure

Understanding the Quynhluu CLI repository layout:

```
hanoi-quynhluu/
├── agent-commands/        # Slash command definitions (copied to agent folders)
│   ├── set-ground-rules.md       # Project principles command
│   ├── specify.md        # Requirements command
│   ├── design.md         # Technical planning command
│   └── templates-for-commands/  # Reusable templates
│
├── skills/               # Reusable skill modules (copied to agent skills folders)
│   ├── architecture-design/
│   ├── coding/
│   ├── context-assessment/
│   ├── nextjs-mockup/
│   └── ... (17 skills total)
│
├── docs/                 # Documentation site
├── scripts/              # Automation scripts (bash + PowerShell)
├── src/quynhluu_cli/      # CLI source code
├── rules/                # Agent-specific rules and guidelines
└── .github/workflows/    # CI/CD and release automation
```

**Note:** The `agent-commands/` and `skills/` folders are source templates. When you run `quynhluu init`, these are copied into your project's agent-specific folders (`.claude/commands/`, `.github/agents/`, etc.).

---

## �🔄 Quick Reference

| What You Want | Command |
| --------------- | ---------- |
| **Run CLI directly** | `python -m src.quynhluu_cli --help` |
| **Editable install** | `uv pip install -e .` then `quynhluu ...` |
| **Local uvx (repo root)** | `uvx --from . quynhluu ...` |
| **Local uvx (absolute path)** | `uvx --from /path/to/hanoi-quynhluu quynhluu ...` |
| **Test specific branch** | `uvx --from git+URL@branch quynhluu ...` |
| **Build package** | `uv build` |
| **Clean up** | `rm -rf .venv dist build *.egg-info` |

---

## 🧹 Cleanup

Remove build artifacts and virtual environments:

```bash
rm -rf .venv dist build *.egg-info
```

---

## 🛠️ Common Issues

| Problem | Solution |
| --------- | ---------- |
| **`ModuleNotFoundError: typer`** | Run `uv pip install -e .` to install dependencies |
| **Scripts not executable (Linux)** | Re-run init or manually run `chmod +x scripts/*.sh` |
| **Git step skipped** | You passed `--no-git` or Git isn't installed |
| **Wrong script type** | Pass `--script sh` or `--script ps` explicitly |
| **TLS errors (corporate network)** | Try `--skip-tls` (not recommended for production) |

---

## 👉 Next Steps

1. **Test your changes** - Run through the Quick Start guide with your modified CLI
2. **Update docs** - Document any new features or changes
3. **Open a PR** - Share your improvements when ready
4. **Tag a release** - Once merged to `main`, create a release tag (optional)

---

## 📚 Resources

- 📖 [Quick Start Guide](quickstart.md) - Test your changes end-to-end
- 🐛 [Report Issues](https://github.com/dauquangthanh/hanoi-quynhluu/issues/new) - Found a bug?
- 💬 [Discussions](https://github.com/dauquangthanh/hanoi-quynhluu/discussions) - Ask questions
