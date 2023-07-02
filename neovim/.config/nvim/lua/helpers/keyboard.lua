-- Alias for function, that set new keybindings
local map = vim.api.nvim_set_keymap 

-- Normal mode keybinding setter
function nm(key, command, descr) 
	map('n', key, command, vim.tbl_deep_extend("keep",descr or {}, {noremap = true }))
end

-- Input mode keybinding setter
function im(key, command, descr)
	map('i', key, command, vim.tbl_deep_extend("keep",descr or {}, {noremap = true }))
end

-- Visual mode keybinding setter
function vm(key, command, descr)
	map('v', key, command, vim.tbl_deep_extend("keep",descr or {}, {noremap = true }))
end

-- Terminal mode keybinding setter
function tm(key, command, descr)
	map('t', key, command, vim.tbl_deep_extend("keep",descr or {}, {noremap = true }))
end
