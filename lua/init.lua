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


local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = {
                command = "clippy",
            },
        },
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
    } } } }
)

-- local hint = vim.lsp.inlay_hint.get({ bufnr = 0 })[1] -- 0 for current buffer
-- local client = vim.lsp.get_client_by_id(hint.client_id)
-- local resp = client:request_sync('inlayHint/resolve', hint.inlay_hint, 100, 0)
-- local resolved_hint = assert(resp and resp.result, resp.err)
-- vim.lsp.util.apply_text_edits(resolved_hint.textEdits, 0, client.encoding)
-- location = resolved_hint.label[1].location
-- client:request('textDocument/hover', {
--   textDocument = { uri = location.uri },
--   position = location.range.start,
-- })


vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })
vim.lsp.inlay_hint.enable(true)
-- vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

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


local cmp = require'cmp'

cmp.setup {
  mapping = {
    -- <CR> just makes a newline unless you've *manually* selected an item
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- optional: explicit accept with Tab or Ctrl-Y
    ['<Ctrl>+Y'] = cmp.mapping.confirm({ select = true }),
  },
}
