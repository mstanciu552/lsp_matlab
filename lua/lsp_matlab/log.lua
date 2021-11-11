local path_to_log_file = "log/log.txt"

local log = function(str)
	local file = io.open(path_to_log_file, "a+")
	file:write(str)
	file:write "\n"
	file:close()
end

return log
