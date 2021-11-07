local errors = require("lsp_matlab.error").defined_errors

local M = {}

M["add"] = function(params)
	local sum = 0

	if not params or type(params) ~= "table" then
		return errors.Invalid_params, nil
	end

	for _, v in ipairs(params) do
		sum = sum + v
	end

	return nil, sum
end

return M
