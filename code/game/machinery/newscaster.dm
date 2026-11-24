//##############################################
//################### NEWSCASTERS BE HERE! ####
//###-Agouri###################################

/datum/feed_message
	var/author =""
	var/body =""
	var/message_type ="Story"
	var/datum/feed_channel/parent_channel
	var/is_admin_message = 0
	var/icon/img = null
	var/icon/caption = ""
	var/time_stamp = ""
	var/backup_body = ""
	var/backup_author = ""
	var/icon/backup_img = null
	var/icon/backup_caption = ""

/datum/feed_channel
	var/channel_name=""
	var/list/datum/feed_message/messages = list()
	var/locked=0
	var/author=""
	var/backup_author=""
	var/views=0
	var/censored=0
	var/is_admin_channel=0
	var/updated = 0
	var/announcement = ""


/datum/feed_message/proc/clear()
	src.author = ""
	src.body = ""
	src.caption = ""
	src.img = null
	src.time_stamp = ""
	src.backup_body = ""
	src.backup_author = ""
	src.backup_caption = ""
	src.backup_img = null
	parent_channel.update()

/datum/feed_channel/proc/update()
	updated = world.time

/datum/feed_channel/proc/clear()
	src.channel_name = ""
	src.messages = list()
	src.locked = 0
	src.author = ""
	src.backup_author = ""
	src.censored = 0
	src.is_admin_channel = 0
	src.announcement = ""
	update()
/datum/feed_network
	var/list/datum/feed_channel/network_channels = list()
	var/datum/feed_message/wanted_issue
	var/list/newscasters = list()
	var/list/news_programs = list()
	var/list/z_levels = list()

/datum/feed_network/New()
	CreateFeedChannel("Announcements", "SS13", 1, 1, "New Announcement Available")

/datum/feed_network/proc/CreateFeedChannel(channel_name, author, locked, adminChannel = 0, announcement_message)
	var/datum/feed_channel/newChannel = new /datum/feed_channel
	newChannel.channel_name = channel_name
	newChannel.author = author
	newChannel.locked = locked
	newChannel.is_admin_channel = adminChannel
	if(announcement_message)
		newChannel.announcement = announcement_message
	else
		newChannel.announcement = "Breaking news from [channel_name]!"
	network_channels += newChannel

/datum/feed_network/proc/SubmitArticle(msg, author, channel_name, obj/item/photo/photo, adminMessage = 0, message_type = "")
	var/datum/feed_message/newMsg = new /datum/feed_message
	newMsg.author = author
	newMsg.body = msg
	newMsg.time_stamp = "[station_time_timestamp("hh:mm")]"
	newMsg.is_admin_message = adminMessage
	if(message_type)
		newMsg.message_type = message_type
	if(photo)
		newMsg.img = photo.img
		newMsg.caption = photo.scribble
	for(var/datum/feed_channel/FC in network_channels)
		if(FC.channel_name == channel_name)
			insert_message_in_channel(FC, newMsg) //Adding message to the network's appropriate feed_channel
			break

/datum/feed_network/proc/insert_message_in_channel(datum/feed_channel/FC, datum/feed_message/newMsg)
	FC.messages += newMsg
	if(newMsg.img)
		SSassets.transport.register_asset("newscaster_photo_[sanitize(FC.channel_name)]_[FC.messages.len].png", newMsg.img)
	newMsg.parent_channel = FC
	FC.update()
	alert_readers(FC.announcement)

/datum/feed_network/proc/alert_readers(annoncement)
	for(var/obj/machinery/newscaster/NEWSCASTER in newscasters)
		NEWSCASTER.newsAlert(annoncement)
		NEWSCASTER.update_icon()
	for(var/datum/nano_module/program/newscast/program in news_programs)
		program.news_alert(annoncement)

var/list/datum/feed_network/news_network = list()     //The global news-network, which is coincidentally a global list.

var/list/obj/machinery/newscaster/allCasters = list() //Global list that will contain reference to all newscasters in existence.


