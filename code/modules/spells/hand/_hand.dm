/datum/spell/hand
	var/min_range = 0
	var/list/compatible_targets = list(/atom)
	var/spell_delay = 5
	var/move_delay
	var/click_delay
	var/hand_state = "spell"
	var/obj/item/magic_hand/current_hand
	var/show_message
	/// If TRUE - will prevent itself from being cast when on help intent
	var/harmful = TRUE
	/// Mana cost for each use of hand
	var/mana_cost_per_cast = 0

/datum/spell/hand/choose_targets(mob/user = usr)
	perform(user, list(user))

/datum/spell/hand/cast_check(skipcharge = 0,mob/user = usr, list/targets)
	if(!..())
		return FALSE
	if(user.get_active_hand())
		to_chat(holder, "<span class='warning'>You need an empty hand to cast this spell.</span>")
		return FALSE
	return TRUE

/datum/spell/hand/cast(list/targets, mob/user)
	if(current_hand)
		CancelHand()
	if(user.get_active_hand())
		to_chat(user, "<span class='warning'>You need an empty hand to cast this spell.</span>")
		return FALSE
	current_hand = new(src)
	if(!user.put_in_active_hand(current_hand))
		QDEL_NULL(current_hand)
		return FALSE
	RegisterSignal(user, COMSIG_ATOM_MOVABLE_DISPELL, .proc/OnUserDispell)
	RegisterSignal(current_hand, COMSIG_PARENT_QDELETING, .proc/OnHandDestroy)
	return TRUE

/datum/spell/hand/proc/OnUserDispell(datum/source, dispell_strength = DISPELL_WEAK)
	SIGNAL_HANDLER
	if(istype(current_hand))
		holder.visible_message(SPAN_DANGER("[current_hand] vanishes in an instant!"))
		CancelHand()

/datum/spell/hand/proc/OnHandDestroy(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(holder, COMSIG_ATOM_MOVABLE_DISPELL)
	UnregisterSignal(current_hand, COMSIG_PARENT_QDELETING)

/datum/spell/hand/proc/CancelHand()
	QDEL_NULL(current_hand)

/datum/spell/hand/Destroy()
	CancelHand()
	return ..()

/datum/spell/hand/proc/valid_target(atom/a, mob/user) //we use separate procs for our target checking for the hand spells.
	var/distance = get_dist(a,user)
	if((min_range && distance < min_range) || (range && distance > range))
		return FALSE
	if(!is_type_in_list(a,compatible_targets))
		return FALSE
	return TRUE

/datum/spell/hand/proc/cast_hand(atom/a, mob/user) //same for casting.
	if(!TakeMana(user, mana_cost_per_cast))
		return FALSE
	return TRUE

/datum/spell/hand/charges
	var/casts = 1
	var/max_casts = 1

/datum/spell/hand/charges/cast(list/targets, mob/user)
	. = ..()
	if(.)
		casts = max_casts
		to_chat(user, "You ready the [name] spell ([casts]/[casts] charges).")

/datum/spell/hand/charges/cast_hand()
	if(..())
		casts--
		to_chat(holder, "<span class='notice'>The [name] spell has [casts] out of [max_casts] charges left</span>")
		CancelHand()
		return TRUE
	return FALSE

/datum/spell/hand/duration
	var/hand_timer = null
	var/hand_duration = 0

/datum/spell/hand/duration/cast(list/targets, mob/user)
	. = ..()
	if(.)
		hand_timer = addtimer(CALLBACK(src, .proc/CancelHand), hand_duration, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_NO_HASH_WAIT|TIMER_OVERRIDE)

/datum/spell/hand/duration/CancelHand()
	deltimer(hand_timer)
	hand_timer = null
	..()
