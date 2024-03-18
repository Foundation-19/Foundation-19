/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the IC data card reader
 */
/obj/item/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/card.dmi'
	w_class = ITEM_SIZE_TINY
	slot_flags = SLOT_EARS

/obj/item/card/data
	name = "data card"
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has a stripe running down the middle."
	icon_state = "data_1"
	var/detail_color = COLOR_ASSEMBLY_ORANGE
	var/function = "storage"
	var/data = "null"
	var/special = null
	var/list/files = list(  )

/obj/item/card/data/Initialize()
	.=..()
	update_icon()
/* Create proc to disable overlays ~~ Lestat
/obj/item/card/data/on_update_icon()
	cut_overlays()
	var/image/detail_overlay = image('icons/obj/card.dmi', src,"[icon_state]-color")
	detail_overlay.color = detail_color
	add_overlay(detail_overlay)
*/
/obj/item/card/data/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/device/integrated_electronics/detailer))
		var/obj/item/device/integrated_electronics/detailer/D = I
		detail_color = D.detail_color
		update_icon()
	return ..()

/obj/item/card/data/full_color
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has the entire card colored."
	icon_state = "data_2"

/obj/item/card/data/disk
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one inexplicibly looks like a floppy disk."
	icon_state = "data_3"

/*
 * ID CARDS
 */

/obj/item/card/emag
	desc = "It's a blank ID card with a magnetic strip and some odd circuitry attached."
	name = "identification card"
	icon_state = "emag"
	item_state = "card-id"
	origin_tech = list(TECH_MAGNET = 2, TECH_ESOTERIC = 2)
	var/uses = 10

/obj/item/card/emag/resolve_attackby(atom/A, mob/user)
	if(uses<1)
		user.visible_message(SPAN_WARNING("\The [src] fizzles and sparks - it seems it's been used once too often."))
	else
		var/used_uses = A.emag_act(uses, user, src)
		if(used_uses == EMAG_NO_ACT)
			return ..(A, user)

		uses -= used_uses
		A.add_fingerprint(user)
		log_and_message_staff("emagged \an [A].")

	return 1

/obj/item/card/emag/examine(mob/user, distance)
	. = ..()
	if((distance <= 0) && (user.skill_check(SKILL_DEVICES, SKILL_TRAINED) || player_is_antag(user.mind)))
		switch(uses)
			if(10 to INFINITY)
				to_chat(user, SPAN_NOTICE("The card looks to be in a pristine condition!"))
			if(4 to 9)
				to_chat(user, SPAN_NOTICE("The card seems to be in normal working order."))
			if(1 to 3)
				to_chat(user, SPAN_NOTICE("The circuitry has visibly degraded, although the card does still look usable."))
			else
				to_chat(user, SPAN_WARNING("You can tell the components are completely fried; whatever use it may have had before is gone."))

/obj/item/card/emag/Initialize()
	. = ..()
	set_extension(src,/datum/extension/chameleon/emag)

/obj/item/card/emag/get_antag_info()
	. = ..()
	. += "You can use this cryptographic sequencer in order to subvert electronics or forcefully open doors you don't have access to. These actions are irreversible and the card only has a limited number of charges!"

// Fine - Sets uses to random amount between 5 and 15.
/obj/item/card/emag/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_FINE)
			uses = rand(5, 15)
			visible_message(SPAN_NOTICE("Electricity runs through \the [src] briefly."))
			playsound(src, 'sounds/effects/sparks3.ogg', 50, TRUE)
			return src
	return ..()

/obj/item/card/emag/broken
	uses = 0

