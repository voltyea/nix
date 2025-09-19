export-env {
	if 'TMUX' not-in $env {
		^tmux -2u new -As0
		exit
	}
}
$env.config.show_banner = false
pokego --no-title --random 1-8
oh-my-posh init nu --config ~/.config/ohmyposh.toml
alias vim = nvim
alias cl = clear
source ./rose-pine-moon.nu
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}
$env.config.edit_mode = 'vi'

$env.config.keybindings ++= [
    {
        name: history_completer
        modifier: control
        keycode: char_f
        mode: [vi_insert]
        event: { send: HistoryHintComplete }
    }
]
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi '#3e8fb0')❯ (ansi reset)"
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi '#eb6f92')❮ (ansi reset)"

$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
$env.TRANSIENT_PROMPT_COMMAND = ""


