// Cross-SCP interaction implementations — ported from daedalusdock
// scp_interactions_impl.dm, adapted to F19 atoms (designation-keyed,
// sanity datum, priority_announcement, F19 939/035 APIs).

// Resolves a partner's parent atom by designation (handles "008-N" instances).
/proc/cross_partner(atom/scp1, atom/scp2, designation)
	if(scp1?.SCP && (scp1.SCP.designation == designation || findtext(scp1.SCP.designation, "[designation]-") == 1))
		return scp1
	if(scp2?.SCP && (scp2.SCP.designation == designation || findtext(scp2.SCP.designation, "[designation]-") == 1))
		return scp2
	return null

// The 049 doctor is a human mob; 035's parent is the mask item. Helpers below
// dig out the live mob/human where relevant.

/proc/interact_049_detect_008(atom/scp1, atom/scp2)
	var/atom/doctor = cross_partner(scp1, scp2, "049")
	var/atom/zombie = cross_partner(scp1, scp2, "008")
	if(!doctor || !zombie)
		return FALSE
	if(get_dist(doctor, zombie) > 10)
		return FALSE
	if(ismob(doctor))
		to_chat(doctor, SPAN_NOTICE("You sense the Pestilence has been partially cured in a nearby subject... imperfect, but promising."))
	log_game("Cross-SCP: 049 sensed 008 zombie at [get_area_name(doctor)].")
	return TRUE

/proc/interact_049_sense_035_host(atom/scp1, atom/scp2)
	var/atom/doctor = cross_partner(scp1, scp2, "049")
	if(!doctor || !ismob(doctor))
		return FALSE
	var/host = cross_partner(scp1, scp2, "035")
	if(host && isobj(host))
		var/mob/living/carbon/human/wearer = host.loc && ishuman(host.loc) ? host.loc : null
		if(wearer)
			to_chat(doctor, SPAN_WARNING("You sense an UNUSUALLY concentrated Pestilence in a nearby host... it clouds your judgment. Fascinating."))
			return TRUE
	to_chat(doctor, SPAN_NOTICE("You detect a dormant but incredibly potent strain of the Pestilence nearby... unlike anything you've encountered."))
	return TRUE

/proc/interact_035_manipulate_049(atom/scp1, atom/scp2)
	var/atom/doctor = cross_partner(scp1, scp2, "049")
	if(!doctor || !ismob(doctor))
		return FALSE
	to_chat(doctor, SPAN_NOTICE("A calm voice speaks: \"Doctor... I am already cured. The Pestilence does not reside in me.\""))
	to_chat(doctor, SPAN_NOTICE("You feel... uncertain. The compulsion to cure fades temporarily."))
	return TRUE

/proc/interact_999_heal_049_victims(atom/scp1, atom/scp2)
	var/atom/slime = cross_partner(scp1, scp2, "999")
	if(!slime)
		return FALSE
	for(var/mob/living/carbon/human/H in range(5, slime))
		if(H.stat == DEAD)
			continue
		if(ishuman(H) && H.sanity)
			H.adjustBruteLoss(-20)
			H.sanity.adjust_sanity(10, "scp999_antipestilence")
			to_chat(H, SPAN_NOTICE("Warmth washes over you. Some of the damage recedes."))
			return TRUE
	return FALSE

/proc/interact_2343_benevolence_049(atom/scp1, atom/scp2)
	var/atom/doctor = cross_partner(scp1, scp2, "049")
	if(!doctor || !ismob(doctor))
		return FALSE
	doctor.visible_message(SPAN_NOTICE("[doctor] seems calmer in the benevolent presence, its compulsion diminished."))
	return TRUE

/proc/interact_999_calm_096(atom/scp1, atom/scp2)
	var/atom/slime = cross_partner(scp1, scp2, "999")
	if(!slime)
		return FALSE
	slime.visible_message(SPAN_NOTICE("[slime] approaches, emanating warmth and comfort. The air feels lighter."))
	for(var/mob/living/carbon/human/H in range(5, slime))
		if(H.sanity)
			H.sanity.adjust_sanity(15, "scp999_comfort")
	return TRUE

/proc/interact_999_counter_513(atom/scp1, atom/scp2)
	var/atom/slime = cross_partner(scp1, scp2, "999")
	if(!slime)
		return FALSE
	var/found = FALSE
	for(var/mob/living/carbon/human/H in range(7, slime))
		if(H.sanity && H.hallucination > 0)
			H.hallucination = max(0, H.hallucination - 20)
			H.sanity.adjust_sanity(5, "scp999_513_counter")
			to_chat(H, SPAN_NOTICE("The looming presence recedes. You feel safe again."))
			found = TRUE
	return found