/obj/item/card/id
	name = "identification card"
	desc = "A card used to provide ID and determine access."
	icon_state = "base"
	item_state = "card-id"
	slot_flags = SLOT_ID

	var/list/access = list()
	/// The name registered on the card
	var/registered_name = "Unknown"
	var/associated_account_number = 0
	var/list/associated_email_login = list("login" = "", "password" = "")

	var/age = "\[UNSET\]"
	var/blood_type = "\[UNSET\]"
	var/dna_hash = "\[UNSET\]"
	var/fingerprint_hash = "\[UNSET\]"
	var/sex = "\[UNSET\]"
	var/icon/front
	var/icon/side

	//alt titles are handled a bit weirdly in order to unobtrusively integrate into existing ID system
	// Alt-title if applicable, otherwise actual job name.
	var/assignment = null
	/// Actual job name, ignoring the alt-title
	var/rank = null

	/// determines if this ID has claimed a dorm already // TODO: delete this
	var/dorm = 0

	/// Job type to acquire access rights from, if any
	var/job_access_type

	/// What class this ID card represents.
	var/class = CLASS_C

	var/formal_name_prefix
	var/formal_name_suffix

	var/detail_color
	var/extra_details

/obj/item/card/id/Initialize()
	.=..()
	if(job_access_type)
		var/datum/job/j = SSjobs.get_by_path(job_access_type)
		if(j)
			rank = j.title
			assignment = rank
			class = j.class
			access |= j.get_access()
			if(!detail_color)
				detail_color = j.selection_color
	update_icon()
/*
/obj/item/card/id/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	ret.add_overlay(overlay_image(ret.icon, "[ret.icon_state]_colors", detail_color, RESET_COLOR))
	return ret

/obj/item/card/id/on_update_icon()
	cut_overlays()
	add_overlay(overlay_image(icon, "[icon_state]_colors", detail_color, RESET_COLOR))
	for(var/detail in extra_details)
		add_overlay(overlay_image(icon, detail, flags=RESET_COLOR))
*/
/obj/item/card/id/CanUseTopic(user)
	if(user in view(get_turf(src)))
		return STATUS_INTERACTIVE

/obj/item/card/id/OnTopic(mob/user, list/href_list)
	if(href_list["look_at_id"])
		if(istype(user))
			user.examinate(src)
			return TOPIC_HANDLED

/obj/item/card/id/examine(mob/user, distance)
	. = ..()
	to_chat(user, "It says '[get_display_name()]'.")
	if(distance <= 1)
		show(user)

/// List of ID cards that can be used in 914 conversion effect
GLOBAL_LIST_INIT(valid_conversion_cards, \
	subtypesof(/obj/item/card/id) - typesof(/obj/item/card/id/syndicate) - /obj/item/card/id/centcom)

/// Associative list of card = list of cards that it can upgrade into
GLOBAL_LIST_EMPTY(conversion_cards)

// 1:1 - Returns random ID card type and copies ALL of our access to it. Nothing gained, nothing lost, just new sprite.
// Fine - Returns an "upgrade" type of our card, but may turn into useless stuff.
// Very Fine - ???
/obj/item/card/id/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_ONE_TO_ONE)
			var/type_path = pick(GLOB.valid_conversion_cards)
			var/obj/item/card/id/new_id = new type_path(get_turf(src))
			new_id.access = access.Copy()
			CopyInfoToCard(new_id)
			return new_id
		if(MODE_FINE)
			if(prob(7))
				return pick(/obj/item/card/data, /obj/item/deck/cards, /obj/item/deck/tarot)
			if(!LAZYLEN(GLOB.conversion_cards))
				for(var/type_path in GLOB.valid_conversion_cards)
					GLOB.conversion_cards[type_path] = list()
					var/obj/item/card/id/id = new type_path(src)
					var/must_match = max(1, round(length(id.access) * 0.5))
					for(var/type_path_again in GLOB.valid_conversion_cards - type_path)
						var/obj/item/card/id/new_id = new type_path(id)
						// Returns a list of accesses that were in both lists
						var/list/matches = id.access & new_id.access
						if(length(matches) >= must_match && length(id.access) > length(access))
							GLOB.conversion_cards[type_path] |= type_path_again
						QDEL_NULL(new_id)
					QDEL_NULL(id)
			// Let's give it some random shit!
			if(!LAZYLEN(GLOB.conversion_cards[type]) || prob(15))
				var/list/valid_access = get_all_site_access() - access
				if(LAZYLEN(valid_access))
					var/new_access = pick(valid_access)
					access |= new_access
					visible_message(SPAN_NOTICE("\The [src] glows for a moment, as if something passed into it."))
				return src
			var/new_type = pick(GLOB.valid_conversion_cards[type])
			var/obj/item/card/id/new_id = new new_type(get_turf(src))
			return new_id
	return ..()

