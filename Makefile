
run: lua/lsp_matlab/init.lua
	nvim --headless -c 'set rtp+=./' -c 'lua require("lsp_matlab").start()'
