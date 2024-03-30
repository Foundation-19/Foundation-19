// A paper that can automatically update its contents when used on certain things
/obj/item/paper/self_writing
	color = COLOR_PALE_BLUE_GRAY
	var/cooldown

/obj/item/paper/self_writing/on_update_icon()
	if(icon_state == "paper_talisman" || is_memo)
		return
	else if(info)
		icon_state = "paper_words"
	else
		icon_state = "paper"

/obj/item/paper/self_writing/afterattack(atom/A, mob/user, proximity)
	if(!proximity)
		return
	if(cooldown > world.time)
		to_chat(user, SPAN_WARNING("\The [src] is seemingly in a resting phase for now..."))
		return
	if(ishuman(A))
		cooldown = world.time + 40 SECONDS
		var/mob/living/carbon/human/H = A
		H.visible_message(\
			SPAN_DANGER("\The [src] shakes as words begin to form on it!"),
			SPAN_USERDANGER("\The [src] is surfing through your mind, pulling the ideas and words from it!")
			)
		info = null
		for(var/i = 1 to 3)
			if(!do_after(user, 5 SECONDS, H))
				to_chat(user, SPAN_WARNING("\The [src] stops absorbing words[i <= 1 ? " before it can do anything." : ", but it seems like it wasn't done yet..."]"))
				return
			playsound(src, pick('sounds/effects/pen1.ogg','sounds/effects/pen2.ogg'), 25)
			cooldown += 5 SECONDS
			switch(i)
				if(1)
					info = "<center><b><large>[H.real_name], [H.mind.role_alt_title]</large></b><br><i><small>Interviewed by [user.real_name], [user.mind.role_alt_title].</small></i></center><hr><br>"
					info += "Name: [H.real_name]<br>"
					info += "Job: [H.mind.assigned_role ? H.mind.assigned_role : "Unknown"]<br>"
					info += "Species: [H.species.name]<br>"
					info += "Age: [H.age]<br>"
					info += "Blood type: [H.b_type]<hr><br>"
				if(2)
					// TODO: Cultural info and other stuff
				if(3)
					if(H.humanStageHandler.getStage("Pestilence"))
						info += "<b>Affected by pestilence!</b><br>"
			to_chat(user, SPAN_NOTICE("\The [src] is done writing down the information!"))
		return
	if(isliving(A))
		cooldown = world.time + 20 SECONDS
		var/mob/living/L = A
		L.visible_message(SPAN_DANGER("\The [src] shakes as words rapidly form on it!"))
		info = "<center><b><large>[L.name]</large></b></center><br><i>[L.desc]</i><hr><br>"
		info += "Health status: [round(L.health / L.maxHealth, 0.01) * 100]%<br>"
		playsound(src, pick('sounds/effects/pen1.ogg','sounds/effects/pen2.ogg'), 25)
		return
	if(isitem(A) && !(A.type in GLOB.items_conversion_blacklist))
		cooldown = world.time + 10 SECONDS
		var/obj/item/I = A
		I.visible_message(SPAN_DANGER("\The [src] shakes as words rapidly form on it!"))
		info = "<center><b><large>[I.name]</large></b></center><br>"
		var/our_rating = I.Check914Rating()
		info += "It is a [our_rating].<br>"
		var/same_count = (our_rating in GLOB.items_by_convert_rating) ? length(GLOB.items_by_convert_rating[our_rating]) : "0"
		info += "There is exactly [same_count] items like this one in existence.<br>"
		playsound(src, pick('sounds/effects/pen1.ogg','sounds/effects/pen2.ogg'), 25)
		return
	cooldown = world.time + 5 SECONDS
	return ..()

// Does nothing for now...
/obj/item/paper/self_writing/Conversion914(mode = MODE_ONE_TO_ONE, mob/living/user = usr)
	return src
