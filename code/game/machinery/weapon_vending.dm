/obj/machinery/vending/weaponry //no guns here... get real.
	name = "\improper GunDispenser v4.2"
	desc = "A glorified vending machine for guns, why just not use gun lockers?"
	icon_state = "weaponry"
	obj_flags = OBJ_FLAG_ANCHORABLE //not rotatable because im not making sprites for dat
	machine_name = "gun dispenser"
	machine_desc = "Holds an internal stock of guns that can be dispensed on-demand or when a charged ID card is swiped, depending on the brand."
	product_slogans = list("Kill some commies for me, will ya?;Warcrimes? HA! What's that?;Hotdogs, Horseshoes & Hand Grenades, America, baby.;'Murica.")
	product_ads = list("Kill some commies for me, will ya?;Warcrimes? HA! What's that?;Hotdogs, Horseshoes & Hand Grenades, America, baby.;'Murica.")

// ## GOC & CI MACHINES //

/obj/machinery/vending/weaponry/goc
	name = "\improper GOCTech Gun Dispenser v1.1"
	icon_state = "goc_weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/fnfal = 6,
		/obj/item/gun/projectile/shotgun/pump/combat = 6,
		/obj/item/gun/projectile/pistol = 6,
		/obj/item/grenade/frag = 12,
		/obj/item/ammo_magazine/scp/fnfal = 15,
		/obj/item/ammo_magazine/scp = 15,
		/obj/item/ammo_magazine/shotholder/shell = 2
	)

/obj/machinery/vending/weaponry/chaos
	name = "\improper Hacked Gun Dispenser v0.0"
	desc = "Has outdated software, the auto-update is also busted... Such is the life of a pirate."
	icon_state = "ci_weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/ak74 = 5,
		/obj/item/gun/projectile/pistol = 5,
		/obj/item/ammo_magazine/scp/ak = 5
	)

/obj/machinery/vending/weaponry/chaos/specialized
	name = "\improper Specialized-Gun Dispenser v0.2"
	desc = "One of the better devices the Chaos Insurgency has, this one dispenses guns for special operatives."
	icon_state = "ci_weaponry_special"
	products = list(
		/obj/item/gun/projectile/automatic/scp/rpk = 2,
		/obj/item/gun/projectile/automatic/scp/svd = 2,
		/obj/item/grenade/frag = 10,
		/obj/item/ammo_magazine/scp/ak = 30,
		/obj/item/ammo_magazine/scp/svd = 30
	)

// ## LCZ MACHINES ## //

/obj/machinery/vending/weaponry/lcz
	name = "\improper LightCZ AutoEquipment Device"
	desc = "An automated gun storage device that can dispense guns on demand, this one has been designed to supply LCZ personnel."
	icon_state = "lcz_weaponry"
	req_access = list("ACCESS_SECURITY_LEVEL2")
	products = list(
		/obj/item/gun/projectile/automatic/scp/p90 = 6,
		/obj/item/gun/projectile/revolver/rhino = 2,
		/obj/item/gun/projectile/pistol/mk9 = 4,
		/obj/item/ammo_magazine/box/a57 = 6,
		/obj/item/ammo_magazine/box/a57/rubber = 30,
		/obj/item/ammo_magazine/box/mk9 = 4,
		/obj/item/ammo_magazine/box/a357 = 4
	)

/obj/machinery/vending/weaponry/lcz/energy
	name = "\improper LightCZ E.G. Storage"
	desc = "An automated gun storage device that can dispense guns on demand, this one houses energy/pulse weapons for LCZ personnel."
	req_access = list("ACCESS_SECURITY_LEVEL2")
	products = list(
		/obj/item/gun/energy/stunrevolver/taser = 6,
		/obj/item/gun/energy/stunrevolver/rifle = 2,
		/obj/item/gun/energy/ionrifle = 1
	)

// ## HCZ MACHINES ## //

/obj/machinery/vending/weaponry/hcz
	name = "\improper HContain AutoEquipment Device"
	desc = "An automated gun storage device that can dispense guns on demand, this one was designed for HCZ personnel."
	icon_state = "weaponry"
	req_access = list("ACCESS_SECURITY_LEVEL3")
	products = list(
		/obj/item/gun/projectile/automatic/scp/p90 = 3,
		/obj/item/gun/projectile/revolver/mateba = 1,
		/obj/item/gun/projectile/pistol/mk9 = 1,
		/obj/item/ammo_magazine/box/a357 = 4,
		/obj/item/ammo_magazine/box/a50 = 4,
		/obj/item/ammo_magazine/box/a57 = 12,
		/obj/item/ammo_magazine/box/mk9 = 6,
		/obj/item/ammo_magazine/box/a556 = 8
	)

/obj/machinery/vending/weaponry/hcz/sergeant
	name = "\improper Sergeant-R-Us"
	desc = "An automated gun storage device that can dispense guns on demand, this one was designed for HCZ Sergeants."
	icon_state = "weaponry"
	req_access = list("ACCESS_SECURITY_LEVEL3")
	products = list(
		/obj/item/gun/projectile/automatic/scp/m4a1 = 2,
		/obj/item/gun/projectile/automatic/scp/m16 = 2,
		/obj/item/grenade/frag = 2
	)

// ## SINGULAR EZ MACHINE ##

/obj/machinery/vending/weaponry/ez
	name = "\improper EntranZ AutoEquip Device"
	desc = "An automated gun storage device that can dispense guns on demand, this one was designed for EZ Agents."
	icon_state = "ez_weaponry"
	req_access = list("ACCESS_SECURITY_LEVEL2")
	products = list(
		/obj/item/gun/projectile/automatic/scp/p90 = 8,
		/obj/item/gun/projectile/automatic/scp/m16 = 2,
		/obj/item/gun/projectile/revolver/rhino = 1,
		/obj/item/gun/projectile/pistol/usp45 = 3,
		/obj/item/gun/projectile/pistol/mk9 = 3,
		/obj/item/ammo_magazine/box/a57 = 6,
		/obj/item/ammo_magazine/box/mk9 = 4,
		/obj/item/ammo_magazine/box/a357 = 6,
		/obj/item/ammo_magazine/box/a45 = 2
	)

