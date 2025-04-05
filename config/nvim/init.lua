-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add = MiniDeps.add
--
-- LSP
add({
    source = 'neovim/nvim-lspconfig',
})
require'lspconfig'.lua_ls.setup{}
require'lspconfig'.clangd.setup{}
require'lspconfig'.zls.setup{}
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            -- Triggers autocomplete on every keypress. Delete if slow
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.o.completeopt = "menu,menuone,noinsert,noselect,popup,fuzzy"
vim.o.pumheight = 10

-- local servers = { "lua-language-server", "clangd", "zls" }
-- for _, server in ipairs(servers) do
--   vim.lsp.enable(server)
-- end

vim.diagnostic.config({ virtual_text = true })
vim.keymap.set({'n'}, '<leader>gd', function() vim.lsp.buf.definition() end, {buffer = true})
-- vim.keymap.set({'i'}, '<Tab>', "pumvisible() ? '<c-n>' : '<tab>'", {expr = true})
-- vim.keymap.set({'i'}, '<s-tab>', "pumvisible() ? '<c-p>' : '<s-tab>'", {expr = true})
-- vim.keymap.set({'i'}, '<cr>', "pumvisible() ? '<c-y>' : '<cr>'", {expr = true})

add({
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})
-- Possible to immediately execute code which depends on the added plugin
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'vimdoc', 'python', 'zig', 'c' },
    highlight = { enable = true },
})

add({
    source = 'ThePrimeagen/harpoon',
    checkout = 'harpoon2',
    depends = {
        'nvim-lua/plenary.nvim'
    },
})
local harpoon = require("harpoon")
-- REQUIRED
harpoon:setup()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.smartindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

vim.o.hlsearch = false

vim.opt.guicursor = ''
vim.opt.mouse = ''

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 4

vim.o.ignorecase = true
vim.o.smartcase = true

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Clipboard with leader
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+Y')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d')
vim.keymap.set({ 'n', 'v' }, '<leader>D', '"+D')

-- Reselect visual selection after changing indent level
vim.keymap.set('v', '<', '<gv', { silent = true })
vim.keymap.set('v', '>', '>gv', { silent = true })

vim.keymap.set('n', '<leader>ha', function () harpoon:list():add() end)
vim.keymap.set('n', '<leader>hl', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set({'n', 'i'}, '<C-j>', function () harpoon:list():select(1) end)
vim.keymap.set({'n', 'i'}, '<C-k>', function () harpoon:list():select(2) end)
vim.keymap.set({'n', 'i'}, '<C-l>', function () harpoon:list():select(3) end)
vim.keymap.set({'n', 'i'}, '<C-h>', function () harpoon:list():select(4) end)

if vim.o.wrap then
  vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
  vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
end

-- Visual
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn='80'

add({
    source = "rose-pine/neovim"
})
vim.cmd("colorscheme rose-pine")
vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

