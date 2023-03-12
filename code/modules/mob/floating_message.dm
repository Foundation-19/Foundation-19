// Thanks to Burger from Burgerstation for the foundation for this
var/global/list/floating_chat_colors = list()

/// How long the chat message's spawn-in animation will occur for
#define CHAT_MESSAGE_SPAWN_TIME 0.2 SECONDS
/// How long the chat message will exist prior to any exponential decay
#define CHAT_MESSAGE_LIFESPAN 5 SECONDS
/// How long the chat message's end of life fading animation will occur for
#define CHAT_MESSAGE_EOL_FADE 0.7 SECONDS
/// Max width of chat message in pixels
#define CHAT_MESSAGE_WIDTH 128
/// Max width of chat message in pixels
#define CHAT_MESSAGE_HEIGHT 64

/atom/movable
	var/list/stored_chat_text

/atom/movable/proc/animate_chat(message, datum/language/language, small, list/show_to, whisper = FALSE, unique_messages = null, duration = CHAT_MESSAGE_LIFESPAN)
	set waitfor = FALSE

	/// Get rid of any URL schemes that might cause BYOND to automatically wrap something in an anchor tag
	var/static/regex/url_scheme = new(@"[A-Za-z][A-Za-z0-9+-\.]*:\/\/", "g")
	message = replacetext(message, url_scheme, "")

	var/static/regex/html_metachars = new(@"&[A-Za-z]{1,7};", "g")
	message = replacetext(message, html_metachars, "")

	//additional style params for the message
	var/style
	var/fontsize = 7
	var/limit = 120

	if(small)
		fontsize = 6

	if(copytext(message, length(message) - 1) == "!!")
		fontsize = 8
		limit = 60
		style += "font-weight: bold;"

	if(length(message) > limit)
		message = "[copytext(message, 1, limit)]..."

	if(!global.floating_chat_colors[name])
		global.floating_chat_colors[name] = get_random_colour(0, 160, 230)
	style += "color: [global.floating_chat_colors[name]];"

	// create 2 messages, one that appears if you know the language, and one that appears when you don't know the language
	var/image/understood = generate_floating_text(src, capitalize(message), style, fontsize, duration, show_to)
	var/image/gibberish = language ? generate_floating_text(src, language.scramble(message), style, fontsize, duration, show_to) : understood

	//hack for unique messages, i.e. misunderstood whispers
	for(var/client/client in unique_messages)
		var/image/unique = generate_floating_text(src, capitalize(unique_messages[client]), style, fontsize, duration, show_to)

		show_to -= client //remove the client from the normal list if we're giving them a unique response to this
		var/mob/living/carbon/human/H
		if(ishuman(client.mob))
			H = client.mob
		if((ishuman(client.mob) ? H.can_hear() : !isdeaf(client.mob)) && client.get_preference_value(/datum/client_preference/floating_messages) == GLOB.PREF_SHOW)
			client.images += unique


	for(var/client/C in show_to)
		var/mob/living/carbon/human/H
		if(ishuman(C.mob))
			H = C.mob
		if((ishuman(C.mob) ? H.can_hear() : !isdeaf(C.mob)) && C.get_preference_value(/datum/client_preference/floating_messages) == GLOB.PREF_SHOW)
			if(C.mob.say_understands(null, language))
				C.images += understood
			else
				C.images += gibberish

/proc/generate_floating_text(atom/movable/holder, message, style, size, duration, show_to)
	var/image/I = image(null, get_atom_on_turf(holder))
	I.layer=FLY_LAYER
	I.alpha = 0
	I.maptext_width = CHAT_MESSAGE_WIDTH
	I.maptext_height = CHAT_MESSAGE_HEIGHT
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	I.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	I.pixel_w = -round(I.maptext_width/2) + 16

	style = "font-family: 'Small Fonts'; -dm-text-outline: 1px black; font-size: [size]px; line-height: 1.1; [style]"
	I.maptext = "<center><span style=\"[style]\">[message]</span></center>"
	animate(I, CHAT_MESSAGE_SPAWN_TIME, alpha = 255, pixel_z = 16)

	var/move_up_z = 10
	for(var/image/old in holder.stored_chat_text)
		var/pixel_z_new = old.pixel_z + move_up_z
		animate(old, CHAT_MESSAGE_SPAWN_TIME, pixel_z = pixel_z_new)
	LAZYADD(holder.stored_chat_text, I)

	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_floating_text, holder, I), duration)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/remove_images_from_clients, I, show_to), duration + CHAT_MESSAGE_SPAWN_TIME)

	return I

/proc/remove_floating_text(atom/movable/holder, image/I)
	animate(I, CHAT_MESSAGE_EOL_FADE, pixel_z = I.pixel_z + 12, alpha = 0, flags = ANIMATION_PARALLEL)
	LAZYREMOVE(holder.stored_chat_text, I)

/proc/remove_images_from_clients(image/I, list/show_to)
	for(var/client/C in show_to)
		C.images -= I
		qdel(I)

#undef CHAT_MESSAGE_SPAWN_TIME
#undef CHAT_MESSAGE_LIFESPAN
#undef CHAT_MESSAGE_EOL_FADE
#undef CHAT_MESSAGE_WIDTH
#undef CHAT_MESSAGE_HEIGHT
