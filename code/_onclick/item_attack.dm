/*
=== Item Click Call Sequences ===
These are the default click code call sequences used when clicking on stuff with an item.

Atoms:

/mob/ClickOn() calls the item's resolve_attackby() proc.
item/resolve_attackby() calls the target atom's attackby() proc.

Mobs:

/mob/living/attackby() after checking for surgery, calls the item's attack() proc.
item/attack() generates attack logs, sets click cooldown and calls the mob's attacked_with_item() proc. If you override this, consider whether you need to set a click cooldown, play attack animations, and generate logs yourself.
/mob/attacked_with_item() should then do mob-type specific stuff (like determining hit/miss, handling shields, etc) and then possibly call the item's apply_hit_effect() proc to actually apply the effects of being hit.

Item Hit Effects:

item/apply_hit_effect() can be overriden to do whatever you want. However "standard" physical damage based weapons should make use of the target mob's hit_with_weapon() proc to
avoid code duplication. This includes items that may sometimes act as a standard weapon in addition to having other effects (e.g. stunbatons on harm intent).
*/

// Called when the item is in the active hand, and clicked; alternately, there is an 'activate held object' verb or you can hit pagedown.
/obj/item/proc/attack_self(mob/user)
	return

//I would prefer to rename this to attack(), but that would involve touching hundreds of files.
/obj/item/proc/resolve_attackby(atom/A, mob/user, click_params)
	if(!(item_flags & ITEM_FLAG_NO_PRINT))
		add_fingerprint(user)
	return A.attackby(src, user, click_params)

// No comment
/atom/proc/attackby(obj/item/W, mob/user, click_params)
	user.interact_log += "([time_stamp()]) (<b>[src.x]X, [src.y]Y, [src.z]Z</b>) - Interacted with [src], using [W]. (Intent: [user.a_intent] | Location: [get_area(src)])"
	return

/atom/movable/attackby(obj/item/W, mob/user)
	if(W?.item_flags & ITEM_FLAG_NO_BLUDGEON)
		visible_message(SPAN_DANGER("[src] has been hit by [user] with [W]."))
	return ..() //removed return above to return ..() here to call the proc above.

/mob/living/attackby(obj/item/I, mob/user)
	if(!ismob(user))
		return 0
	if(can_operate(src,user) && I?.do_surgery(src,user)) //Surgery
		user.interact_log += "<font color=red>([time_stamp()]) (<b>[src.x]X, [src.y]Y, [src.z]Z</b>) - Did surgery on [src], using [I].</font>"
		src.interact_log += "<font color=red>([time_stamp()]) (<b>[src.x]X, [src.y]Y, [src.z]Z</b>) - Had surgery performed on them by [user], using [I].</font>."
		return 1

	user.interact_log += "([time_stamp()]) (<b>[src.x]X, [src.y]Y, [src.z]Z</b>) - Interacted with [src], using [I]. (Intent: [user.a_intent] | Location: [get_area(src)])"
	src.interact_log += "([time_stamp()]) (<b>[src.x]X, [src.y]Y, [src.z]Z</b>) - Was interacted with by [user], using [I]. (Intent: [user.a_intent] | Location: [get_area(src)])"
	return I.attack(src, user, user.zone_sel ? user.zone_sel.selecting : ran_zone())

/mob/living/carbon/human/attackby(obj/item/I, mob/user)
	if(user == src && zone_sel.selecting == BP_MOUTH && can_devour(I, silent = TRUE))
		var/obj/item/blocked = src.check_mouth_coverage()
		if(blocked)
			to_chat(user, SPAN_WARNING("\The [blocked] is in the way!"))
			return TRUE
		if(devour(I))
			return TRUE
	return ..()

// Proximity_flag is 1 if this afterattack was called on something adjacent, in your square, or on your person.
// Click parameters is the params string from byond Click() code, see that documentation.
/obj/item/proc/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	return

/datum/attack_result
	var/hit_zone = 0
	var/mob/living/attackee = null

//I would prefer to rename this attack_as_weapon(), but that would involve touching hundreds of files. // lol ok, TODO: search and replace this
/obj/item/proc/attack(mob/living/M, mob/living/user, target_zone, animate = TRUE)
	if(!force || (item_flags & ITEM_FLAG_NO_BLUDGEON))
		return 0
	if(M == user && user.a_intent != I_HURT)
		return 0
	if (user.a_intent == I_HELP && !attack_ignore_harm_check)
		return FALSE

	if (HAS_TRAIT(user, TRAIT_PACIFISM))
		return

	/////////////////////////

	if(!no_attack_log)
		admin_attack_log(user, M, "Attacked using \a [src] (DAMTYE: [uppertext(damtype)])", "Was attacked with \a [src] (DAMTYE: [uppertext(damtype)])", "used \a [src] (DAMTYE: [uppertext(damtype)]) to attack")
	/////////////////////////
	user.setClickCooldown(attack_cooldown + w_class)
	if(animate)
		user.do_attack_animation(M)
	if(!M.aura_check(AURA_TYPE_WEAPON, src, user))
		return 0

	var/hit_zone = M.resolve_item_attack(src, user, target_zone)

	var/datum/attack_result/AR = hit_zone
	if(istype(AR))
		if(AR.hit_zone)
			apply_hit_effect(AR.attackee ? AR.attackee : M, user, AR.hit_zone)
		return 1
	if(hit_zone)
		apply_hit_effect(M, user, hit_zone)

	return 1

//Called when a weapon is used to make a successful melee attack on a mob. Returns whether damage was dealt.
/obj/item/proc/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	if(hitsound)
		playsound(loc, hitsound, 50, 1, -1)
		show_sound_effect(loc, user, soundicon = SFX_ICON_JAGGED)

	var/power = force
	if(MUTATION_HULK in user.mutations)
		power *= 2
	return target.hit_with_weapon(src, user, power, hit_zone)

/**
 * Used to get how fast a mob should attack, and influences click delay.
 * This is just for inheritance.
 */
/mob/proc/get_attack_speed()
	return CLICK_CD_ATTACK

/**
 * W is the item being used in the attack, if any. modifier is if the attack should be longer or shorter than usual, for whatever reason.
 */
/mob/living/get_attack_speed(obj/item/W)
	var/speed = base_attack_cooldown
	if(istype(W))
		speed = W.attack_cooldown

	return speed
