local utils = {}

utils.print_table = function(input)
	print("Key\tValue")
	for k, v in pairs(input) do
		print(string.format("%s\t%s", k, v))
	end
end

utils.json_encode = function(payload)
	local ok, encoded = pcall(vim.fn.json_encode, payload)
	if ok then
		return encoded
	else
		return nil, encoded
	end
end

utils.json_decode = function(payload)
	local ok, decoded = pcall(vim.fn.json_decode, payload)
	if ok then
		return decoded
	else
		return nil, decoded
	end
end

return utils
