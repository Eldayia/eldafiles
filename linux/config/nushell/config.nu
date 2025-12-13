# config.nu
#
# Installed by:
# version = "0.107.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

#Plugins
overlay use /home/dedsec/.config/nushell/plugins/git-aliases.nu/git-aliases.nu


# Aliases 
alias vim = nvim
alias y = yazi
alias top = btop
alias c = clear
alias e = exit
alias cat = bat
alias ping = mtr
alias df = duf
alias dig = dog
alias man = tldr
alias npm = pnpm
alias npx = pnpx
alias docker = podman
alias z = zellij
alias tauri = cargo-tauri
alias gi = git init


#Function 
#def cp [] { rsync -a --info=progress2 }
def grep [] { rg --smart-case --color=always }
def find [] { fd --color=always }
def m [] { curl wttr.in }
def f [] {
    let file = (fzf --preview "bat {}")
    if $file != "" {
        run nvim $file
    }
}
def topmem []  { ps | sort-by mem | last 15 }
def topcpu [] { ps | sort-by cpu | last 15 }




$env.config.buffer_editor = 'nvim'

# Remove Welcome Message
$env.config.show_banner = false

# zoxide
source ~/.zoxide.nu

# Atuin 
source ~/.config/nushell/autin-init.nu
source ~/.config/nushell/completion/atuin.nu

# Starship 
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


source $"($nu.home-path)/.cargo/env.nu"
$env.PATH ++= ["/home/dedsec/.local/share/gem/ruby/3.4.0/bin"]

