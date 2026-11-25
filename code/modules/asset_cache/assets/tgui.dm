/datum/asset/simple/tgui
	keep_local_name = TRUE
	assets = list(
		"tgui.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui.bundle.css" = file("tgui/public/tgui.bundle.css"),
		"tgui.acs.css" = file("html/acs.css"),
	)

// Cache-busted names: BYOND clients can serve stale rsc entries when the
// filename is unchanged. Bump the number when a bundle change doesn't seem
// to reach clients.
/datum/asset/simple/tgui_v2
	keep_local_name = TRUE
	assets = list(
		"tgui2.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui2.bundle.css" = file("tgui/public/tgui.bundle.css"),
		"tgui.acs.css" = file("html/acs.css"),
	)

// v3: clients were serving stale tgui2 bundles (pre close-handshake fixes),
// which swallowed x-button suspends entirely. New filename forces a
// re-download of the fixed bundle.
/datum/asset/simple/tgui_v3
	keep_local_name = TRUE
	assets = list(
		"tgui3.bundle.js" = file("tgui/public/tgui.bundle.js"),
		"tgui3.bundle.css" = file("tgui/public/tgui.bundle.css"),
		"tgui.acs.css" = file("html/acs.css"),
	)

/datum/asset/simple/tgui_panel
	keep_local_name = TRUE
	assets = list(
		"tgui-panel.bundle.js" = file("tgui/public/tgui-panel.bundle.js"),
		"tgui-panel.bundle.css" = file("tgui/public/tgui-panel.bundle.css"),
	)
