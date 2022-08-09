# Neovim personal config

## neovim pre-requisites

Install pre-requisites through brew or otherwise

Brew

```sh
brew install ninja libtool automake cmake pkg-config gettext
```

## Try out this config

Make sure to remove or move your current `nvim` directory

```sh
git clone git@github.com:andoni0305/nvim.git ~/.config/nvim
```

### Install nvim latest 

Follow build instructions from neovim GitHub's site

### Run `nvim`

Run `nvim` and wait for the plugins to be installed

**NOTE:** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been set up

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```

## Fonts

- [A nerd font](https://github.com/ryanoasis/nerd-fonts)