/obj/machinery/newscaster
	name = "newscaster"
	desc = "A standard newsfeed handler. All the news you absolutely have no use for, in one place!"
	icon = 'icons/obj/terminals.dmi'
	icon_state = "newscaster_normal"
	//var/list/datum/feed_channel/channel_list = list() //This list will contain the names of the feed channels. Each name will refer to a data region where the messages of the feed channels are stored.
	var/screen = 0
		// 0 = welcome screen - main menu
		// 1 = view feed channels
		// 2 = create feed channel
		// 3 = create feed story
		// 4 = feed story submited sucessfully
		// 5 = feed channel created successfully
		// 6 = ERROR: Cannot create feed story
		// 7 = ERROR: Cannot create feed channel
		// 8 = print newspaper
		// 9 = viewing channel feeds
		// 10 = censor feed story
		// 11 = censor feed channel
		//Holy shit this is outdated, made this when I was still starting newscasters :3
	var/paper_remaining = 0
	var/securityCaster = 0
		// 0 = Caster cannot be used to issue wanted posters
		// 1 = the opposite
	var/unit_no = 0 //Each newscaster has a unit number
	//var/datum/feed_message/wanted //We're gonna use a feed_message to store data of the wanted person because fields are similar
	//var/wanted_issue = 0          //OBSOLETE
		// 0 = there's no WANTED issued, we don't need a special icon_state
		// 1 = Guess what.
	var/alert_delay = 500
	var/alert = 0
		// 0 = there hasn't been a news/wanted update in the last alert_delay
		// 1 = there has
	var/scanned_user = "Unknown" //Will contain the name of the person who currently uses the newscaster
	var/msg = "";                //Feed message
	var/datum/news_photo/photo_data = null
	var/channel_name = ""; //the feed channel which will be receiving the feed, or being created
	var/c_locked=0;        //Will our new channel be locked to public submissions?
	var/hitstaken = 0      //Death at 3 hits from an item with force>=15
	var/datum/feed_channel/viewing_channel = null
	var/datum/feed_network/connected_group
	light_outer_range = 0
	anchored = TRUE
	layer = ABOVE_WINDOW_LAYER

/obj/machinery/newscaster/security_unit
	name = "Security Newscaster"
	securityCaster = 1

/obj/machinery/newscaster/Initialize()
	. = ..()

	for (var/datum/feed_network/G in news_network)
		if (src.z in G.z_levels)
			G.newscasters += src
			connected_group = G

			break

	if (!connected_group)
		var/datum/feed_network/G = new /datum/feed_network
		G.newscasters += src
		G.z_levels = GetConnectedZlevels(src.z)

		connected_group = G
		LAZYADD(news_network, G)

	src.paper_remaining = 15            // Will probably change this to something better
	for (var/obj/machinery/newscaster/NEWSCASTER in connected_group.newscasters) // Let's give it an appropriate unit number
		src.unit_no++
	src.update_icon() //for any custom ones on the map...

/obj/machinery/newscaster/Destroy()
	if (connected_group)
		connected_group.newscasters -= src
	..()

/obj/machinery/newscaster/on_update_icon()
	if(inoperable())
		icon_state = "newscaster_off"
		if(stat & BROKEN) //If the thing is smashed, add crack overlay on top of the unpowered sprite.
			cut_overlays()
			add_overlay(image(src.icon, "crack3"))
		return

	src.cut_overlays() //reset overlays

	if(connected_group.wanted_issue) //wanted icon state, there can be no overlays on it as it's a priority message
		icon_state = "newscaster_wanted"
		return

	if(alert) //new message alert overlay
		src.add_overlay("newscaster_alert")

	if(hitstaken > 0) //Cosmetic damage overlay
		src.add_overlay(image(src.icon, "crack[hitstaken]"))

	icon_state = "newscaster_normal"
	return

/obj/machinery/newscaster/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/newscaster/tgui_interact(mob/user, datum/tgui/ui)
	if(!istype(user, /mob/living/carbon/human) && !istype(user, /mob/living/silicon))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Newscaster", "Newscaster")
		ui.open()

