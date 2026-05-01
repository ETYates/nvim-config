require("config.lazy")

require("nvim-autopairs").setup({ enable_check_bracket_pairs = true,
                                  check_ts = true,
                                })
local autopairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

autopairs.add_rules({
  -- Pair $ for inline math, but only in tex/latex files
  Rule("$", "$", {"tex", "latex", "markdown"})
    -- Don't add a pair if the next character is already a $
    :with_pair(cond.not_after_regex("$"))
    -- Don't add a pair if the previous character is a \ (escaped $)
    :with_pair(cond.not_before_regex("\\", 1)),
  -- Pair $$ for display math
  Rule("$$", "$$", "tex")
    :with_pair(cond.not_after_regex("$$")),
})

autopairs.add_rule(Rule('<', '>', 'html'))

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text)',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
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

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<C-/>', ':noh<CR>')

vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.o.winborder = 'rounded'

vim.opt.cursorline = true
vim.opt.guicursor = "a:block"
vim.opt.mouse = ""

vim.cmd.colorscheme "nord"
vim.wo.number = true
vim.wo.wrap = false
