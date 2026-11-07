local viewer = swayimg.viewer
local gallery = swayimg.gallery
local slideshow = swayimg.slideshow
local text = swayimg.text

text.size = 16
text.color = 0xffc8d3f5
text.font = "Noto Sans CJK SC" -- font name
text.shadow = 0x22243600
text.visible = false

viewer.default_scale = "fit"
viewer.set_image_background(0x000)
viewer.set_window_background(0x0)
viewer.preload = 20
viewer.history = 40

swayimg.on_window_resize(function()
  if swayimg.mode == "viewer" then viewer.set_fix_scale "optimal" end
end)

gallery.preload = true
gallery.pstore = true
gallery.window_color = 0x000
gallery.border_color = 0xff111034
gallery.selected_color = 0xff111034

local timeout = 2.0

slideshow.timeout = timeout

-- KeyBinds

viewer.on_key("Escape", function() swayimg.mode = "gallery" end)
slideshow.on_key("Escape", function() swayimg.mode = "viewer" end)
viewer.on_key("q", swayimg.exit)
gallery.on_key("q", swayimg.exit)

---@param direction "left"|"right"|"up"|"down"
local function move(direction)
  local offset ---@type fun(x:integer, y:integer, wnd: {height:integer, width:integer}): integer, integer
  if direction == "left" then
    offset = function(x, y, wnd) return math.floor(x + wnd.width / 10), y end
  elseif direction == "right" then
    offset = function(x, y, wnd) return math.floor(x - wnd.width / 10), y end
  elseif direction == "up" then
    offset = function(x, y, wnd) return x, math.floor(y + wnd.height / 10) end
  elseif direction == "down" then
    offset = function(x, y, wnd) return x, math.floor(y - wnd.height / 10) end
  else
    offset = function(x, y) return x, y end
  end

  return function()
    local wnd = swayimg.get_window_size()
    local pos = viewer.get_position()
    ---@diagnostic disable-next-line
    viewer.abs_position = offset(pos.x, pos.y, wnd)
  end
end

viewer.on_key("h", move "left")
viewer.on_key("j", move "down")
viewer.on_key("k", move "up")
viewer.on_key("l", move "right")
gallery.on_key("h", function() gallery.switch_image "left" end)
gallery.on_key("j", function() gallery.switch_image "down" end)
gallery.on_key("k", function() gallery.switch_image "up" end)
gallery.on_key("l", function() gallery.switch_image "right" end)

viewer.on_key("Shift-h", function() viewer.switch_image "prev" end)
viewer.on_key("Shift-l", function() viewer.switch_image "next" end)
viewer.on_key("Space", function() viewer.switch_image "prev" end)
viewer.on_key("Shift-Space", function() viewer.switch_image "next" end)

viewer.on_key("v", viewer.flip_vertical)
viewer.on_key("V", viewer.flip_horizontal)
viewer.on_key("r", function() viewer.rotate(90) end)
viewer.on_key("Shift-r", function() viewer.rotate(270) end)

viewer.on_key("=", viewer.reset)

viewer.on_key("i", text.show)
gallery.on_key("i", text.show)
slideshow.on_key("i", text.show)

local function print_marked_images()
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then print(entry.path) end
  end
end

viewer.on_key("Ctrl-p", print_marked_images)
gallery.on_key("Ctrl-p", print_marked_images)

viewer.on_key("m", viewer.mark_image)
gallery.on_key("m", gallery.mark_image)

---@param timeout number
---@return string
function format_speed(timeout) ---@diagnostic disable-line
  if timeout < 1 then
    return tostring(math.floor(1 / timeout))
  elseif timeout == 1 then
    return "1"
  else
    return "1/" .. timeout
  end
end

function decelerate()
  timeout = timeout < 0.5 and 0.5 or timeout + 0.5
  slideshow.timeout = timeout
  text.status = "timeout: " .. format_speed(timeout) .. "x"
end

function accelerate()
  timeout = timeout <= 0.2 and 0.1 or timeout <= 0.5 and timeout - 0.1 or timeout - 0.5
  slideshow.timeout = timeout
  text.status = "timeout: " .. format_speed(timeout) .. "x"
end

viewer.on_key("Shift+less", viewer.prev_frame)
viewer.on_key("Shift+greater", viewer.next_frame)
viewer.on_key("p", viewer.set_animation)
slideshow.on_key("Shift+less", decelerate)
slideshow.on_key("Shift+greater", accelerate)
