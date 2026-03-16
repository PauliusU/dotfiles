return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	config = true,
	keys = {
		{ "<leader>e", nil, desc = "AI/Claude Code" },
		{ "<leader>ec", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>ef", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<M-;>", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle: buffer → Claude" },
		{ "<A-;>", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle: buffer → Claude (Alt alias)" },
		{ "<Esc>;", "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle: buffer → Claude (Esc fallback)" },
		{ "<leader>er", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>eC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>em", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		{ "<leader>eb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>es", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		{
			"<leader>es",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
		},
		-- Diff management
		{ "<leader>ea", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ed", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
	},
}
