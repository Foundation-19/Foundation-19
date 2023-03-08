/obj/structure/alien/resin
	name = "resin"
	desc = "Looks like some kind of slimy growth."
	icon_state = "resin"

	density = TRUE
	opacity = 1
	anchored = TRUE
	health = 200

/obj/structure/alien/resin/wall
	name = "resin wall"
	desc = "Purple slime solidified into a wall."
	icon_state = "resinwall"

/obj/structure/alien/resin/membrane
	name = "resin membrane"
	desc = "Purple slime just thin enough to let light pass through."
	icon_state = "resinmembrane"
	opacity = 0
	health = 120

/obj/structure/alien/resin/New()
	..()
	var/turf/T = get_turf(src)
	T.thermal_conductivity = WALL_HEAT_TRANSFER_COEFFICIENT

/obj/structure/alien/resin/Destroy()
	var/turf/T = get_turf(src)
	T.thermal_conductivity = initial(T.thermal_conductivity)
	..()

/obj/structure/alien/resin/attack_hand(mob/user)
	if (HULK in user.mutations)
		visible_message(SPAN_DANGER("\The [user] destroys \the [name]!"))
		health = 0
	else
		// Aliens can get straight through these.
		if(istype(user,/mob/living/carbon))
			var/mob/living/carbon/M = user
			if(locate(/obj/item/organ/internal/xenos/hivenode) in M.internal_organs)
				visible_message(SPAN_CLASS("alium","\The [user] strokes \the [name] and it melts away!"))
				health = 0
				healthcheck()
				return
		visible_message(SPAN_DANGER("\The [user] claws at \the [src]!"))
		// Todo check attack datums.
		health -= rand(5,10)
	healthcheck()
	return
