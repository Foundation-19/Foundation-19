/obj/item/material/twohanded/baseballbat/scp2398
	name = "wooden bat"
	desc = "A generic wooden bat. The letters 'K.O.' are branded into the wood, just above the handle."

	icon = 'icons/SCP/scp-2398.dmi'
	icon_state = null

	//Config

	//How long our doafter swing is
	var/swing_time = 4 SECONDS

/obj/item/material/twohanded/baseballbat/scp2398/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"wooden bat", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"2398" //Numerical Designation
	)

//Overrides

/obj/item/material/twohanded/baseballbat/scp2398/attack(mob/living/M, mob/living/carbon/human/user, target_zone, animate)
	if(!istype(M) || !istype(user) || M.SCP)
		return ..()

	var/hand_used = user.hand ? BP_L_HAND : BP_R_HAND

	visible_message(SPAN_DANGER("[user] begins to swing [src] at [M]!"))
	if(!do_after(user, swing_time, M))
		visible_message(SPAN_DANGER("[user] misses [M] with \The [src]!"))
		return

	var/obj/item/organ/external/E = user.get_organ(hand_used)
	E?.fracture()

	//Calculate explosion power based on mob size
	var/explosion_size = ceil(clamp(((M.mob_size / 40) * 5), 0, 5)) //40 is used as its the max mob size, and five represents the maximium explosion size

	explosion(M, explosion_size * 0.25, explosion_size * 0.25, explosion_size * 0.5, explosion_size, TRUE)
	M.gib()

	admin_attack_log(user, M, null, null, "[user] has attacked [M] with an instance of SCP-[SCP.designation]!") //TODO: switch to admin macros once they are ported.
	log_and_message_staff("[user]/[user.ckey] has swung SCP-2398 at [M]/[M.ckey]!", user, get_turf(user))

/obj/item/material/twohanded/baseballbat/scp2398/ex_act(severity) //We shouldent explode ourselves as a result
	return
