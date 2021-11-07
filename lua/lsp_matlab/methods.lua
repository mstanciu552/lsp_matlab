local errors = require("lsp_matlab.error").defined_errors

local M = {}

local status = {}
status.textDocument = {}

--[[
--  @Method_structure
--  M[<method>] = function(params)
--    handle parameter structure and throw error if needed
--    local function handle_params(params)
--      [...]
--    end
--    [...] -- actual method ahndling
--    if handle_params(params) then return handle_params(params), nil end 
--    return nil, result
--  end
--]]

M["textDocument/didOpen"] = function(params)
	status.textDocument[params.textDocument.uri] = params.textDocument
end
M["textDocument/didChange"] = function(params) end
M["textDocument/didClose"] = function(params)
	status.textDocument[params.textDocument.uri] = nil
end

return M
