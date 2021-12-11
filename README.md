# Bloated Neovim with lua

```
git clone git@github.com:EdwardKerckhof/nvim.git ~/.config/nvim
```

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

Fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

- On Arch Linux

  ```
  sudo pacman -S xsel
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```
  pip install pynvim
  ```

- Neovim node support

  ```
  npm i -g neovim
  ```

