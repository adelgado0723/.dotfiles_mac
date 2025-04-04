# Dotfiles

My personal configuration files for various tools and applications. This repository contains my setup for:

- Shell configuration (zsh)
- Neovim configuration
- Window manager configurations (i3, qtile)
- Various application configurations
- Development environment setup

## Features

- Neovim setup with LSP support, debugging, and various plugins
- Zsh configuration with oh-my-zsh and custom plugins
- Window manager configurations for both i3 and qtile
- Various development tools and utilities
- Custom scripts and aliases for productivity

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
```

2. Create necessary directories:
```bash
mkdir -p ~/.config
```

3. Create symlinks for configuration files:
```bash
# For zsh
ln -s ~/dotfiles/.zshrc ~/.zshrc

# For neovim
ln -s ~/dotfiles/.config/nvim ~/.config/nvim

# For other configurations
ln -s ~/dotfiles/.config/* ~/.config/
```

4. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your personal settings
```

## Required Dependencies

- Neovim
- Zsh
- Oh My Zsh
- Various development tools (Node.js, Python, Go, etc.)
- Window manager (i3 or qtile)

## Environment Variables

Create a `.env` file in your home directory with the following variables:
```
GITHUB_USER=your-email@example.com
AWS_PROFILE=default
JAVA_HOME=/path/to/java/home
# Add other environment variables as needed
