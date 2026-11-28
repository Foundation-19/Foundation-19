// SCP-076 — "Abel". Ported from daedalusdock SCP-076.dm, adapted:
//  - F19 has no /mob/living/scp base; this is a plain /mob/living like 173
//  - SPAN_* macros, tgui_input_list prompts, Weaken() stuns
//  - sanity damage via H.sanity (adjust_sanity / add_trauma)
//  - actions via F19 /datum/action (AB_INNATE), movespeed via the
//    add_or_update_variable_movespeed_modifier API
//  - blade damage is straight BURN-less BRUTE (F19 has no abstract types)

#define SCP076_STATE_DORMANT "dormant"
#define SCP076_STATE_AWAKENING "awakening"
#define SCP076_STATE_ACTIVE "active"
#define SCP076_STATE_DECEASED "deceased"

/mob/living/scp076
	name = "SCP-076"
	desc = "A muscular humanoid figure emerging from a stone sarcophagus. He carries an insatiable desire for combat."
	icon = 'icons/SCP/scp-076-2.dmi'
	icon_state = "preview"
	real_name = "SCP-076-2"
	status_flags = NO_ANTAG

	maxHealth = 400
	health = 400

	a_intent = I_HURT
	can_be_buckled = FALSE
	can_pull_size = 0

	// State machine
	var/current_state = SCP076_STATE_DORMANT
	var/awakening_timer = 0
	var/awakening_duration = 60 SECONDS
	var/dormant_duration = 5 MINUTES
	var/dormant_timer = 0
	var/respawn_count = 0

	// Combat resources
	var/weapon_cooldown = 0
	var/blade_summoned = FALSE
	var/obj/item/melee/scp076_blade/summoned_blade
	var/rage_meter = 0
	var/max_rage = 100
	var/kill_count = 0
	var/speed_boost_active = FALSE
	var/respects_opponent = FALSE
	var/battle_cry_cooldown = 0
	var/throw_cooldown = 0
	var/leap_cooldown = 0
	var/focus_cooldown = 0

	var/spawn_area

	var/datum/action/scp076_battle_cry/cry_action
	var/datum/action/scp076_throw_blade/throw_action
	var/datum/action/scp076_leap/leap_action
	var/datum/action/scp076_berserk/berserk_action
	var/datum/action/scp076_focus/focus_action
	var/datum/action/scp076_dormant/dormant_action

/mob/living/scp076/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"Abel",
		SCP_KETER,
		"076",
		SCP_PLAYABLE
	)
	SCP.min_playercount = 20
	SCP.min_time = 15 MINUTES
	spawn_area = get_area(src)
	add_language(LANGUAGE_EAL, FALSE)
	add_language(LANGUAGE_SKRELLIAN, FALSE)
	add_language(LANGUAGE_GUTTER, FALSE)
	add_language(LANGUAGE_SIGN, FALSE)
	add_language(LANGUAGE_ENGLISH, TRUE)

	cry_action = new /datum/action/scp076_battle_cry(src)
	throw_action = new /datum/action/scp076_throw_blade(src)
	leap_action = new /datum/action/scp076_leap(src)
	berserk_action = new /datum/action/scp076_berserk(src)
	focus_action = new /datum/action/scp076_focus(src)
	dormant_action = new /datum/action/scp076_dormant(src)
	cry_action.Grant(src)
	throw_action.Grant(src)
	leap_action.Grant(src)
	berserk_action.Grant(src)
	focus_action.Grant(src)
	dormant_action.Grant(src)
	enter_dormant()

/mob/living/scp076/Destroy()
	QDEL_NULL(summoned_blade)
	QDEL_NULL(SCP)
	return ..()

/mob/living/scp076/Life()
	. = ..()
	if(stat == DEAD)
		return

	switch(current_state)
		if(SCP076_STATE_DORMANT)
			process_dormant()
		if(SCP076_STATE_AWAKENING)
			process_awakening()
		if(SCP076_STATE_DECEASED)
			process_deceased()

