# UMA Reference

Detailed descriptions of UMA commands, flags, and configuration.

## Commands

### Chat mode (default)

Invoke UMA with no flags to enter interactive chat:

```bash
UMA [prompt...]
```

It will remember context for up to 60 seconds (configurable in `uma` script).

### --run, -r

Generate code-only scripts and execute them immediately.

```bash
UMA -r <natural language description>
```

Example:

```bash
UMA -r calculate factorial of 10
```

Generates a script (e.g., Python) that computes factorial(10), runs it, and prints the output.

### --write, -w

Generate code or text-only output, and save to a file.

```bash
UMA -w --ext <extension> <description>
```

Example:

```bash
UMA -w --ext sh create a Bash script that backs up /home on remote server
```

Saves the script to `backup_home.sh`.

### --ext

Specifies the file extension for `-w`.

### --update, -u

Self-update UMA scripts from the upstream GitHub repository.

```bash
UMA -u
```

## Environment Variables

- `OPENAI_API_KEY`: if set, overrides the API key in `config.py`.

## Configuration File

- `config.py` in the install directory contains:

```python
OPENAI_API_KEY = "..."
```

## Generating HTML Documentation

Install `pdoc` (see `docs/requirements.txt`):

```bash
pip install -r docs/requirements.txt
```

Generate HTML docs from the Python module docstrings:

```bash
pdoc --html uma --output-dir docs/html --force
```

Open `docs/html/uma/index.html` in your browser.