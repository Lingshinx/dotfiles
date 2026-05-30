# The easiest, most secure way to use WireGuard.
# This CLI is still under active development. Commands and flags will
# change in the future.
@complete external
export extern main []

def hostname [] {
  status | get name
}

# Ping a host at the Tailscale layer, see how it routed
export extern ping [
  hostname: string@hostname
]

# Show state of tailscaled and its connections
export def status [
  --long (-l)
  host?: string
] {
  ^tailscale status --json
  | from json
  | get Peer
  | values
  | insert status {|it| if $it.Online { $"(ansi green)Online(ansi reset)" } else { $it.LastSeen | date humanize }}
  | insert ip { get TailscaleIPs.0 }
  | insert name { get DNSName | split row . | first }
  | rename --block { str downcase }
  | if $long {
    $in
  } else {
    select name hostname ip os status
  }
  | if ($host | is-not-empty) { where name == $host | first } else { $in }
}