/mob/living/scp076/proc/enter_dormant()
	current_state = SCP076_STATE_DORMANT
	dormant_timer = world.time + dormant_duration
	SetParalysis(999999) // dormancy reads as unconscious in the body bag
	visible_message(SPAN_NOTICE("[src] collapses back into the sarcophagus, becoming dormant."))
	if(SCP && SCP.research && SCP.research.containment_status == SCP_BREACHED)
		SCP.research.set_containment_status(SCP_CONTAINED)
	if(summoned_blade)
		QDEL_NULL(summoned_blade)
		blade_summoned = FALSE

/mob/living/scp076/proc/process_dormant()
	if(world.time >= dormant_timer)
		begin_awakening()

/mob/living/scp076/proc/begin_awakening()
	current_state = SCP076_STATE_AWAKENING
	awakening_timer = world.time + awakening_duration
	SetParalysis(0)
	visible_message(SPAN_WARNING("[src] begins to stir within the sarcophagus..."))
	playsound(src, 'sounds/effects/ghost.ogg', 50, TRUE)

/mob/living/scp076/proc/process_awakening()
	if(world.time >= awakening_timer)
		enter_active()

/mob/living/scp076/proc/enter_active()
	current_state = SCP076_STATE_ACTIVE
	SetParalysis(0)
	if(health < maxHealth)
		revive() // Abel rises whole, every time
	rage_meter = 0
	visible_message(SPAN_DANGER("[src] fully emerges from the sarcophagus, eyes burning with battle fury!"))
	playsound(src, 'sounds/hallucinations/growl1.ogg', 60, TRUE)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_BREACHED)
	if(!blade_summoned)
		summon_blade()

/mob/living/scp076/proc/process_deceased()
	if(world.time >= dormant_timer)
		respawn_count++
		SetParalysis(0)
		begin_awakening()

/mob/living/scp076/proc/summon_blade()
	if(blade_summoned)
		return
	summoned_blade = new /obj/item/melee/scp076_blade(src)
	put_in_hands(summoned_blade)
	blade_summoned = TRUE
	visible_message(SPAN_DANGER("[src] summons a blade of dark energy from thin air!"))

/mob/living/scp076/proc/activate_speed_boost()
	speed_boost_active = TRUE
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/scp076_rage, TRUE, -1)
	visible_message(SPAN_DANGER("[src] moves with blinding speed!"))
	addtimer(CALLBACK(src, PROC_REF(deactivate_speed_boost)), 30 SECONDS)

/mob/living/scp076/proc/deactivate_speed_boost()
	speed_boost_active = FALSE
	remove_movespeed_modifier(/datum/movespeed_modifier/scp076_rage)

/mob/living/scp076/proc/is_worthy_opponent(mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	// F19 has no combat_mode toggle; harm intent is the "wanting a fight" signal.
	if(H.a_intent == I_HURT)
		return TRUE
	var/obj/item/held = H.get_active_hand()
	if(held && (istype(held, /obj/item/melee) || istype(held, /obj/item/gun) || istype(held, /obj/item/shield)))
		return TRUE
	// Security-ladder jobs count as worthy.
	var/datum/job/J = H.mind && SSjobs.get_by_title(H.mind.assigned_role)
	if(J && (J.department_flag & SEC))
		return TRUE
	if(H.LAssailant == src)
		return TRUE
	return FALSE

/mob/living/scp076/proc/scp076_ai_berserk()
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/scp076_rage, TRUE, -1.5)
	visible_message(SPAN_DANGER("[src] enters a berserk frenzy!"))
	addtimer(CALLBACK(src, PROC_REF(scp076_end_berserk)), 15 SECONDS)

/mob/living/scp076/proc/scp076_end_berserk()
	remove_movespeed_modifier(/datum/movespeed_modifier/scp076_rage)
	to_chat(src, SPAN_NOTICE("Your berserk frenzy subsides."))

