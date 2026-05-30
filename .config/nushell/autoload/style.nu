$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"

$env.config.table.abbreviated_row_count = 15
$env.config.table.header_on_separator = true
$env.config.table.index_mode = "auto"
$env.config.table.trim.methodology = "truncating"
$env.config.table.missing_value_symbol = "󰟢"

$env.config.hooks.display_output = {
  table --icons
}

$env.config.highlight_resolved_externals = true

$env.config.color_config.shape_external = "light_red"
$env.config.color_config.shape_external_resolved = "light_green"
$env.config.color_config.shape_flag = "yellow"
$env.config.color_config.shape_externalarg = "yellow"
$env.config.color_config.datetime = {||
  let duration = (date now) - $in
  if $duration < 1min {
    "#d9ffac"
  } else if $duration < 10min {
    "#c0ef8a"
  } else if $duration < 1hr {
    "#a9d78c"
  } else if $duration < 1day {
    "#99c7ac"
  } else if $duration < 1wk {
    "#79c79c"
  } else if $duration < 4wk {
    "#49a78c"
  } else if $duration < 52wk {
    "#49774c"
  } else {
    "#29572c"
  }
}

$env.config.color_config.filesize = {||
  if $in < 1kb {
    "#c0c0c0"
  } else if $in < 10kb {
    "#d0fffd"
  } else if $in < 100kb {
    "#d0fadd"
  } else if $in < 1mb {
    "#c3e88d"
  } else if $in < 10mb {
    "#c9d78c"
  } else if $in < 100mb {
    "#d9d77c"
  } else if $in < 1gb {
    "#f9c79c"
  } else {
    "#f9a79c"
  }
}