/obj/machinery/newscaster/tgui_data(mob/user)
	if(istype(user, /mob/living/carbon/human) || istype(user, /mob/living/silicon))
		scan_user(user)
	var/list/data = list()
	data["screen"] = screen
	data["unit_no"] = unit_no
	data["scanned_user"] = scanned_user
	data["security"] = securityCaster ? 1 : 0
	data["channel_name"] = channel_name
	data["c_locked"] = c_locked
	data["msg"] = msg
	data["paper_remaining"] = paper_remaining
	data["company"] = GLOB.using_map.company_name
	data["station"] = station_name()
	data["has_photo"] = (photo_data && photo_data.photo) ? 1 : 0
	data["photo"] = (photo_data && photo_data.photo && photo_data.photo.img) ? icon2html(photo_data.photo.img, user.client, sourceonly = TRUE) : null

	var/list/channels = list()
	var/list/errors = list()
	var/list/stats = list()
	var/list/viewing = null
	var/list/wanted = null

	if(connected_group)
		for(var/datum/feed_channel/CHANNEL in connected_group.network_channels)
			channels += list(list(
				"ref" = "\ref[CHANNEL]",
				"name" = CHANNEL.channel_name,
				"admin" = CHANNEL.is_admin_channel ? 1 : 0,
				"censored" = CHANNEL.censored ? 1 : 0,
			))

		var/total_num = length(connected_group.network_channels)
		var/active_num = total_num
		var/message_num = 0
		for(var/datum/feed_channel/FC in connected_group.network_channels)
			if(!FC.censored)
				message_num += length(FC.messages)
			else
				active_num--
		stats = list("total" = total_num, "active" = active_num, "messages" = message_num)

		if(connected_group.wanted_issue)
			var/datum/feed_message/W = connected_group.wanted_issue
			wanted = list(
				"author" = W.author,
				"body" = W.body,
				"backup_author" = W.backup_author,
				"img" = W.img ? icon2html(W.img, user.client, sourceonly = TRUE) : null,
			)

	data["channels"] = channels
	data["stats"] = stats
	data["wanted"] = wanted ? 1 : 0
	data["wanted_issue"] = wanted

	if(viewing_channel)
		if(screen == 9)
			++viewing_channel.views
		viewing = list(
			"ref" = "\ref[viewing_channel]",
			"name" = viewing_channel.channel_name,
			"author" = viewing_channel.author,
			"author_censored" = (viewing_channel.author == "<B>\[REDACTED\]</B>") ? 1 : 0,
			"censored" = viewing_channel.censored ? 1 : 0,
			"views" = viewing_channel.views,
		)
		var/list/messages = list()
		for(var/datum/feed_message/MESSAGE in viewing_channel.messages)
			messages += list(list(
				"ref" = "\ref[MESSAGE]",
				"body" = MESSAGE.body,
				"body_censored" = (MESSAGE.body == "<B>\[REDACTED\]</B>") ? 1 : 0,
				"author" = MESSAGE.author,
				"author_censored" = (MESSAGE.author == "<B>\[REDACTED\]</B>") ? 1 : 0,
				"type" = MESSAGE.message_type,
				"time" = MESSAGE.time_stamp,
				"img" = MESSAGE.img ? icon2html(MESSAGE.img, user.client, sourceonly = TRUE) : null,
				"caption" = MESSAGE.caption,
			))
		viewing["messages"] = messages
	data["viewing"] = viewing

	if(screen == 6)
		if(channel_name == "")
			errors += "Invalid receiving channel name."
		if(scanned_user == "Unknown")
			errors += "Channel author unverified."
		if(msg == "" || msg == "\[REDACTED\]")
			errors += "Invalid message body."
	else if(screen == 7)
		var/list/existing_authors = list()
		for(var/datum/feed_channel/FC in connected_group.network_channels)
			if(FC.author == "\[REDACTED\]")
				existing_authors += FC.backup_author
			else
				existing_authors += FC.author
		if(scanned_user in existing_authors)
			errors += "There already exists a Feed channel under your name."
		if(channel_name == "" || channel_name == "\[REDACTED\]")
			errors += "Invalid channel name."
		var/check = 0
		for(var/datum/feed_channel/FC in connected_group.network_channels)
			if(FC.channel_name == channel_name)
				check = 1
				break
		if(check)
			errors += "Channel name already in use."
		if(scanned_user == "Unknown")
			errors += "Channel author unverified."
	else if(screen == 16)
		if(channel_name == "" || channel_name == "\[REDACTED\]")
			errors += "Invalid name for person wanted."
		if(scanned_user == "Unknown")
			errors += "Issue author unverified."
		if(msg == "" || msg == "\[REDACTED\]")
			errors += "Invalid description."
	data["errors"] = errors
	return data

