/obj/item/organ/internal/augment/active/nerve_dampeners
	name = "nerve dampeners"
	allowed_organs = list(BP_AUGMENT_CHEST_ACTIVE)
	icon_state = "muscule"
	desc = "Each activation of this augment provides a strong painkilling effect for around thirty seconds, but will be followed by a powerful comedown. Excessive short-term use may cause brain damage."
	augment_flags = AUGMENTATION_ORGANIC
	origin_tech = list(TECH_DATA = 4, TECH_BIO = 4)
	var/ticks_remaining = 0

/obj/item/organ/internal/augment/active/nerve_dampeners/can_activate()
	if (ticks_remaining)
		to_chat(owner, SPAN_WARNING("Your [name] is already active."))
		return
	. = ..()

/obj/item/organ/internal/augment/active/nerve_dampeners/activate()
	if (!can_activate())
		return
	to_chat(owner, SPAN_NOTICE("You activate your [name], and feel a wave of numbness wash over you!"))
	ticks_remaining = 15
	if (owner.has_status_effect(/datum/status_effect/drowsiness))
		to_chat(owner, SPAN_DANGER("Your body slackens as you lose sensation."))
		if (prob(owner.getBrainLoss()))
			to_chat(owner, SPAN_DANGER("You slump to the ground and black out."))
			owner.Paralyse(10)
		owner.adjustBrainLoss(10)

/obj/item/organ/internal/augment/active/nerve_dampeners/Process()
	if (!owner)
		return
	if (ticks_remaining)
		ticks_remaining--
		owner.add_chemical_effect(CE_PAINKILLER, 160) // About twice as strong as tramadol at full strength
		if (!ticks_remaining) // ...but comes at a price. Brief short term benefit for a long-term comedown
			to_chat(owner, SPAN_WARNING("You abruptly feel intensely exhausted as sensation returns."))
			owner.set_drowsiness_if_lower(15 SECONDS)
			owner.set_confusion_if_lower(15 SECONDS)
			owner.set_slurring_if_lower(30 SECONDS)
			owner.chem_effects[CE_PAINKILLER] = 0
			owner.stamina = 0
			if(MOVING_QUICKLY(owner))
				owner.set_moving_slowly()
