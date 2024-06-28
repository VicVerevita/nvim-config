vim.diagnostic.config({ virtual_text = false })
vim.keymap.set("n", "<leader>d", require("lsp_lines").toggle, { desc = "Inline Diagnostics" })

