-- @Docs https://neovim.io/doc/user/lsp.html
local M = {}
local rpc = require "lsp_matlab.rpc"
local log = require "lsp_matlab.log"

-- @Info Main function
M.start = function()
	log "Server started\n"
	local Shutdown = false

	-- @Info Handle stdin and stdout
	while not Shutdown do
		local block = io.read "*l"
		if not block then
			break
		end
		rpc.handle_input(block)
	end

	os.exit(0)
end

-- @Optional
-- @Info Check if user provided settings or not
M.setup = function(opts)
	if opts then
		M.defaults = opts
	else
		M.defaults = require "lsp_matlab.defaults"
	end

	local configs = require "lspconfig/configs"
	local util = require "lspconfig/util"
	local lspconfig = require "lspconfig"

	assert(not lspconfig.matlab, "Server already exists")
	configs.matlab = {
		default_config = {
			filetypes = { "matlab" },
			root_dir = function(fname)
				return util.path.dirname(fname)
			end,
			cmd = { "nvim", "--headless", "-c", "'lua require('lsp_matlab').start()'" },
			settings = {},
		},
		docs = {
			description = [[
      Test description
    ]],
			default_config = {
				root_dir = [[dirname]],
			},
		},
	}

	lspconfig.matlab.setup(opts)
end

return M
