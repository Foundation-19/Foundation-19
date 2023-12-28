/obj/item/underwear
	w_class = ITEM_SIZE_TINY
	var/required_slot_flags
	var/required_free_body_parts

/obj/item/underwear/afterattack(atom/target, mob/user, proximity)
	if(!proximity)
		return // Might as well check
	DelayedEquipUnderwear(user, target)

/obj/item/underwear/MouseDrop(atom/target)
	DelayedEquipUnderwear(usr, target)

/obj/item/underwear/proc/CanEquipUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanAdjustUnderwear(user, H, "put on"))
		return FALSE
	if(!(H.species && (H.species.appearance_flags & HAS_UNDERWEAR)))
		to_chat(user, SPAN_WARNING("\The [H]'s species cannot wear underwear of this nature."))
		return FALSE
	if(is_path_in_list(type, H.worn_underwear))
		to_chat(user, SPAN_WARNING("\The [H] is already wearing underwear of this nature."))
		return FALSE
	return TRUE

/obj/item/underwear/proc/CanRemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanAdjustUnderwear(user, H, "remove"))
		return FALSE
	if(!(src in H.worn_underwear))
		to_chat(user, SPAN_WARNING("\The [H] isn't wearing \the [src]."))
		return FALSE
	return TRUE

/obj/item/underwear/proc/CanAdjustUnderwear(mob/user, mob/living/carbon/human/H, adjustment_verb)
	if(!istype(H))
		return FALSE
	if(user != H && !CanPhysicallyInteractWith(user, H))
		return FALSE

	var/list/covering_items = H.get_covering_equipped_items(required_free_body_parts)
	if(covering_items.len)
		var/obj/item/I = covering_items[1]
		if(adjustment_verb)
			to_chat(user, SPAN_WARNING("Cannot [adjustment_verb] \the [src]. [english_list(covering_items)] [length(covering_items) == 1 ? I.p_are() : "are"] in the way."))
		return FALSE

	return TRUE

/obj/item/underwear/proc/DelayedRemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return
	if(user != H)
		visible_message(SPAN_DANGER("\The [user] is trying to remove \the [H]'s [name]!"))
		if(!do_after(user, HUMAN_STRIP_DELAY, H, do_flags = DO_DEFAULT | DO_SHOW_TARGET, bonus_percentage = 25))
			return FALSE
	. = RemoveUnderwear(user, H)
	if(. && user != H)
		user.visible_message(SPAN_WARNING("\The [user] has removed \the [src] from \the [H]."), SPAN_NOTICE("You have removed \the [src] from \the [H]."))
		admin_attack_log(user, H, "Removed \a [src]", "Had \a [src] removed.", "removed \a [src] from")

/obj/item/underwear/proc/DelayedEquipUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return
	if(user != H)
		user.visible_message(SPAN_WARNING("\The [user] has begun putting on \a [src] on \the [H]."), SPAN_NOTICE("You begin putting on \the [src] on \the [H]."))
		if(!do_after(user, HUMAN_STRIP_DELAY, H, do_flags = DO_DEFAULT | DO_SHOW_TARGET, bonus_percentage = 25))
			return FALSE
	. = EquipUnderwear(user, H)
	if(. && user != H)
		user.visible_message(SPAN_WARNING("\The [user] has put \the [src] on \the [H]."), SPAN_NOTICE("You have put \the [src] on \the [H]."))
		admin_attack_log(user, H, "Put on \a [src]", "Had \a [src] put on.", "put on \a [src] on")

/obj/item/underwear/proc/EquipUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanEquipUnderwear(user, H))
		return FALSE
	if(!user.unEquip(src))
		return FALSE
	return ForceEquipUnderwear(H)

/obj/item/underwear/proc/ForceEquipUnderwear(mob/living/carbon/human/H, update_icons = TRUE)
	// No matter how forceful, we still don't allow multiples of the same underwear type
	if(is_path_in_list(type, H.worn_underwear))
		return FALSE

	H.worn_underwear += src
	forceMove(H)
	if(update_icons)
		H.update_underwear()

	return TRUE

/obj/item/underwear/proc/RemoveUnderwear(mob/user, mob/living/carbon/human/H)
	if(!CanRemoveUnderwear(user, H))
		return FALSE

	H.worn_underwear -= src
	dropInto(H.loc)
	user.put_in_hands(src)
	H.update_underwear()

	return TRUE

/obj/item/underwear/verb/RemoveSocks()
	set name = "Remove Underwear"
	set category = "Object"
	set src in usr

	RemoveUnderwear(usr, usr)

/obj/item/underwear/socks
	required_free_body_parts = FEET

/obj/item/underwear/top
	required_free_body_parts = UPPER_TORSO

/obj/item/underwear/bottom
	required_free_body_parts = FEET|LEGS|LOWER_TORSO

/obj/item/underwear/undershirt
	required_free_body_parts = UPPER_TORSO
