/*
 * Site 53 Security
 */

// MTF LOCKERS

/*
 * Torch Security
 */

// MTF LOCKERS

/obj/structure/closet/secure_closet/mtf
	name = "MTF Locker - NO USE, ONLY FOR CODE."
	req_access = list(access_mtflvl1)
	icon_state = "enlistedlocked"
	icon_closed = "enlistedunlocked"
	icon_locked = "enlistedlocked"
	icon_opened = "enlistedopen"
	icon_off = "enlistedoff"
	var/registered_name = null

/obj/structure/closet/secure_closet/mtf/WillContain()
	return list(
	)

/obj/structure/closet/secure_closet/mtf/enlisted
	name = "Junior Guard's Locker"
	req_access = list(access_mtflvl1)
	icon_state = "enlistedlocked"
	icon_closed = "enlistedunlocked"
	icon_locked = "enlistedlocked"
	icon_opened = "enlistedopen"
	icon_off = "enlistedoff"

/obj/structure/closet/secure_closet/mtf/enlisted/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security,
		/obj/item/clothing/head/helmet/pcrc,
		/obj/item/clothing/accessory/armor/helmcover/navy,
		/obj/item/clothing/suit/armor/pcarrier,
		/obj/item/clothing/accessory/armorplate,
		/obj/item/clothing/accessory/armguards,
		/obj/item/clothing/accessory/legguards,
		/obj/item/clothing/accessory/armor/tag/solgov/sec,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/weapon/storage/belt/security/tactical,
		/obj/item/weapon/gun/projectile/sec/sec,
		/obj/item/ammo_magazine/c45m = 4,
		/obj/item/weapon/gun/projectile/automatic/c20r,
		/obj/item/ammo_magazine/a10mm = 4,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/device/flash,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/mask/balaclava,
		/obj/item/weapon/storage/box/bloodtypes
	)

/obj/structure/closet/secure_closet/mtf/commander
	name = "Guard Commander Locker"
	req_access = list(access_mtflvl5)
	icon_state = "cmlocked"
	icon_closed = "cmunlocked"
	icon_locked = "cmlocked"
	icon_opened = "cmopen"
	icon_off = "cmoff"

/obj/structure/closet/secure_closet/mtf/commander/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security/gc,
		/obj/item/clothing/head/helmet/site53/guardcomm,
		/obj/item/clothing/accessory/armor/helmcover/navy,
		/obj/item/clothing/suit/armor/pcarrier,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/accessory/armorplate/merc,
		/obj/item/clothing/accessory/armguards/merc,
		/obj/item/clothing/accessory/legguards/merc,
		/obj/item/clothing/accessory/armor/tag/solgov/com/guardcomm,
		/obj/item/weapon/storage/belt/security/tactical,
		/obj/item/clothing/accessory/storage/pouches/large,
		/obj/item/weapon/gun/projectile/revolver,
		/obj/item/ammo_magazine/a357 = 4,
		/obj/item/weapon/gun/projectile/automatic/c20r,
		/obj/item/ammo_magazine/a10mm = 4,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/handcuffs,
		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/device/flash,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/mask/balaclava,
		/obj/item/weapon/storage/box/bloodtypes
	)

/obj/structure/closet/secure_closet/mtf/nco
	name = "Guard's Locker"
	req_access = list(access_mtflvl3)
	icon_state = "nlocked"
	icon_closed = "nunlocked"
	icon_locked = "nlocked"
	icon_opened = "nopen"
	icon_off = "noff"

/obj/structure/closet/secure_closet/mtf/nco/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security,
		/obj/item/clothing/head/helmet/pcrc,
		/obj/item/clothing/accessory/armor/helmcover/navy,
		/obj/item/clothing/suit/armor/pcarrier,
		/obj/item/clothing/accessory/armorplate/medium,
		/obj/item/clothing/accessory/armguards,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/accessory/legguards,
		/obj/item/clothing/accessory/armor/tag/solgov/sec,
		/obj/item/weapon/storage/belt/security/tactical,
		/obj/item/clothing/accessory/storage/pouches,
		/obj/item/weapon/gun/projectile/sec/sec,
		/obj/item/ammo_magazine/c45m = 4,
		/obj/item/weapon/gun/projectile/automatic/c20r,
		/obj/item/ammo_magazine/a10mm = 4,
		/obj/item/weapon/melee/telebaton,
		/obj/item/weapon/handcuffs,
		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/device/flash,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/mask/balaclava,
		/obj/item/weapon/storage/box/bloodtypes
	)

