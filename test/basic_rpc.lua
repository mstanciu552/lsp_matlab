-- require("plenary.test_harness"):setup_busted()
local methods = require("lsp_matlab.methods")

describe("textDocument", function()
	it("it should support open requests", function()
		local uri = vim.uri_from_fname("~/.config/nvim/lua/globals.lua")
		local item = {
			uri = uri,
			text = "local hello = 'world'",
		}
		methods["textDocument/didOpen"]({
			textDocument = item,
		})
		assert.are.same(require("lsp_matlab.methods").state.get_text_document_from_uri(uri), item)
	end)
	it("it should receive change request", function()
		-- textDocument/didChange
		local uri = vim.uri_from_fname("~/.config/nvim/lua/globals.lua")
		local item = {
			uri = uri,
			text = "local hello = 'world'",
		}
		methods["textDocument/didOpen"]({
			textDocument = item,
		})

		methods["textDocument/didChange"]({
			textDocument = item,
			contentChanges = {
				{ text = "local hello = 'changed'" },
			},
		})

		assert.are.same(require("lsp_matlab.methods").state.get_text_document_from_uri(uri), {
			uri = uri,
			text = "local hello = 'changed'",
		})
	end)
end)
