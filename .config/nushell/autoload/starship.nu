$env.STARSHIP_CONFIG = ($env.HOME)/.config/starship.nu.toml
$env.STARSHIP_SHELL = "nu"

load-env {
  PROMPT_COMMAND : {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
  }

  PROMPT_COMMAND_RIGHT : { (ansi grey) ++ (date now | format date '%H:%M:%S') }

  PROMPT_INDICATOR : "❯ "
  PROMPT_INDICATOR_VI_INSERT : {
    if $env.LAST_EXIT_CODE == 0 {
      $"(ansi gb)❯ (ansi reset)"
    } else {
      $"(ansi rb)❯ (ansi reset)"
    }
  }
  PROMPT_INDICATOR_VI_NORMAL : $"(ansi gb)❮ (ansi reset)"
  PROMPT_MULTILINE_INDICATOR : ""
}
