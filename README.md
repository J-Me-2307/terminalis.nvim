# terminalis.nvim
A small neovim plugin for working with the integrated terminal.

## About
Terminalis is a small [Neovim](https://neovim.io/) plugin for opening/closing the integrated terminal.

## Installation

### Packer
```lua
use 'J-Me-2307/terminalis.nvim'
```

### Plug
```lua
Plug 'J-Me-2307/terminalis.nvim'
```

### Lazy
```lua
{
    "J-Me-2307/terminalis.nvim",
    config = function ()
        require("terminalis").setup()
    end
}
```

## Configuration
Here are the default options for the plugin

```lua
opts = {
    keymap = {
    show = "<C-t>",
    hide = "<C-t>",
    },
    apperance = {
        height = math.floor(vim.o.lines / 4),
    },
}

```
