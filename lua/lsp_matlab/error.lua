local utils = require("lsp_matlab.utils")

local M = {}

M.defined_errors = {
	Parse_error = -32700, -- 	Invalid JSON was received by the server. An error occurred on the server while parsing the JSON text.
	Invalid_Request = -32600, -- The JSON sent is not a valid Request object.
	Method_not_found = -32601, -- The method does not exist / is not available.
	Invalid_params = -32602, -- Invalid method parameter(s).
	Internal_error = -32603, -- Internal JSON-RPC error.
}

M.error_data = function(code)
	if code == -32700 then
		return "Invalid JSON was received by the server. An error occurred on the server while parsing the JSON text."
	elseif code == -32600 then
		return "The JSON sent is not a valid Request object."
	elseif code == -32601 then
		return "The method does not exist / is not available."
	elseif code == -32602 then
		return "Invalid method parameter(s)."
	elseif code == -32603 then
		return "Internal JSON-RPC error."
	end
end

M.send_error = function(code)
	local error_response = {
		code = code,
		message = utils.get_key(M.defined_errors, code),
		data = M.error_data(code),
	}
	return error_response
end

return M
