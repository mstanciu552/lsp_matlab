local M = {}

M.add = function(params)
	local sum = 0

	if not params then
		return sum
	end

	for v in ipairs(params) do
		sum = sum + v
	end

	return sum
end

return M
