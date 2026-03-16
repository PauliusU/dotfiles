-- AI chat sidebar with multi-provider support (Cursor ACP, Claude, Codex, Gemini CLI)
return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		build = vim.fn.has("win32") == 1
				and function(plugin)
					local tag = vim.trim(vim.fn.system("git -C " .. vim.fn.shellescape(plugin.dir) .. " describe --tags --abbrev=0"))
					local build_dir = plugin.dir .. "/build"
					vim.fn.mkdir(build_dir, "p")
					local url = ("https://github.com/yetone/avante.nvim/releases/download/%s/avante_lib-windows-x86_64-luajit.zip"):format(tag)
					local tmp = vim.fn.tempname() .. ".zip"
					vim.fn.system({ "curl", "-sL", url, "-o", tmp })
					vim.fn.system({ "unzip", "-o", tmp, "-d", build_dir })
					vim.fn.delete(tmp)
					-- MSYS2/MINGW neovim detects as "linux" and looks for .so instead of .dll
					for _, dll in ipairs(vim.fn.glob(build_dir .. "/*.dll", true, true)) do
						vim.uv.fs_copyfile(dll, dll:gsub("%.dll$", ".so"))
					end
					vim.fn.writefile({ tag }, build_dir .. "/.tag")
				end
			or "make",
		opts = {
			provider = "claude",
			mode = "agentic",
			input = {
				provider = "snacks", -- native provider crashes during OAuth on startup
			},
			providers = {
				-- :lua require("avante.api").switch_provider("claude")
				claude = {
					auth_type = "max", -- OAuth via Claude Pro/Max subscription (no API key needed)
				},
			},
			acp_providers = {
				-- :lua require("avante.api").switch_provider("cursor")
				cursor = {
					command = os.getenv("HOME") .. "/.local/bin/agent",
					args = { "acp" },
					auth_method = "cursor_login",
					env = {
						HOME = os.getenv("HOME"),
						PATH = os.getenv("PATH"),
					},
				},
				-- :lua require("avante.api").switch_provider("codex")
				["codex"] = {
					command = "npx",
					args = { "@zed-industries/codex-acp" },
				},
				-- :lua require("avante.api").switch_provider("gemini-cli")
				-- TODO: gemini --experimental-acp requires GEMINI_API_KEY, doesn't use OAuth session.
				-- Avante's built-in gemini provider also needs GEMINI_API_KEY (no auth_type like Claude).
				-- https://github.com/yetone/avante.nvim — gemini-cli ACP config shows GEMINI_API_KEY.
				["gemini-cli"] = {
					command = "gemini",
					args = { "--experimental-acp" },
					env = { NODE_NO_WARNINGS = "1" },
				},
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"HakonHarnes/img-clip.nvim", -- requires: brew install pngpaste
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = { insert_mode = true },
						use_absolute_path = true,
					},
				},
			},
		},
		keys = {
			{
				"<leader>ap",
				function()
					local providers = { "claude", "cursor", "codex", "gemini-cli" }
					vim.ui.select(providers, { prompt = "Switch Avante provider:" }, function(choice)
						if choice then require("avante.api").switch_provider(choice) end
					end)
				end,
				desc = "Switch Avante provider",
			},
			{
				"<leader>ai",
				function()
					return vim.bo.filetype == "AvanteInput" and require("avante.clipboard").paste_image()
						or require("img-clip").paste_image()
				end,
				desc = "Paste image",
			},
		},
	},
}
