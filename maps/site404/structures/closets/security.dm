/*
 * Site 53 Security
 */

// MTF LOCKERS

/* Site 53 Security */

// GUARD LOCKERS

/obj/structure/closet/secure_closet/guard
	name = "Guard Locker - NO USE, ONLY FOR CODE."
	icon = 'icons/obj/sec-lockers_new.dmi'
	icon_state = "lczjunior1"
	icon_closed = "lczjunior"
	icon_locked = "lczjunior1"
	icon_opened = "lczopen"
	icon_off = "lczjunioroff"
	anchored = TRUE
	req_access = list(ACCESS_SECURITY_LVL1)
	var/registered_name = null

// Default contents of ALL guard lockers
/obj/structure/closet/secure_closet/guard/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/sec,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/solgov/department/security/marine,
	)

/obj/structure/closet/secure_closet/guard/attackby(obj/item/W, mob/user)
	if(opened)
		return ..()
	if(W.GetIdCard())
		var/obj/item/card/id/I = W.GetIdCard()
		if(!I || !I.registered_name)
			return
		if(togglelock(user, I))
			if(!registered_name)
				registered_name = I.registered_name
				name += " ([I.registered_name])"
				desc = "Owned by [I.registered_name]."
				return
		to_chat(user, SPAN_WARNING("Access Denied"))
		return
	return ..()

/obj/structure/closet/secure_closet/guard/CanToggleLock(mob/user, obj/item/card/id/id_card)
	return ..() || (istype(id_card) && id_card.registered_name && (!registered_name || (registered_name == id_card.registered_name)))

/obj/structure/closet/secure_closet/guard/verb/reset()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Reset Lock"

	if(!CanPhysicallyInteract(usr)) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return
	if(ishuman(usr))
		add_fingerprint(usr)
		if (locked || !registered_name)
			to_chat(usr, SPAN_WARNING("You need to unlock it first."))
		else if (src.broken)
			to_chat(usr, SPAN_WARNING("It appears to be broken."))
		else
			if(opened)
				if(!close())
					return
			locked = 1
			registered_name = null
			SetName(initial(name))
			desc = initial(desc)

/obj/structure/closet/secure_closet/cadet
	name = "Cadet Locker - NO USE, ONLY FOR CODE."
	icon = 'icons/obj/sec-lockers_new.dmi'
	icon_state = "lczjunior1"
	icon_closed = "lczjunior"
	icon_locked = "lczjunior1"
	icon_opened = "lczopen"
	icon_off = "lczjunioroff"
	anchored = TRUE
	req_access = list(ACCESS_SECURITY_LVL1)
	var/registered_name = null

// Default contents of ALL cadet lockers
/obj/structure/closet/secure_closet/cadet/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/sec,
		/obj/item/clothing/accessory/storage/black_vest,
	)

/obj/structure/closet/secure_closet/cadet/attackby(obj/item/W, mob/user)
	if(opened)
		return ..()
	if(W.GetIdCard())
		var/obj/item/card/id/I = W.GetIdCard()
		if(!I || !I.registered_name)
			return
		if(togglelock(user, I))
			if(!registered_name)
				registered_name = I.registered_name
				name += " ([I.registered_name])"
				desc = "Owned by [I.registered_name]."
				return
		to_chat(user, SPAN_WARNING("Access Denied"))
		return
	return ..()

/obj/structure/closet/secure_closet/cadet/CanToggleLock(mob/user, obj/item/card/id/id_card)
	return ..() || (istype(id_card) && id_card.registered_name && (!registered_name || (registered_name == id_card.registered_name)))

/obj/structure/closet/secure_closet/cadet/verb/reset()
	set src in oview(1) // One square distance
	set category = "Object"
	set name = "Reset Lock"

	if(!CanPhysicallyInteract(usr)) // Don't use it if you're not able to! Checks for stuns, ghost and restrain
		return
	if(ishuman(usr))
		add_fingerprint(usr)
		if (locked || !registered_name)
			to_chat(usr, SPAN_WARNING("You need to unlock it first."))
		else if (src.broken)
			to_chat(usr, SPAN_WARNING("It appears to be broken."))
		else
			if(opened)
				if(!close())
					return
			locked = 1
			registered_name = null
			SetName(initial(name))
			desc = initial(desc)

