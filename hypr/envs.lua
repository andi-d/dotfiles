-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
local home = os.getenv("HOME")
local path = os.getenv("PATH")
hl.env("PATH", home .. "/.local/bin:" .. path)
