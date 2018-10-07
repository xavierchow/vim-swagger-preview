Vim Swagger Preview
====================

- [Intro](#intro)
- [Installation](#installation)
- [Usage](#usage)
- [License](#licnese)

Intro
-----
[Swagger Editor](https://swagger.io/tools/swagger-editor/) is fancy, but my favorite editor is vim, and all my code is in vim,
I don't like to copy & paste the yaml between the swagger-editor and vim.
That's why I built this plugin; you can edit your yaml OpenAPI spec in vim and preview the result in Chrome.

Installation
------------
### Prerequisite
* Chrome
* docker
* `cat .zshenv >> ~/.zshenv`
  * Notes:
    * `.zshrc` doesn't work because shell script from vim is not interactive shell.
    * you can put the script above to other shell if you don't use zsh.
* make sure port `8017` is availabe to listen on, of course you can change it [here](https://github.com/xavierchow/vim-swagger-preview/blob/b63ff606135c3a5239936ef21307f3ad1de22e40/.zshenv#L18). 

### Plugin

* With [Pathogen](https://github.com/tpope/vim-pathogen): Place `vim-swagger-preview/` in `.vim/bundle/`.
* With [Vundle](https://github.com/VundleVim/Vundle.vim):
    * Add `Plugin 'xavierchow/vim-swagger-preview'` to your `.vimrc`.
    * Launch `vim` and run `:PluginInstall`
* With [vim-plug](https://github.com/junegunn/vim-plug):
    * Setup with [vim-plug guide](https://github.com/junegunn/vim-plug#usage)
    * Add `Plug 'xavierchow/vim-swagger-preview'` to your `.vimrc`.

Usage
-----
### File extension
This plugin only applies to yaml file with the OpenAPI spec.

### Keymap for preview
The default keymap is `<leader>e`, it brings up a browser window and shows the swagger-ui.
You can also define your keymap in vimrc.
```
nmap <unique> <leader>e <Plug>GenerateDiagram 
```
*Notes: Why I named it as `GenerateDiagram` is that I'd like to reuse the same mapping as [vim-sequence-diagram](https://github.com/xavierchow/vim-sequence-diagram).*

License
-----------------

MIT

