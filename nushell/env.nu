# Nushell Environment Config File
#
# version = "0.96.1"

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
    # ($env.NUPM_HOME | path join "modules")
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
$env.PATH = ($env.PATH | split row (char esep))
path add ~/.cargo/bin
path add ~/bin
path add ~/.local/bin
$env.PATH = ($env.PATH | uniq)

# $env.PATH = (
#     $env.PATH
#         | split row (char esep)
#         | ....
#         | prepend ($env.NUPM_HOME | path join "scripts")
#         | uniq
# )

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

$env.XDG_DATA_DIR = "/home/tombh/.local/share"
$env.GTK_THEME = "Adwaita:dark"
$env.GSETTINGS_SCHEMA_DIR = "/usr/share/glib-2.0/schemas"
$env.COTP_DB_PATH = "/home/tombh/.config/cotp/db.cotp"
$env.LANG = "en_GB.UTF-8"
$env.NUPM_HOME = ($env.XDG_DATA_DIR | path join "nupm")
$env.EDITOR = "nvim"
$env.GPG_TTY = (tty | str trim)
$env.DISPLAY = ":0"
$env.VK_ICD_FILENAMES = "/usr/share/vulkan/icd.d"


if $env.USER == "streamer" {
	$env.CARGO_BUILD_JOBS = 6
	$env.DISPLAY = ":1"
}

if $env.USER == "tombh" {
	source nix.nu
}

