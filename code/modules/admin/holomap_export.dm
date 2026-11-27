// Admin verb to export the runtime-generated holomaps (drawn from the
// CURRENT live map by SSmminimap at init) as PNG files, for updating
// nano/images/site53/site53-N.png used by the crew monitor map view.
//
// Output format matches the frontend contract:
//   480x480 canvas, station centered, 1px per turf.
// Files land in data/minimap_export/ — copy them into
// nano/images/site53/ (or the map's path dir) and commit.

/datum/admins/proc/export_holomaps()
	set category = "Server"
	set name = "Export Holomaps"
	set desc = "Export the runtime holomaps (drawn from the current map) as 480x480 PNGs for the crew monitor."

	if(!check_rights(R_ADMIN|R_DEBUG|R_SERVER))
		to_chat(usr, "You are not allowed to use this command")
		return

	if(!SSminimap || !LAZYLEN(SSminimap.holomaps))
		to_chat(usr, SPAN_WARNING("Holomap data is not generated. Has the round initialized?"))
		return

	var/outdir = "data/minimap_export/"
	if(!fexists(outdir))
		// rustg creates files but not directories; seed the dir with a marker.
		rustg_file_write("export marker", "data/minimap_export/.keep")

	var/exported = 0
	for(var/z in GLOB.using_map.map_levels)
		var/datum/holomapdata/data = SSminimap.holomaps[z]
		if(!data || !data.holomap_combined)
			continue
		var/icon/map = data.holomap_combined
		if(map.Width() != 480 || map.Height() != 480)
			to_chat(usr, SPAN_WARNING("Unexpected holomap size [map.Width()]x[map.Height()] for z[z]."))
			continue
		// Rasterize: rustg_dmi_create_png takes a flat string of 7-char
		// hex color tokens (hash + 6 digits), row-major, first row = TOP.
		// icon GetPixel y=1 is the BOTTOM row.
		var/list/rows = list()
		for(var/py = 480 to 1 step -1)
			var/row = ""
			for(var/px = 1 to 480)
				var/rgb = map.GetPixel(px, py)
				if(!rgb)
					row += "#050505" // empty space -> frontend bg color
				else
					row += rgb
			rows += row
		var/payload = jointext(rows, "")
		var/path = "[outdir]site53-[z].png"
		var/result = rustg_dmi_create_png(path, "480", "480", payload)
		if(result)
			to_chat(usr, SPAN_WARNING("Failed to write [path]: [result]"))
			continue
		exported++
		to_chat(usr, SPAN_NOTICE("Exported [path]."))
	log_game("[key_name(usr)] exported [exported] holomap pngs.")
	to_chat(usr, SPAN_NOTICE("Done. [exported] file(s) in data/minimap_export/ — copy to nano/images/site53/ and commit."))
