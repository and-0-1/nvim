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

### Install nvim latest (optional)

```sh
cd ~/.config/nvim
./install_neovim.sh
```

### Run `nvim`

Run `nvim` and wait for the plugins to be installed

**NOTE:** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

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

- [codicon](https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf)
- [An emoji font](https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf)

After moving fonts to `~/.local/share/fonts/`

Run: `$ fc-cache -f -v`

**NOTE:** (If you are seeing boxes without icons, try changing this line from `false` to `true`: [link](https://github.com/ChristianChiarulli/nvim/blob/ac41efa237caf3a498077df19a3f31ca4b35caf3/lua/user/icons.lua#L5))

<!-- ## Java Debugging and Testing -->
<!---->
<!-- ``` -->
<!-- git clone git@github.com:microsoft/java-debug.git -->
<!-- cd java-debug/ -->
<!-- ./mvnw clean install -->
<!-- ``` -->
<!---->
<!-- ``` -->
<!-- git clone git@github.com:microsoft/vscode-java-test.git -->
<!-- cd vscode-java-test -->
<!-- npm install -->
<!-- npm run build-plugin -->
<!-- ``` -->