// Copies most of the info (such as owner and their job) to another card
/obj/item/card/id/proc/CopyInfoToCard(obj/item/card/id/new_id)
	if(!istype(new_id))
		return

	new_id.assignment = assignment
	new_id.age = age
	new_id.front = front
	new_id.side = side
	new_id.formal_name_prefix = formal_name_prefix
	new_id.formal_name_suffix = formal_name_suffix
	new_id.registered_name = registered_name
	new_id.sex = sex
	new_id.blood_type = blood_type
	new_id.dna_hash = dna_hash
	new_id.fingerprint_hash = fingerprint_hash

/obj/item/card/id/proc/prevent_tracking()
	return 0

/obj/item/card/id/proc/show(mob/user as mob)
	if(front && side)
		send_rsc(user, front, "front.png")
		send_rsc(user, side, "side.png")
	var/datum/browser/popup = new(user, "idcard", name, 600, 250)
	popup.set_content(dat())
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()
	return

/obj/item/card/id/proc/get_display_name()
	. = "[formal_name_prefix][registered_name][formal_name_suffix]"
	if(class)
		. ="[class] [.]"
	if(assignment)
		. += ", [assignment]"

/obj/item/card/id/proc/set_id_photo(mob/M)
	front = getFlatIcon(M, SOUTH, always_use_defdir = 1)
	front.Crop(9, 18, 23, 32)
	side = getFlatIcon(M, WEST, always_use_defdir = 1)
	side.Crop(9, 18, 23, 32)

/mob/proc/set_id_info(obj/item/card/id/id_card)
	id_card.age = 0

	id_card.formal_name_prefix = initial(id_card.formal_name_prefix)
	id_card.formal_name_suffix = initial(id_card.formal_name_suffix)
	if(client && client.prefs)
		for(var/culturetag in client.prefs.cultural_info)
			var/decl/cultural_info/culture = SSculture.get_culture(client.prefs.cultural_info[culturetag])
			if(culture)
				id_card.formal_name_prefix = "[culture.get_formal_name_prefix()][id_card.formal_name_prefix]"
				id_card.formal_name_suffix = "[id_card.formal_name_suffix][culture.get_formal_name_suffix()]"

	id_card.registered_name = real_name

	id_card.sex = gender2text(get_sex())
	id_card.set_id_photo(src)

	if(dna)
		id_card.blood_type		= dna.b_type
		id_card.dna_hash		= dna.unique_enzymes
		id_card.fingerprint_hash= md5(dna.uni_identity)

/mob/living/carbon/human/set_id_info(obj/item/card/id/id_card)
	..()
	id_card.age = age

/obj/item/card/id/proc/dat()
	var/list/dat = list("<table><tr><td>")
	dat += text("Name: []</A><BR>", "[formal_name_prefix][registered_name][formal_name_suffix]")
	dat += text("Sex: []</A><BR>\n", sex)
	dat += text("Age: []</A><BR>\n", age)
	dat += text("Class: []</A><BR>\n", class)
	dat += text("Assignment: []</A><BR>\n", assignment)
	dat += text("Fingerprint: []</A><BR>\n", fingerprint_hash)
	dat += text("Blood Type: []<BR>\n", blood_type)
	dat += text("DNA Hash: []<BR><BR>\n", dna_hash)
	if(front && side)
		dat +="<td align = center valign = top>Photo:<br><img src=front.png height=70 width=70 border=7 style='-ms-interpolation-mode: nearest-neighbor'> <img src=side.png height=70 width=70 border=4 style='-ms-interpolation-mode: nearest-neighbor'></td>"
	dat += "</tr></table>"
	return jointext(dat,null)

