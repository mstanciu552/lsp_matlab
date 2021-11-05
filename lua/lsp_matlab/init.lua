local M = {}
local utils = require("lsp_matlab.utils")

-- @Info Main function
M.start = function()
	print("Server running")

	-- @Info Handle stdin and stdout
	while true do
		local res = io.read("*l")
		if not res then
			break
		end
		io.write(res)
	end

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
