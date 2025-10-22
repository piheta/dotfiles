require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

---- Setup LSP keybindings when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- Document highlight on cursor hold
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})
