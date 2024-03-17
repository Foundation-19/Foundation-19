/obj/infestation_structure
	abstract_type = /obj/infestation_structure

	name = "infestation structure base"
	desc = "You are not meant to see this."

	density = TRUE
	opacity = 1
	anchored = TRUE
	mouse_opacity = 2

	damage_hitsound = 'sounds/effects/attackblob.ogg'

	health_resistances = list(
		DAMAGE_BRUTE     = 1.5,
		DAMAGE_BURN      = 1,
		DAMAGE_FIRE      = 2,
		DAMAGE_EXPLODE   = 1,
		DAMAGE_STUN      = 0.2,
		DAMAGE_EMP       = 0,
		DAMAGE_RADIATION = 0,
		DAMAGE_BIO       = 0,
		DAMAGE_PAIN      = 0.2,
		DAMAGE_TOXIN     = 0,
		DAMAGE_GENETIC   = 3,
		DAMAGE_OXY       = 0,
		DAMAGE_BRAIN     = 0
	)

	var/faction = "abominable_infestation"
