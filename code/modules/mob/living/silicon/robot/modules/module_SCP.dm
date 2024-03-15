/obj/item/robot_module/anomaly
	name = "anomalous robot module"
	display_name = "Unusual"
	hide_on_manifest = 1
	upgrade_locked = TRUE

//TODO: Make all equipment functional
/obj/item/robot_module/anomaly/scp1370
	sprites = list(
		"SCP-1370" = "pesterbot"
	)
	equipment = list(
		/obj/item/boombox,
		/obj/item/bikehorn/airhorn,
		/obj/item/party_light,
		/obj/item/bikehorn,
		/obj/item/device/hailer
	)

/obj/item/robot_module/anomaly/scp1370/finalize_equipment(mob/living/silicon/robot/R)
	var/obj/item/device/hailer/thehailer = locate() in equipment
	thehailer.insults = 3
	. = ..()

/obj/item/robot_module/anomaly/scp846
	sprites = list(
		"SCP-846" = "robodude"
	)
	equipment = list(
		/obj/item/flamethrower/full,
		/obj/item/gun/projectile/pistol/military,
		/obj/item/crowbar,
		/obj/item/gun/launcher/grenade/loaded,
		/obj/item/gun/energy/gun/secure/mounted
	)

//TODO: Make more mounted types so these things dont just run out of ammo forver
/obj/item/robot_module/SCP/robodude/finalize_equipment(mob/living/silicon/robot/R)
	for(var/obj/item/thing in equipment)
		switch(thing.type)
			if(/obj/item/flamethrower/full)
				thing.name = "Fire Drill"
			if(/obj/item/gun/projectile/pistol/military)
				thing.name = "Energy Laser"
			if(/obj/item/gun/launcher/grenade/loaded)
				thing.name = "Atomic Grenade"
			if(/obj/item/gun/energy/gun/secure/mounted)
				thing.name = "Ultra Plasma Rifle"
	. = ..()
