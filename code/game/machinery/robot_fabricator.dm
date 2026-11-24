/obj/machinery/robotic_fabricator
	name = "Robotic Fabricator"
	icon = 'icons/obj/robotics.dmi'
	icon_state = "fab-idle"
	density = TRUE
	anchored = TRUE
	var/metal_amount = 0
	var/operating = 0
	var/obj/item/robot_parts/being_built = null
	idle_power_usage = 40
	active_power_usage = 10000

/obj/machinery/robotic_fabricator/attackby(obj/item/O as obj, mob/user as mob)
	if (istype(O, /obj/item/stack/material) && O.get_material_name() == MATERIAL_STEEL)
		var/obj/item/stack/M = O
		if (src.metal_amount < 150000.0)
			var/count = 0
			src.add_overlay("fab-load-metal")
			spawn(15)
				if(M)
					if(!M.get_amount())
						return
					while(metal_amount < 150000 && M.use(1))
						src.metal_amount += O.matter[MATERIAL_STEEL] /*O:height * O:width * O:length * 100000.0*/
						count++

					to_chat(user, "You insert [count] metal sheet\s into the fabricator.")
					cut_overlay("fab-load-metal")
					SStgui.update_uis(src)
		else
			to_chat(user, "The robot part maker is full. Please remove metal from the robot part maker in order to insert more.")

/obj/machinery/robotic_fabricator/interface_interact(mob/user)
	tgui_interact(user)
	return TRUE

/obj/machinery/robotic_fabricator/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RobotFabricator", "Robotic Fabricator Control Panel")
		ui.open()

/obj/machinery/robotic_fabricator/tgui_data(mob/user)
	var/list/data = list()
	data["operating"] = operating
	data["metal_amount"] = min(150000, metal_amount)
	if(operating && being_built)
		data["building"] = being_built.name
	return data

/obj/machinery/robotic_fabricator/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("make")
			if(src.operating)
				return TRUE
			var/part_type = text2num(params["part"])

			var/build_type = null
			var/build_time = 200
			var/build_cost = 25000

			switch (part_type)
				if (1)
					build_type = /obj/item/robot_parts/l_arm
					build_time = 200
					build_cost = 25000

				if (2)
					build_type = /obj/item/robot_parts/r_arm
					build_time = 200
					build_cost = 25000

				if (3)
					build_type = /obj/item/robot_parts/l_leg
					build_time = 200
					build_cost = 25000

				if (4)
					build_type = /obj/item/robot_parts/r_leg
					build_time = 200
					build_cost = 25000

				if (5)
					build_type = /obj/item/robot_parts/chest
					build_time = 350
					build_cost = 50000

				if (6)
					build_type = /obj/item/robot_parts/head
					build_time = 350
					build_cost = 50000

				if (7)
					build_type = /obj/item/robot_parts/robot_suit
					build_time = 600
					build_cost = 75000

			var/building = build_type
			if (!isnull(building))
				if (src.metal_amount >= build_cost)
					src.operating = 1
					src.update_use_power(POWER_USE_ACTIVE)

					src.metal_amount = max(0, src.metal_amount - build_cost)

					src.being_built = new building(src)

					src.add_overlay("fab-active")
					SStgui.update_uis(src)
					addtimer(CALLBACK(src, PROC_REF(done_building)), build_time)
			return TRUE
	return FALSE

/obj/machinery/robotic_fabricator/proc/done_building()
	if (!isnull(being_built))
		being_built.dropInto(get_turf(src))
		being_built = null
	update_use_power(POWER_USE_IDLE)
	cut_overlay("fab-active")
	operating = FALSE
	SStgui.update_uis(src)