/obj/machinery/newscaster/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if(!((src in usr.contents) || ((get_dist(src, usr) <= 1) && istype(src.loc, /turf)) || (istype(usr, /mob/living/silicon))))
		return TRUE
	usr.set_machine(src)

	switch(action)
		if("set_channel_name")
			src.channel_name = sanitizeSafe(input(usr, "Provide a Feed Channel Name", "Network Channel Handler", ""), MAX_LNAME_LEN)
			return TRUE

		if("set_channel_lock")
			src.c_locked = !src.c_locked
			return TRUE

		if("submit_new_channel")
			var/list/existing_authors = list()
			for(var/datum/feed_channel/FC in connected_group.network_channels)
				if(FC.author == "\[REDACTED\]")
					existing_authors += FC.backup_author
				else
					existing_authors += FC.author
			var/check = 0
			for(var/datum/feed_channel/FC in connected_group.network_channels)
				if(FC.channel_name == src.channel_name)
					check = 1
					break
			if(src.channel_name == "" || src.channel_name == "\[REDACTED\]" || src.scanned_user == "Unknown" || check || (src.scanned_user in existing_authors))
				src.screen = 7
			else
				var/choice = alert("Please confirm Feed channel creation","Network Channel Handler","Confirm","Cancel")
				if(choice=="Confirm")
					connected_group.CreateFeedChannel(src.channel_name, src.scanned_user, c_locked)
					src.screen = 5
			return TRUE

		if("set_channel_receiving")
			var/list/available_channels = list()
			for(var/datum/feed_channel/F in connected_group.network_channels)
				if((!F.locked || F.author == scanned_user) && !F.censored)
					available_channels += F.channel_name
			src.channel_name = input(usr, "Choose receiving Feed Channel", "Network Channel Handler") in available_channels
			return TRUE

		if("set_new_message")
			src.msg = sanitize(input(usr, "Write your Feed story", "Network Channel Handler", ""))
			return TRUE

		if("set_attachment")
			AttachPhoto(usr)
			return TRUE

		if("submit_new_message")
			if(src.msg =="" || src.msg=="\[REDACTED\]" || src.scanned_user == "Unknown" || src.channel_name == "" )
				src.screen = 6
			else
				var/image = photo_data ? photo_data.photo : null
				SSstatistics.add_field("newscaster_stories",1)
				connected_group.SubmitArticle(src.msg, src.scanned_user, src.channel_name, image, 0)
				if(photo_data)
					qdel(photo_data)
					photo_data = null
				src.screen = 4
			return TRUE

		if("create_channel")
			src.screen = 2
			return TRUE

		if("create_feed_story")
			src.screen = 3
			return TRUE

		if("menu_paper")
			src.screen = 8
			return TRUE

		if("print_paper")
			if(!src.paper_remaining)
				src.screen = 21
			else
				src.print_paper()
				src.screen = 20
			return TRUE

		if("menu_censor_story")
			src.screen = 10
			return TRUE

		if("menu_censor_channel")
			src.screen = 11
			return TRUE

		if("menu_wanted")
			var/already_wanted = 0
			if(connected_group.wanted_issue)
				already_wanted = 1
			if(already_wanted)
				src.channel_name = connected_group.wanted_issue.author
				src.msg = connected_group.wanted_issue.body
			src.screen = 14
			return TRUE

		if("set_wanted_name")
			src.channel_name = sanitizeSafe(input(usr, "Provide the name of the Wanted person", "Network Security Handler", ""), MAX_LNAME_LEN)
			return TRUE

		if("set_wanted_desc")
			src.msg = sanitize(input(usr, "Provide the a description of the Wanted person and any other details you deem important", "Network Security Handler", ""))
			return TRUE

		if("submit_wanted")
			var/input_param = text2num(params["end_param"])
			if(src.msg == "" || src.channel_name == "" || src.scanned_user == "Unknown")
				src.screen = 16
			else
				var/choice = alert("Please confirm Wanted Issue [(input_param==1) ? ("creation.") : ("edit.")]","Network Security Handler","Confirm","Cancel")
				if(choice=="Confirm")
					if(input_param==1)
						var/datum/feed_message/WANTED = new /datum/feed_message
						WANTED.author = src.channel_name
						WANTED.body = src.msg
						WANTED.backup_author = src.scanned_user
						if(photo_data)
							WANTED.img = photo_data.photo.img
						connected_group.wanted_issue = WANTED
						connected_group.alert_readers()
						src.screen = 15
					else
						if(connected_group.wanted_issue.is_admin_message)
							alert("The wanted issue has been distributed by a [GLOB.using_map.company_name] higherup. You cannot edit it.","Ok")
							return TRUE
						connected_group.wanted_issue.author = src.channel_name
						connected_group.wanted_issue.body = src.msg
						connected_group.wanted_issue.backup_author = src.scanned_user
						if(photo_data)
							connected_group.wanted_issue.img = photo_data.photo.img
						src.screen = 19
			return TRUE

		if("cancel_wanted")
			if(connected_group.wanted_issue.is_admin_message)
				alert("The wanted issue has been distributed by a [GLOB.using_map.company_name] higherup. You cannot take it down.","Ok")
				return TRUE
			var/choice = alert("Please confirm Wanted Issue removal","Network Security Handler","Confirm","Cancel")
			if(choice=="Confirm")
				connected_group.wanted_issue = null
				for(var/obj/machinery/newscaster/NEWSCASTER in connected_group.newscasters)
					NEWSCASTER.update_icon()
				src.screen=17
			return TRUE

		if("view_wanted")
			src.screen = 18
			return TRUE

		if("censor_channel_author")
			var/datum/feed_channel/FC = locate(params["ref"])
			if(FC.is_admin_channel)
				alert("This channel was created by a [GLOB.using_map.company_name] Officer. You cannot censor it.","Ok")
				return TRUE
			if(FC.author != "<B>\[REDACTED\]</B>")
				FC.backup_author = FC.author
				FC.author = "<B>\[REDACTED\]</B>"
			else
				FC.author = FC.backup_author
			FC.update()
			return TRUE

		if("censor_channel_story_author")
			var/datum/feed_message/MSG = locate(params["ref"])
			if(MSG.is_admin_message)
				alert("This message was created by a [GLOB.using_map.company_name] Officer. You cannot censor its author.","Ok")
				return TRUE
			if(MSG.author != "<B>\[REDACTED\]</B>")
				MSG.backup_author = MSG.author
				MSG.author = "<B>\[REDACTED\]</B>"
			else
				MSG.author = MSG.backup_author
			MSG.parent_channel.update()
			return TRUE

		if("censor_channel_story_body")
			var/datum/feed_message/MSG = locate(params["ref"])
			if(MSG.is_admin_message)
				alert("This channel was created by a [GLOB.using_map.company_name] Officer. You cannot censor it.","Ok")
				return TRUE
			if(MSG.body != "<B>\[REDACTED\]</B>")
				MSG.backup_body = MSG.body
				MSG.backup_caption = MSG.caption
				MSG.backup_img = MSG.img
				MSG.body = "<B>\[REDACTED\]</B>"
				MSG.caption = "<B>\[REDACTED\]</B>"
				MSG.img = null
			else
				MSG.body = MSG.backup_body
				MSG.caption = MSG.caption
				MSG.img = MSG.backup_img
			MSG.parent_channel.update()
			return TRUE

		if("pick_d_notice")
			var/datum/feed_channel/FC = locate(params["ref"])
			src.viewing_channel = FC
			src.screen = 13
			return TRUE

		if("toggle_d_notice")
			var/datum/feed_channel/FC = locate(params["ref"])
			if(FC.is_admin_channel)
				alert("This channel was created by a [GLOB.using_map.company_name] Officer. You cannot place a D-Notice upon it.","Ok")
				return TRUE
			FC.censored = !FC.censored
			FC.update()
			return TRUE

		if("view")
			src.screen = 1
			return TRUE

		if("setScreen")
			src.screen = text2num(params["screen"])
			if (src.screen == 0)
				src.scanned_user = "Unknown"
				msg = ""
				src.c_locked = 0
				channel_name = ""
				src.viewing_channel = null
				if (photo_data)
					qdel(photo_data)
					photo_data = null
			return TRUE

		if("show_channel")
			var/datum/feed_channel/FC = locate(params["ref"])
			src.viewing_channel = FC
			src.screen = 9
			return TRUE

		if("pick_censor_channel")
			var/datum/feed_channel/FC = locate(params["ref"])
			src.viewing_channel = FC
			src.screen = 12
			return TRUE

		if("refresh")
			return TRUE

	return FALSE

