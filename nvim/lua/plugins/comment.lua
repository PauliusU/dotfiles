-- Comments, "gc" to comment visual regions/lines
return {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
