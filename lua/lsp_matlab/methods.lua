local errors = require("lsp_matlab.error").defined_errors
local definitions = require "spec.definitions"
local log = require "lsp_matlab.log"

local M = {}

M.state = {}
M.state.textDocument = {}

M.state.clear = function()
	M.state = {}
	M.state.textDocument = {}
end

M.state.get_text_document_from_uri = function(uri)
	return M.state.textDocument[uri]
end

M.state.textDocument.change = function(textDocument, contentChanges)
	assert(M.state.textDocumentItem[textDocument.uri], "Should have already loaded the textDocument")

	assert(contentChanges, "Should have some changes")
	assert(#contentChanges == 1, "Can only handle 1 change")

	local changes = contentChanges[1]
	assert(not changes.range)
	assert(not changes.rangeLength)

	M.state.textDocumentItem[textDocument.uri].text = changes.text
	M.state.textDocument[textDocument.uri].text = changes.text

	-- TODO Continue
end

M["textDocument/didOpen"] = function(params)
	log "didOpen"
	assert(not M.state.textDocument[params.textDocument.uri], "didOpen already called")
	M.state.textDocument[params.textDocument.uri] = params.textDocument
end

M["textDocument/didChange"] = function(params)
	log "didChange"
	M.state.textDocument.change(params.textDocument, params.contentChanges)
end

M["textDocument/didClose"] = function(params)
	log "didClose"
	M.state.textDocument[params.textDocument.uri] = nil
end

M["textDocument/didSave"] = function(params)
	log "didSave"
	M.state.textDocument[params.textDocument.uri].text = params.text
end

M["textDocument/definition"] = definitions.jump_definition

return M
