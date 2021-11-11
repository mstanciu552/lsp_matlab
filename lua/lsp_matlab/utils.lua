local ts_util = require "nvim-treesitter.ts_util"

local utils = {}

utils.print_table = function(input)
	io.write "Key=Value"
	for k, v in pairs(input) do
		io.write(string.format("%s=%s", k, v))
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
	local split = utils.split(payload, "\r\n")
	payload = split[2] or split[1]
	local ok, decoded = pcall(vim.fn.json_decode, payload)
	if ok then
		return decoded
	else
		return nil, decoded
	end
end

-- @info Mimic client
utils.send_request = function(method, params, id)
	local request = {
		jsonrpc = "2.0",
		method = method,
		params = params,
		id = id,
	}
	return utils.json_encode(request)
end

-- FIXME Make use of textDocument to look through for nodes
utils.get_node_at_position = function(position, textDocument)
	assert(position.start, "Invalid position format")
	local cursor_range = { position.start.line[1] - 1, position.start.character[2] }
	local root = ts_util.get_root_for_position(unpack(cursor_range))

	assert(root, "Error getting root")

	return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

return utils
