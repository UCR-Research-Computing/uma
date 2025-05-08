# UMA Quickstart

This quickstart guides you through installing UMA and running your first commands.

## Installation

Prerequisites:
- Python 3.6+ and pip or conda
- Git

1. Clone the repository:

   git clone https://github.com/UCR-Research-Computing/uma.git
   cd uma

2. Run the installer:

   ./install-uma.sh

This will create a Conda environment `uma`, install dependencies, and place executables in `~/bin` (or your chosen directory).

3. Ensure `~/bin` (or your install directory) is in your `PATH`.

## Configuration

UMA will prompt you for your OpenAI API key during installation and write it to `config.py`. You can also set the environment variable:

```bash
export OPENAI_API_KEY="sk-..."
```

## Basic Usage

1. Interactive chat:

   UMA

2. Generate and run a script:

   UMA -r print Hello, World

3. Generate a script and save to file:

   UMA -w --ext py create a Python script to compute Fibonacci numbers

4. Update UMA to the latest version:

   UMA -u

For detailed reference on all commands and options, see [UMA Reference](REFERENCE.md).