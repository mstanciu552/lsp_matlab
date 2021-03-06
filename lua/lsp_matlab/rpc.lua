local utils = require "lsp_matlab.utils"
local methods = require "lsp_matlab.methods"
local error_handler = require "lsp_matlab.error"
local errors = require("lsp_matlab.error").defined_errors
local log = require "lsp_matlab.log"

local M = {}

-- @private
-- @params method , params -> used to get a result to the request
-- @return err -> should be an error code; if err is not nil then send error type response
-- @return result
local function analyze(method, params)
	local err, result = methods[method](params)

	if not methods[method] then
		return errors.Method_not_found, nil
	end

	if err then
		return err, nil
	else
		return nil, result
	end
end

-- @public
-- @params request -> JSON object of an RPC Request
-- @info decodes the requests and asks for a response
M.handle_request = function(request)
	local request_table = utils.json_decode(request)
	return M.send_response(request_table)
end

-- @public
-- @params decoded request and an optional pipe for output(default stdout)
-- @info writes to output; JSON RPC Response
M.send_response = function(request, pipe)
	if not pipe then
		pipe = io.stdout
	end

	local err, result = analyze(request.method, request.params)
	local response = {
		jsonrpc = "2.0",
	}

	if request.id then
		response.id = request.id
	end

	if err then
		response.error = error_handler.send_error(err)
	else
		response.result = result
	end

	local json_response = utils.json_encode(response)
	pipe:write(json_response)
	return json_response
end

--- Handles stdin input <=> RPC Calls
-- @params block -> stdin input
-- @info optional writes to output; JSON RPC Response
M.handle_input = function(block)
	local jsonify = utils.json_decode(block)
	assert(jsonify.method, "Invalid Request")
	return analyze(jsonify.method, jsonify.params)
end

return M
