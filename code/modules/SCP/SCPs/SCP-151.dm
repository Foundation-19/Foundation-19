/obj/structure/scp151
	name = "painting"
	desc = "A painting depicting a rising wave."
	icon = 'icons/obj/structures.dmi'
	icon_state = "great_wave"
	anchored = TRUE
	density = TRUE
	var/last_regen = 0
	var/gen_time = 100 //how long we wait between hurting victims
	var/list/victims = list()


/obj/structure/scp151/proc/hurt_victims() //simulate drowning
	for(var/mob/living/user in victims)
		user.apply_damage(30, OXY)

/obj/structure/scp151/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	last_regen = world.time

/obj/structure/scp151/Process()
	if(world.time > last_regen + gen_time) //hurt victims after time
		hurt_victims()
		last_regen = world.time

/obj/structure/scp151/examine(mob/living/user)
	. = ..()

	if(!user.can_see(src, 1))
		return
	if(user.stat)
		return

	if(!(user in victims) && istype(user))
		victims += user //on examine, adds user into victims list
	if (user in victims)
		spawn(2 SECONDS)
			user.emote("cough")
		spawn(2 SECONDS)
			to_chat(user, SPAN_WARNING("Your lungs begin to feel tight, and the briny taste of seawater permeates your mouth."))
