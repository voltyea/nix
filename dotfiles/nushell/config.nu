export-env {
	if 'TMUX' not-in $env {
		^tmux -2u new -As0
		exit
	}
}
$env.config.show_banner = false
pokego --no-title --random 1-8
oh-my-posh init nu --config ~/.config/ohmyposh.toml
source ~/.zoxide.nu



