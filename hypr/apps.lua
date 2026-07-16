-- Tag Impala windows so they can share the same rules
hl.window_rule({
	match = { title = "^Impala$" },
	tag = "+floating-center",
})

-- all floating-center tagged windows are centered and floating
hl.window_rule({
	match = { tag = "floating-center" },
	float = true,
	center = true,
	size = { 900, 700 },
})
