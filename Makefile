
run: lua/lsp_matlab/init.lua
	nvim --headless -c 'set rtp+=./' -c 'lua require("lsp_matlab").start()'

test_rpc: lua/lsp_matlab/methods.lua
	nvim --headless -c 'set rtp+=./' -c 'PlenaryBustedFile test/basic_rpc.lua'

test_dir: lua/lsp_matlab/methods.lua
	nvim --headless -c 'set rtp+=./' -c 'PlenaryBustedDirectory test'
