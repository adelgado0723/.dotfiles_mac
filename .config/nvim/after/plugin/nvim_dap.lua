local dap = require("dap")

-- look for launch.js config
-- require("dap.ext.vscode").load_launchjs()

-- Makes Breakpoints look better
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "⭕", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "💬", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "💥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })

-- hooks into dlv
dap.adapters.go = function(callback, config)
	local stdout = vim.loop.new_pipe(false)
	local handle
	local pid_or_err
	local port = 38697
	local opts = {
		stdio = { nil, stdout },
		args = {
			"dap",
			"-l",
			"127.0.0.1:" .. port,
		},
		detached = true,
	}
	handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
		stdout:close()
		handle:close()
		if code ~= 0 then
			print("dlv exited with code", code)
		end
	end)
	assert(handle, "Error running dlv: " .. tostring(pid_or_err))
	stdout:read_start(function(err, chunk)
		assert(not err, err)
		if chunk then
			vim.schedule(function()
				require("dap.repl").append(chunk)
			end)
		end
	end)
	-- Wait for delve to start
	vim.defer_fn(function()
		callback({ type = "server", host = "127.0.0.1", port = port })
	end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "go",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- Javascript
dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/debuggers/vscode-node-debug2/out/src/nodeDebug.js" },
}
-- start chrome with `google-chrome-stable --remote-debugging-port=9222` to use this adapter
dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/debuggers/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
}
dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/debuggers/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
	{
		name = "Debug with chrome",
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescript = {
	{
		name = "Launch ts project",
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		program = "${workspaceFolder}/index.ts",
		preLaunchTask = "tsc: build - tsconfig.json",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
	{
		name = "debug dev ./bin/script.ts",
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		program = "${workspaceFolder}/bin/script.ts",
		preLaunchTask = "tsc: build - tsconfig.json",
    envFile = "${workspaceFolder}/.env",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
	{
		name = "debug backfill script",
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		program = "${workspaceFolder}/bin/backfilljob.ts",
		preLaunchTask = "tsc: build - tsconfig.json",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
	{
		name = "debug test payouts script",
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		program = "${workspaceFolder}/bin/testCommissionPayoutAggregation.ts",
		preLaunchTask = "tsc: build - tsconfig.json",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:8012",
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/usr/bin/firefox",
	},
	{
		name = "Debug with Chrome",
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
		preLaunchTask = "tsc: build - tsconfig.json",
		outFiles = { "${workspaceFolder}/dist/**/*.js" },
	},
}
