local ts_util = require "nvim-treesitter.ts_utils"
local locals = require "nvim-treesitter.locals"

local utils = require "lsp_matlab.utils"

local M = {}

-- @returns Location = { uri, range }
-- Range = { start = Position, end = Position }
-- Position = {line = number, character = number}
M.jump_definition = function(params)
	-- assert(params.textDocument, "textDocument needed")
	local node = utils.get_node_at_position(params.position) or ts_util.get_node_at_cursor()
	assert(node, "cursor position invalid")

	local node_text = ts_util.get_node_text(node)
	local definitions = locals.get_definitions(0)
	local final_definitions = {}
	local positions = {}

	-- Check which definition in the current buffer match the current node
	for _, def in ipairs(definitions) do
		if def.var then
			local definition_text = ts_util.get_node_text(def.var.node)[1]
			if definition_text == node_text then -- check matching node text
				table.insert(final_definitions, def.var.node)
			end
		end
	end

	assert(#final_definitions ~= 0, "No definitions found")

	-- Get positions for all definitions that match the current node
	for _, definition_node in pairs(final_definitions) do
		local start_row, start_col, end_row, end_col = definition_node:range()

		local start = { line = start_row, character = start_col }
		local end_position = { line = end_row, character = end_col }

		-- Position type table
		positions[definition_node] = {}
		positions[definition_node]["start"] = start
		positions[definition_node]["end"] = end_position
	end
	assert(#positions ~= 0, "No positions returned")

	-- Pick last position, assuming that it is correct(latest)
	local final_positions = positions[#positions]
	-- Write response
	local response = {
		uri = params.textDocument.uri,
		range = final_positions,
	}

	return response
end

return M
