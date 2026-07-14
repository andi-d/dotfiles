-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1, -- "auto"
})

hl.env("GDK_SCALE", tostring(1))
