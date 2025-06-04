-- https://github.com/kyazdani42/nvim-tree.lua
-- local nvim_tree = require'nvim-tree'
local status, nvim_tree = pcall(require, "nvim-tree")
if not status then
  vim.notify("没有找到 nvim-tree")
  return
end

local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  local map = vim.keymap.set


  map('n', 'CR', api.node.open.edit, opts("Open"))
  map('n', 'v',  api.node.open.edit, opts("Open: Vertical Split"))
  map('n', 'h',  api.node.open.edit, opts("Open: Horizontal Split"))

  map('n', 'R',  api.tree.reload, opts("Refresh"))

  map('n', 'a', api.fs.create, opts("Create File or Directory"))
  map('n', 'd', api.fs.create, opts("Delete"))
  map('n', 'r', api.fs.create, opts("Rename"))
  map('n', 'c', api.fs.copy.node, opts("Copy"))
  map('n', 'p', api.fs.paste, opts("Paste"))

  map('n', '<C-j>', api.tree.change_root_to_parent, opts("Up"))
  map('n', '?', api.tree.toggle_help, opts('Help'))
end

-- 列表操作快捷键
local list_keys = require("keybindings").nvimTreeList

nvim_tree.setup({
--  on_attach = on_attach,
  -- 不显示 git 状态图标
  git = {
    enable = true,
    ignore = true,
  },
  -- project plugin 需要这样设置
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  -- 隐藏 .文件 和 node_modules 文件夹
  filters = {
    dotfiles = true,
    custom = { "node_modules" },
  },
  view = {
    -- 宽度
    width = 36,
    -- 也可以 'right'
    side = "left",
    -- 不显示行数
    number = true,
    relativenumber = false,
    -- 显示图标
    signcolumn = "yes",
  },
  actions = {
    open_file = {
      -- 首次打开大小适配
      resize_window = true,
      -- 打开文件时关闭 tree
      quit_on_open = false,
    },
  },
  -- wsl install -g wsl-open
  -- https://github.com/4U6U57/wsl-open/
  system_open = {
    -- mac
    cmd = "open",
    -- windows
    -- cmd = "wsl-open",
  },
})
