local errors = require("lsp_matlab.error").defined_errors
local definitions = require("spec.definitions")

local M = {}

M.state = {}
M.state.textDocument = {}

local storage = {}
storage.textDocumentItem = {}

M.state.get_text_document_from_uri = function(uri)
	return storage.textDocumentItem[uri]
end

M.state.textDocument.change = function(textDocument, contentChanges)
	assert(storage.textDocumentItem[textDocument.uri], "Should have already loaded the textDocument")

	assert(contentChanges, "Should have some changes")
	assert(#contentChanges == 1, "Can only handle 1 change")

	local changes = contentChanges[1]
	assert(not changes.range)
	assert(not changes.rangeLength)

	storage.textDocumentItem[textDocument.uri].text = changes.text

	-- TODO Continue
end

M["textDocument/didOpen"] = function(params)
	M.state.textDocument[params.textDocument.uri] = params.textDocument
	storage.textDocumentItem[params.textDocument.uri] = params.textDocument
end

M["textDocument/didChange"] = function(params)
	M.state.textDocument.change(params.textDocument, params.contentChanges)
end

M["textDocument/didClose"] = function(params)
	M.state.textDocument[params.textDocument.uri] = nil
end

M["textDocument/definition"] = definitions.jump_definition

return M
