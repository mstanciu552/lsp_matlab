-- @Docs https://neovim.io/doc/user/lsp.html
local M = {}
local utils = require("lsp_matlab.utils")
local rpc = require("lsp_matlab.rpc")
local log = require("lsp_matlab.log")

-- @Info Main function
M.start = function()
	print("Server running\n")
	local Shutdown = false

	-- @Info Handle stdin and stdout
	-- while not Shutdown do
	-- 	local block = io.read("*l")
	-- 	if not block then
	-- 		break
	-- 	end
	-- 	rpc.handle_input(block)
	-- end
	-- @TEST
	log(rpc.handle_request(utils.send_request("add", { 1, 2, 4 }, 1)))

	os.exit(0)
end

-- @Optional
-- @Info Check if user provided settings or not
M.setup = function(opts)
	if opts then
		M.defaults = opts
	else
		M.defaults = require("lsp_matlab.defaults")
	end
	M.start()
end

return M
