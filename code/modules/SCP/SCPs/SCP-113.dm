/obj/item/device/scp113
	name = "SCP-113"
	desc = "The red piece of quartz gleams with unnatural smoothness."
	icon_state = "scp113"
	force = 10.0
	w_class = ITEM_SIZE_HUGE // temporary workaround until I can fix the nodrop code to include noplace in bags/tables
	throwforce = 10.0
	throw_range = 15
	throw_speed = 3
	SCP = /datum/scp/scp_113
	var/list/victims = list()

/datum/scp/scp_113
	name = "SCP-113"
	designation = "113"
	classification = SAFE

/datum/scp/scp_113/isCompatible(atom/A)
	if(isitem(A))
		return 1

/obj/item/device/scp113/pickup(mob/living/user)
	if(!isliving(user))
		return ..()

	var/mob/living/carbon/human/H = user
	if(istype(H) && H.gloves)
		return ..()

	canremove = 0 // reset canremove for new pickup

	var/which_hand = BP_L_HAND // determine hand to burn
	if(!user.hand)
		which_hand = BP_R_HAND

	to_chat(user, SPAN_WARNING("The [name] begins to sear your hand, burning the skin on contact, and you feel yourself unable to drop it."))
	var/damage_coeff = 1
	if(user in victims)
		damage_coeff = clamp((5000-(world.time - victims[user]))/1000,1,5)
	user.apply_damage(10*damage_coeff, BURN, which_hand, 0) //administer damage
	user.apply_damage(30*damage_coeff, TOX, which_hand, 0)

	spawn(200)
		to_chat(user, SPAN_WARNING("Bones begin to shift and grind inside of you, and every single one of your nerves seems like it's on fire."))
	spawn(210)
		user.visible_message(SPAN_NOTICE("\The [user] starts to scream and writhe in pain as their bone structure reforms."))
	spawn(300)
		if(H.is_blue_lady)
			if(user.gender == MALE)
				user.gender = FEMALE
				to_chat(user, SPAN_NOTICE("A vast sense of relief washes over you, as you feel your body reshape itself to be more like hers again."))
			else if(H.pre_scp013_gender == MALE && H.blue_lady_transitioned == 0)
				H.blue_lady_transitioned = 1
				to_chat(user, SPAN_NOTICE("At last, you feel truly at home in your own body. You have become that wistful lady in blue."))
			else
				user.gender = MALE
				to_chat(user, SPAN_WARNING("There's something you can't see, and it feels unbearably wrong. It's all wrong. You weren't ... she wasn't ... a man."))
				spawn(500)
					to_chat(user, SPAN_WARNING("You have the terrifying feeling that you're inhabiting the wrong body. You have to find a way to reverse whatever you just did!"))
		else
			if(user.gender == FEMALE)
				user.gender = MALE
			else
				user.gender = FEMALE
	spawn(310)
		H.reset_hair()
		H.update_dna()
		H.update_body()
	spawn(350)
		to_chat(user, SPAN_WARNING("The burning begins to fade, and you feel your hand relax it's grip on the [name]."))
	spawn(360)
		canremove = 1 //transformation finished, you can let go now
		victims[user] = world.time
