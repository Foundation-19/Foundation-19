/obj/structure/backup_server
	name = "backup server"
	icon = 'icons/obj/machines/research.dmi'
	icon_state = "server"
	desc = "Impact resistant server rack. You might be able to pry a disk out."
	var/obj/item/stock_parts/computer/hard_drive/cluster/drive = new /obj/item/stock_parts/computer/hard_drive/cluster

/obj/structure/backup_server/attackby(obj/item/W, mob/user, click_params)
	if(isCrowbar(W))
		if (!drive)
			to_chat(user, SPAN_WARNING("There is nothing else to take from \the [src]."))
			return

		to_chat(user, SPAN_NOTICE("You pry out the data drive from \the [src]."))
		playsound(loc, 'sound/items/Crowbar.ogg', 50, 1)
		drive.origin_tech = list(TECH_DATA = rand(4,5), TECH_ENGINEERING = rand(4,5), TECH_PHORON = rand(4,5), TECH_COMBAT = rand(2,5), TECH_ESOTERIC = rand(0,6))
		var/obj/item/stock_parts/computer/hard_drive/cluster/extracted_drive = drive
		user.put_in_hands(extracted_drive)
		drive = null

/obj/structure/monolith
	name = "monolith"
	desc = "An obviously artifical structure of unknown origin. The symbols '<font face='Shage'>DWNbTX</font>' are engraved on the base."
	icon = 'icons/obj/monolith.dmi'
	icon_state = "jaggy1"
	layer = ABOVE_HUMAN_LAYER
	density = TRUE
	anchored = TRUE
	var/active = 0

/obj/structure/monolith/Initialize()
	. = ..()
	icon_state = "jaggy[rand(1,4)]"
	var/material/A = SSmaterials.get_material_by_name(MATERIAL_ALIENALLOY)
	if(A)
		color = A.icon_colour
	if(GLOB.using_map.use_overmap)
		var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
		if(istype(E))
			desc += "\nThere are images on it: [E.get_engravings()]"
	update_icon()

/obj/structure/monolith/on_update_icon()
	cut_overlays()
	if(active)
		var/image/I = image(icon,"[icon_state]decor")
		I.appearance_flags = RESET_COLOR
		I.color = get_random_colour(0, 150, 255)
		I.layer = ABOVE_LIGHTING_LAYER
		I.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		add_overlay(I)
		set_light(0.3, 0.1, 2, l_color = I.color)

	var/turf/simulated/floor/exoplanet/T = get_turf(src)
	if(istype(T))
		var/image/I = overlay_image(icon, "dugin", T.dirt_color, RESET_COLOR)
		add_overlay(I)

/obj/structure/monolith/attack_hand(mob/user)
	visible_message("[user] touches \the [src].")
	if(GLOB.using_map.use_overmap && istype(user,/mob/living/carbon/human))
		var/obj/effect/overmap/visitable/sector/exoplanet/E = map_sectors["[z]"]
		if(istype(E))
			var/mob/living/carbon/human/H = user
			if(!H.isSynthetic())
				playsound(src, 'sound/effects/zapbeep.ogg', 100, 1)
				active = 1
				update_icon()
				if(prob(70))
					to_chat(H, SPAN_NOTICE("As you touch \the [src], you suddenly get a vivid image - [E.get_engravings()]"))
				else
					to_chat(H, SPAN_WARNING("An overwhelming stream of information invades your mind!"))
					var/vision = ""
					for(var/i = 1 to 10)
						vision += pick(E.actors) + " " + pick("killing","dying","gored","expiring","exploding","mauled","burning","flayed","in agony") + ". "
					to_chat(H, SPAN_DANGER("<font size=2>[uppertext(vision)]</font>"))
					H.Paralyse(2)
					H.hallucination(20, 100)
				return
	to_chat(user, SPAN_NOTICE("\The [src] is still."))
	return ..()
