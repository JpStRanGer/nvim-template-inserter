
# 🚀 nvim-template-inserter

A simple and elegant Neovim plugin that lets you insert code templates into an **empty buffer** using a **Telescope-powered picker**. Perfect for quickly bootstrapping new files in HTML, CSS, C++, Arduino, and CMake.

---

## 📦 Features

- 🌟 Trigger only when the buffer is empty
- 🔭 Uses [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for fuzzy template selection
- ⚡ Fast and non-blocking
- ✍️ Easily extendable with your own templates
- 🧠 Designed to fit naturally into your existing workflow

---

## 📸 Demo

![Demo GIF](https://user-images.githubusercontent.com/your-gif-demo.gif)
*Press `<leader>tt` to pick and insert a template into an empty buffer.*

---

## 📥 Installation (with `lazy.nvim`)

```lua
{
  "JpStRanGer/nvim-template-inserter",
  config = function()
    require("template_inserter").setup({
      keymap = "<leader>tt" -- You can customize the keybind
    })
  end,
  dependencies = { "nvim-telescope/telescope.nvim" },
  lazy = false,
}
```
## ⌨️  Usage
1. Open a new empty file: :enew
1. Press <leader>tt (or your configured key)
1. Select a template (e.g. html, cpp)
1. Voilà! Template inserted 🎉

## 🧩 Included Templates
- html
- css
- cpp
- arduino
- cmake
- Each template is defined as a Lua module returning a table of lines. Example: html.lua

## 🛠️ Custom Templates (coming soon)
Want to use your own templates? Soon you’ll be able to place them in a directory like:

```ruby
~/.config/nvim/templates/
```
And the plugin will automatically discover and load them!

## 💡 Ideas for Future
- Filetype-based auto template suggestion
- Template preview in Telescope
- External/custom template path support
- Integration with snippet engines (like LuaSnip)

## 📄 License
MIT © JpStRanGer
