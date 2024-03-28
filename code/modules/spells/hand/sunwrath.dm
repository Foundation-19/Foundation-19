/datum/spell/hand/duration/sunwrath
	name = "sun god's wrath"
	desc = "Your hands become a gateway of fire, shooting hot plasma from your fingertips."
	spell_flags = 0
	charge_max = 600
	invocation_type = INVOKE_SHOUT
	invocation = "Herald! Bless me with your anger!"
	show_message = " erupts fire from their hands"
	hand_duration = 100
	spell_delay = 30
	range = 4

	categories = list(SPELL_CATEGORY_FIRE)

	hud_state = "wiz_immolate"

	spell_cost = 5
	mana_cost = 30

/datum/spell/hand/duration/sunwrath/cast_hand(atom/A, mob/user)
	. = ..()
	if(!.)
		return

	var/turf/T = get_turf(user)
	var/list/turfs = getline(T,A) - T
	for(var/t in turfs)
		var/turf/turf = t
		if(turf.density || istype(turf, /turf/space))
			break
		new /obj/effect/fake_fire/sunwrath(t)
	return 1

/obj/effect/fake_fire/sunwrath
	firelevel = 5
	last_temperature = 0
	pressure = 5000

/obj/effect/fake_fire/sunwrath/Process() //Override, so we burn mobs only
	for(var/mob/living/L in loc)
		L.FireBurn(firelevel, last_temperature, pressure)
