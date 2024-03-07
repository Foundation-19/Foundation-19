// List of item types that may be used in activation of the symptom
GLOBAL_LIST_INIT(paranoia_items, list(
	/obj/item/card/data,
	/obj/item/card/emag,
	/obj/item/plastique,
	/obj/item/aiModule/syndicate,
	/obj/item/aiModule/freeform,
	/obj/item/shield/energy,
	/obj/item/melee/baton,
	/obj/item/melee/baton/cattleprod,
	/obj/item/melee/energy/sword,
	/obj/item/implantcase/adrenalin,
	/obj/item/implantcase/explosive,
	/obj/item/implanter/uplink,
	/obj/item/gun/energy/gun,
	/obj/item/gun/energy/gun/nuclear,
	/obj/item/gun/energy/captain,
	/obj/item/gun/energy/ionrifle/small,
	/obj/item/gun/energy/toxgun,
	/obj/item/gun/projectile/pistol/military,
	/obj/item/gun/projectile/pistol/sec,
	/obj/item/gun/projectile/automatic,
	/obj/item/pen,
	/obj/item/grenade/anti_photon,
	/obj/item/grenade/smokebomb,
	/obj/item/grenade/empgrenade,
	/obj/item/grenade/frag,
	/obj/item/grenade/frag/high_yield,
	/obj/item/device/uplink_service/fake_ion_storm,
	/obj/item/device/powersink,
	))

// List of random spooky sounds to play to paranoid people
// The associated list is: list(maximum repeats, minimum delay, maximum delay)
// If no list is associated - treated as single sound instance
GLOBAL_LIST_INIT(paranoia_sounds, list(
	"button" = list(3, 1 SECONDS, 3 SECONDS),
	'sounds/machines/airlock_open.ogg',
	'sounds/machines/airlock_open_force.ogg',
	'sounds/machines/airlock_close.ogg',
	'sounds/machines/airlock_close_force.ogg',
	'sounds/machines/bolts_up.ogg',
	'sounds/machines/bolts_down.ogg',
	'sounds/machines/deniedboop.ogg' = list(5, 1.5 SECONDS, 3 SECONDS),
	'sounds/effects/walkieon.ogg' = list(2, 2 SECONDS, 4 SECONDS),
	'sounds/effects/walkietalkie.ogg' = list(6, 1 SECONDS, 6 SECONDS),
	'sounds/weapons/Laser.ogg' = list(6, 1 SECONDS, 4 SECONDS),
	'sounds/weapons/lasercannonfire.ogg' = list(3, 2 SECONDS, 6 SECONDS),
	'sounds/weapons/pulse.ogg' = list(5, 1.5 SECONDS, 5 SECONDS),
	'sounds/weapons/gunshot/gunshot_strong.ogg' = list(7, 1 SECONDS, 2 SECONDS),
	'sounds/weapons/gunshot/gunshot_pistol.ogg' = list(7, 1 SECONDS, 2 SECONDS),
	'sounds/weapons/gunshot/revolver.ogg' = list(6, 1.3 SECONDS, 3 SECONDS),
	'sounds/weapons/gunshot/gunshot2.ogg' = list(10, 0.1 SECONDS, 0.4 SECONDS),
	'sounds/weapons/gunshot/gunshot3.ogg' = list(10, 0.1 SECONDS, 0.4 SECONDS),
	'sounds/weapons/guns/miss1.ogg' = list(5, 0.1 SECONDS, 1 SECONDS),
	'sounds/weapons/guns/miss2.ogg' = list(5, 0.1 SECONDS, 1 SECONDS),
	'sounds/weapons/guns/ricochet1.ogg' = list(5, 0.1 SECONDS, 1 SECONDS),
	'sounds/weapons/guns/ricochet2.ogg' = list(5, 0.1 SECONDS, 1 SECONDS),
	// If you don't have infestation PTSD - you aren't a real human,
	'sounds/weapons/rapidslice.ogg' = list(3, 1 SECONDS, 2 SECONDS),
	'sounds/weapons/slashmiss.ogg' = list(7, 0.5 SECONDS, 1 SECONDS),
	'sounds/weapons/alien_claw_flesh1.ogg' = list(5, 0.8 SECONDS, 1.4 SECONDS),
	'sounds/simple_mob/abominable_infestation/assembler/ambient_1.ogg' = list(3, 2 SECONDS, 4 SECONDS),
	'sounds/simple_mob/abominable_infestation/broodling/ambient_1.ogg' = list(2, 1 SECONDS, 3 SECONDS),
	'sounds/simple_mob/abominable_infestation/broodling/ambient_2.ogg' = list(2, 1 SECONDS, 3 SECONDS),
	'sounds/simple_mob/abominable_infestation/broodling/death.ogg',
	'sounds/simple_mob/abominable_infestation/eviscerator/attack.ogg' = list(3, 1 SECONDS, 3 SECONDS),
	'sounds/simple_mob/abominable_infestation/eviscerator/step.ogg' = list(4, 1 SECONDS, 3 SECONDS),
	'sounds/simple_mob/abominable_infestation/eviscerator/aggro_1.ogg',
	'sounds/simple_mob/abominable_infestation/eviscerator/aggro_2.ogg',
	'sounds/simple_mob/abominable_infestation/eviscerator/aggro_3.ogg',
	'sounds/simple_mob/abominable_infestation/eviscerator/death_1.ogg',
	'sounds/simple_mob/abominable_infestation/floatfly/fly.ogg',
	'sounds/simple_mob/abominable_infestation/floatfly/death.ogg',
	'sounds/simple_mob/abominable_infestation/rhino/step.ogg' = list(3, 2 SECONDS, 4 SECONDS),
	'sounds/simple_mob/abominable_infestation/rhino/roar.ogg',
	// Authentic SCP sounds,
	'sounds/scp/spook/NeckSnap1.ogg',
	'sounds/scp/spook/NeckSnap3.ogg',
	'sounds/scp/voice/SCP049_1.ogg',
	'sounds/scp/voice/SCP049_2.ogg',
	'sounds/scp/voice/SCP049_3.ogg',
	'sounds/scp/voice/SCP049_4.ogg',
	'sounds/scp/voice/SCP049_5.ogg',
	'sounds/effects/footstep/scp106/step1.ogg' = list(12, 0.7 SECONDS, 2 SECONDS),
	'sounds/effects/footstep/scp106/step2.ogg' = list(12, 0.7 SECONDS, 2 SECONDS),
	'sounds/effects/footstep/scp106/step3.ogg' = list(12, 0.7 SECONDS, 2 SECONDS),
	'sounds/scp/106/decay1.ogg',
	'sounds/scp/106/decay2.ogg',
	'sounds/scp/106/decay3.ogg',
	'sounds/scp/106/breathing.ogg' = list(4, 12 SECONDS, 30 SECONDS),
	'sounds/scp/106/laugh.ogg' = list(3, 25 SECONDS, 40 SECONDS),
	'sounds/mecha/mechmove04.ogg' = list(12, 0.5 SECONDS, 1 SECONDS)
	))