/obj/item/card/id/attack_self(mob/user as mob)
	user.visible_message("\The [user] shows you: [icon2html(src, viewers(get_turf(src)))] [src.name]. The assignment on the card: [src.assignment]",\
		"You flash your ID card: [icon2html(src, viewers(get_turf(src)))] [src.name]. The assignment on the card: [src.assignment]")

	src.add_fingerprint(user)
	return

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetIdCard()
	return src

/obj/item/card/id/verb/read()
	set name = "Read ID Card"
	set category = "Object"
	set src in usr

	to_chat(usr, text("[icon2html(src, usr)] []: The current assignment on the card is [].", src.name, src.assignment))
	to_chat(usr, "The blood type on the card is [blood_type].")
	to_chat(usr, "The DNA hash on the card is [dna_hash].")
	to_chat(usr, "The fingerprint hash on the card is [fingerprint_hash].")
	return

/obj/item/card/id/captains_spare
	name = "captain's spare ID"
	desc = "The spare ID of the High Lord himself."
	item_state = "gold_id"
	registered_name = "Captain"
	assignment = "Captain"
	detail_color = COLOR_AMBER

/obj/item/card/id/captains_spare/New()
	access = get_all_site_access()
	..()

/obj/item/card/id/synthetic
	name = "\improper Synthetic ID"
	desc = "Access module for lawed synthetics."
	icon_state = "robot_base"
	assignment = "Synthetic"
	detail_color = COLOR_AMBER

/obj/item/card/id/synthetic/New()
	access = get_all_site_access() + ACCESS_SYNTH
	..()

/obj/item/card/id/centcom
	name = "\improper CentCom. ID"
	desc = "An ID straight from Cent. Com."
	registered_name = "Central Command"
	assignment = "General"
	color = COLOR_GRAY40
	detail_color = COLOR_COMMAND_BLUE
	extra_details = list("goldstripe")

/obj/item/card/id/centcom/New()
	access = get_all_centcom_access()
	..()

/obj/item/card/id/centcom/station/New()
	..()
	access |= get_all_site_access()

/obj/item/card/id/centcom/ERT
	name = "\improper Mobile Task Force ID"
	assignment = "Mobile Task Force"

/obj/item/card/id/centcom/ERT/New()
	..()
	access |= get_all_site_access()

/obj/item/card/id/all_access
	name = "\improper Administrator's spare ID"
	desc = "The spare ID of the Lord of Lords himself."
	registered_name = "Administrator"
	assignment = "Administrator"
	detail_color = COLOR_MAROON
	extra_details = list("goldstripe")

/obj/item/card/id/all_access/New()
	access = get_access_ids()
	..()

// Department-flavor IDs

/obj/item/card/id/security
	name = "identification card"
	desc = "A card issued to security staff."
//	job_access_type = /datum/job/officer
	color = COLOR_OFF_WHITE
	detail_color = COLOR_MAROON

/obj/item/card/id/civilian
	name = "identification card"
	desc = "A card issued to civilian staff."
	job_access_type = DEFAULT_JOB_TYPE
	detail_color = COLOR_CIVIE_GREEN

/obj/item/card/id/civilian/chaplain
	job_access_type = /datum/job/chaplain

/*
***************
***SCP CARDS***
***************
*/

// Currently, cards have to be added for each job and have their own unique identifier if we want access to be made more unique. So that's what we're doing here.

// TEMP CARDS

/obj/item/card/id/seclvl1
	name = "security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficerlcz

/obj/item/card/id/seclvl2
	name = "security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/juneng

/obj/item/card/id/seclvl3
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/eng

/obj/item/card/id/seclvl4
	name = "security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/seneng

//ENGINEERING

/obj/item/card/id/seclvl2eng
	name = "security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/juneng

/obj/item/card/id/seclvl3eng
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/eng

/obj/item/card/id/seclvl4eng
	name = "security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/seneng


/obj/item/card/id/seclvl5eng
	name = "security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/chief_engineer

