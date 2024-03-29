-- Set up lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install a color scheme
require("lazy").setup({
    {
        "rebelot/kanagawa.nvim", -- Download Kanagawa color scheme
        config = function()
            vim.cmd.colorscheme("kanagawa-wave") -- Make the color scheme active after download
        end,
    },
    {
        "numToStr/Comment.nvim", -- For auto commenting
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
                auto_install = true, -- This will cause treesitter to automatically install a parser for files not explicitly listed above, e.g. python
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss", -- Starts smart selection
                        node_incremental = "<leader>si", -- Expands smart selection
                        scope_incremental = "<leader>sc", -- Expands smart selection to scope
                        node_decremental = "<leader>sd", -- Decreases smart selection
                    },
                },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                            -- You can also use captures from other query groups like `locals.scm`
                            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true or false
                        include_surrounding_whitespace = true,
                    },
                },
            })
        end,
    },
    {
        -- Treesitter for text objects, syntax highlighting
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
        -- Mason for auto LSP installs
        -- This MUST come before mson-lspconfig
        --
        -- https://github.com/williamboman/mason.nvim
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },
    {
        -- Mason LSP config
        -- This MUST come after mason and before lspconfig
        "williambowman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
            })
        end,
    },
    {
        -- LSP configs
        -- This MUST come after mason-lspconfig
        --
        -- https://github.com/neovim/nvim-lspconfig
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- A searchable list of LSPs for Mason can be found at https://mason-registry.dev/registry/list
            -- The following LSP names come from :LspInfo, the names are otherwise not obvious
            lspconfig.awk_ls.setup({}) -- LSP for awk
            lspconfig.clangd.setup({}) -- LSP for C
            lspconfig.pylsp.setup({}) -- LSP for Python
            lspconfig.bash_ls.setup({}) -- LSP for Bash
            lspconfig.spectral.setup({}) -- JSON and YAML linter
            lspconfig.quick_lint_js.setup({}) -- LSP for Javascript, faster than ESLint
        end,
    },
})

