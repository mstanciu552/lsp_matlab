local methods = require "lsp_matlab.methods"
local state = require("lsp_matlab.methods").state

describe("textDocument", function()
	it("should support open requests", function()
		local uri = vim.uri_from_fname "~/fake.lua"
		local item = {
			uri = uri,
			text = "local hello = 'world'",
		}
		methods["textDocument/didOpen"] {
			textDocument = item,
		}
		assert.are.same(require("lsp_matlab.methods").state.get_text_document_from_uri(uri), item)
	end)
	it("should receive change request", function()
		-- textDocument/didChange
		local uri = vim.uri_from_fname "~/fake.lua"
		local item = {
			uri = uri,
			text = "local hello = 'world'",
		}
		methods["textDocument/didOpen"] {
			textDocument = item,
		}

		assert.are.same(state.get_text_document_from_uri(uri).text, item.text)

		methods["textDocument/didChange"] {
			textDocument = item,
			contentChanges = {
				{ text = "local hello = 'changed'" },
			},
		}

		assert.are.same(state.get_text_document_from_uri(uri), {
			uri = uri,
			text = "local hello = 'changed'",
		})
	end)
	it("should receive close requests", function()
		local uri = vim.uri_from_fname "~/fake.lua"
		local item = {
			uri = uri,
			text = "local hello = 'world'",
		}
		methods["textDocument/didOpen"] {
			textDocument = item,
		}

		assert.are.same(state.get_text_document_from_uri(uri).text, item.text)

		methods["textDocument/didClose"] {
			textDocument = item,
		}

		assert(not state.get_text_document_from_uri(uri))
	end)
end)
