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



