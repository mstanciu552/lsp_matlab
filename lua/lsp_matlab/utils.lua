local utils = {}

utils.print_table = function(input)
	print("Key=Value")
	for k, v in pairs(input) do
		print(string.format("%s=%s", k, v))
	end
end

utils.split = function(str, delimiter)
	local split = {}
	-- String splitting in lua
	for match in string.gmatch(str, "([^" .. delimiter .. "]+)") do
		table.insert(split, match)
	end
	return split
end

utils.get_key = function(table, value)
	for k, v in pairs(table) do
		if v == value then
			return k
		end
	end
end

utils.json_encode = function(payload)
	local ok, encoded = pcall(vim.fn.json_encode, payload)
	encoded = string.format("Content-Length: %d\r\n", 10 + 2 * string.len(encoded)) .. encoded
	if ok then
		return encoded
	else
		return nil, encoded
	end
end

utils.json_decode = function(payload)
	payload = utils.split(payload, "\r\n")[2]
	local ok, decoded = pcall(vim.fn.json_decode, payload)
	if ok then
		return decoded
	else
		return nil, decoded
	end
end
utils.send_request = function(method, params, id)
	local request = {
		jsonrpc = "2.0",
		method = method,
		params = params,
		id = id,
	}
	return utils.json_encode(request)
end

return utils