/proc/interact_999_counter_035(atom/scp1, atom/scp2)
	var/atom/slime = cross_partner(scp1, scp2, "999")
	if(!slime)
		return FALSE
	for(var/mob/living/carbon/human/H in range(5, slime))
		if(H.sanity)
			H.sanity.adjust_sanity(20, "scp999_035_shield")
	return TRUE

/proc/interact_106_corrode_173_containment(atom/scp1, atom/scp2)
	var/atom/larry = cross_partner(scp1, scp2, "106")
	var/atom/statue = cross_partner(scp1, scp2, "173")
	if(!larry || !statue)
		return FALSE
	// Damage the zone integrity of 173's containment via its zone datum.
	var/area/A = get_area(statue)
	if(!A)
		return FALSE
	var/datum/containment_zone/CZ = A.get_containment_zone()
	if(CZ)
		CZ.integrity = max(0, CZ.integrity - 15)
	larry.visible_message(SPAN_DANGER("Dark corrosive residue seeps from the walls near [statue]!"))
	log_game("Cross-SCP: 106 corroded 173 containment in [A.name].")
	return TRUE

/proc/interact_106_pocket_939_prey(atom/scp1, atom/scp2)
	var/atom/larry = cross_partner(scp1, scp2, "106")
	var/atom/predator = cross_partner(scp1, scp2, "939")
	if(!larry || !predator)
		return FALSE
	for(var/mob/living/carbon/human/H in range(3, predator))
		if(H.stat == DEAD || H.SCP)
			continue
		H.apply_damage(15, BRUTE, sharp = TRUE)
		to_chat(H, SPAN_USERDANGER("A dark puddle drags you briefly into a decaying void!"))
		to_chat(predator, SPAN_NOTICE("The prey's terror echoes... delicious. New voice patterns acquired."))
		return TRUE
	return FALSE

/proc/interact_457_ignite_106_residue(atom/scp1, atom/scp2)
	var/atom/flame = cross_partner(scp1, scp2, "457")
	if(!flame)
		return FALSE
	for(var/mob/living/carbon/human/H in range(3, flame))
		if(H.stat == DEAD || H.SCP)
			continue
		H.apply_damage(10, TOX)
		to_chat(H, SPAN_WARNING("Toxic fumes burn your lungs!"))
	flame.visible_message(SPAN_DANGER("SCP-457 ignites corrosive residue! Toxic smoke fills the corridor!"))
	return TRUE

/proc/interact_2020_phase_106(atom/scp1, atom/scp2)
	scp1.visible_message(SPAN_WARNING("Spatial distortions ripple through the area as two phasing entities interfere with each other!"))
	return TRUE

/proc/interact_280_shadow_106(atom/scp1, atom/scp2)
	var/atom/shadow = cross_partner(scp1, scp2, "280")
	if(!shadow)
		return FALSE
	shadow.visible_message(SPAN_WARNING("[shadow] slips through shadows into a dimensional pocket!"))
	return TRUE

/proc/interact_017_shadow_173(atom/scp1, atom/scp2)
	var/atom/statue = cross_partner(scp1, scp2, "173")
	if(!statue)
		return FALSE
	statue.visible_message(SPAN_WARNING("A shadowy entity manifests near [statue], lingering in the darkness..."))
	return TRUE

/proc/interact_131_watch_173(atom/scp1, atom/scp2)
	var/atom/eyepod = cross_partner(scp1, scp2, "131")
	var/atom/statue = cross_partner(scp1, scp2, "173")
	if(!eyepod || !statue)
		return FALSE
	eyepod.visible_message(SPAN_NOTICE("A small eye-pod creature stares unblinkingly at the sculpture, keeping it still."))
	// Freeze the statue briefly: extend its snap cooldown so it holds still.
	if(istype(statue, /mob/living/scp173))
		var/mob/living/scp173/S = statue
		S.snap_cooldown = max(S.snap_cooldown, world.time + 10 SECONDS)
	return TRUE

/proc/interact_247_illusion_173(atom/scp1, atom/scp2)
	var/atom/statue = cross_partner(scp1, scp2, "173")
	if(!statue)
		return FALSE
	statue.visible_message(SPAN_WARNING("[statue] appears as a harmless decorative piece... but something feels wrong."))
	return TRUE

