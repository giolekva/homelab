# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Nix Home Manager configuration for a macOS development environment. Each tool gets its own `.nix` module file at the repo root, imported by `default.nix`.

## Commands

```bash
home-manager switch   # (alias: hms) Apply configuration changes
home-manager build    # (alias: hmb) Build without applying (dry run)
```

After editing any `.nix` file, run `hms` to apply.

## Architecture

- `default.nix` — Entry point; imports all modules and NUR (for `rycee.hmModules.emacs-init`)
- `.config/home.nix` — Home Manager user config; imports this repo via `~/dev/src/homelab`
- `.config/config.nix` — Nix package overrides (NUR)
- `install.sh` — Bootstrap script for fresh machines (installs Nix, Home Manager, symlinks configs)
- `programs.nix` — CLI packages list
- `bash.nix` — Shell aliases, env vars, direnv hook
- `tmux.nix` — Tmux config (prefix: C-t, emacs keybindings)
- `emacs.nix` — Emacs config using NUR's declarative `emacs-init` module (tree-sitter, eglot for Go, lsp-mode for TS/JS)
- `alacritty.nix` — Terminal config (Berkeley Mono, zenburn theme)

## Design Philosophy

Simple tools that do one thing well. Prefer minimal, focused solutions over complex all-in-one tools. Each config module is a single file — no nested directories or abstractions.

## Conventions

- One `.nix` file per tool at the repo root; add new imports to `default.nix`
- Bash is the shell (not zsh/fish)
- Emacs is the primary editor, run in terminal mode (`emacs -nw`, aliased to `e`)
- Zenburn theme is used everywhere (Emacs, Alacritty)
- Go uses eglot; TypeScript/JS uses lsp-mode — these are separate LSP stacks
- NUR's `emacs-init` module manages Emacs packages declaratively via `usePackage` attrset
