require("noice").setup({
	routes = {
		{ filter = { event = "msg_show", kind = "", find = "written" },                  view = "mini" },
		{ filter = { event = "msg_show", kind = "", find = "yanked into" },              view = "mini" },

		{ filter = { event = "msg_show", kind = "", find = "line less;" },               skip = true },
		{ filter = { event = "msg_show", kind = "", find = "fewer lines" },              skip = true },
		{ filter = { event = "msg_show", kind = "", find = "lines;" },                   skip = true },
		{ filter = { event = "msg_show", kind = "", find = "before;" },                  skip = true },
		{ filter = { event = "msg_show", kind = "", find = "after;" },                   skip = true },
		{ filter = { event = "msg_show", kind = "", find = "change;" },                  skip = true },
		{ filter = { event = "msg_show", kind = "", find = "changes;" },                 skip = true },
		{ filter = { event = "msg_show", kind = "", find = "Already at oldest change" }, skip = true },
		{ filter = { event = "msg_show", kind = "", find = "Already at newest change" }, skip = true },
	}
})
