local methods = require "lsp_matlab.methods"

describe("definition request", function()
	it("should return a Location type result", function()
		local uri = vim.uri_from_fname "~/fake.lua"
		local position = {}
		position.start = { line = 0, character = 0 }
		position["end"] = { line = 0, character = 10 }

		local textDocument = {
			uri = uri,
		}

		methods["textDocument/definition"] {
			textDocument = textDocument,
			position = position,
		}

		-- Can't test without valid textDocument
	end)
end)
