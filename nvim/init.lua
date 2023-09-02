-- nvim/init.lua

-- As a part of migrating from 'packer' to 'lazy' plugin manager, settings in
-- 'nvim/after/plugin' will be slowly moved to 'nvim/lua/plugins'

require('core.options')
require('core.keymaps')
require('core.autocommands')
require('core.lazy_plugin_manager')
