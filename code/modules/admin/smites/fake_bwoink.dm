/// Sends the target a fake adminhelp sound
/datum/smite/fake_bwoink
	name = "Fake bwoink"

/datum/smite/fake_bwoink/effect(client/user, mob/living/target)
	. = ..()
	sound_to(target, 'sounds/effects/adminhelp.ogg')
