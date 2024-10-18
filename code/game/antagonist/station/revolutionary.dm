GLOBAL_DATUM_INIT(revs, /datum/antagonist/revolutionary, new)

/datum/antagonist/revolutionary
	id = MODE_REVOLUTIONARY
	role_text = "Head Revolutionary"
	role_text_plural = "Revolutionaries"
	blacklisted_jobs = list(/datum/job/ai, /datum/job/cyborg, /datum/job/captain, /datum/job/hos, /datum/job/chief_engineer, /datum/job/achief_engineer, /datum/job/cmo, /datum/job/acmo, /datum/job/rd, /datum/job/ard, /datum/job/ethicsliaison, /datum/job/tribunal, /datum/job/commsofficer, /datum/job/enlistedofficerez, /datum/job/enlistedofficerlcz, /datum/job/enlistedofficerhcz, /datum/job/ncoofficerez, /datum/job/ncoofficerlcz, /datum/job/ncoofficerhcz, /datum/job/ltofficerez, /datum/job/ltofficerlcz, /datum/job/ltofficerhcz, /datum/job/guardlcz, /datum/job/guardhcz, /datum/job/guardez, /datum/job/goirep, /datum/job/raisa, /datum/job/investigation, /datum/job/investigationoff)
	feedback_tag = "rev_objective"
	antag_indicator = "hud_rev_head"
	welcome_text = "Down with the capitalists! Down with the Bourgeoise!"
	victory_text = "The heads of staff were relieved of their posts! The revolutionaries win!"
	loss_text = "The heads of staff managed to stop the revolution!"
	victory_feedback_tag = "win - heads killed"
	loss_feedback_tag = "loss - rev heads killed"
	flags = ANTAG_VOTABLE
	antaghud_indicator = "hud_rev"
	skill_setter = /datum/antag_skill_setter/station

	hard_cap = 2
	hard_cap_round = 4
	initial_spawn_req = 2
	initial_spawn_target = 4

	//Inround revs.
	faction_role_text = "Revolutionary"
	faction_descriptor = "Revolution"
	faction_verb = /mob/living/proc/convert_to_rev
	faction_welcome = "Help the cause overturn the ruling class. Do not harm your fellow freedom fighters."
	faction_indicator = "hud_rev"
	faction_invisible = 1
	faction = "revolutionary"



/datum/antagonist/revolutionary/create_global_objectives()
	if(!..())
		return
	global_objectives = list()
	for(var/mob/living/carbon/human/player in SSmobs.mob_list)
		if(!player.mind || player.stat==2 || !(player.mind.assigned_role in SSjobs.titles_by_department(COM)))
			continue
		var/datum/objective/rev/rev_obj = new
		rev_obj.target = player.mind
		rev_obj.explanation_text = "Assassinate, capture or convert [player.real_name], the [player.mind.assigned_role]."
		global_objectives += rev_obj

/datum/antagonist/revolutionary/equip(mob/living/carbon/human/revolutionary_mob)
	spawn_uplink(revolutionary_mob)
	. = ..()
	if(!.)
		return

/datum/antagonist/revolutionary/proc/spawn_uplink(mob/living/carbon/human/revolutionary_mob)
	setup_uplink_source(revolutionary_mob, DEFAULT_TELECRYSTAL_AMOUNT)
