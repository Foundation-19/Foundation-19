/obj/machinery/vending/weaponry //no guns here... get real.
	name = "\improper GunDispenser v4.2"
	desc = "A glorified vending machine for guns, why just not use gun lockers?"
	icon_state = "weaponry"
	obj_flags = null //prevents it from being rotated and unanchored
	machine_name = "gun dispenser"
	machine_desc = "Holds an internal stock of guns that can be dispensed on-demand or when a charged ID card is swiped, depending on the brand."
	product_ads = list("Kill some commies for me, will ya?;Warcrimes? HA! What's that?;Hotdogs, Horseshoes & Hand Grenades, America, baby.;'Murica.")

// ## GOC & CI MACHINES //

/obj/machinery/vending/weaponry/goc
	name = "\improper GOCTech Gun Dispenser v1.1"
	icon_state = "goc_weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/fnfal = 6,
		/obj/item/gun/projectile/shotgun/pump/combat = 6,
		/obj/item/gun/projectile/pistol = 6,
		/obj/item/grenade/frag = 12
	)

/obj/machinery/vending/weaponry/chaos
	name = "\improper Hacked Gun Dispenser v0.0"
	desc = "Has outdated software, the auto-update is also busted... Such is the life of a pirate."
	icon_state = "ci_weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/ak74 = 5,
		/obj/item/gun/projectile/pistol = 5
	)

/obj/machinery/vending/weaponry/chaos/specialized
	name = "\improper Specialized-Gun Dispenser v0.2"
	desc = "One of the better devices the Chaos Insurgency has, this one dispenses guns for special operatives."
	icon_state = "ci_weaponry_special"
	products = list(
		/obj/item/gun/projectile/automatic/scp/rpk = 2,
		/obj/item/gun/projectile/automatic/scp/svd = 2,
		/obj/item/grenade/frag = 10
	)

// ## LCZ MACHINES ## //

/obj/machinery/vending/weaponry/lcz
	name = "\improper LightCZ AutoEquipment Device"
	desc = "An automated gun storage device that can dispense guns on demand, this one has been designed to supply LCZ personnel."
	icon_state = "lcz_weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/p90 = 6,
		/obj/item/gun/projectile/revolver/rhino = 2,
		/obj/item/gun/projectile/pistol/mk9 = 4
	)

/obj/machinery/vending/weaponry/lcz/energy
	name = "\improper LightCZ E.G. Storage"
	desc = "An automated gun storage device that can dispense guns on demand, this one houses energy/pulse weapons for LCZ personnel."
	products = list(
		/obj/item/gun/energy/plasmastun = 1,
		/obj/item/gun/energy/ionrifle = 1
	)

/obj/machinery/vending/weaponry/hcz
	name = "\improper HContain AutoEquipment Device"
	desc = "An automated gun storage device that can dispense guns on demand, this one was designed for HCZ personnel."
	icon_state = "weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/p90 = 3,
		/obj/item/gun/projectile/revolver/rhino = 1,
		/obj/item/gun/projectile/revolver/mateba = 1,
		/obj/item/gun/projectile/pistol/mk9 = 1
	)

/obj/machinery/vending/weaponry/hcz/sergeant
	name = "\improper Sergeant-R-Us"
	desc = "An automated gun storage device that can dispense guns on demand, this one was designed for HCZ Sergeants."
	icon_state = "weaponry"
	products = list(
		/obj/item/gun/projectile/automatic/scp/m4a1 = 2,
		/obj/item/gun/projectile/automatic/scp/m16 = 2,
	)
