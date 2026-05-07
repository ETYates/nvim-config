require("config.lazy")

require("luasnip.loaders.from_vscode").lazy_load()

require("nvim-autopairs").setup({ enable_check_bracket_pairs = true,
                                  check_ts = true,
                                })

-- Lua
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
local git_blame = require('gitblame')

require('lualine').setup({
    sections = {
            lualine_c = {
                { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
            }
    }
})
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup.filetype({ "sql" }, {
    sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
    },
})


vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-/>', ':noh<CR>')

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.o.winborder = 'rounded'

vim.opt.cursorline = true
vim.opt.guicursor = "a:block"

vim.cmd.colorscheme "nord"
vim.wo.number = true
vim.wo.wrap = false
