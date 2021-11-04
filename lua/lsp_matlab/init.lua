local M = {}

M.setup = function(opts)
	if opts then
		M.defaults = opts
	else
		M.defaults = require("lsp_matlab.defaults")
	end
end

return M
