GLOBAL_LIST_EMPTY(scp1102)

var/static/list/climbsounds = list('sounds/effects/ladder.ogg','sounds/effects/ladder2.ogg','sounds/effects/ladder3.ogg','sounds/effects/ladder4.ogg')

/obj/item/weapon/scp1102ru
	name = "SCP-1102-RU"
	desc = "Very old plastic case. Looks a bit... off?"
	icon = 'icons/obj/storage.dmi'
	icon_state = "briefcase"
	item_state = "briefcase"
	force = 8
	throw_speed = 1
	throw_range = 4
	w_class = ITEM_SIZE_HUGE

/obj/item/weapon/scp1102ru/attack_self(mob/user)
	if(do_after(user,20))
		user.drop_active_hand()
		user.forceMove(pick(GLOB.scp1102_floors))
		playsound(src, pick(climbsounds), 50)
		user.visible_message(SPAN_WARNING("The [user] has opened the briefcase and climbed down into it!"))

/obj/item/weapon/scp1102ru/Initialize()
	GLOB.scp1102 += src
	return ..()

/obj/item/weapon/scp1102ru/Destroy()
	GLOB.scp1102 -= src
	return ..()


///////////Ladder

/obj/structure/ladder_scp_1102
	name = "ladder"
	desc = "A ladder. You can climb it up and down."
	icon_state = "ladder10"
	icon = 'icons/obj/structures.dmi'
	anchored = TRUE

/obj/structure/ladder_scp_1102/attackby(obj/item/C as obj, mob/user as mob)
	climb(user)

/obj/structure/ladder_scp_1102/attack_hand(mob/M)
	climb(M)

/obj/structure/ladder_scp_1102/proc/climb(mob/user)
	if(do_after(user,20))
		var/turf/T = get_turf(pick(GLOB.scp1102))
		user.forceMove(T)
		playsound(src, pick(climbsounds), 50)
		user.visible_message(SPAN_WARNING("[user] climbs up the ladder!"))
