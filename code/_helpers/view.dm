/proc/getviewsize(view)
	if(!view) // Just to avoid any runtimes that could otherwise cause constant disconnect loops.
		view = world.view

	if(isnum(view))
		var/totalviewrange = (view < 0 ? -1 : 1) + 2 * view
		return list(totalviewrange, totalviewrange)
	else
		var/list/viewrangelist = splittext(view, "x")
		return list(text2num(viewrangelist[1]), text2num(viewrangelist[2]))

/proc/getScreenSize(widescreen)
	if(widescreen)
		return config.default_view
	return config.default_view_square
