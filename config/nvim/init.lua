vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

add("leath-dub/snipe.nvim")
local snipe = require("snipe")
snipe.setup({ ui = { position = "center" } })
vim.keymap.set("n", "<leader>b", snipe.open_buffer_menu)
snipe.ui_select_menu = require("snipe.menu"):new { position = "center" }
snipe.ui_select_menu:add_new_buffer_callback(function (m)
  vim.keymap.set("n", "<esc>", function ()
    m:close()
  end, { nowait = true, buffer = m.buf })
end)
vim.ui.select = snipe.ui_select;

-- LSP
-- add({
--     source = 'neovim/nvim-lspconfig',
-- })
-- require'lspconfig'.lua_ls.setup{}
-- require'lspconfig'.clangd.setup{}
-- require'lspconfig'.zls.setup{}
--
-- add({source = 'echasnovski/mini.completion' })
-- require('mini.completion').setup({ lsp_completion = { auto_setup = false } })
-- require('mini.completion').setup()

-- use a release tag to download pre-built binaries
add({
  source = "saghen/blink.cmp",
  depends = { "rafamadriz/friendly-snippets" },
  checkout = "v1.3.1", -- check releases for latest tag
})
require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
        -- menu = { autoshow = true },
        list = { selection = { preselect = false } },
    },
    signature = { enabled = true }
})

vim.o.completeopt = "menu,menuone,noinsert,noselect,popup,fuzzy,preview"
vim.o.pumheight = 10
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        vim.keymap.set({'n'}, 'gd', function() vim.lsp.buf.definition() end, {})
        vim.keymap.set({'n'}, '<leader>rn', function() vim.lsp.buf.rename() end, {})
        vim.keymap.set({'n'}, '<leader>ca', function() vim.lsp.buf.code_action() end, {})

--      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--      if client:supports_method('textDocument/completion') then
--          -- Triggers autocomplete on every keypress. Delete if slow
--          local chars = {};
--          for i = 65, 122 do table.insert(chars, string.char(i)) end
--          client.server_capabilities.completionProvider.triggerCharacters = {'.', '(', unpack(chars)}

--          vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--          -- vim.keymap.set({'i'}, '<Tab>', "pumvisible() ? '<c-n>' : '<tab>'", {expr = true})
--          -- vim.keymap.set({'i'}, '<s-tab>', "pumvisible() ? '<c-p>' : '<s-tab>'", {expr = true})
--          -- vim.keymap.set({'i'}, '<cr>', "pumvisible() ? '<c-y>' : '<cr>'", {expr = true})
--      end

    end,
})
vim.keymap.set({'i'}, '<C-f>', '<C-x><C-f>',  {})

local servers = { "luals", "clangd", "zls", "pyls", "php", "tsls", "hls" }
for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

local diag_config1 = { virtual_text = true, virtual_lines = false, }
local diag_config2 = { virtual_text = false, virtual_lines = true, }

vim.diagnostic.config(diag_config1)
local diag_config_basic = false
vim.keymap.set("n", "gK", function()
  diag_config_basic = not diag_config_basic
  if diag_config_basic then
    vim.diagnostic.config(diag_config2)
  else
    vim.diagnostic.config(diag_config1)
  end
end, { desc = "Toggle diagnostic virtual_lines" })

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
    ensure_installed = { 'lua', 'vimdoc', 'python', 'haskell', 'c' },
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

vim.o.smartindent = true
vim.o.shiftround = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

local markup_patterns = { "tex", "latex", "markdown" }
vim.api.nvim_create_autocmd("FileType", {
    pattern = markup_patterns,
    callback = function()
        vim.o.smartindent = false
        vim.o.wrap = true
        vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
        vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
    end,
})

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
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"+y$')
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

-- Double escape to exit terminal mode
vim.keymap.set("t", "<esc>", (function()
    local timer = assert(vim.uv.new_timer())
    return function()
        if timer:is_active() then
            timer:stop()
            vim.cmd("stopinsert")
        else
            timer:start(200, 0, function() end)
            return "<esc>"
        end
    end
end)(), {})

-- Set j,k to move by virtual lines when wrap is set
vim.api.nvim_create_autocmd('OptionSet', {
    callback = function(_)
        if vim.o.wrap then
            vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { expr = true })
            vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { expr = true })
        end
    end,
})

-- Visual
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.colorcolumn='80'

add({
    source = "WillowShrub/nvim-piper-tts"
})
require('nvim-piper-tts').setup({
    path = "$HOME/.local/voice/mv2.onnx",
    voice_number = 11,
})
vim.keymap.set("n", "<leader>t", function() require('nvim-piper-tts').create_or_toggle() end, {})

add({
    source = "miikanissi/modus-themes.nvim"
})
vim.cmd("colorscheme modus")

-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
