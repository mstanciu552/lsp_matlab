local utils = require("lsp_matlab.utils")
local methods = require("lsp_matlab.methods")
local error_handler = require("lsp_matlab.error")
local errors = require("lsp_matlab.error").defined_errors

local M = {}

-- @private
-- @params method , params -> used to get a result to the request
-- @return err -> should be an error code; if err is not nil then send error type response
-- @return result
local function analyze(method, params)
	for k, v in pairs(methods) do
		if k == method then
			return nil, v(params)
		end
	end
	return errors.Method_not_found, nil
end

-- @public
-- @params request -> JSON object of an RPC Request
-- @info decodes the requests and asks for a response
M.handle_request = function(request)
	local request_table = utils.json_decode(request)
	M.send_response(request_table)
end

-- @public
-- @params decoded request and an optional pipe for output(default stdout)
-- @info writes to output; JSON RPC Response
M.send_response = function(request, pipe)
	if not pipe then
		pipe = io.stdout
	end

	local err, result = analyze(request.method, request.params)
	local response

	if err then
		response = {
			jsonrpc = "2.0",
			error = error_handler.send_error(err),
			id = request.id,
		}
	else
		response = {
			jsonrpc = "2.0",
			result = result,
			id = request.id,
		}
	end

	pipe:write(utils.json_encode(response))
end

return M
