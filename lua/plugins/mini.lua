return {
    'nvim-mini/mini.nvim',
    version = '*',
    config = function()
        require('mini.ai').setup { n_lines = 500 }
        require('mini.surround').setup()
        require("mini.pairs").setup()
        local statusline = require 'mini.statusline'
        statusline.setup()

        --@diagnostic disable-next-line
        statusline.section_location = function()
            return ''
        end

    end,
}