/*
//////////////////////////////////////

Paranoia

	Very stealthy.
	Reduces resistance.
	Increases stage speed.
	Reduces transmissibility.
	Medium Level.

BONUS
	Displays an annoying message!
	Should be used for buffing your disease.

//////////////////////////////////////
*/

/datum/symptom/paranoia
	name = "Paranoia"
	desc = "The virus causes delusional and distrustful behavior in the host."
	stealth = 2
	resistance = -2
	stage_speed = 1
	transmittable = -2
	level = 5
	severity = 1
	symptom_delay_min = 2
	symptom_delay_max = 90 // They will never know what to trust :)

/datum/symptom/paranoia/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(A.stage <= 3)
		return
	else
		var/mob/living/M = A.affected_mob
		var/rand_effect = pick(1, 2, 3)
		switch(rand_effect)
			// Fake examine message
			if(1)
				SendFakeExamine(M)
			// Fake sound
			if(2)
				PlayFakeSound(M)

/datum/symptom/paranoia/proc/SendFakeExamine(mob/living/M)
	if(!M.can_see())
		return
	var/list/potential_people = list()
	for(var/mob/living/carbon/human/H in view(4, M))
		if(H == M)
			continue
		if(!H.client)
			continue
		if(H.stat)
			continue
		if(H.is_invisible_to(M))
			continue
		potential_people += H
	if(!LAZYLEN(potential_people))
		return
	var/mob/living/carbon/human/H = pick(potential_people)
	var/fake_message = "at the void"
	if(prob(25) && istype(H.back, /obj/item/storage))
		fake_message = "inside \the [H.back.name]"
	else
		var/obj/item/fake_item = pick(GLOB.paranoia_items)
		fake_message = "at \the [initial(fake_item.name)]"
	to_chat(M, "<span class='subtle'><b>\The [H]</b> looks [fake_message].</span>")

/datum/symptom/paranoia/proc/PlayFakeSound(mob/living/M)
	var/turf/T = get_random_turf_in_range(M, 8, 4)
	var/S = pick(GLOB.paranoia_sounds)
	var/vol = rand(10, 50)
	M.playsound_local(T, S, vol, prob(50))
	if(!islist(GLOB.paranoia_sounds[S]))
		return
	// Epic paranoidal sounds
	var/list/params = GLOB.paranoia_sounds[S]
	var/repeats = rand(1, params[1])
	for(var/i = 1 to repeats)
		var/delay = rand(params[2], params[3])
		addtimer(CALLBACK(src, PROC_REF(PlayDelayedSound), M, T, S), delay)

/datum/symptom/paranoia/proc/PlayDelayedSound(mob/living/M, turf/T, S, vol)
	if(QDELETED(M) || QDELETED(T))
		return
	var/turf/TT = get_random_turf_in_range(T, 1) // Sound is coming from slightly different place now
	M.playsound_local(TT, S, rand(round(vol * 0.75), round(vol * 1.25)), prob(50))