/proc/interact_2398_baseball_173(atom/scp1, atom/scp2)
	var/atom/statue = cross_partner(scp1, scp2, "173")
	var/atom/bat = cross_partner(scp1, scp2, "2398")
	if(!statue || !bat)
		return FALSE
	var/bat_holder = istype(bat, /obj/item) && ishuman(bat.loc) ? bat.loc : null
	if(bat_holder)
		bat_holder.visible_message(SPAN_DANGER("A powerful swing connects with [statue]! It is knocked backward!"))
		step_away(statue, bat, 2)
		return TRUE
	return FALSE

/proc/interact_017_shadow_096(atom/scp1, atom/scp2)
	var/atom/shy = cross_partner(scp1, scp2, "096")
	if(!shy)
		return FALSE
	shy.visible_message(SPAN_NOTICE("The shadow entity instinctively retreats from [shy], refusing to perceive its face."))
	return TRUE

/proc/interact_131_watch_096(atom/scp1, atom/scp2)
	var/atom/eyepod = cross_partner(scp1, scp2, "131")
	if(!eyepod)
		return FALSE
	eyepod.visible_message(SPAN_NOTICE("A small eye-pod creature averts its gaze, making distressed sounds as a warning."))
	return TRUE

/proc/interact_247_illusion_096(atom/scp1, atom/scp2)
	var/atom/shy = cross_partner(scp1, scp2, "096")
	if(!shy)
		return FALSE
	shy.visible_message(SPAN_NOTICE("An illusory tiger casually pads between onlookers and [shy]... no one can see the face."))
	return TRUE

/proc/interact_035_corrupt_939_voice(atom/scp1, atom/scp2)
	var/atom/mask = cross_partner(scp1, scp2, "035")
	var/atom/predator = cross_partner(scp1, scp2, "939")
	if(!mask || !predator)
		return FALSE
	// 939 learns the mask's current host's voice.
	var/mob/living/carbon/human/host = isobj(mask) && mask.loc && ishuman(mask.loc) ? mask.loc : null
	if(host && istype(predator, /mob/living/simple_animal/hostile/scp939))
		var/mob/living/simple_animal/hostile/scp939/S = predator
		S.learn_voice(host)
		to_chat(S, SPAN_NOTICE("New voice patterns merge with your own... the prey will not resist."))
		return TRUE
	return FALSE

/proc/interact_939_mimic_035_voice(atom/scp1, atom/scp2)
	var/atom/predator = cross_partner(scp1, scp2, "939")
	var/atom/mask = cross_partner(scp1, scp2, "035")
	if(!predator || !mask)
		return FALSE
	var/mob/living/carbon/human/host = isobj(mask) && mask.loc && ishuman(mask.loc) ? mask.loc : null
	if(host && istype(predator, /mob/living/simple_animal/hostile/scp939))
		var/mob/living/simple_animal/hostile/scp939/S = predator
		S.learn_voice(host)
	for(var/mob/living/carbon/human/H in range(10, predator))
		if(H.stat != DEAD && !H.SCP)
			to_chat(H, SPAN_WARNING("You hear a familiar voice calling your name... it sounds so real..."))
			if(H.sanity)
				H.sanity.adjust_sanity(-5, "scp939_035_lure")
			break
	return TRUE

/proc/interact_151_mirror_035(atom/scp1, atom/scp2)
	var/atom/mask = cross_partner(scp1, scp2, "035")
	if(!mask)
		return FALSE
	for(var/mob/living/carbon/human/H in range(8, mask))
		if(H.stat == DEAD || H.SCP)
			continue
		if(prob(15))
			to_chat(H, SPAN_WARNING("You see strange suggestions in the water's reflection..."))
			if(H.sanity)
				H.sanity.adjust_sanity(-5, "scp151_035_reflect")
	return TRUE

/proc/interact_347_stealth_035(atom/scp1, atom/scp2)
	var/atom/mask = cross_partner(scp1, scp2, "035")
	if(!mask)
		return FALSE
	mask.visible_message(SPAN_WARNING("An unseen agent extends the mask's influence..."))
	return TRUE

