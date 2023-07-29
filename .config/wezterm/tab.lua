local wezterm = require("wezterm")
local colors = {
		rosewater = "#F5E0DC",
		flamingo = "#F2CDCD",
		pink = "#F5C2E7",
		mauve = "#CBA6F7",
		red = "#F38BA8",
		maroon = "#EBA0AC",
		peach = "#FAB387",
		yellow = "#F9E2AF",
		green = "#A6E3A1",
		teal = "#94E2D5",
		sky = "#89DCEB",
		sapphire = "#74C7EC",
		blue = "#89B4FA",
		lavender = "#B4BEFE",
		text = "#CDD6F4",
		subtext1 = "#BAC2DE",
		subtext0 = "#A6ADC8",
		overlay2 = "#9399B2",
		overlay1 = "#7F849C",
		overlay0 = "#6C7086",
		surface2 = "#585B70",
		surface1 = "#45475A",
		surface0 = "#313244",

		base = "#1E1E2E",
		mantle = "#181825",
		crust = "#11111B",
	}

local Tab = {}

local function get_process(tab)
	local process_icons = {
		["docker"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰡨" },
		},
		["docker-compose"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰡨" },
		},
		["nvim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "" },
		},
		["bob"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "" },
		},
		["vim"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "" },
		},
		["node"] = {
			{ Foreground = { Color = colors.green } },
			{ Text = "󰋘" },
		},
		["zsh"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = "" },
		},
		["bash"] = {
			{ Foreground = { Color = colors.overlay1 } },
			{ Text = "" },
		},
		["htop"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "" },
		},
		["btop"] = {
			{ Foreground = { Color = colors.rosewater } },
			{ Text = "" },
		},
		["cargo"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["go"] = {
			{ Foreground = { Color = colors.sapphire } },
			{ Text = "" },
		},
		["git"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = "󰊢" },
		},
		["lazygit"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = "󰊢" },
		},
		["lua"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "" },
		},
		["wget"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "󰄠" },
		},
		["curl"] = {
			{ Foreground = { Color = colors.yellow } },
			{ Text = "" },
		},
		["gh"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = "" },
		},
		["flatpak"] = {
			{ Foreground = { Color = colors.blue } },
			{ Text = "󰏖" },
		},
		["dotnet"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = "󰪮" },
		},
		["paru"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = "󰣇" },
		},
		["yay"] = {
			{ Foreground = { Color = colors.mauve } },
			{ Text = "󰣇" },
		},
		["fish"] = {
			{ Foreground = { Color = colors.peach } },
			{ Text = "" },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	if process_icons[process_name] then
		return wezterm.format(process_icons[process_name])
	elseif process_name == "" then
		return wezterm.format({
			{ Foreground = { Color = colors.red } },
			{ Text = "󰌾" },
		})
	else
		return wezterm.format({
			{ Foreground = { Color = colors.blue } },
			{ Text = string.format("[%s]", process_name) },
		})
	end
end

local function get_current_working_folder_name(tab)
	local cwd_uri = tab.active_pane.current_working_dir

	cwd_uri = cwd_uri:sub(8)

	local slash = cwd_uri:find("/")
	local cwd = cwd_uri:sub(slash)

	local HOME_DIR = os.getenv("HOME")
	if cwd == HOME_DIR then
		return "  ~"
	end

	return string.format("  %s", string.match(cwd, "[^/]+$"))
end

function Tab.setup(config)
	config.tab_bar_at_bottom = false
	config.use_fancy_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false
	config.tab_max_width = 100
	config.hide_tab_bar_if_only_one_tab = true

	wezterm.on("format-tab-title", function(tab)
		return wezterm.format({
			{ Text = "  " },
			{ Attribute = { Intensity = "Half" } },
			{ Text = string.format("%s", tab.tab_index + 1) },
			"ResetAttributes",
			{ Text = get_current_working_folder_name(tab) },
			{ Text = " " },
			{ Text = get_process(tab) },
			{ Foreground = { Color = colors.base } },
			{ Text = "  " },
		})
	end)
end

return Tab

