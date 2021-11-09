local path_to_log_file = "log/log.txt"

local log = function(str)
	local file = io.open(path_to_log_file, "a")
	local stdout = io.stdout
	io.output(file)

	print(str)
	io.write(str)

	io.close(file)
	io.output(stdout)
end

return log
