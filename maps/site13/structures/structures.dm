/*
 * Site13 Spare Closets
 */

/obj/structure/closet/secure_closet/animals13
	name = "animal control closet"
	req_access = list(access_mtflvl2)

/obj/structure/closet/secure_closet/animals13/WillContain()
	return list(
		/obj/item/device/assembly/signaler,
		/obj/item/device/radio/electropack = 3,
		/obj/item/weapon/gun/launcher/syringe/rapid,
		/obj/item/weapon/storage/box/syringegun,
		/obj/item/weapon/storage/box/syringes,
		/obj/item/weapon/reagent_containers/glass/bottle/chloralhydrate,
		/obj/item/weapon/storage/box/handcuffs,
		/obj/item/weapon/reagent_containers/glass/bottle/stoxin,
	)

/obj/structure/closet/secure_closet/personal/cabinet/site13
	icon_state = "cabinetdetective"
	icon_closed = "cabinetdetective"
	icon_locked = "cabinetdetective_locked"
	icon_opened = "cabinetdetective_open"
	icon_broken = "cabinetdetective_sparks"
	icon_off = "cabinetdetective_broken"

/obj/structure/closet/secure_closet/personal/cabinet/site13/WillContain()
	return list(/obj/item/weapon/storage/backpack/satchel/grey/withwallet)

//the ROCK!

/turf/simulated/mineral/random/site13
	mineralChance = 10
	mineralSpawnChanceList = list("Uranium" = 10, "Platinum" = 10, "Iron" = 20, "Carbon" = 20, "Diamond" = 2, "Gold" = 10, "Silver" = 10, "Phoron" = 20)

/turf/simulated/mineral/random/site13/Initialize()
	if (prob(mineralChance) && !mineral)
		var/mineral_name = pickweight(mineralSpawnChanceList) //temp mineral name
		mineral_name = lowertext(mineral_name)
		if (mineral_name && (mineral_name in ore_data))
			mineral = ore_data[mineral_name]
			UpdateMineral()

	. = ..()

/obj/machinery/light/site13
	idle_power_usage = 1
	active_power_usage = 5