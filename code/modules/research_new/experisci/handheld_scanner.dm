/**
 * # Experi-Scanner
 *
 * Handheld scanning unit to perform scanning experiments
 */
/obj/item/experi_scanner
	name = "Experi-Scanner"
	desc = "A handheld scanner used for completing the many experiments of modern science."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/devices/scanner.dmi'
	icon_state = "experiscanner"
	item_icons = list(
					slot_l_hand_str = 'icons/mob/inhands/items/devices_lefthand.dmi',
					slot_r_hand_str = 'icons/mob/inhands/items/devices_righthand.dmi'
					)
	item_state = "experiscanner"

/obj/item/experi_scanner/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

// Late initialize to allow for the rnd servers to initialize first
/obj/item/experi_scanner/LateInitialize()
	. = ..()
	var/static/list/handheld_signals = list(
		COMSIG_ITEM_PRE_ATTACK = TYPE_PROC_REF(/datum/component/experiment_handler, try_run_handheld_experiment),
		COMSIG_ITEM_AFTERATTACK = TYPE_PROC_REF(/datum/component/experiment_handler, ignored_handheld_experiment_attempt),
	)
	AddComponent(/datum/component/experiment_handler, \
		allowed_experiments = list(/datum/experiment/scanning, /datum/experiment/physical), \
		disallowed_traits = EXPERIMENT_TRAIT_DESTRUCTIVE, \
		experiment_signals = handheld_signals, \
	)
