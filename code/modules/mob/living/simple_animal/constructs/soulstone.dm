#define SOULSTONE_CRACKED -1
#define SOULSTONE_EMPTY 0
#define SOULSTONE_ESSENCE 1

/obj/item/device/soulstone
	name = "soul stone shard"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	item_state = "electronic"
	desc = "A strange, ridged chunk of some glassy red material. Achingly cold to the touch."
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	origin_tech = list(TECH_BLUESPACE = 4, TECH_MATERIAL = 4)

	var/full = SOULSTONE_EMPTY
	var/is_evil = 1
	var/mob/living/simple_animal/shade = null
	var/smashing = 0
	var/soulstatus = null

/obj/item/device/soulstone/Initialize(mapload)
	shade = new /mob/living/simple_animal/shade(src)
	. = ..(mapload)

/obj/item/device/soulstone/disrupts_psionics()
	return (full == SOULSTONE_ESSENCE) ? src : FALSE

/obj/item/device/soulstone/proc/shatter()
	playsound(loc, "shatter", 70, 1)
	show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
	for(var/i=1 to rand(2,5))
		new /obj/item/material/shard(get_turf(src), MATERIAL_NULLGLASS)
	qdel(src)

/obj/item/device/soulstone/withstand_psi_stress(stress, atom/source)
	. = ..(stress, source)
	if(. > 0)
		. = max(0, . - rand(2,5))
		shatter()

/obj/item/device/soulstone/full
	full = SOULSTONE_ESSENCE
	icon_state = "soulstone2"

/obj/item/device/soulstone/Destroy()
	QDEL_NULL(shade)
	return ..()

/obj/item/device/soulstone/examine(mob/user)
	. = ..()
	if(full == SOULSTONE_EMPTY)
		to_chat(user, "The shard still flickers with a fraction of the full artifact's power, but it needs to be filled with the essence of someone's life before it can be used.")
	if(full == SOULSTONE_ESSENCE)
		to_chat(user,"The shard has gone transparent, a seeming window into a dimension of unspeakable horror.")
	if(full == SOULSTONE_CRACKED)
		to_chat(user, "This one is cracked and useless.")

/obj/item/device/soulstone/on_update_icon()
	if(full == SOULSTONE_EMPTY)
		icon_state = "soulstone"
	if(full == SOULSTONE_ESSENCE)
		icon_state = "soulstone2" //TODO: A spookier sprite. Also unique sprites.
	if(full == SOULSTONE_CRACKED)
		icon_state = "soulstone"//TODO: cracked sprite
		SetName("cracked soulstone")

/obj/item/device/soulstone/attackby(obj/item/I, mob/user)
	..()
	if(is_evil && istype(I, /obj/item/nullrod))
		to_chat(user, SPAN_NOTICE("You cleanse \the [src] of taint, purging its shackles to its creator.."))
		is_evil = 0
		return
	if(I.force >= 5)
		if(full != SOULSTONE_CRACKED)
			user.visible_message(SPAN_WARNING("\The [user] hits \the [src] with \the [I], and it breaks.[shade.client ? " You hear a terrible scream!" : ""]"), SPAN_WARNING("You hit \the [src] with \the [I], and it cracks.[shade.client ? " You hear a terrible scream!" : ""]"), shade.client ? "You hear a scream." : null)
			playsound(loc, 'sound/effects/Glasshit.ogg', 75)
			set_full(SOULSTONE_CRACKED)
		else
			user.visible_message(SPAN_DANGER("\The [user] shatters \the [src] with \the [I]!"))
			shatter()

/obj/item/device/soulstone/attack(mob/living/simple_animal/M, mob/user)
	if(M == shade)
		to_chat(user, SPAN_NOTICE("You recapture \the [M]."))
		M.forceMove(src)
		return
	if(full == SOULSTONE_ESSENCE)
		to_chat(user, SPAN_NOTICE("\The [src] is already full."))
		return
	if(M.stat != DEAD && !M.is_asystole())
		to_chat(user, SPAN_NOTICE("Kill or maim the victim first."))
		return
	for(var/obj/item/W in M)
		M.drop_from_inventory(W)
	M.dust()
	set_full(SOULSTONE_ESSENCE)

/obj/item/device/soulstone/attack_self(mob/user)
	if(full != SOULSTONE_ESSENCE) // No essence - no shade
		to_chat(user, SPAN_NOTICE("This [src] has no life essence."))
		return

	if(!shade.key) // No key = hasn't been used
		to_chat(user, SPAN_NOTICE("You cut your finger and let the blood drip on \the [src]."))
		user.remove_blood_simple(1)
		var/datum/ghosttrap/cult/shade/S = get_ghost_trap("soul stone")
		S.request_player(shade, "The soul stone shade summon ritual has been performed. ")
	else if(!shade.client) // Has a key but no client - shade logged out
		to_chat(user, SPAN_NOTICE("\The [shade] in \the [src] is dormant."))
		return
	else if(shade.loc == src)
		var/choice = alert("Would you like to invoke the spirit within?",,"Yes","No")
		if(choice == "Yes")
			shade.dropInto(loc)
			to_chat(user, SPAN_NOTICE("You summon \the [shade]."))
		if(choice == "No")
			return

/obj/item/device/soulstone/proc/set_full(f)
	full = f
	update_icon()

/obj/structure/constructshell
	name = "empty shell"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "construct"
	desc = "A wicked machine used by those skilled in magical arts. It is inactive."

/obj/structure/constructshell/cult
	icon_state = "construct-cult"
	desc = "This eerie contraption looks like it would come alive if supplied with a missing ingredient."

/obj/structure/constructshell/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/device/soulstone))
		var/obj/item/device/soulstone/S = I
		if(!S.shade.client)
			to_chat(user, SPAN_NOTICE("\The [I] has essence, but no soul. Activate it in your hand to find a soul for it first."))
			return
		if(S.shade.loc != S)
			to_chat(user, SPAN_NOTICE("Recapture the shade back into \the [I] first."))
			return
		var/construct = alert(user, "Please choose which type of construct you wish to create.",,"Artificer", "Wraith", "Juggernaut")
		var/ctype
		switch(construct)
			if("Artificer")
				ctype = /mob/living/simple_animal/construct/builder
			if("Wraith")
				ctype = /mob/living/simple_animal/construct/wraith
			if("Juggernaut")
				ctype = /mob/living/simple_animal/construct/armoured
		var/mob/living/simple_animal/construct/C = new ctype(get_turf(src))
		C.key = S.shade.key
		//C.cancel_camera()
		if(S.is_evil)
			GLOB.cult.add_antagonist(C.mind)
		qdel(S)
		qdel(src)

#undef SOULSTONE_CRACKED
#undef SOULSTONE_EMPTY
#undef SOULSTONE_ESSENCE