/obj/item/card/id/seclvl3it_tech
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/it_tech

// JUNIOR GUARD ID'S

/obj/item/card/id/junseclvl2lcz
	name = "security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/enlistedofficerlcz

/obj/item/card/id/junseclvl2ez
	name = "security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/enlistedofficerez

/obj/item/card/id/junseclvl3hcz
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/enlistedofficerhcz

// GUARD ID'S.
/obj/item/card/id/seclvl3lcz
	name = "security ID"
	desc = "A dark purple ID. Looks important. The person wearing it, not at all."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/ncoofficerlcz

/obj/item/card/id/seclvl3ez
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ncoofficerez

/obj/item/card/id/seclvl3raisa
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/raisa

/obj/item/card/id/seclvl3hcz
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ncoofficerhcz

// ZC ID'S

/obj/item/card/id/zcseclvl4hcz
	name = "security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/ltofficerhcz

/obj/item/card/id/zcseclvl3lcz
	name = "security ID"
	desc = "A teal ID. A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/ltofficerlcz

/obj/item/card/id/zcseclvl4ez
	name = "security ID"
	desc = "A teal ID. Looks cool."
	icon_state = "securitylvl4"
	item_state = "Sec_ID4"
	job_access_type = /datum/job/ltofficerez

// GC ID.

/obj/item/card/id/gcseclvl5
	name = "security ID"
	desc = "A dark purple ID. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/hos

// SCIENCE

/obj/item/card/id/sciencelvl1
	name = "science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/juniorscientist

/obj/item/card/id/sciencelvl2
	name = "science ID"
	desc = "A bright yellow ID. Looks ordinary?"
	icon_state = "sciencelvl2"
	item_state = "Science_ID2"
	job_access_type = /datum/job/scientist

/obj/item/card/id/sciencelvl3
	name = "science ID"
	desc = "A dark yellow ID. Looks cool, the person wearing it, not so much."
	icon_state = "sciencelvl3"
	item_state = "Science_ID3"
	job_access_type = /datum/job/scientist

/obj/item/card/id/sciencelvl4
	name = "science ID"
	desc = "An orange ID. Looks important."
	icon_state = "sciencelvl4"
	item_state = "Science_ID4"
	job_access_type = /datum/job/seniorscientist

/obj/item/card/id/sciencelvl5
	name = "science ID"
	desc = "A red ID. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// ADMIN
/obj/item/card/id/adminlvl1
	name = "administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl1"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/card/id/adminlvl2
	name = "administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl2"
	item_state = "Admin_ID"
//	job_access_type = /datum/job/rd

/obj/item/card/id/adminlvl3
	name = "administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
	job_access_type = /datum/job/goirep

/obj/item/card/id/adminlvl4
	name = "administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl4"
	item_state = "Admin_ID"
	job_access_type = /datum/job/hop

/obj/item/card/id/adminlvl5
	name = "administration ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"
	job_access_type = /datum/job/captain

// ERT CARDS

/obj/item/card/id/mtf
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	icon_state = "adminlvl5"
	item_state = "Admin_ID"

/obj/item/card/id/mtf/ninetail
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Epsilon-11 Task Force Operative"

/obj/item/card/id/mtf/epsilon
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Epsilon-9 Task Force Operative"

/obj/item/card/id/mtf/nu_7
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Nu-7 Task Force Operative"

/obj/item/card/id/mtf/beta_7
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "beta_7 Task Force Operative"

/obj/item/card/id/mtf/alpha
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Alpha-1 Task Force Operative"

/obj/item/card/id/mtf/omega
	name = "mobile task force ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Omega-1 Task Force Operative"

/obj/item/card/id/mtf/isd
	name = "internal security operations ID"
	desc = "A black ID. Looks like the person wearing this won't give it up easy."
	assignment = "Internal Security Agent"

/obj/item/card/id/mtf/Initialize()
	. = ..()
	rank = "Mobile Task Force Operative"
	access |= get_all_site_access()


