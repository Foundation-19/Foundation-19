GLOBAL_DATUM_INIT(ert, /datum/antagonist/ert, new)

/datum/antagonist/ert
	id = MODE_ERT
	role_text = "MTF Nine-Tailed Fox - Epsilon-11 Agent"
	role_text_plural = "MTF Nine-Tailed Fox - Epsilon-11 Agents"
	welcome_text = "As Agent of the Epsilon-11 taskforce, you only answer to your leader, nobody else."
	antag_text = "You are an <b>anti</b> antagonist! Within the rules, \
		try to save the site and its inhabitants from the ongoing crisis. \
		Try to make sure other players have <i>fun</i>! If you are confused or at a loss, always adminhelp, \
		and before taking extreme actions, please try to also contact the administration! \
		Think through your actions and make the roleplay immersive! <b>Please remember all \
		rules aside from those without explicit exceptions apply to the MTF.</b>"
	leader_welcome_text = "You shouldn't see this"
	landmark_id = "Response Team"
	id_type = /obj/item/card/id/mtf

	flags = ANTAG_OVERRIDE_JOB | ANTAG_HAS_LEADER | ANTAG_CHOOSE_NAME | ANTAG_RANDOM_EXCEPTED
	antaghud_indicator = "hudloyalist"

	hard_cap = 5
	hard_cap_round = 7
	initial_spawn_req = 5
	initial_spawn_target = 7
	show_objectives_on_creation = 0 //we are not antagonists, we do not need the antagonist shpiel/objectives
	var/reason = ""

/datum/antagonist/ert/create_default(var/mob/source)
	var/mob/living/carbon/human/M = ..()
	if(istype(M)) M.age = rand(25,45)

/datum/antagonist/ert/New()
	..()
	leader_welcome_text = "As leader of Mobile Task Force Epsilon-11, you answer only to the O5 Council, and have authority to override the Site staff where it is necessary to achieve your mission goals. It is recommended that you attempt to cooperate with the site staff where possible, however."
//	ert = src

/datum/antagonist/ert/greet(var/datum/mind/player)
	if(!..())
		return
	to_chat(player.current, "The Mobile Task Force works for the O5 Council; your job is to contain loose SCPs and eliminate infiltrators. There is a code red alert at [station_name()], you are tasked to go and fix the problem.")
	to_chat(player.current, "You should first gear up and discuss a plan with your team. More members may be joining, don't move out before you're ready.")

/datum/antagonist/ert/equip(var/mob/living/carbon/human/player)

	//Special radio setup
	player.add_language(LANGUAGE_ENGLISH)
	player.equip_to_slot_or_del(new /obj/item/device/radio/headset/ert(src), slot_l_ear)
	player.equip_to_slot_or_del(new /obj/item/clothing/under/ert(src), slot_w_uniform)
	player.equip_to_slot_or_del(new /obj/item/clothing/shoes/swat(src), slot_shoes)
	player.equip_to_slot_or_del(new /obj/item/clothing/gloves/thick/swat(src), slot_gloves)
	player.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/mtftactical(player), slot_head)
	player.equip_to_slot_or_del(new /obj/item/clothing/suit/armor/mtftactical(player), slot_wear_suit)

	create_id(role_text, player)
	return 1