/mob/living/scp076/death(gibbed)
	if(current_state == SCP076_STATE_ACTIVE)
		current_state = SCP076_STATE_DECEASED
		dormant_timer = world.time + dormant_duration
		kill_count = 0
		rage_meter = 0
		visible_message(SPAN_DANGER("[src] falls... but the sarcophagus begins to glow."))
		QDEL_NULL(summoned_blade)
		blade_summoned = FALSE
		// Abel does not die — the corpse reforms on the dormant timer.
		addtimer(CALLBACK(src, PROC_REF(check_respawn)), dormant_duration)
		return
	..()

/mob/living/scp076/proc/check_respawn()
	if(current_state != SCP076_STATE_DECEASED)
		return
	SetParalysis(0)
	revive() // rebuild from the sarcophagus glow
	begin_awakening()

/mob/living/scp076/UnarmedAttack(atom/A)
	if(!isliving(A) || current_state != SCP076_STATE_ACTIVE)
		return ..()

	var/mob/living/L = A

	if(ishuman(L) && !is_worthy_opponent(L))
		visible_message(SPAN_NOTICE("[src] looks at [L] with contempt, but does not attack."))
		return

	if(!respects_opponent && ishuman(L) && is_worthy_opponent(L))
		respects_opponent = TRUE
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/scp076_rage, TRUE, -0.5)
		visible_message(SPAN_DANGER("[src] recognizes a worthy opponent and moves with renewed fury!"))

	var/damage = 35 + (rage_meter * 0.3) + (respects_opponent ? 10 : 0)

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.apply_damage(damage, BRUTE)
		if(H.sanity)
			H.sanity.add_trauma(TRAUMA_VIOLENCE, 15)
			H.sanity.on_violence_witnessed(5)

	visible_message(SPAN_DANGER("[src] strikes [L] with devastating force!"))
	playsound(src, 'sounds/weapons/bladeslice.ogg', 50, TRUE)

	rage_meter = min(rage_meter + 5, max_rage)

	if(L.stat == DEAD)
		kill_count++
		rage_meter = max(rage_meter - 15, 0)

/mob/living/scp076/examine(mob/user)
	. = ..()
	if(ishuman(user))
		to_chat(user, SPAN_WARNING("This is SCP-076-2, 'Abel'. A Keter-class hostile entity with infinite regenerative abilities. He follows a warrior's code — unworthy opponents are beneath his notice."))

// ============================================================================
// ABILITIES (F19 action datums)
// ============================================================================

/datum/action/scp076_battle_cry
	name = "Battle Cry"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "repulse"

/datum/action/scp076_battle_cry/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	if(world.time < S.battle_cry_cooldown)
		return 0
	return 1

/datum/action/scp076_battle_cry/Activate()
	var/mob/living/scp076/S = owner
	S.battle_cry_cooldown = world.time + 45 SECONDS
	S.visible_message(SPAN_DANGER("[S] lets out a thunderous battle cry!"))
	playsound(S, 'sounds/hallucinations/growl2.ogg', 100, FALSE)
	for(var/mob/living/carbon/human/H in view(5, S))
		if(H == S || H.stat == DEAD)
			continue
		if(H.sanity)
			H.sanity.adjust_sanity(-20, "scp076_battle_cry")
		if(prob(40))
			H.Weaken(2)
			to_chat(H, SPAN_USERDANGER("[S]'s battle cry freezes you in terror!"))
	S.rage_meter = min(S.rage_meter + 20, S.max_rage)
	to_chat(S, SPAN_NOTICE("Rage surges through you! (+20 rage)"))

/datum/action/scp076_throw_blade
	name = "Throw Blade"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "spell_missile"

/datum/action/scp076_throw_blade/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	if(!S.summoned_blade)
		return 0
	if(world.time < S.throw_cooldown)
		return 0
	return 1

