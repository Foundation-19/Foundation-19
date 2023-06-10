/obj/machinery/vending/weaponry //no guns here... get real.
	name = "\improper GunDispenser v4.2"
	desc = "A glorified vending machine for guns, why just not use gun lockers?"
	icon_state = "weaponry"
	machine_name = "gun dispenser"
	machine_desc = "Holds an internal stock of guns that can be dispensed on-demand or when a charged ID card is swiped, depending on the brand."
	product_ads = list("Kill some commies for me, will ya?;Warcrimes? HA! What's that?;Hotdogs, Horseshoes & Hand Grenades, America, baby.;'Murica.")
	base_type = /obj/machinery/vending/weaponry

/obj/machinery/vending/weaponry/goc
	name = "\improper GOCTech Gun Dispenser v1.1"
	products = list(
		/obj/item/gun/projectile/automatic/scp/fnfal = 6,
		/obj/item/gun/projectile/shotgun/pump/combat = 6,
		/obj/item/gun/projectile/pistol = 6,
		/obj/item/grenade/frag = 12
	)
