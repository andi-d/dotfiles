-- Tag Impala windows so they can share the same rules
hl.window_rule({
	match = { title = "^Impala$" },
	tag = "+floating-center",
})

hl.window_rule({
	match = { title = "^Volume Control$" },
	tag = "+floating-center",
})

hl.window_rule({
	match = { title = "^Network Connections$" },
	tag = "+floating-center",
})

-- all floating-center tagged windows are centered and floating
hl.window_rule({
	match = { tag = "floating-center" },
	float = true,
	center = true,
	size = { 900, 700 },
})

hl.window_rule({
	name = "thunar-appearance",
	match = { class = "thunar" },

	opacity = 0.85,
})
