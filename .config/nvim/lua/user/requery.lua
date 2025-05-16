vim.api.nvim_create_user_command("Requery", function()
	local question = ""
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	for i, line in ipairs(lines) do
		if line:match("^## 🧠 Question") then
			question = table.concat(vim.list_slice(lines, i + 1, #lines), "\n")
			break
		end
	end

	if question == "" then
		print("❌ Could not find question block.")
		return
	end

	local handle = io.popen(
		"curl -sS https://api.openai.com/v1/chat/completions "
			.. "-H 'Content-Type: application/json' "
			.. "-H 'Authorization: Bearer '\"$OPENAI_API_KEY\" "
			.. "-d '"
			.. string
				.format(
					[[
      {
        "model": "gpt-4o",
        "messages": [
          {"role": "system", "content": "You are a helpful technical assistant."},
          {"role": "user", "content": %q}
        ],
        "temperature": 0.7
      }
    ]],
					question
				)
				:gsub("\n", "\\n")
			.. "'"
	)

	local result = handle:read("*a")
	handle:close()

	local ok, json = pcall(vim.fn.json_decode, result)
	if not ok or not json.choices or not json.choices[1] then
		print("❌ Error from OpenAI.")
		return
	end

	local response = json.choices[1].message.content
	vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "### 💬 Response", "", unpack(vim.split(response, "\n")) })
end, {})

vim.api.nvim_create_user_command("RequeryChatGPT", function()
	local line = vim.fn.line(".")

	local script_path = os.getenv("HOME") .. "/scripts/utils/chatGptRequery"

	if vim.fn.filereadable(script_path) == 0 then
		print("Script not found: " .. script_path)
		return
	end

	-- Open a terminal in a horizontal split and run the requery script
	vim.cmd("split")
	vim.cmd("resize 15")
	vim.cmd("terminal bash " .. script_path .. " " .. line)

end, {})
