GLOBAL_DATUM_INIT(informants, /datum/antagonist/informant, new)

/datum/antagonist/informant
	id = MODE_INFORMANT
	role_text = "Informant"
	role_text_plural = "Informants"
	antaghud_indicator = "hud_informant"
	whitelisted_jobs = list(/datum/job/classd)
	flags = ANTAG_RANDSPAWN | ANTAG_VOTABLE
	skill_setter = null
	antag_text = "You are an semi-tagonist! While you have goals of your own, you aren't inherently an opposing force of your own. \
		Further RP and try to make sure other players have <i>fun</i>! \
		If you are confused or at a loss, always adminhelp, and before taking extreme actions, please try to also contact the administration! \
		Think through your actions and make the roleplay immersive! \
		<b>Please remember all rules aside from those without explicit exceptions apply to you.</b>"
	welcome_text = "You are an Informant! Discretely spy on potential escape plans and riots, and report information to your handlers."

/datum/antagonist/informant/create_objectives(datum/mind/informant_mind)
	if(!..())
		return

	var/datum/objective/informant/inform_objective = new
	inform_objective.owner = informant_mind
	informant_mind.objectives += inform_objective

// we have a special symbol on the wanted hud
// TODO: move this all to the crew records system (and allow guards to organically add/remove informant status)

/datum/antagonist/informant/add_antagonist(datum/mind/player, ignore_role, do_not_equip, move_to_spawn, do_not_announce, preserve_appearance)
	. = ..()
	BITSET(player.current, WANTED_HUD)

/datum/antagonist/informant/remove_antagonist(datum/mind/player, show_message, implanted)
	. = ..()
	BITSET(player.current, WANTED_HUD)
