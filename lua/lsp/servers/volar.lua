local u = require("functions.utils")
return {
	setup = function(common_on_attach, capabilities, server)
		local ts_server
		if u.get_os() == "Linux" then
			ts_server =
				"/home/harrycramer/.local/share/nvim/lsp_servers/volar/node_modules/typescript/lib/tsserverlibrary.js"
		else
			ts_server =
				"/Users/harrisoncramer/.fnm/node-versions/v16.13.0/installation/lib/node_modules/typescript/lib/tsserverlibrary.js"
		end

		local lspconfig = require("lspconfig")
		server:setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				common_on_attach(client, bufnr)
			end,
			init_options = {
				typescript = {
					serverPath = ts_server,
				},
				languageFeatures = {
					references = true,
					definition = true,
					typeDefinition = true,
					callHierarchy = true,
					hover = false,
					rename = true,
					signatureHelp = true,
					codeAction = true,
					completion = {
						defaultTagNameCase = "both",
						defaultAttrNameCase = "kebabCase",
					},
					schemaRequestService = true,
					documentHighlight = true,
					codeLens = true,
					semanticTokens = true,
					diagnostics = true,
				},
				documentFeatures = {
					selectionRange = true,
					foldingRange = true,
					linkedEditingRange = true,
					documentSymbol = true,
					documentColor = true,
				},
			},
			settings = {
				volar = {
					codeLens = {
						references = true,
						pugTools = true,
						scriptSetupTools = true,
					},
				},
			},
			root_dir = lspconfig.util.root_pattern("package.json", "vue.config.js"),
		})
	end,
}