/datum/action/scp076_throw_blade/Activate()
	var/mob/living/scp076/S = owner
	S.throw_cooldown = world.time + 15 SECONDS
	var/list/targets = list()
	for(var/mob/living/L in view(7, S))
		if(L == S || L.stat == DEAD)
			continue
		targets += L
	if(!length(targets))
		to_chat(S, SPAN_WARNING("No targets in range."))
		return
	var/mob/living/target = tgui_input_list(S, "Choose a target:", "Blade Throw", targets)
	if(!target || QDELETED(target))
		S.throw_cooldown = 0
		return
	S.visible_message(SPAN_DANGER("[S] hurls the abyssal blade at [target]!"))
	playsound(S, 'sounds/weapons/bladeslice.ogg', 80, TRUE)
	var/damage = 30 + (S.rage_meter * 0.2)
	target.apply_damage(damage, BRUTE)
	if(target.stat != DEAD && ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.sanity)
			H.sanity.add_trauma(TRAUMA_VIOLENCE, 10)
	if(target.stat == DEAD)
		S.kill_count++
	// The blade flies: toss the actual item so it can be picked up/resisted.
	var/obj/item/melee/scp076_blade/blade = S.summoned_blade
	if(blade)
		S.drop_from_inventory(blade)
		blade.throw_at(target, 8, 5)

/datum/action/scp076_leap
	name = "Leaping Strike"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "genetic_jump"

/datum/action/scp076_leap/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	if(world.time < S.leap_cooldown)
		return 0
	return 1

/datum/action/scp076_leap/Activate()
	var/mob/living/scp076/S = owner
	S.leap_cooldown = world.time + 20 SECONDS
	var/list/targets = list()
	for(var/mob/living/L in view(7, S))
		if(L == S || L.stat == DEAD)
			continue
		targets += L
	if(!length(targets))
		to_chat(S, SPAN_WARNING("No targets in range."))
		return
	var/mob/living/target = tgui_input_list(S, "Choose a target:", "Leaping Strike", targets)
	if(!target || QDELETED(target))
		S.leap_cooldown = 0
		return
	var/turf/target_turf = get_step(target, get_dir(target, S))
	if(!target_turf || target_turf.density)
		target_turf = get_turf(target)
	S.visible_message(SPAN_DANGER("[S] leaps through the air towards [target]!"))
	playsound(S, 'sounds/effects/thud.ogg', 60, TRUE)
	S.forceMove(target_turf)
	var/damage = 25 + (S.rage_meter * 0.15)
	target.apply_damage(damage, BRUTE)
	S.rage_meter = min(S.rage_meter + 10, S.max_rage)

/datum/action/scp076_berserk
	name = "Berserk Frenzy"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "genetic_hulk"

/datum/action/scp076_berserk/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	if(S.rage_meter < 50)
		return 0
	return 1

/datum/action/scp076_berserk/Activate()
	var/mob/living/scp076/S = owner
	S.rage_meter = max(S.rage_meter - 50, 0)
	S.scp076_ai_berserk()
	S.visible_message(SPAN_DANGER("[S] enters a berserk frenzy, eyes blazing with fury!"))

/datum/action/scp076_focus
	name = "Warrior's Focus"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "spell_mind"

/datum/action/scp076_focus/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	if(world.time < S.focus_cooldown)
		return 0
	return 1

/datum/action/scp076_focus/Activate()
	var/mob/living/scp076/S = owner
	S.focus_cooldown = world.time + 30 SECONDS
	var/mob/living/carbon/human/closest_worthy = null
	var/closest_dist = 999
	for(var/mob/living/carbon/human/H in view(10, S))
		if(H == S || H.stat == DEAD)
			continue
		if(S.is_worthy_opponent(H))
			var/dist = get_dist(S, H)
			if(dist < closest_dist)
				closest_dist = dist
				closest_worthy = H
	if(closest_worthy)
		to_chat(S, SPAN_NOTICE("You fix your gaze upon [closest_worthy.real_name]. A worthy opponent."))
		to_chat(closest_worthy, SPAN_USERDANGER("[S] fixes its gaze upon you with deadly intent!"))
		S.respects_opponent = TRUE
		S.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/scp076_rage, TRUE, -0.5)
	else
		to_chat(S, SPAN_NOTICE("No worthy opponents nearby."))

