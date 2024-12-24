require("theprimeagen.set")
require("theprimeagen.remap")
require("theprimeagen.lazy_init")

vim.diagnostic.reset()

-- DO.not
-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
-- DO.not

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup('ThePrimeagen', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

ColorMyPencils();

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = ThePrimeagenGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('LspAttach', {
    group = ThePrimeagenGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

--local M = {}

-- M.start = function()
--  vim.lsp.set_log_level 'debug'
--  require('vim.lsp.log').set_format_func(vim.inspect)
--
--  local client, err = vim.lsp.start {
--    name = 'surrealql-lsp-server',
--    cmd = { 'surrealql-lsp-server' },  -- No need for full path now
--  }
--
--  if not client then
--    vim.notify('Failed to start surrealql-lsp-server: ' .. tostring(err), vim.log.levels.ERROR)
--    return
--  end
--
--  vim.lsp.buf_attach_client(0, client)
--end
--
--local group = vim.api.nvim_create_namespace 'surrealql-lsp-server'
--
--M.setup = function()
--  vim.api.nvim_clear_autocmds { group = group }
--
--  vim.api.nvim_create_autocmd('FileType', {
--    group = group,
--    pattern = 'surql',
--    callback = M.start,
--  })
--end
--
--M.setup()
--M.start()
