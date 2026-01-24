local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
require("telescope").load_extension('harpoon')

-- TELESCOPE
vim.keymap.set("n", "ff", function() require('telescope.builtin').find_files() end)
vim.keymap.set("n", "fg", function() require('telescope.builtin').live_grep() end)
vim.keymap.set("n", "fb", function() require('telescope.builtin').buffers() end)
vim.keymap.set("n", "fh", function() require('telescope.builtin').help_tags() end)

vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {
			files = { watcher = "server" },
			cargo = { targetDir = true },
			check = { command = "clippy" },
			inlayHints = {
				bindingModeHints = { enabled = true },
				closureCaptureHints = { enabled = true },
				closureReturnTypeHints = { enable = "always" },
				maxLength = 100,
			},
            diagnostics = { enable = true },
			rustc = { source = "discover" },
			completion = {
                autoimport = {
                    enable = false, -- Try disabling auto-import
                },
            },
		},
	},
	-- root_dir = require('lspconfig.util').root_pattern("Cargo.toml", ".git"),

	root_markers = { { "Config.toml" }, ".git" },
})

local cmp = require('cmp')
cmp.setup({
	-- completion = {
	-- 	autocomplete = false,
	-- },
    -- sources = cmp.config.sources({
    --     { name = 'nvim_lsp' },
    --     { name = 'buffer' },
    -- }),
    -- mapping = cmp.mapping.preset.insert({
    --     ['<C-e>'] = cmp.mapping.abort(), -- Close completion menu
    --     ['<CR>'] = cmp.mapping.confirm({ select = false }),
    --     ['<Tab>'] = cmp.mapping.select_next_item(),
    --     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- }),
    -- completion = {
    --     completeopt = 'menu,menuone,noselect', -- Don't auto-select
    -- },
	preselect = cmp.PreselectMode.None, -- Don't preselect any item
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(), -- Explicitly close the menu
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Only confirm if you've explicitly selected something
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }),
})

-- require'cmp'.setup({
--   -- other settings...
--   completion = {
--     autocomplete = false,
--   },
-- })

-- vim.lsp.config('rust_analyzer', {
--     settings = {
--         ["rust-analyzer"] = {
--             cargo = { allFeatures = true },
--             checkOnSave = { command = "clippy" },
--             diagnostics = { enable = true },
--         }
--     }
-- })



-- inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

vim.keymap.set('n', '<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = 'Toggle inlay hints' })






vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local tb = require('telescope.builtin')
--
function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end
-- LiveGrep
keymap('n', '<space>g', ':Telescope current_buffer_fuzzy_find<cr>', opts)
keymap('n', '<space>G', ':Telescope live_grep<cr>', opts)
keymap('v', '<space>g', function()
	local text = vim.getVisualSelection()
	tb.current_buffer_fuzzy_find({ default_text = text })
end, opts)
keymap('v', '<space>G', function()
	local text = vim.getVisualSelection()
	tb.live_grep({ default_text = text })
end, opts)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

