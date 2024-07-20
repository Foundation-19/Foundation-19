/proc/iconstate2appearance(icon, iconstate)
	var/static/image/stringbro = new()
	stringbro.icon = icon
	stringbro.icon_state = iconstate
	return stringbro.appearance

/proc/icon2appearance(icon)
	var/static/image/iconbro = new()
	iconbro.icon = icon
	return iconbro.appearance

/atom/proc/build_appearance_list(list/build_overlays)
	if (!islist(build_overlays))
		build_overlays = list(build_overlays)
	for (var/overlay in build_overlays)
		if(!overlay)
			build_overlays -= overlay
			continue
		if (istext(overlay))
			var/index = build_overlays.Find(overlay)
			build_overlays[index] = iconstate2appearance(icon, overlay)
		else if(isicon(overlay))
			var/index = build_overlays.Find(overlay)
			build_overlays[index] = icon2appearance(overlay)
	return build_overlays

/atom/proc/cut_overlays(priority = FALSE)
	overlays = null

/atom/proc/cut_overlay(list/overlays_list, priority)
	if(!overlays)
		return
	overlays -= build_appearance_list(overlays_list)

/atom/proc/add_overlay(list/overlays_list, priority = FALSE)
	if(!overlays)
		return
	overlays += build_appearance_list(overlays_list)

/atom/proc/set_overlays(list/overlays_list, priority = FALSE)	// Sets overlays to a list, equivalent to cut_overlays() + add_overlays().
	if (!overlays)
		return
	overlays = null
	overlays += build_appearance_list(overlays_list)

/atom/proc/copy_overlays(atom/other, cut_old = FALSE)	//copys our_overlays from another atom
	if(!other)
		if(cut_old)
			cut_overlays()
		return

	var/list/cached_other = other.overlays.Copy()
	if(cut_old)
		if(cached_other)
			overlays = cached_other
		else
			overlays = null
	else if(cached_other)
		overlays += cached_other

//TODO: Better solution for these?
/image/proc/add_overlay(x)
	overlays += x

/image/proc/cut_overlay(x)
	overlays -= x

/image/proc/cut_overlays(x)
	overlays.Cut()