/obj/item/card/id/physics
	name = "military ID"
	desc = "A dark purple ID. Looks like the person wearing this won't give it up easy."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"

/obj/item/card/id/physics/Initialize()
	. = ..()
	rank = "UNGOC Physics Operative"
	access |= get_all_station_access()

// COMMS CARDS

/obj/item/card/id/commslvl1
	name = "administration ID"
	desc = "A black ID. A black ID. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commeng
	icon_state = "adminlvl1"
	item_state = "Admin_ID"

/obj/item/card/id/commslvl4
	name = "administration ID"
	desc = "A black ID. A black ID. Looks like the person wearing this won't give it up easy."
	job_access_type = /datum/job/commsofficer
	icon_state = "adminlvl4"
	item_state = "Admin_ID"

// MEDICAL CARDS

/obj/item/card/id/emt
	name = "security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl1"
	item_state = "Sec_ID1"
	job_access_type = /datum/job/emt

/obj/item/card/id/chemist
	name = "security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/chemist

/obj/item/card/id/doctor
	name = "security ID"
	desc = "A light blue card. Seems almost as unimportant as the person itself."
	icon_state = "securitylvl2"
	item_state = "Sec_ID2"
	job_access_type = /datum/job/medicaldoctor

/obj/item/card/id/chiefmedicalofficer
	name = "security ID"
	desc = "A dark purple ID. Looks important."
	icon_state = "securitylvl5"
	item_state = "Sec_ID5"
	job_access_type = /datum/job/cmo

/obj/item/card/id/psychiatrist
	name = "administration ID"
	desc = "A light blue card. Seems important."
	icon_state = "adminlvl3"
	item_state = "Admin_ID"
	job_access_type = /datum/job/psychiatrist

// RESEARCH

/obj/item/card/id/rd
	name = "science ID"
	desc = "A red ID. Looks like the person wearing this won't give it up easy."
	icon_state = "sciencelvl5"
	item_state = "Science_ID5"
	job_access_type = /datum/job/rd

// MISC

/obj/item/card/id/chef
	name = "science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/chef

/obj/item/card/id/bartender
	name = "science ID"
	desc = "A light blue ID. Haven't you seen a janitor with this before?"
	icon_state = "sciencelvl1"
	item_state = "Science_ID1"
	job_access_type = /datum/job/bartender

/obj/item/card/id/officeworker
	name = "Office Staff ID"
	desc = "A low level ID issued to office workers."
	icon_state = "adminlvl1"
	item_state = "Admin_ID"
	job_access_type = /datum/job/officeworker

/obj/item/card/id/classd
	name = "Class-D ID"
	desc = "An ID card issued to Class-D Foundation personnel."
	icon_state = "classd"
	item_state = "Admin_ID"
	job_access_type = /datum/job/classd

// LOGISTICS

/obj/item/card/id/logoff
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/qm


/obj/item/card/id/logspec
	name = "security ID"
	desc = "A dark blue ID. Looks important. The person wearing it not so much."
	icon_state = "securitylvl3"
	item_state = "Sec_ID3"
	job_access_type = /datum/job/cargo_tech

// CD ASSIGNMENT CARDS

/obj/item/card/id/dassignment
	desc = "A plain ID Card, used for granting access to D-Class personnel so they're able to perform their duties."

/obj/item/card/id/dassignment/dmining
	name = "mining assignment card"
	access = list(ACCESS_DCLASS_MINING)

/obj/item/card/id/dassignment/dbotany
	name = "botany assignment card"
	access = list(ACCESS_DCLASS_BOTANY)

/obj/item/card/id/dassignment/dkitchen
	name = "kitchen assignment card"
	access = list(ACCESS_DCLASS_KITCHEN)

/obj/item/card/id/dassignment/djanitorial
	name = "janitorial assignment card"
	access = list(ACCESS_DCLASS_JANITORIAL)

/obj/item/card/id/dassignment/dmedical
	name = "medical assignment card"
	access = list(ACCESS_DCLASS_MEDICAL)