/obj/machinery/newscaster/attackby(obj/item/I, mob/user)
	if (user.a_intent == I_HURT)
		user.setClickCooldown(CLICK_CD_ATTACK)
		if (I.force < 15)
			visible_message(SPAN_WARNING("\The [user] uselessly bops \the [src] with \an [I]."))
		else if (stat & BROKEN)
			visible_message(SPAN_WARNING("\The [user] further abuses the shattered [name]."))
			playsound(src, 'sounds/effects/hit_on_shattered_glass.ogg', 100, 1)
			show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
		else if (++hitstaken < 3)
			visible_message(SPAN_DANGER("\The [user] slams \the [src] with \an [I], cracking it!"))
			playsound(src, 'sounds/effects/Glassbr3.ogg', 100, 1)
			show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
		else
			visible_message(SPAN_DANGER("\The [user] smashes \the [src] with \an [I]!"))
			playsound(src, 'sounds/effects/Glasshit.ogg', 100, 1)
			show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
			set_broken(TRUE)
			update_icon()
		return TRUE
	else
		. = ..()

/datum/news_photo
	var/is_synth = 0
	var/obj/item/photo/photo = null

/datum/news_photo/New(obj/item/photo/p, synth)
	is_synth = synth
	photo = p

/obj/machinery/newscaster/proc/AttachPhoto(mob/user as mob)
	if(photo_data)
		qdel(photo_data)
		photo_data = null
		return

	if(istype(user.get_active_hand(), /obj/item/photo))
		var/obj/item/photo = user.get_active_hand()
		photo_data = new(photo, 0)
	else if(istype(user,/mob/living/silicon))
		var/mob/living/silicon/tempAI = user
		var/obj/item/photo/selection = tempAI.GetPicture()
		if (!selection)
			return

		photo_data = new(selection, 1)


