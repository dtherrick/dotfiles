#!/bin/bash
# Symlink Claude Code user config
mkdir -p ~/.claude
ln -sf $DOTFILES_PATH/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf $DOTFILES_PATH/.claude/.credentials.json ~/.claude/.credentials.json
ln -sf $DOTFILES_PATH/.claude/gsd-file-manifest.json ~/.claude/gsd-file-manifest.json
ln -sf $DOTFILES_PATH/.claude/statusline-command.sh ~/.claude/statusline-command.sh
ln -sf $DOTFILES_PATH/.claude/commands ~/.claude/commands
ln -sf $DOTFILES_PATH/.claude/commands ~/.claude/agents
ln -sf $DOTFILES_PATH/.claude/commands ~/.claude/get-shit-done
ln -sf $DOTFILES_PATH/.claude/commands ~/.claude/hooks
ln -sf $DOTFILES_PATH/.claude/commands ~/.claude/skills

# Install Playwright browsers using the version already in frontend/package.json
cd frontend && npx playwright install --with-deps chromium && cd ..

