/datum/spell/targeted/communicate_049
	name = "Communicate"
	desc = "Allows you to communicate with other instances of 049."
	spell_flags = null
	charge_max = 0

/datum/spell/targeted/communicate_049/cast(list/targets, mob/user)
	var/message = html_encode(input(user, "", "Say") as text|null)
	if(!message)
		return FALSE
	for(var/mob/living/carbon/human/target in GLOB.scp049s | GLOB.scp049_1s)
		to_chat(target, "<i>Hivemind</i> <b>[target.name]</b> says, \"[message]\"")
	return TRUE