// LCZ - Cadet
/obj/structure/closet/secure_closet/cadet/lcz
	name = "LCZ Cadet's Locker"
	req_access = list(ACCESS_SECURITY_LVL1)
	icon_state = "lczcadet1"
	icon_closed = "lczcadet"
	icon_locked = "lczcadet1"
	icon_opened = "lczopen"
	icon_off = "lczcadetoff"

/obj/structure/closet/secure_closet/cadet/lcz/WillContain()
	return ..() | list(
		/obj/item/clothing/suit/armor/vest/scp/medarmor,
		/obj/item/clothing/head/helmet/scp/security/cadet,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// LCZ - Guard
/obj/structure/closet/secure_closet/guard/lcz
	name = "LCZ Guard's Locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "lczjunior1"
	icon_closed = "lczjunior"
	icon_locked = "lczjunior1"
	icon_opened = "lczopen"
	icon_off = "lczjunioroff"

/obj/structure/closet/secure_closet/guard/lcz/WillContain()
	return ..() | list(
		/obj/item/clothing/suit/armor/vest/scp/medarmor,
		/obj/item/clothing/head/helmet/scp/security,
		/obj/item/clothing/head/beret/sec/guard,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// LCZ - Sergeant
/obj/structure/closet/secure_closet/guard/lcz/sergeant
	name = "LCZ Sergeant's Locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "lczguard1"
	icon_closed = "lczguard"
	icon_locked = "lczguard1"
	icon_opened = "lczopen"
	icon_off = "lczguardoff"

/obj/structure/closet/secure_closet/guard/lcz/sergeant/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/sec,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/accessory/storage/bandolier,
		/obj/item/clothing/suit/armor/vest/scp/medarmor,
		/obj/item/clothing/head/helmet/scp/security,
		/obj/item/clothing/head/beret/sec/sergeant,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// HCZ - Cadet
/obj/structure/closet/secure_closet/cadet/hcz
	name = "HCZ Private's Locker"
	req_access = list(ACCESS_SECURITY_LVL3)
	icon_state = "hczcadet1"
	icon_closed = "hczcadet"
	icon_locked = "hczcadet1"
	icon_opened = "hczopen"
	icon_off = "hczcadetoff"

/obj/structure/closet/secure_closet/cadet/hcz/WillContain()
	return ..() | list(
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/material/knife/combat,
		/obj/item/clothing/suit/armor/pcarrier/scp/medium,
		/obj/item/clothing/head/helmet/scp/hczsecurityguard,
		/obj/item/melee/telebaton,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/gun/energy/taser,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// HCZ - Guard
/obj/structure/closet/secure_closet/guard/hcz
	name = "HCZ Guard's Locker"
	req_access = list(ACCESS_SECURITY_LVL3, ACCESS_SCIENCE_LVL3)
	icon_state = "hczjunior1"
	icon_closed = "hczjunior"
	icon_locked = "hczjunior1"
	icon_opened = "hczopen"
	icon_off = "hczjunioroff"

/obj/structure/closet/secure_closet/guard/hcz/WillContain()
	return ..() | list(
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/material/knife/combat,
		/obj/item/melee/telebaton,
		/obj/item/gun/energy/stunrevolver/taser,
		/obj/item/ammo_magazine/box/a57/ap,
		/obj/item/ammo_magazine/box/a57/rubber,
		/obj/item/clothing/head/bio_hood/security,
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/suit/armor/pcarrier/scp/medium,
		/obj/item/clothing/head/beret/sec/guard,
		/obj/item/ammo_magazine/scp/usp45 = 3,
	)

// HCZ - Sergeant
/obj/structure/closet/secure_closet/guard/hcz/sergeant
	name = "HCZ Sergeant's Locker"
	icon_state = "hczguard1"
	icon_closed = "hczguard"
	icon_locked = "hczguard1"
	icon_opened = "hczopen"
	icon_off = "hczguardoff"

/obj/structure/closet/secure_closet/guard/hcz/sergeant/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/sec,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/melee/telebaton,
		/obj/item/material/knife/combat,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/gun/projectile/automatic/scp/m16,
		/obj/item/gun/energy/stunrevolver,
		/obj/item/ammo_magazine/scp/m16_mag = 3,
		/obj/item/ammo_magazine/box/a556,
		/obj/item/clothing/head/bio_hood/security,
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/suit/armor/pcarrier/scp/medium,
		/obj/item/clothing/head/beret/sec/sergeant,
		/obj/item/ammo_magazine/scp/usp45 = 3,
	)

// EZ - Cadet
/obj/structure/closet/secure_closet/cadet/ez
	name = "EZ Probationary Agent's Locker"
	req_access = list(ACCESS_SECURITY_LVL2, ACCESS_ADMIN_LVL1)
	icon_state = "ezcadet1"
	icon_closed = "ezcadet"
	icon_locked = "ezcadet1"
	icon_opened = "ezopen"
	icon_off = "ezcadetoff"

/obj/structure/closet/secure_closet/cadet/ez/WillContain()
	return ..() | list(
		/obj/item/clothing/suit/armor/pcarrier/scp/medium,
		/obj/item/clothing/head/helmet/scp/hczsecurityguard,
		/obj/item/melee/telebaton,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/gun/energy/taser,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// EZ - Guard
/obj/structure/closet/secure_closet/guard/ez
	name = "EZ Agent's Locker"
	req_access = list(ACCESS_SECURITY_LVL3, ACCESS_ADMIN_LVL2)
	icon_state = "ezjunior1"
	icon_closed = "ezjunior"
	icon_locked = "ezjunior1"
	icon_opened = "ezopen"
	icon_off = "ezjunioroff"

/obj/structure/closet/secure_closet/guard/ez/WillContain()
	return ..() | list(
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/gun/projectile/automatic/scp/mp5,
		/obj/item/ammo_magazine/scp/smgm9mm = 4,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/gun/energy/stunrevolver/taser,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// EZ - Sergeant
/obj/structure/closet/secure_closet/guard/ez/sergeant
	name = "EZ Senior Agent's Locker"
	icon_state = "ezguard1"
	icon_closed = "ezguard"
	icon_locked = "ezguard1"
	icon_opened = "ezopen"
	icon_off = "ezguardoff"

/obj/structure/closet/secure_closet/guard/ez/sergeant/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/sec,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/gun/projectile/automatic/scp/mp5,
		/obj/item/ammo_magazine/scp/smgm9mm = 4,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/clothing/gloves/tactical/scp,
		/obj/item/gun/energy/stunrevolver/taser,
		/obj/item/ammo_magazine/scp/mk9 = 3,
	)

// Guard Commander
/obj/structure/closet/secure_closet/guard/guard_commander
	name = "Guard Commander Locker"
	req_access = list(ACCESS_SECURITY_LVL5)
	icon_state = "gc1"
	icon_closed = "gc"
	icon_locked = "gc1"
	icon_opened = "gcopen"
	icon_off = "gcoff"

/obj/structure/closet/secure_closet/guard/guard_commander/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/material/knife/combat,
		/obj/item/melee/telebaton,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/accessory/solgov/department/security/marine,
		/obj/item/clothing/head/beret/sec/guardcom,
		/obj/item/clothing/head/beret/sec/corporate/hos,
		/obj/item/clothing/suit/armor/pcarrier/scp/tactical,
		/obj/item/clothing/under/rank/head_of_security/guardcom,
		/obj/item/clothing/under/rank/head_of_security/guardcom/alt,
		/obj/item/gun/projectile/pistol/mk9,
		/obj/item/ammo_magazine/scp/mk9 = 3,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/gun/energy/taser/carbine,
	)

// Zone Commander
/obj/structure/closet/secure_closet/guard/zone_commander
	name = "LCZ Zone Lieutenant's Locker"
	req_access = list(ACCESS_SECURITY_LVL4)
	icon_state = "lczcomm1"
	icon_closed = "lczcomm"
	icon_locked = "lczcomm1"
	icon_opened = "lczopen"
	icon_off = "lczcommoff"

/obj/structure/closet/secure_closet/guard/zone_commander/WillContain()
	return list(
		/obj/item/handcuffs = 4,
		/obj/item/storage/box/ifak,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/material/knife/combat,
		/obj/item/melee/telebaton,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
		/obj/item/clothing/glasses/sunglasses/sechud/goggles,
		/obj/item/clothing/accessory/armor/unobtainable/tag/base/com/zonecomm,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/clothing/head/beret/sec/corporate/hos,
		/obj/item/clothing/suit/armor/pcarrier/scp/tactical,
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/head/bio_hood/security,
		/obj/item/storage/pill_bottle/amnesticsa,
		/obj/item/gun/projectile/pistol/usp45,
		/obj/item/ammo_magazine/scp/usp45 = 3,
		/obj/item/ammo_magazine/box/acp45,
	)

/obj/structure/closet/secure_closet/guard/zone_commander/hcz
	name = "HCZ Zone Lieutenant's Locker"
	req_access = list(ACCESS_SECURITY_LVL4)
	icon_state = "hczcomm1"
	icon_closed = "hczcomm"
	icon_locked = "hczcomm1"
	icon_opened = "hczopen"
	icon_off = "hczcommoff"

/obj/structure/closet/secure_closet/guard/zone_commander/ez
	name = "EZ Zone Supervisor's Locker"
	req_access = list(ACCESS_SECURITY_LVL4)
	icon_state = "ezcomm1"
	icon_closed = "ezcomm"
	icon_locked = "ezcomm1"
	icon_opened = "ezopen"
	icon_off = "ezcommoff"

/obj/structure/closet/secure_closet/guard/breachautomatics
	name = "Assault rifle locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "tactical1"
	icon_closed = "tactical"
	icon_locked = "tactical1"
	icon_opened = "gunopen"
	icon_off = "tacticaloff"

/obj/structure/closet/secure_closet/guard/breachautomatics/WillContain()
	return list(
		/obj/item/gun/projectile/automatic/scp/m16,
		/obj/item/gun/projectile/automatic/scp/m16,
		/obj/item/gun/projectile/automatic/scp/m4a1,
		/obj/item/gun/projectile/automatic/scp/m4a1,
		/obj/item/ammo_magazine/scp/m16_mag = 12,
		/obj/item/ammo_magazine/box/a556 = 4
	)


/obj/structure/closet/secure_closet/guard/breachshotguns
	name = "Tactical Shotgun Locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "gun1"
	icon_closed = "gun"
	icon_locked = "gun1"
	icon_opened = "gunopen"
	icon_off = "gunoff"

/obj/structure/closet/secure_closet/guard/breachshotguns/WillContain()
	return list(
		/obj/item/gun/projectile/automatic/scp/saiga12 = 2,
		/obj/item/ammo_magazine/box/buckshot = 4,
		/obj/item/ammo_magazine/box/slug = 4,
		/obj/item/ammo_magazine/box/emp = 2,
		/obj/item/ammo_magazine/scp/saiga12 = 6,
		/obj/item/ammo_magazine/scp/saiga12/emp = 4,
		/obj/item/ammo_magazine/scp/saiga12/buckshot = 6,
		/obj/item/clothing/accessory/storage/bandolier = 2
	)

/obj/structure/closet/secure_closet/guard/riotshotguns
	name = "Riot Shotgun Locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "gun1"
	icon_closed = "gun"
	icon_locked = "gun1"
	icon_opened = "gunopen"
	icon_off = "gunoff"

/obj/structure/closet/secure_closet/guard/riotshotguns/WillContain()
	return list(
		/obj/item/gun/projectile/automatic/scp/saiga12/beanbag = 2,
		/obj/item/ammo_magazine/scp/saiga12/beanbag = 8,
		/obj/item/ammo_magazine/box/beanbag = 4,
		/obj/item/clothing/accessory/storage/bandolier = 2,
	)

/obj/structure/closet/secure_closet/guard/specialistshotgun
	name = "Specialized Shotgun Crowd Control Gear"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "gun1"
	icon_closed = "gun"
	icon_locked = "gun1"
	icon_opened = "gunopen"
	icon_off = "gunoff"

/obj/structure/closet/secure_closet/guard/specialistshotgun/WillContain()
	return list(
		/obj/item/ammo_magazine/scp/saiga12/beanbag = 3,
		/obj/item/ammo_magazine/scp/saiga12/rubbershot = 3,
		/obj/item/ammo_magazine/scp/saiga12/stunshell = 3,
		/obj/item/ammo_magazine/scp/saiga12/flash = 3,
		/obj/item/ammo_magazine/box/beanbag = 3,
		/obj/item/ammo_magazine/box/rubbershot = 3,
		/obj/item/ammo_magazine/box/stunshell = 3,
		/obj/item/ammo_magazine/box/flash = 3,
	)

/obj/structure/closet/secure_closet/guard/lethalshotgunammunitionbuckshot
	name = "Buckshot Storage Locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "gun1"
	icon_closed = "gun"
	icon_locked = "gun1"
	icon_opened = "gunopen"
	icon_off = "gunoff"

/obj/structure/closet/secure_closet/guard/lethalshotgunammunitionbuckshot/WillContain()
	return list(
		/obj/item/ammo_magazine/scp/saiga12/buckshot = 16,
		/obj/item/ammo_magazine/box/buckshot = 8,
	)

/obj/structure/closet/secure_closet/guard/riotgear
	name = "riot gear locker"
	req_access = list(ACCESS_SECURITY_LVL2)
	icon_state = "armor1"
	icon_closed = "armor"
	icon_locked = "armor1"
	icon_opened = "gunopen"
	icon_off = "armoroff"

/obj/structure/closet/secure_closet/guard/riotgear/WillContain()
	return list(
		/obj/item/clothing/head/helmet/riot = 3,
		/obj/item/clothing/suit/armor/riot = 3,
		/obj/item/shield/riot = 3,
		/obj/item/melee/telebaton = 3,
	)

/obj/structure/closet/secure_closet/guard/scout
	name = "Scout's Locker"
	req_access = list(ACCESS_SECURITY_LVL3)
	icon_state = "mtf1"
	icon_closed = "mtf"
	icon_locked = "mtf1"
	icon_opened = "mtfopen"
	icon_off = "mtfoff"

/obj/structure/closet/secure_closet/guard/scout/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/head/bio_hood/security,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/dufflebag,
		/obj/item/grenade/frag = 2,
		/obj/item/crowbar/prybar,
		/obj/item/taperoll/research,
		/obj/item/device/tape/random = 4,
		/obj/item/device/radio,
		/obj/item/device/taperecorder,
		/obj/item/device/flashlight/maglight,
//		/obj/item/gun/projectile/colt/officer,
//		/obj/item/gun/projectile/automatic/tactical,
//		/obj/item/ammo_magazine/tac9mm = 6,
		/obj/item/storage/pill_bottle/amnesticsb,
		/obj/item/storage/box/freezer
	)

/obj/structure/closet/secure_closet/guard/scout/sergeant
	name = "Scout's Leader Locker"
	req_access = list(ACCESS_SECURITY_LVL5)
	icon_state = "mtfsenior1"
	icon_closed = "mtfsenior"
	icon_locked = "mtfsenior1"
	icon_opened = "mtfsenioropen"
	icon_off = "mtfsenioroff"

/obj/structure/closet/secure_closet/guard/scout/sergeant/WillContain()
	return list(
		/obj/item/clothing/suit/bio_suit/security,
		/obj/item/clothing/head/bio_hood/security,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/material/hatchet/machete = 5,
//		/obj/item/storage/pill_bottle/amnesticsb,
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/dufflebag,
		/obj/item/grenade/frag = 2,
		/obj/item/device/tape/random = 4,
		/obj/item/device/radio,
		/obj/item/device/taperecorder,
		/obj/item/crowbar/prybar,
		/obj/item/device/flashlight/maglight,
//		/obj/item/gun/projectile/revolver/tactical,
//		/obj/item/gun/projectile/automatic/hcrifle,
//		/obj/item/ammo_magazine/a762 = 6,
		/obj/item/material/hatchet/machete/deluxe
	)

/obj/structure/closet/secure_closet/guard/ntf
	name = "Task Force Agent's locker"
	req_access = list(ACCESS_SECURITY_LVL3)
	icon_state = "mtf1"
	icon_closed = "mtf"
	icon_locked = "mtf1"
	icon_opened = "mtfopen"
	icon_off = "mtfoff"

/obj/structure/closet/secure_closet/guard/ntf/WillContain()
	return list(
		/obj/item/clothing/accessory/storage/bandolier,
		/obj/item/device/flashlight/maglight,
		/obj/item/clothing/mask/balaclava,
		/obj/item/clothing/glasses/night,
		/obj/item/clothing/accessory/ubac,
		/obj/item/storage/backpack/rucksack,
		/obj/item/gun/projectile/pistol/mk9,
		/obj/item/ammo_magazine/scp/mk9 = 3,
		/obj/item/ammo_magazine/box/a9mm,
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/melee/telebaton,
	)

/obj/structure/closet/secure_closet/guard/epsilon11agent
	name = "Epsilon-11 Task Force Agent's locker"
	req_access = list(ACCESS_MTF)
	icon_state = "mtf1"
	icon_closed = "mtf"
	icon_locked = "mtf1"
	icon_opened = "mtfopen"
	icon_off = "mtfoff"

/obj/structure/closet/secure_closet/guard/epsilon11agent/WillContain()
	return list(
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/ammo_magazine/scp/mk9 = 3,
		/obj/item/gun/projectile/pistol/glock/spec,
		/obj/item/clothing/glasses/night,
		/obj/item/clothing/mask/gas/mtf,
		/obj/item/melee/baton/loaded,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/storage/box/cdeathalarm_kit,
		/obj/item/material/knife/combat,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
	)

/obj/structure/closet/secure_closet/guard/epsilon11leader
	name = "Epsilon-11 Task Force Leader's locker"
	req_access = list(ACCESS_MTF)
	icon_state = "mtfsenior1"
	icon_closed = "mtfsenior"
	icon_locked = "mtfsenior1"
	icon_opened = "mtfopen"
	icon_off = "mtfsenioroff"

/obj/structure/closet/secure_closet/guard/epsilon11leader/WillContain()
	return list(
		/obj/item/storage/belt/holster/security/tactical,
		/obj/item/ammo_magazine/speedloader/heavy = 3,
		/obj/item/ammo_magazine/box/a454,
		/obj/item/gun/projectile/revolver/military/heavy,
		/obj/item/clothing/glasses/night,
		/obj/item/clothing/mask/gas/mtf,
		/obj/item/melee/baton/loaded,
		/obj/item/crowbar/emergency_forcing_tool,
		/obj/item/storage/box/cdeathalarm_kit,
		/obj/item/material/knife/combat,
		/obj/item/clothing/accessory/storage/black_vest,
		/obj/item/clothing/accessory/storage/holster/thigh,
	)
