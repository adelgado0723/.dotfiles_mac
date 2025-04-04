local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
--[[ local diagnostics = null_ls.builtins.diagnostics ]]

null_ls.setup({
  debug = false,
  sources = {
    --#formatters
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.cbfmt,
    formatting.markdownlint,
    formatting.stylua,
    formatting.prettierd,
    --[[ formatting.eslint_d, ]]
    -- formatting.yapf,

    --#diagnostics/linters
    null_ls.builtins.diagnostics.flake8,
    --[[ null_ls.builtins.diagnostics.eslint_d, ]]

    --#code actions
    --[[ null_ls.builtins.code_actions.eslint_d, ]]
    require("typescript.extensions.null-ls.code-actions"),

    --#completions
    null_ls.builtins.completion.spell.with({ filetypes = { "markdown", "md", "text", "txt" } }),
  },
})