//########################################################################################################################
//###################################### NEWSPAPER! ######################################################################
//########################################################################################################################

/obj/item/newspaper
	name = "newspaper"
	desc = "An issue of The Griffon, the space newspaper."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "newspaper"
	w_class = ITEM_SIZE_SMALL	//Let's make it fit in trashbags!
	attack_verb = list("bapped")
	var/screen = 0
	var/pages = 0
	var/curr_page = 0
	var/list/datum/feed_channel/news_content = list()
	var/datum/feed_message/important_message = null
	var/scribble=""
	var/scribble_page = null

/obj/item/newspaper/attack_self(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		var/dat
		src.pages = 0
		switch(screen)
			if(0) //Cover
				dat+="<DIV ALIGN='center'><B><FONT SIZE=6>The Griffon</FONT></B></div>"
				dat+="<DIV ALIGN='center'><FONT SIZE=2>[GLOB.using_map.company_name]-standard newspaper, for use on [GLOB.using_map.company_name] Space Facilities</FONT></div><HR>"
				if(!length(news_content))
					if(src.important_message)
						dat+="Contents:<BR><ul><B><FONT COLOR='red'>**</FONT>Important Security Announcement<FONT COLOR='red'>**</FONT></B> <FONT SIZE=2>\[page [src.pages+2]\]</FONT><BR></ul>"
					else
						dat+="<I>Other than the title, the rest of the newspaper is unprinted...</I>"
				else
					dat+="Contents:<BR><ul>"
					for(var/datum/feed_channel/NP in src.news_content)
						src.pages++
					if(src.important_message)
						dat+="<B><FONT COLOR='red'>**</FONT>Important Security Announcement<FONT COLOR='red'>**</FONT></B> <FONT SIZE=2>\[page [src.pages+2]\]</FONT><BR>"
					var/temp_page=0
					for(var/datum/feed_channel/NP in src.news_content)
						temp_page++
						dat+="<B>[NP.channel_name]</B> <FONT SIZE=2>\[page [temp_page+1]\]</FONT><BR>"
					dat+="</ul>"
				if(scribble_page==curr_page)
					dat+="<BR><I>There is a small scribble near the end of this page... It reads: \"[src.scribble]\"</I>"
				dat+= "<HR><DIV STYLE='float:right;'><A href='byond://?src=\ref[src];next_page=1'>Next Page</A></DIV> <div style='float:left;'><A href='byond://?src=\ref[human_user];mach_close=newspaper_main'>Done reading</A></DIV>"
			if(1) // X channel pages inbetween.
				for(var/datum/feed_channel/NP in src.news_content)
					src.pages++ //Let's get it right again.
				var/datum/feed_channel/C = src.news_content[src.curr_page]
				dat+="<FONT SIZE=4><B>[C.channel_name]</B></FONT><FONT SIZE=1> \[created by: <FONT COLOR='maroon'>[C.author]</FONT>\]</FONT><BR><BR>"
				if(C.censored)
					dat+="This channel was deemed dangerous to the general welfare of the [station_name()] and therefore marked with a <B><FONT COLOR='red'>D-Notice</B></FONT>. Its contents were not transferred to the newspaper at the time of printing."
				else
					if(!length(C.messages))
						dat+="No Feed stories stem from this channel..."
					else
						dat+="<ul>"
						var/i = 0
						for(var/datum/feed_message/MESSAGE in C.messages)
							++i
							dat+="-[MESSAGE.body] <BR>"
							if(MESSAGE.img)
								var/resource_name = "newscaster_photo_[sanitize(C.channel_name)]_[i].png"
								SSassets.transport.send_assets(user.client, SSassets.cache[resource_name])
								dat+="<img src='[resource_name]' width = '180'><BR>"
							dat+="<FONT SIZE=1>\[[MESSAGE.message_type] by <FONT COLOR='maroon'>[MESSAGE.author]</FONT>\]</FONT><BR><BR>"
						dat+="</ul>"
				if(scribble_page==curr_page)
					dat+="<BR><I>There is a small scribble near the end of this page... It reads: \"[src.scribble]\"</I>"
				dat+= "<BR><HR><DIV STYLE='float:left;'><A href='byond://?src=\ref[src];prev_page=1'>Previous Page</A></DIV> <DIV STYLE='float:right;'><A href='byond://?src=\ref[src];next_page=1'>Next Page</A></DIV>"
			if(2) //Last page
				for(var/datum/feed_channel/NP in src.news_content)
					src.pages++
				if(src.important_message!=null)
					dat+="<DIV STYLE='float:center;'><FONT SIZE=4><B>Wanted Issue:</B></FONT SIZE></DIV><BR><BR>"
					dat+="<B>Criminal name</B>: <FONT COLOR='maroon'>[important_message.author]</FONT><BR>"
					dat+="<B>Description</B>: [important_message.body]<BR>"
					dat+="<B>Photo:</B>: "
					if(important_message.img)
						send_rsc(user, important_message.img, "tmp_photow.png")
						dat+="<BR><img src='tmp_photow.png' width = '180'>"
					else
						dat+="None"
				else
					dat+="<I>Apart from some uninteresting Classified ads, there's nothing on this page...</I>"
				if(scribble_page==curr_page)
					dat+="<BR><I>There is a small scribble near the end of this page... It reads: \"[src.scribble]\"</I>"
				dat+= "<HR><DIV STYLE='float:left;'><A href='byond://?src=\ref[src];prev_page=1'>Previous Page</A></DIV>"
			else
				dat+="I'm sorry to break your immersion. This shit's bugged. Report this bug on GitHub or Discord."

		dat+="<BR><HR><div align='center'>[src.curr_page+1]</div>"
		var/datum/browser/popup = new(human_user, "newspaper_main", "Newspaper", 300, 400)
		popup.set_content(dat)
		popup.open()
		onclose(human_user, "newspaper_main")
	else
		to_chat(user, "The paper is full of intelligible symbols!")


/obj/item/newspaper/Topic(href, href_list)
	var/mob/living/U = usr
	..()
	if ((src in U.contents) || ( istype(loc, /turf) && in_range(src, U) ))
		U.set_machine(src)
		if(href_list["next_page"])
			if(curr_page==src.pages+1)
				return //Don't need that at all, but anyway.
			if(src.curr_page == src.pages) //We're at the middle, get to the end
				src.screen = 2
			else
				if(curr_page == 0) //We're at the start, get to the middle
					src.screen=1
			src.curr_page++
			playsound(src.loc, SFX_PAGETURN, 50, 1)

		else if(href_list["prev_page"])
			if(curr_page == 0)
				return
			if(curr_page == 1)
				src.screen = 0

			else
				if(curr_page == src.pages+1) //we're at the end, let's go back to the middle.
					src.screen = 1
			src.curr_page--
			playsound(src.loc, SFX_PAGETURN, 50, 1)

		if (istype(src.loc, /mob))
			src.attack_self(src.loc)


/obj/item/newspaper/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/pen))
		if(src.scribble_page == src.curr_page)
			to_chat(user, FONT_COLORED("blue","There's already a scribble in this page... You wouldn't want to make things too cluttered, would you?"))
		else
			var/s = sanitize(input(user, "Write something", "Newspaper", ""))
			s = sanitize(s)
			if (!s)
				return
			if (!in_range(src, usr) && src.loc != usr)
				return
			src.scribble_page = src.curr_page
			src.scribble = s
			src.attack_self(user)
		return