/obj/structure/closet/secure_closet/mtf/co
	name = "Zone Commander's Locker"
	req_access = list(access_mtflvl4)
	icon_state = "colocked"
	icon_closed = "counlocked"
	icon_locked = "colocked"
	icon_opened = "coopen"
	icon_off = "cooff"

/obj/structure/closet/secure_closet/mtf/co/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/security/zc,
		/obj/item/clothing/head/helmet/site53/zonecomm,
		/obj/item/clothing/accessory/armor/helmcover/navy,
		/obj/item/clothing/suit/armor/pcarrier,
		/obj/item/clothing/accessory/armorplate/tactical,
		/obj/item/clothing/accessory/armguards/ballistic,
		/obj/item/clothing/accessory/legguards/ballistic,
		/obj/item/clothing/accessory/armor/tag/solgov/com/zonecomm,
		/obj/item/weapon/storage/belt/security/tactical,
		/obj/item/clothing/accessory/storage/pouches/large,
		/obj/item/weapon/gun/projectile/sec/sec,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/ammo_magazine/c45m = 4,
		/obj/item/weapon/gun/projectile/automatic/c20r,
		/obj/item/ammo_magazine/a10mm = 4,
		/obj/item/clothing/accessory/storage/webbing_large,
		/obj/item/weapon/melee/telebaton,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/weapon/handcuffs,
		/obj/item/weapon/reagent_containers/spray/pepper,
		/obj/item/device/flash,
		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/clothing/accessory/holster/thigh,
		/obj/item/clothing/mask/balaclava,
		/obj/item/weapon/storage/box/bloodtypes
	)

/obj/structure/closet/secure_closet/mtf/breachautomatics
	name = "automatic weapons locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/mtf/breachautomatics/WillContain()
	return list(
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/weapon/gun/projectile/automatic/z8,
		/obj/item/ammo_magazine/a762 = 12
	)


/obj/structure/closet/secure_closet/mtf/breachshotguns
	name = "tactical shotgun locker"
	req_access = list(access_mtflvl2)
	icon_state = "sec1"
	icon_closed = "sec"
	icon_locked = "sec1"
	icon_opened = "secopen"
	icon_off = "secoff"

/obj/structure/closet/secure_closet/mtf/breachshotguns/WillContain()
	return list(
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/gun/projectile/shotgun/tactical,
		/obj/item/weapon/storage/box/mtf/empammo = 6,
		/obj/item/weapon/storage/box/mtf/pelletammo = 6
	)

/obj/structure/closet/secure_closet/mtf/attackby(var/obj/item/weapon/W, var/mob/user)
	if (src.opened)
		..()
	else if(W.GetIdCard())
		var/obj/item/weapon/card/id/I = W.GetIdCard()

		if(!I || !I.registered_name)
			return
		if(togglelock(user, I))
			if(!src.registered_name)
				src.registered_name = I.registered_name
				src.name += " ([I.registered_name])"
				src.desc = "Owned by [I.registered_name]."
		else
			to_chat(user, "<span class='warning'>Access Denied</span>")
	else
		..()

/obj/structure/closet/secure_closet/mtf/CanToggleLock(var/mob/user, var/obj/item/weapon/card/id/id_card)
	return ..() || (istype(id_card) && id_card.registered_name && (!registered_name || (registered_name == id_card.registered_name)))

/obj/structure/closet/secure_closet/mtf/verb/reset()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Reset Lock"
	if(!CanPhysicallyInteract(usr)) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return
	if(ishuman(usr))
		src.add_fingerprint(usr)
		if (src.locked || !src.registered_name)
			to_chat(usr, "<span class='warning'>You need to unlock it first.</span>")
		else if (src.broken)
			to_chat(usr, "<span class='warning'>It appears to be broken.</span>")
		else
			if (src.opened)
				if(!src.close())
					return
			src.locked = 1
			src.icon_state = src.icon_locked
			src.registered_name = null
			src.SetName(initial(name))
			src.desc = initial(desc)