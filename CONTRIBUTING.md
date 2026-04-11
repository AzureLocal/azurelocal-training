# Contributing

Thank you for your interest in contributing to the Azure Local Training project.

## Before You Start

- Read the [README](README.md) for an overview of the project
- Check open issues and pull requests to avoid duplicate work

## Making Changes

1. Fork the repository
2. Create a branch: `git checkout -b feat/your-feature`
3. Make your changes
4. Commit using [Conventional Commits](https://www.conventionalcommits.org/): `feat:`, `fix:`, `docs:`, etc.
5. Open a pull request against `main`

## Documentation

Documentation lives in the `docs/` directory and is built with MkDocs Material.

To preview locally:

```bash
pip install mkdocs-material
mkdocs serve
```

## Working Independently

This repository can be used as a standalone project without the parent multi-root workspace.

### Open Only This Repository

1. Open VS Code
2. File > Open Workspace from File > select `azurelocal-training.code-workspace`
3. All recommended extensions will be prompted for installation

### Prerequisites

- Python 3.x and pip (for MkDocs documentation)
- [MkDocs Material](https://squidfunk.github.io/mkdocs-material/): `pip install mkdocs-material`

### Run Documentation Locally

```bash
mkdocs serve
```

Browse to <http://127.0.0.1:8000>

### Build Documentation

```bash
mkdocs build
```
