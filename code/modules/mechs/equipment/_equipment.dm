// Defining all of this here so it's centralized.
// Used by the exosuit HUD to get a 1-10 value representing charge, ammo, etc.
/obj/item/mech_equipment
	name = "exosuit hardpoint system"
	icon = 'icons/mecha/mech_equipment.dmi'
	icon_state = ""
	matter = list(MATERIAL_STEEL = 10000, MATERIAL_PLASTIC = 5000, MATERIAL_OSMIUM = 500)
	force = 10

	var/list/restricted_hardpoints
	var/mob/living/exosuit/owner
	var/list/restricted_software
	var/equipment_delay = 0
	var/active_power_use = 1 KILOWATTS // How much does it consume to perform and accomplish usage
	var/passive_power_use = 0          // For gear that for some reason takes up power even if it's supposedly doing nothing (mech will idly consume power)
	var/mech_layer = MECH_GEAR_LAYER //For the part where it's rendered as mech gear
	var/require_adjacent = TRUE
	var/active = FALSE //For gear that has an active state (ie, floodlights)
	var/equipment_flags = ME_ANY_POWER | ME_BYPASS_INTERFACE

/obj/item/mech_equipment/attack(mob/living/M, mob/living/user, target_zone) //Generally it's not desired to be able to attack with items
	return FALSE

/obj/item/mech_equipment/afterattack(atom/target, mob/living/user, inrange, params)
	if(!owner)
		return FALSE
	if(!owner.hatch_closed && !(equipment_flags & ME_BYPASS_INTERFACE))
		return FALSE
	if(require_adjacent)
		if(!inrange)
			return FALSE
	if (owner && loc == owner && ((user in owner.pilots) || user == owner))
		if(target in owner.contents)
			return FALSE
		if(equipment_flags & ME_POWERLESS_ACTIVATION)
			return TRUE
		if(!(get_cell(FALSE, equipment_flags)?.check_charge(active_power_use * CELLRATE)))
			to_chat(user, SPAN_WARNING("The power indicator flashes briefly as you attempt to use \the [src]"))
			return FALSE
		return TRUE
	return FALSE

/obj/item/mech_equipment/attack_self(mob/user)
	if(!owner)
		return FALSE
	if(!owner.hatch_closed && !(equipment_flags & ME_BYPASS_INTERFACE))
		return FALSE
	if (owner && loc == owner && ((user in owner.pilots) || user == owner))
		if(equipment_flags & ME_POWERLESS_ACTIVATION)
			return TRUE
		if(!(get_cell(FALSE,equipment_flags)?.check_charge(active_power_use * CELLRATE)))
			to_chat(user, SPAN_WARNING("The power indicator flashes briefly as you attempt to use \the [src]"))
			return FALSE
		return TRUE
	return FALSE

/obj/item/mech_equipment/examine(mob/user, distance)
	. = ..()
	if(user.skill_check(SKILL_DEVICES, SKILL_BASIC))
		if(length(restricted_software))
			to_chat(user, SPAN_SUBTLE("It seems it would require [english_list(restricted_software)] to be used."))
		if(length(restricted_hardpoints))
			to_chat(user, SPAN_SUBTLE("You figure it could be mounted in the [english_list(restricted_hardpoints)]."))

/obj/item/mech_equipment/proc/deactivate()
	active = FALSE
	return

/obj/item/mech_equipment/proc/installed(mob/living/exosuit/_owner)
	owner = _owner
	//generally attached. Nothing should be able to grab it
	canremove = FALSE

/obj/item/mech_equipment/proc/uninstalled()
	if(active)
		deactivate()
	owner = null
	canremove = TRUE

/obj/item/mech_equipment/Destroy()
	owner = null
	. = ..()

/obj/item/mech_equipment/proc/get_effective_obj()
	return src

/obj/item/mech_equipment/proc/MouseDragInteraction(src_object, over_object, src_location, over_location, src_control, over_control, params, mob/user)
	//Get intent updated
	if(user != owner)
		owner.a_intent = user.a_intent
	if(user.zone_sel)
		owner.zone_sel.set_selected_zone(user.zone_sel.selecting)
	else
		owner.zone_sel.set_selected_zone(BP_CHEST)

/obj/item/mech_equipment/mob_can_unequip(mob/M, slot, disable_warning)
	. = ..()
	if(. && owner)
		//Installed equipment shall not be unequiped.
		return FALSE

/obj/item/mech_equipment/mounted_system
	var/holding_type
	var/obj/item/holding

/obj/item/mech_equipment/mounted_system/attack_self(mob/user)
	. = ..()
	if(. && holding)
		return holding.attack_self(user)

/obj/item/mech_equipment/mounted_system/proc/forget_holding()
	if(holding) //It'd be strange for this to be called with this var unset
		UnregisterSignal(holding, COMSIG_PARENT_QDELETING)
		holding = null
		qdel(src)

/obj/item/mech_equipment/mounted_system/Initialize()
	. = ..()
	if(holding_type)
		holding = new holding_type(src)
		RegisterSignal(holding, COMSIG_PARENT_QDELETING, PROC_REF(forget_holding))
	if(holding)
		if(!icon_state)
			icon = holding.icon
			icon_state = holding.icon_state
		SetName(holding.name)
		desc = "[holding.desc] This one is suitable for installation on an exosuit."


/obj/item/mech_equipment/mounted_system/Destroy()
	UnregisterSignal(holding, COMSIG_PARENT_QDELETING)
	if(holding)
		QDEL_NULL(holding)
	. = ..()


/obj/item/mech_equipment/mounted_system/get_effective_obj()
	return (holding ? holding : src)

/obj/item/mech_equipment/mounted_system/get_hardpoint_status_value()
	return (holding ? holding.get_hardpoint_status_value() : null)

/obj/item/mech_equipment/mounted_system/get_hardpoint_maptext()
	return (holding ? holding.get_hardpoint_maptext() : null)

/obj/item/proc/get_hardpoint_status_value()
	return null

/obj/item/proc/get_hardpoint_maptext()
	return null

/obj/item/mech_equipment/get_cell(force = FALSE)
	RETURN_TYPE(/obj/item/cell)
	if(QDELETED(owner))
		return null
	if(loc != owner)
		return null
	return owner.get_cell(force, equipment_flags)
