return {
    -- {
    --     "oskarnurm/koda.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("koda").setup({ transparent = true })
    --         vim.cmd("colorscheme koda")
    --     end,
    -- },
    {
        "scottmckendry/cyberdream.nvim",
        name = "cyberdream",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                transparent = true
            })
            vim.cmd("colorscheme cyberdream")
        end
    },
    {
        "numToStr/Comment.nvim",
        enabled = true,
        opts = {},
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},

        vim.keymap.set("n", "<LEADER>xx", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Toggle trouble list" }),
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,   desc = "Flash" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        }
        ,
    },
    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
            })
        end,

        vim.keymap.set("n", "<LEADER>;", "<CMD>Oil<CR>", { desc = "Trigger Oil" }),
    }
}
