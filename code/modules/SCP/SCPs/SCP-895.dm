#define MESSAGE_COOLDOWN 100

/datum/scp/scp_895
	name = "SCP-895"
	designation = "895"
	classification = EUCLID

/obj/structure/closet/coffin/scp895
	name = "oak coffin"
	SCP = /datum/scp/scp_895
	var/redzone = 5
	var/list/cooldown = list()
	var/list/start = list()
	var/list/users = list()

/obj/structure/closet/coffin/scp895/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/closet/coffin/scp895/Destroy()
	cooldown = null
	start = null
	users = null
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/closet/coffin/scp895/Process()
	var/list/our_view = view(redzone, src)
	for (var/obj/machinery/camera/network/C in our_view)
		for (var/client/client in GLOB.clients)
			if (client.eye == C)
				if(ishuman(client.mob))
					var/mob/living/carbon/human/H = client.mob
					if(!start[H])
						start[H] = world.time
					if(!(H in users))
						users += H
					var/time = Floor((world.time - start[H])/10)
					if((time >= 5) && ((time % 51) == 0))
						H << sound('sound/effects/Heart Beat.ogg', channel = 895, volume = 70)
					H.hallucination_duration = max(H.hallucination_duration, 15)
					H.hallucination_power = max(H.hallucination_power, 70)
					if (!cooldown[H] || (world.time >= (cooldown[H] + MESSAGE_COOLDOWN)))
						cooldown[H] = world.time
						to_chat(H, SPAN_DANGER("<B>You see unimaginable horrors within \the [src]...</B>"))
//					if((time >= 10) && ((time % 2) == 0))
//						var/obj/item/organ/internal/brain = H.internal_organs_by_name[BP_BRAIN]
/*						if(brain)
							brain.take_damage(15)*/
				break

	for(var/mob/living/carbon/human/H in users)
		if(!(H in our_view))
			users -= H
			start -= H
			cooldown -= H
			H << sound(null, channel = 895)


#undef MESSAGE_COOLDOWN