/proc/interact_066_eric_035(atom/scp1, atom/scp2)
	var/atom/mask = cross_partner(scp1, scp2, "035")
	if(!mask)
		return FALSE
	scp1.visible_message(SPAN_WARNING("A small metal sphere repeatedly says 'Eric!' near [mask], disrupting its concentration."))
	return TRUE

// --- 914 refinement pairs: the item SCP must be inside 914's input booth ---
/proc/interact_914_refine_500(atom/scp1, atom/scp2)
	var/atom/machine = cross_partner(scp1, scp2, "914")
	var/atom/pills = cross_partner(scp1, scp2, "500")
	if(!machine || !pills)
		return FALSE
	if(!istype(machine, /obj/machinery/scp914) || !istype(pills, /obj/item/reagent_containers/pill/scp500))
		return FALSE
	var/obj/machinery/scp914/M = machine
	var/obj/item/reagent_containers/pill/scp500/P = pills
	if(get_area(P) != get_area(M.input_part) && get_dist(P, M.input_part) > 2)
		return FALSE
	if(M.setting == "Fine" && P.reagents)
		P.reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)
		P.desc = "An enhanced red pill. The label reads 'SCP-500-F'."
		M.visible_message(SPAN_NOTICE("[M] hums contentedly as it refines [P]..."))
		log_game("Cross-SCP: 914 Fine-refined SCP-500.")
		return TRUE
	return FALSE

/proc/interact_914_refine_113(atom/scp1, atom/scp2)
	var/atom/machine = cross_partner(scp1, scp2, "914")
	var/atom/ring = cross_partner(scp1, scp2, "113")
	if(!machine || !ring || !istype(machine, /obj/machinery/scp914))
		return FALSE
	var/obj/machinery/scp914/M = machine
	if(M.setting == "Fine" && istype(ring, /obj/item/clothing/ring))
		var/obj/item/clothing/ring/R = ring
		R.desc = "A red jasper ring, somehow softer-edged than before. Less dangerous, maybe."
		M.visible_message(SPAN_NOTICE("[M] polishes [R] to a gentler sheen."))
		log_game("Cross-SCP: 914 Fine-refined SCP-113.")
		return TRUE
	return FALSE

/proc/interact_914_refine_513(atom/scp1, atom/scp2)
	var/atom/machine = cross_partner(scp1, scp2, "914")
	var/atom/bell = cross_partner(scp1, scp2, "513")
	if(!machine || !bell || !istype(machine, /obj/machinery/scp914))
		return FALSE
	var/obj/machinery/scp914/M = machine
	if(M.setting == "Rough")
		M.visible_message(SPAN_DANGER("[M] crushes and grinds — the bell's ring comes out dead and silent."))
		bell.visible_message(SPAN_NOTICE("[bell] emerges dented, its memetic toll seemingly gone."))
		log_game("Cross-SCP: 914 Rough-destroyed SCP-513 memetic property.")
		return TRUE
	return FALSE

/proc/interact_914_refine_427(atom/scp1, atom/scp2)
	var/atom/machine = cross_partner(scp1, scp2, "914")
	var/atom/locket = cross_partner(scp1, scp2, "427")
	if(!machine || !locket)
		return FALSE
	// F19 427 may not carry an SCP datum; accept any amulet-shaped item nearby.
	var/obj/machinery/scp914/M = machine
	if(M.setting == "Fine")
		M.visible_message(SPAN_NOTICE("[M] produces a stabilized variant from its output booth..."))
		var/obj/item/reagent_containers/pill/telecordrazine/P = new /obj/item/reagent_containers/pill/telecordrazine(get_turf(M.output_part))
		P.name = "stabilized healing compound (SCP-427-F)"
		log_game("Cross-SCP: 914 Fine-refined SCP-427 locket.")
		return TRUE
	return FALSE

/proc/interact_216_vault_500(atom/scp1, atom/scp2)
	var/atom/vault = cross_partner(scp1, scp2, "216")
	if(!vault)
		return FALSE
	// Dispense a bonus 500 pill if a critically injured person accessed 216 recently.
	for(var/mob/living/carbon/human/H in range(2, vault))
		if(H.stat != DEAD && H.health / H.maxHealth < 0.35)
			new /obj/item/reagent_containers/pill/scp500(get_turf(vault))
			vault.visible_message(SPAN_NOTICE("A red pill slides out of [vault], as if anticipating the need."))
			log_game("Cross-SCP: 216 dispensed SCP-500 for a critically injured user.")
			return TRUE
	return FALSE

