lua <<EOF
local lspconfig = require 'lspconfig'
lspconfig.tsserver.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

local navbuddy = require("nvim-navbuddy")

lspconfig.clangd.setup {
    on_attach = function(client, bufnr)
        navbuddy.attach(client, bufnr)
    end
}

local actions = require("nvim-navbuddy.actions")

navbuddy.setup {
    window = {
        border = "single",  -- "rounded", "double", "solid", "none"
                            -- or an array with eight chars building up the border in a clockwise fashion
                            -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
        size = "60%",
        position = "50%",
        sections = {
            left = {
                size = "20%",
                border = nil -- You can set border style for each section individually as well.
            },
            mid = {
                size = "40%",
                border = nil
            },
            right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil
            }
        }
    },
    icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "練",
        Interface     = "練",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = "◩ ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = "ﳠ ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
    },
    mappings = {
        ["<esc>"] = actions.close,        -- Close and cursor to original location
        ["q"] = actions.close,

        ["j"] = actions.next_sibling,     -- down
        ["k"] = actions.previous_sibling, -- up

        ["h"] = actions.parent,           -- Move to left panel
        ["l"] = actions.children,         -- Move to right panel

        ["v"] = actions.visual_name,      -- Visual selection of name
        ["V"] = actions.visual_scope,     -- Visual selection of scope

        ["y"] = actions.yank_name,        -- Yank the name to system clipboard "+
        ["Y"] = actions.yank_scope,       -- Yank the scope to system clipboard "+

        ["i"] = actions.insert_name,      -- Insert at start of name
        ["I"] = actions.insert_scope,     -- Insert at start of scope

        ["a"] = actions.append_name,      -- Insert at end of name
        ["A"] = actions.append_scope,     -- Insert at end of scope

        ["r"] = actions.rename,           -- Rename currently focused symbol

        ["d"] = actions.delete,           -- Delete scope

        ["f"] = actions.fold_create,      -- Create fold of current scope
        ["F"] = actions.fold_delete,      -- Delete fold of current scope

        ["c"] = actions.comment,          -- Comment out current scope

        ["<enter>"] = actions.select,     -- Goto selected symbol
        ["o"] = actions.select,
    },
    lsp = {
        auto_attach = true,  -- If set to true, you don't need to manually use attach function
        preference = nil      -- list of lsp server names in order of preference
    },
    source_buffer = {
        follow_node = true,   -- Keep the current node in focus on the source buffer
        highlight = true      -- Highlight the currently focused node
    }
}
EOF


