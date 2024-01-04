/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	origin_tech = list(TECH_MAGNET = 3, TECH_BIO = 2)
	var/list/icon/current = list() //the current hud icons
	electric = TRUE
	gender = NEUTER
	toggleable = TRUE
	action_button_name = "Toggle HUD"
	activation_sound = sound('sounds/machines/boop1.ogg', volume = 10)
	deactivation_sound = sound('sounds/effects/compbeep1.ogg', volume = 30)

	species_restricted = list("exclude", SPECIES_DIONA)
	hidden_from_codex = FALSE

/obj/item/clothing/glasses/hud/Initialize()
	. = ..()
	toggle_on_message = "\The [src] boots up to life, flashing with information."
	toggle_off_message = "\The [src] powers down with a beep."

/obj/item/clothing/glasses/proc/process_hud(mob/M)
	if(hud)
		hud.process_hud(M)

/obj/item/clothing/glasses/hud/process_hud(mob/M)
	return

/obj/item/clothing/glasses/hud/health
	name = "health scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	off_state = "healthhud_off"
	hud_type = HUD_MEDICAL
	body_parts_covered = 0
	req_access = list(ACCESS_MEDICAL_LVL1)

/obj/item/clothing/glasses/hud/health/process_hud(mob/M)
	process_med_hud(M, 1)

/obj/item/clothing/glasses/hud/health/prescription
	name = "prescription health scanner HUD"
	desc = "A medical HUD integrated with a set of prescription glasses."
	prescription = 7
	icon_state = "healthhudpresc"
	off_state = "healthhudpresc_off"
	item_state = "healthhudpresc"

/obj/item/clothing/glasses/hud/health/visor
	name = "medical HUD visor"
	desc = "A medical HUD integrated with a wide visor."
	icon_state = "medhud_visor"
	off_state = "medhud_visor_off"
	item_state = "medhud_visor"
	body_parts_covered = EYES

/obj/item/clothing/glasses/hud/security
	name = "security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	off_state = "securityhud_off"
	hud_type = HUD_SECURITY
	body_parts_covered = 0
	var/global/list/jobs[0]
	req_access = list(ACCESS_SECURITY_LVL1)

/obj/item/clothing/glasses/hud/security/prescription
	name = "prescription security HUD"
	desc = "A security HUD integrated with a set of prescription glasses."
	prescription = 7
	icon_state = "sechudpresc"
	off_state = "sechudpresc_off"
	item_state = "sechudpresc"

/obj/item/clothing/glasses/hud/security/jensenshades
	name = "augmented shades"
	desc = "Polarized bioneural eyewear, designed to augment your vision."
	gender = PLURAL
	icon_state = "jensenshades"
	item_state = "jensenshades"
	toggleable = FALSE
	vision_flags = SEE_MOBS
	see_invisible = SEE_INVISIBLE_NOLIGHTING


/obj/item/clothing/glasses/hud/security/process_hud(mob/M)
	process_sec_hud(M, 1)

/obj/item/clothing/glasses/hud/janitor
	name = "janiHUD"
	desc = "A heads-up display that scans for messes and alerts the user. Good for finding puddles hiding under catwalks."
	icon_state = "janihud"
	off_state = "janihud_off"
	body_parts_covered = 0
	hud_type = HUD_JANITOR

/obj/item/clothing/glasses/hud/janitor/prescription
	name = "prescription janiHUD"
	icon_state = "janihudpresc"
	off_state = "janihudpresc_off"
	item_state = "janihudpresc"
	desc = "A janitor HUD integrated with a set of prescription glasses."
	prescription = 7

/obj/item/clothing/glasses/hud/janitor/process_hud(mob/M)
	process_jani_hud(M)

/obj/item/clothing/glasses/hud/science
	name = "science HUD"
	desc = "A heads-up display that analyzes objects for research potential."
	icon_state = "scihud"
	off_state = "scihud_off"
	hud_type = HUD_SCIENCE
	body_parts_covered = 0

/obj/item/clothing/glasses/hud/science/prescription
	name = "prescription scienceHUD"
	icon_state = "scihudpresc"
	off_state = "scihudpresc_off"
	item_state = "scihudpresc"
	desc = "A science HUD integrated with a set of prescription glasses."
	prescription = 7

/obj/item/clothing/glasses/hud/scramble
	name = "SCRAMBLE goggles"
	desc = "State-of-the-art SCRAMBLE goggles. They work by obscuring the face of SCP-096 in software before the brain can register the image."
	icon_state = "scramble"
	item_state = "glasses"
	origin_tech = null
	action_button_name = "Toggle Goggles"
	toggleable = TRUE
	see_invisible = SEE_INVISIBLE_NOLIGHTING
	off_state = "denight"
	electric = TRUE
	visual_insulation = V_INSL_PERFECT

/obj/item/clothing/glasses/hud/scramble/Initialize()
	. = ..()
	overlay = GLOB.global_hud.scramble

/obj/item/clothing/glasses/hud/scramble/process_hud(mob/M)
	process_scramble_hud(M)


/obj/item/clothing/glasses/hud/scramble/faulty // for admin shenanigans
	visual_insulation = V_INSL_IMPERFECT

/obj/item/clothing/glasses/hud/scramble/experimental
	name = "experimental SCRAMBLE goggles"
	desc = "Experimental SCRAMBLE goggles. Designed to prevent the user from viewing the face of SCP-096 by obscuring it before the brain can register the image."

/obj/item/clothing/glasses/hud/scramble/experimental/Initialize()
	. = ..()
	// 30% chance of being faulty
	if(prob(30))
		visual_insulation = V_INSL_IMPERFECT
