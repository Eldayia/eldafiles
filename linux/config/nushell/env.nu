# ================================
# 🐚 Nushell Environment Config
# ================================

# --- XDG defaults (for Ly/Wayland or minimal sessions) ---
if not ($env | columns | any {|x| $x == "XDG_CONFIG_HOME"}) {
    $env.XDG_CONFIG_HOME = ($env.HOME | path join ".config")
}
if not ($env | columns | any {|x| $x == "XDG_DATA_HOME"}) {
    $env.XDG_DATA_HOME = ($env.HOME | path join ".local" "share")
}
if not ($env | columns | any {|x| $x == "XDG_CACHE_HOME"}) {
    $env.XDG_CACHE_HOME = ($env.HOME | path join ".cache")
}

# --- PATH setup ---
let paths = [
    ($env.HOME | path join ".local" "bin")
    ($env.HOME | path join ".local" "share" "pnpm")
    ($env.HOME | path join "go" "bin")
    ($env.HOME | path join "bin")
    "/opt/android-sdk/platform-tools"
    "/opt/android-sdk/tools/bin"
    "~/.dotnet/tools"
]

# Merge paths uniquely
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append $paths
    | uniq
    | str join (char esep)
)

# --- Zoxide setup ---
$env._ZO_ECHO = 1
$env._ZO_RESOLVE_SYMLINKS = 1
$env._ZO_FZF_OPTS = "
  --height=40%
  --layout=reverse
  --border
  --info=inline
  --marker='*'
  --prompt='dedsec ❯ '
  --pointer='▶'
  --separator='─'
  --ansi
  --color=fg:#d0d0d0,bg:#1c1c1c,hl:#ffaf00
  --color=fg+:#ffffff,bg+:#262626,hl+:#ffd700
  --color=info:#87afd7,prompt:#5fafff,pointer:#ff5f5f,marker:#5fff87,spinner:#af87ff,header:#5fafff
"

# Initialise zoxide
zoxide init nushell --cmd cd | save -f ~/.zoxide.nu

# --- NUPM setup ---
$env.NUPM_HOME = ($env.XDG_DATA_HOME | path join "nupm")

# ensure dirs exist
if not ($env.NUPM_HOME | path exists) {
    mkdir $env.NUPM_HOME
}

# Add NUPM bin + modules to paths
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | append ($env.NUPM_HOME | path join "bin")
    | uniq
    | str join (char esep)
)

$env.NU_LIB_DIRS = [
    ($env.NUPM_HOME | path join "modules")
]


# --- PNPM setup ---
$env.PNPM_HOME = ($env.XDG_DATA_HOME | path join "pnpm")

# --- Default programs ---
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.PAGER = "less"

# --- Greeting ---
figlet -t "Welcome home," ($env.USER) | lolcat -a -d 1 -t

