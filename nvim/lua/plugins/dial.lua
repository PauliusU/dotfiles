return {
    "monaqa/dial.nvim",
    desc = "Increment and decrement numbers, dates and more. Also toggle booleans and pre-defined values.",
    keys = {
        { '<C-a>',  '<Plug>(dial-increment)',  mode = { 'n', 'v' }, remap = true },
        { '<C-x>',  '<Plug>(dial-decrement)',  mode = { 'n', 'v' }, remap = true },
        { 'g<C-a>', 'g<Plug>(dial-increment)', mode = { 'n', 'v' }, remap = true },
        { 'g<C-x>', 'g<Plug>(dial-decrement)', mode = { 'n', 'v' }, remap = true },
    },
    config = function()
        local augend = require('dial.augend')

        local function add_constant(elements)
            return augend.constant.new {
                elements = elements,
                cyclic = true,
                word = true
            }
        end

        require('dial.config').augends:register_group {
            default = {
                augend.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
                augend.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
                augend.integer.alias.binary,   -- augend.date.alias['%Y/%m/%d'],
                augend.date.alias['%Y-%m-%d'], -- date (2024-08-29, etc.)
                -- augend.date.alias['%H:%M'],
                augend.constant.alias.bool,    -- boolean value (true <-> false)
                add_constant({ 'TRUE', 'FALSE' }),
                add_constant({ 'enable', 'disable' }),
                add_constant({ '&&', '||' }),
                add_constant({ 'and', 'or' }),
                add_constant({ 'on', 'off' }),
                add_constant({ 'private', 'public' }),
                add_constant({ 'left', 'right' }),
                add_constant({
                    'zero', 'one', 'two', 'three', 'four', 'five', 'six',
                    'seven', 'eight', 'nine', 'ten', 'eleven', 'twelve'
                }),
                add_constant({
                    'Zero', 'One', 'Two', 'Three', 'Four', 'Five', 'Six',
                    'seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve'
                }),
                add_constant({
                    'first', 'second', 'third', 'fourth', 'fifth', 'sixth',
                    'seventh', 'eighth', 'ninth', 'tenth', 'eleventh', 'twelveth'
                }),
                augend.misc.alias.markdown_header, -- markdown header level # <-> ##
            }
        }
    end
}
