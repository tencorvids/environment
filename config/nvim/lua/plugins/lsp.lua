return {
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            local filetypes = { "bash", "c", "html", "lua", "luadoc",
                "vim", "vimdoc", "gdscript", "godot_resource", "gdshader" }
            require("nvim-treesitter").install(filetypes)
            vim.api.nvim_create_autocmd("FileType", {
                pattern = filetypes,
                callback = function() vim.treesitter.start() end,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
        },
        config = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- LSP keymappings
                    -- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                    -- map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                    map("<LEADER>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                    map("<LEADER>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
                    map("K", vim.lsp.buf.hover, "Hover Documentation")

                    -- Set up document highlight
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

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            local servers = {
                clangd = {
                    cmd = {
                        '/Users/rew/.espressif/tools/esp-clang/esp-19.1.2_20250312/esp-clang/bin/clangd',
                        '--query-driver=/Users/rew/.espressif/tools/riscv32-esp-elf/esp-14.2.0_20241119/riscv32-esp-elf/bin/riscv32-esp-elf-*,/Users/rew/.espressif/tools/xtensa-esp-elf/esp-14.2.0_20241119/xtensa-esp-elf/bin/xtensa-esp*-elf-*',
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                nixd = {},
                gopls = {},
                gdscript = {},
                emmet_language_server = {},
                ts_ls = {},
                tailwindcss = {},
            }

            -- Configure shared settings for all servers
            vim.lsp.config('*', {
                capabilities = capabilities,
            })

            -- Configure and enable each server
            for server, config in pairs(servers) do
                local lsp_config = {}
                if config.settings then
                    lsp_config.settings = config.settings
                end
                if config.cmd then
                    lsp_config.cmd = config.cmd
                end
                if next(lsp_config) then
                    vim.lsp.config(server, lsp_config)
                end
                vim.lsp.enable(server)
            end
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                lua = { "stylua" },
                nix = { "nixfmt-rfc-style" },
                go = { "gofmt" }
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<RETURN>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                }),
                sources = {
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer" },
                    -- { name = "supermaven" },
                },
            })
        end,
    },
}
