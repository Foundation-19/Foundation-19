/obj/structure/scp409/
	name = "SCP-409"
	desc = "A white crystal, something beckons you to come and touch it..."
	icon = 'icons/SCP/scp-409.dmi'
	icon_state = "409"
	layer = 2.9
	anchored = TRUE // makes it not able to be moved
	density = TRUE // makes it have collisions
	SCP = /datum/scp/scp_409

/datum/scp/scp_409
	name = "SCP-409"
	designation = "409"
	classification = KETER

/obj/effect/decal/cleanable/residue409
	name = "crystals"
	desc = "Some crystals on the floor... is that blood?" // something about blood even though it doesnt have blood on the sprite, blame the spriting team
	icon = 'icons/SCP/scp-409.dmi'
	icon_state = "residue409"
	gender = PLURAL

/obj/structure/scp409/attack_hand(mob/user as mob)
	visible_message("[user] touches [src].")
	log_and_message_admins("[user] has touched SCP-409 at [x] [y] [z]") // not sure if co-ordinates are required for the JUMP option to be available but its cool :sunglasses:
	Crystal(user)

/obj/structure/scp409/proc/Crystal(var/mob/living/user) // defines Crystal() which calls crystaltim(), i am dumb
	if(istype(user, /mob/living/carbon/human/scp049))
		to_chat(SPAN_WARNING("Your doctor instincts prevent you from touching that odd crystal."))
	else if(istype(user))
		sleep(60) // makes it so that it takes a while to take effect
		playsound(src, 'sound/voice/emotes/male_scream2.ogg', 25) // I didn't find any other solution to do this, so this sound will play regardless if the victim is male or female. TODO: fix dis
		log_and_message_admins("[user] has died from SCP-409 exposure at [x] [y] [z]")
		user.visible_message(
			SPAN_DANGER(FONT_LARGE("You scream, as your body starts to twist and turn, it's flesh being replaced by rock. Stinging into your skin, you try and scream but the crystals already covered your mouth.")),
			SPAN_WARNING("[user] screams and starts to turn into crystals on the floor.")
		)
		user.crystaltim() // TODO: make it use CA (crystal agent)