/datum/action/scp076_dormant
	name = "Enter Dormancy"
	action_type = AB_INNATE
	button_icon = 'icons/hud/actions.dmi'
	button_icon_state = "statue"

/datum/action/scp076_dormant/IsAvailable()
	var/mob/living/scp076/S = owner
	if(!istype(S) || S.stat == DEAD || S.current_state != SCP076_STATE_ACTIVE)
		return 0
	return 1

/datum/action/scp076_dormant/Activate()
	var/mob/living/scp076/S = owner
	S.enter_dormant()
	to_chat(S, SPAN_NOTICE("You return to the sarcophagus to rest."))

// ============================================================================
// THE ABYSSAL BLADE
// ============================================================================

/obj/item/melee/scp076_blade
	name = "Abyssal Blade"
	desc = "A blade of dark, pulsating energy summoned by SCP-076-2. It radiates hostility."
	icon = 'icons/obj/weapons/melee_physical.dmi'
	icon_state = "katana"
	item_state = "katana"
	force = 45
	throwforce = 20
	throw_speed = 5
	w_class = ITEM_SIZE_LARGE
	sharp = TRUE
	edge = TRUE
	hitsound = 'sounds/weapons/bladeslice.ogg'
	var/mob/living/scp076/owner

/obj/item/melee/scp076_blade/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/melee/scp076_blade/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/scp076_blade/Process()
	// The blade is an extension of Abel — gone when he is gone.
	if(!owner || QDELETED(owner))
		visible_message(SPAN_NOTICE("\The [src] dissipates into shadow."))
		qdel(src)
		return
	if(owner.current_state != SCP076_STATE_ACTIVE && loc != owner)
		visible_message(SPAN_NOTICE("\The [src] dissipates into shadow as its master sleeps."))
		qdel(src)

/obj/item/melee/scp076_blade/attack(mob/living/target, mob/living/user)
	if(!istype(user, /mob/living/scp076))
		to_chat(user, SPAN_WARNING("The blade burns your hand!"))
		user.apply_damage(15, BURN)
		user.drop_from_inventory(src)
		return
	return ..()

// Rage speed modifier.
/datum/movespeed_modifier/scp076_rage
	variable = TRUE

// ============================================================================
// THE SARCOPHAGUS (SCP-076-1)
// ============================================================================

/obj/structure/scp076_sarcophagus
	name = "SCP-076-1 Sarcophagus"
	desc = "A large stone sarcophagus with intricate carvings. SCP-076-2 emerges from within."
	icon = 'icons/obj/closets/coffin.dmi'
	icon_state = ""
	density = TRUE
	anchored = TRUE
	var/mob/living/scp076/contained_scp

/obj/structure/scp076_sarcophagus/Initialize()
	. = ..()
	contained_scp = new /mob/living/scp076(get_turf(src))
	contained_scp.forceMove(src)

/obj/structure/scp076_sarcophagus/Destroy()
	QDEL_NULL(contained_scp)
	return ..()

/obj/structure/scp076_sarcophagus/attack_hand(mob/user)
	if(contained_scp && contained_scp.current_state == SCP076_STATE_DORMANT)
		to_chat(user, SPAN_WARNING("You hear faint scratching from inside the sarcophagus..."))
	..()

#undef SCP076_STATE_DORMANT
#undef SCP076_STATE_AWAKENING
#undef SCP076_STATE_ACTIVE
#undef SCP076_STATE_DECEASED