////////////////////////////////////helper procs


/obj/machinery/newscaster/proc/scan_user(mob/living/user as mob)
	if(istype(user,/mob/living/carbon/human))                       //User is a human
		var/mob/living/carbon/human/human_user = user
		var/obj/item/card/id/id = human_user.GetIdCard()
		if(istype(id))                                      //Newscaster scans you
			src.scanned_user = GetNameAndAssignmentFromId(id)
		else
			src.scanned_user = "Unknown"
	else
		var/mob/living/silicon/ai_user = user
		src.scanned_user = "[ai_user.name] ([ai_user.job])"


/obj/machinery/newscaster/proc/print_paper()
	SSstatistics.add_field("newscaster_newspapers_printed",1)
	var/obj/item/newspaper/NEWSPAPER = new /obj/item/newspaper
	for(var/datum/feed_channel/FC in connected_group.network_channels)
		NEWSPAPER.news_content += FC
	if(connected_group.wanted_issue)
		NEWSPAPER.important_message = connected_group.wanted_issue
	NEWSPAPER.dropInto(loc)
	src.paper_remaining--
	return

//Removed for now so these aren't even checked every tick. Left this here in-case Agouri needs it later.
///obj/machinery/newscaster/process()       //Was thinking of doing the icon update through process, but multiple iterations per second does not
//	return                                  //bode well with a newscaster network of 10+ machines. Let's just return it, as it's added in the machines list.

/obj/machinery/newscaster/proc/newsAlert(news_call)   //This isn't Agouri's work, for it is ugly and vile.
	var/turf/T = get_turf(src)                      //Who the fuck uses spawn(600) anyway, jesus christ
	if(news_call)
		for(var/mob/O in hearers(world.view-1, T))
			O.show_message(SPAN_CLASS("newscaster","<EM>[src.name]</EM> beeps, \"[news_call]\""),2)
		src.alert = 1
		src.update_icon()
		spawn(300)
			src.alert = 0
			src.update_icon()
		playsound(src.loc, 'sounds/machines/twobeep.ogg', 75, 1)
	else
		for(var/mob/O in hearers(world.view-1, T))
			O.show_message(SPAN_CLASS("newscaster","<EM>[src.name]</EM> beeps, \"Attention! Wanted issue distributed!\""),2)
		playsound(src.loc, 'sounds/machines/warning-buzzer.ogg', 75, 1)
	return
