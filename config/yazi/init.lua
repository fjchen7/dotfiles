require("git"):setup()

-- Hide preview in neovim
-- https://github.com/yazi-rs/plugins/tree/main/toggle-pane.yazi#advanced
if os.getenv("NVIM") then
	require("toggle-pane"):entry("min-preview")
end

require("mactag"):setup({
	-- Keys used to add or remove tags
	keys = {
		r = "Red",
		o = "Orange",
		y = "Yellow",
		g = "Green",
		b = "Blue",
		p = "Purple",
	},
	-- Colors used to display tags
	colors = {
		Red = "#ee7b70",
		Orange = "#f5bd5c",
		Yellow = "#fbe764",
		Green = "#91fc87",
		Blue = "#5fa3f8",
		Purple = "#cb88f8",
	},
})
