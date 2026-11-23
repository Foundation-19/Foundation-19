/obj/item/rig/light/stealth/scp5000
	name = "scp-5000"
	suit_type = "stealth"
	desc = "The so-called Total Exclusion Harness is a suit presumably produced by a version of the SCP Foundation from a parallel universe. Though once capable of rendering it's wearer uncomprehendable and sustaining their vitals nearly indefinitely, it's now broken. In spite of this, it contains a portable datavault with a wealth of information pertaining to the Foundation's activities in it's origin universe."
	icon_state = "stealth_rig"
	cell_type =  /obj/item/cell/hyper

	req_access = list(ACCESS_SYNDICATE)

	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/device/healthscanner,
		/obj/item/rig_module/datajack
		)

/obj/item/rig/light/stealth/scp5000/working
	name = "total exclusion harness"
	suit_type = "stealth"
	desc = "The Total Exclusion Harness is a suit produced by an unknown version of the SCP Foundation in a parallel universe. It is capable of rendering it's wearer entirely incomprehendable, and thus, invisible, whilst also maintaining their vital functions and carrying a portable datavault and AI interface."
	icon_state = "stealth_rig"
	online_slowdown = 0
	cell_type =  /obj/item/cell/infinite
	aimove_power_usage = 0
	emp_protection = 100
	siemens_coefficient = 1
	req_access = list(ACCESS_ADMIN_LVL3)

	initial_modules = list(
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/stealth_field,
		/obj/item/rig_module/teleporter,
		/obj/item/rig_module/chem_dispenser/ninja,
		/obj/item/rig_module/voice,
		/obj/item/rig_module/self_destruct
		)

/obj/item/rig/light/stealth/scp5000/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src,
		"total exclusion harness",
		SCP_SAFE,
		"5000",
	)
	if(SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)

/obj/item/rig/light/stealth/scp5000/forceMove(atom/dest)
	var/atom/old_loc = loc
	. = ..()
	if(old_loc && istype(old_loc, /obj/structure/scp_containment_safe) && !(istype(loc, /obj/structure/scp_containment_safe)))
		if(SCP && SCP.research)
			SCP.research.set_containment_status(SCP_BREACHED)
	else if(istype(loc, /obj/structure/scp_containment_safe) && SCP && SCP.research)
		SCP.research.set_containment_status(SCP_CONTAINED)
