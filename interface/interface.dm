//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki()
	set name = "Wiki"
	set desc = "Visit the wiki."
	set hidden = 1
	if(config.wikiurl)
		if(tgui_alert(src, "This will open the wiki in your browser. Are you sure?", null, list("Yes", "No")) == "Yes")
			send_link(src, config.wikiurl)
	else
		to_chat(src, SPAN_WARNING("The wiki URL is not set in the server configuration."))

/client/verb/discord()
	set name = "Discord"
	set desc = "Visit the Discord server."
	set hidden = 1
	if(config.discordurl)
		if(tgui_alert(src, "This will open the Discord invition link in your browser. Are you sure?", null, list("Yes", "No")) == "Yes")
			send_link(src, config.discordurl)
	else
		to_chat(src, SPAN_WARNING("The Discord server URL is not set in the server configuration."))

/client/verb/github()
	set name = "GitHub"
	set desc = "Visit the GitHub repository."
	set hidden = 1
	if(config.githuburl)
		if(tgui_alert(src, "This will open GitHub in your browser. Are you sure?", null, list("Yes", "No")) == "Yes")
			send_link(src, config.githuburl)
	else
		to_chat(src, SPAN_WARNING("The github URL is not set in the server configuration."))

/client/verb/rules()
	set name = "Rules"
	set desc = "Show Server Rules."
	set hidden = 1
	if(config.rulesurl)
		if(tgui_alert(src, "This will open the forum in your browser. Are you sure?", null, list("Yes", "No")) == "Yes")
			send_link(src, config.rulesurl)
	else
		to_chat(src, SPAN_WARNING("The forum URL is not set in the server configuration."))

/client/verb/lore()
	set name = "Lore"
	set desc = "Links to the beginner Lore wiki."
	set hidden = 1
	if(config.loreurl)
		if(tgui_alert(src, "This will open the forum in your browser. Are you sure?", null, list("Yes", "No")) == "Yes")
			send_link(src, config.loreurl)
	else
		to_chat(src, SPAN_WARNING("The forum URL is not set in the server configuration."))

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	if(!GLOB.changelog_tgui)
		GLOB.changelog_tgui = new /datum/changelog()

	GLOB.changelog_tgui.tgui_interact(mob)
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")
