/obj/item/photo/scp096/scp096_photo
	name =  "???? photo"

/obj/item/photo/scp096/scp096_photo/examine(mob/living/user)
	. = ..()
	if(!istype(user, /mob/living/scp096))
		var/mob/living/scp096/scp_to_trigger = locate(/mob/living/scp096) in GLOB.SCP_list
		if(get_dist(user, src) <= 1 && isliving(user)) // если нужна дистанция юзать get_dist()
			scp_to_trigger.trigger(user)
			to_chat(user, SPAN_DANGER("You catch [scp_to_trigger]"))
		else
			to_chat(user, SPAN_NOTICE("It is too far away."))