/proc/interact_263_quiz_012(atom/scp1, atom/scp2)
	var/atom/quiz = cross_partner(scp1, scp2, "263")
	if(!quiz)
		return FALSE
	for(var/mob/living/carbon/human/H in range(3, quiz))
		if(H.stat != DEAD && H.sanity)
			H.sanity.adjust_sanity(5, "scp263_012_resist")
			to_chat(H, SPAN_NOTICE("The quizmaster's question snaps you out of the composition's pull... for now."))
			return TRUE
	return FALSE

/proc/interact_013_bluelady_012(atom/scp1, atom/scp2)
	var/atom/cigs = cross_partner(scp1, scp2, "013")
	if(!cigs)
		return FALSE
	for(var/mob/living/carbon/human/H in range(5, cigs))
		if(H.stat == DEAD || H.SCP)
			continue
		if(prob(10))
			to_chat(H, SPAN_WARNING("A ghostly melody fills your mind, compelling you to write..."))
			if(H.sanity)
				H.sanity.adjust_sanity(-3, "scp013_012_loop")
	return TRUE

/proc/interact_151_mirror_895(atom/scp1, atom/scp2)
	var/atom/coffin = cross_partner(scp1, scp2, "895")
	if(!coffin)
		return FALSE
	for(var/mob/living/carbon/human/H in range(5, coffin))
		if(H.stat == DEAD)
			continue
		if(H.hallucination < 30)
			H.hallucination += 10
			to_chat(H, SPAN_WARNING("The water's surface shows something that shouldn't be there..."))
		break
	return TRUE

/proc/interact_457_feed_895_corpse(atom/scp1, atom/scp2)
	var/atom/flame = cross_partner(scp1, scp2, "457")
	var/atom/coffin = cross_partner(scp1, scp2, "895")
	if(!flame || !coffin)
		return FALSE
	flame.visible_message(SPAN_DANGER("SCP-457 burns near SCP-895! Corrupted smoke billows through the vents!"))
	// Extend 895's reach: anyone viewing cameras near the coffin gets worse.
	for(var/mob/living/carbon/human/H in range(10, coffin))
		if(H.stat != DEAD && H.hallucination < 40)
			H.hallucination += 5
	return TRUE

/proc/interact_2427_malfunction_914(atom/scp1, atom/scp2)
	var/atom/machine = cross_partner(scp1, scp2, "914")
	var/atom/glitcher = cross_partner(scp1, scp2, "2427-3")
	if(!machine || !glitcher || !istype(machine, /obj/machinery/scp914))
		return FALSE
	if(get_dist(machine, glitcher) > 5)
		return FALSE
	machine.visible_message(SPAN_WARNING("[machine]'s dials spin erratically as electronic interference corrupts the refinement!"))
	log_game("Cross-SCP: 2427-3 glitched 914 refinement.")
	return TRUE

/proc/interact_280_shadow_017(atom/scp1, atom/scp2)
	var/atom/shadow = cross_partner(scp1, scp2, "280")
	var/atom/shadowling = cross_partner(scp1, scp2, "017")
	if(!shadow || !shadowling)
		return FALSE
	scp1.visible_message(SPAN_DANGER("Shadows merge and twist, forming a larger and more menacing darkness!"))
	return TRUE

/proc/interact_343_god_999(atom/scp1, atom/scp2)
	var/atom/slime = cross_partner(scp1, scp2, "999")
	if(!slime)
		return FALSE
	slime.visible_message(SPAN_NOTICE("[slime]'s aura glows brighter in the divine presence!"))
	for(var/mob/living/carbon/human/H in range(7, slime))
		if(H.sanity)
			H.sanity.adjust_sanity(10, "scp343_999_blessing")
	return TRUE

/proc/interact_527_trade_082(atom/scp1, atom/scp2)
	var/atom/chef = cross_partner(scp1, scp2, "082")
	if(!chef)
		return FALSE
	chef.visible_message(SPAN_NOTICE("[chef] accepts ingredients from a small dragon-like creature and begins cooking!"))
	return TRUE

/proc/interact_529_half_cat_131(atom/scp1, atom/scp2)
	var/atom/cat = cross_partner(scp1, scp2, "529")
	var/atom/eyepod = cross_partner(scp1, scp2, "131")
	if(!cat || !eyepod)
		return FALSE
	scp1.visible_message(SPAN_NOTICE("A half-cat and an eye-pod creature form an adorable protective pair."))
	return TRUE
