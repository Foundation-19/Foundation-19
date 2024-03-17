/datum/spell/aoe_turf/conjure/force_portal
	name = "Force Portal"
	desc = "Create a portal that sucks in anything that touches it and then shoots it all out at the end.."
	summon_type = list(/obj/effect/force_portal)
	charge_max = 200
	spell_flags = NEEDSCLOTHES
	range = 0
	cast_sound = null

	hud_state = "wiz_force"

	spell_cost = 2
	mana_cost = 20
