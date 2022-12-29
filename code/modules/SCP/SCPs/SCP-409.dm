/obj/structure/scp409/
	name = "SCP-409"
	desc = "A white crystal, something beckons you to come and touch it..."
	icon = 'icons/SCP/scp-409.dmi'
	icon_state = "409"
	layer = 2.9
	anchored = TRUE
	density = TRUE
	SCP = /datum/scp/scp_409

/datum/scp/scp_409
	name = "SCP-409"
	designation = "409"
	classification = KETER

/obj/effect/decal/cleanable/residue409
	name = "crystals"
	desc = "Some crystals on the floor... is that blood?"
	icon = 'icons/SCP/scp-409.dmi'
	icon_state = "residue409"
	gender = PLURAL

/obj/structure/scp409/attack_hand(mob/user as mob)
	visible_message("[user] touches [src].")
	log_and_message_admins("[user] has touched SCP-409 at [x] [y] [z]")
	Crystal(user)

/obj/structure/scp409/proc/Crystal(var/mob/living/user)
	if(istype(user))
		sleep(60)
		playsound(src, 'sound/voice/emotes/male_scream2.ogg', 25)
		log_and_message_admins("[user] has died from SCP-409 exposure at [x] [y] [z]")
		user.visible_message(
			SPAN_DANGER(FONT_LARGE("You scream, as your body starts to twist and turn, it's flesh being replaced by rock. Stinging into your skin, you try and scream but the crystals already covered your mouth.")),
			SPAN_WARNING("The [user] screams and starts to turn into crystals on the floor.")
		)
		user.crystaltim()
	else
		qdel(user)