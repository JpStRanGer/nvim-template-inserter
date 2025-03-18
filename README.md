
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

---

## ⌨️  Usage
1. Open a new empty file: :enew
1. Press <leader>tt (or your configured key)
1. Select a template (e.g. html, cpp)
1. Voilà! Template inserted 🎉

---

## 🧩 Included Templates
- html
- css
- cpp
- arduino
- cmake
- Qt 
- Each template is defined as a Lua module returning a table of lines. Example: html.lua


## 🏠 🛠️ Custom User Templates
Put your own templates in:

```bash
~/.config/nvim/templates/
```
Each file will appear in the template picker. The filename (without extension) is used as the template name and sets the filetype.

Example:

```bash
~/.config/nvim/templates/python.txt
```
Will insert the content and set filetype=python.

And the plugin will automatically discover and load them!
---

## 🔍 Live Preview
When browsing templates, a preview window shows the full content of the template before insertion — for both built-in and user-defined templates.

---

## 💡 Ideas for Future
- Filetype-based auto template suggestion
- Integration with snippet engines (like LuaSnip)

---

## 📄 License
MIT © JpStRanGer
