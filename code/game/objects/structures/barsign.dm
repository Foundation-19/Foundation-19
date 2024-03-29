/obj/structure/sign/double/barsign
	name = "bar sign"
	desc = "A bar sign that hasn't properly initialized. Notify a coder."
	icon = 'icons/obj/barsigns.dmi'
	icon_state = "off"
	appearance_flags = 0
	anchored = TRUE
	var/datum/barsign/chosen_sign

/obj/structure/sign/double/barsign/Initialize()
	. = ..()
	set_sign(new /datum/barsign/signoff)

/obj/structure/sign/double/barsign/attackby(obj/item/I, mob/user)
	var/obj/item/card/id/card = I.GetIdCard()
	if(istype(card))
		if(ACCESS_BAR in card.GetAccess())
			pick_sign(user)
		else
			to_chat(user, SPAN_WARNING("Access denied."))
		return
	return ..()

/obj/structure/sign/double/barsign/proc/set_sign(datum/barsign/sign)
	if(!istype(sign))
		return

	chosen_sign = sign

	name = "[initial(name)] ([sign.name])"
	icon_state = sign.icon
	desc = sign.desc

/obj/structure/sign/double/barsign/proc/set_sign_by_name(sign_name)
	for(var/d in subtypesof(/datum/barsign))
		var/datum/barsign/D = d
		if(initial(D.name) == sign_name)
			var/new_sign = new D
			set_sign(new_sign)

/obj/structure/sign/double/barsign/proc/pick_sign(mob/user)
	var/picked_name = tgui_input_list(user, "Available Signage", "Bar Sign", sort_list(get_bar_names()))
	if(isnull(picked_name))
		return
	set_sign_by_name(picked_name)

/proc/get_bar_names()
	var/list/names = list()
	for(var/d in subtypesof(/datum/barsign))
		var/datum/barsign/D = d
		if(!initial(D.hidden))
			names += initial(D.name)
	. = names

/datum/barsign
	var/name
	var/icon
	var/desc
	var/hidden = FALSE	// hidden from selection menu
	var/rename = TRUE	// renames sign when chosen

// Barsign datums

/datum/barsign/alohasnackbar
	name = "The Aloha Snackbar"
	icon = "alohasnackbar"
	desc = "A tasteful, inoffensive tiki bar sign."

/datum/barsign/armoksbargrill
	name = "Armok's Bar and Grill"
	icon = "armoksbargrill"
	desc = ""

/datum/barsign/brokendrum
	name = "The Broken Drum"
	icon = "brokendrum"
	desc = ""

/datum/barsign/drunkengod
	name = "Church of the Drunken God"
	icon = "drunkengod"
	desc = "The drunk answers only to Beer, for his mouth consumes His body."

/datum/barsign/cavern
	name = "The Cavern"
	icon = "cavern"
	desc = ""

/datum/barsign/cindikate
	name = "Cindi Kate's"
	icon = "cindikate"
	desc = ""

/datum/barsign/clownshead
	name = "The Clown's Head"
	icon = "clownshead"
	desc = ""

/datum/barsign/coderbus
	name = "The Coderbus"
	icon = "coderbus"
	desc = "A very controversial bar known for its wide variety of constantly-changing drinks."

/datum/barsign/damnwall
	name = "The Damn Wall"
	icon = "damnwall"
	desc = ""

/datum/barsign/drunkcarp
	name = "The Drunk Carp"
	icon = "drunkcarp"
	desc = "Don't drink and swim."

/datum/barsign/harmbaton
	name = "The Harmbaton"
	icon = "harmbaton"
	desc = "A smashingly good time. Free drinks for security officers!"

/datum/barsign/honkednloaded
	name = "Honked 'n' Loaded"
	icon = "honkednloaded"
	desc = "Honk."

/datum/barsign/limbo
	name = "The Limbo"
	icon = "limbo"
	desc = ""

/datum/barsign/magmasea
	name = "The Magma Sea"
	icon = "magmasea"
	desc = ""

/datum/barsign/maltesefalcon
	name = "The Maltese Falcon"
	icon = "maltesefalcon"
	desc = "The Maltese Falcon, famous bar and grill."

/datum/barsign/meadbay
	name = "Mead Bay"
	icon = "meadbay"
	desc = ""

/datum/barsign/orchard
	name = "The Orchard"
	icon = "orchard"
	desc = ""

/datum/barsign/pinkflamingo
	name = "The Pink Flamingo"
	icon = "pinkflamingo"
	desc = ""

/datum/barsign/rustyaxe
	name = "The Rusty Axe"
	icon = "rustyaxe"
	desc = ""

/datum/barsign/saucyclown
	name = "The Saucy Clown"
	icon = "saucyclown"
	desc = ""

/datum/barsign/shaken
	name = "The Shaken"
	icon = "shaken"
	desc = "This establishment does not serve stirred drinks."

/datum/barsign/shotscrapspints
	name = "Shots, Craps, Pints"
	icon = "shotscrapspints"
	desc = "The Foundation's Finest."

// Hidden barsigns

/datum/barsign/signoff
	name = "Off"
	icon = "off"
	desc = "The sign appears to be switched off."
	hidden = TRUE
	rename = FALSE

/datum/barsign/scp078
	name = "Too Late to Die Young"
	icon = "toolate"
	desc = "A pink neon sign approximately one and a half meters long that displays the phrase \"TOO LATE TO DIE YOUNG\""
	hidden = TRUE
