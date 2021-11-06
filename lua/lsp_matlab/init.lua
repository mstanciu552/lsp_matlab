local M = {}
local utils = require("lsp_matlab.utils")
local rpc = require("lsp_matlab.rpc")

-- @Info Main function
M.start = function()
	print("Server running\n")

	-- @Info Handle stdin and stdout
	-- while true do
	-- 	local res = io.read("*l")
	-- 	if not res then
	-- 		break
	-- 	end
	-- 	io.write(res)
	-- end
	-- @TEST
	print(rpc.handle_request(utils.send_request("add", { 1, 2, 3 }, 1)))

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
end

return M
