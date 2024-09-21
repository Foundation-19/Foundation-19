/obj/item/gun/projectile/shotgun/tactical
	name = "combat shotgun"
	desc = "A pump action shotgun"
	icon_state = "tac_shotgun"
	item_state = "cshotgun"
	caliber = CALIBER_SHOTGUN
	load_method = SINGLE_CASING|SPEEDLOADER
	max_shells = 7
	w_class = ITEM_SIZE_HUGE
	force = 10
	obj_flags =  OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BACK
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 1)
	ammo_type = /obj/item/ammo_casing/shotgun
	one_hand_penalty = 2
	wielded_item_state = "gun_wielded"

	burst_delay = 0

/obj/item/gun/projectile/shotgun/tactical/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/gun/projectile/pistol/mk9
	name = "MK9 Foundation pistol"
	desc = "Standard issue 9mm pistol of the SCP Foundation. Based on the HK VP9."
	icon = 'icons/obj/gun.dmi'
	icon_state = "MK9"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9, /obj/item/ammo_magazine/scp/mk9/rubber)

/obj/item/gun/projectile/pistol/mk9/on_update_icon()
	..()
	if(ammo_magazine)
		icon_state = "[initial(icon_state)][length(ammo_magazine.stored_ammo) ? "" : "_0"]"
	else
		icon_state = "[initial(icon_state)]-e"

/obj/item/gun/projectile/revolver/mateba
	name = "mateba"
	desc = "Standard issue Foundation revolver based on the Mateba Unica. Chambered in .44 Magnum"
	icon = 'icons/obj/gun.dmi'
	icon_state = "mateba"
	caliber = ".44"
	fire_delay = 6
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/pistol/a50
	handle_casings = CYCLE_CASINGS

/obj/item/gun/projectile/revolver/mateba/bigiron
	name = "Big Iron"
	desc = "A Mateba Unica chambered in .44 Magnum. Various engravings of fine art adorn the sides of the barrel. On the right side, an engraving reads 'I fought the law and the law won'. A Security Department logo is precisely cut into the grip, with an engraved label of 'Marty Robbins' below it."

/obj/item/gun/projectile/revolver/rhino
	name = "rhino"
	desc = "Standard issue Foundation revolver based on the Chiappa Rhino. Chambered in .357 magnum"
	icon = 'icons/obj/gun.dmi'
	icon_state = "rhino"
	caliber = ".357"
	fire_delay = 4
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	ammo_type = /obj/item/ammo_casing/pistol/a357
	handle_casings = CYCLE_CASINGS

/obj/item/gun/projectile/silenced
	name = "silenced pistol"
	desc = "A handgun with an integral silencer. Uses .45 rounds."
	icon = 'icons/obj/gun.dmi'
	icon_state = "silenced_pistol"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 1
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 8)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/c45m
	allowed_magazines = /obj/item/ammo_magazine/c45m

/obj/item/gun/projectile/pistol/gyropistol
	name = "prototype pistol"
	desc = "A bulky foundation prototype pistol designed to fire self propelled rounds."
	icon = 'icons/obj/gun.dmi'
	icon_state = "gyropistol"
	max_shells = 8
	caliber = "20mmG"
	origin_tech = list(TECH_COMBAT = 3)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/gyrojet
	allowed_magazines = /obj/item/ammo_magazine/gyrojet
	fire_delay = 25
	slot_flags = SLOT_BELT
	auto_eject = 1
	auto_eject_sound = 'sounds/weapons/smg_empty_alarm.ogg'

/obj/item/gun/projectile/pistol/gyropistol/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "gyropistolloaded"
	else
		icon_state = "gyropistol"

/obj/item/gun/projectile/pistol/m1911
	name = "M1911"
	desc = "A classic Model 1911 pistol. A trusty sidearm even to this day, usually seen by administrative staff."
	icon = 'icons/obj/gun.dmi'
	icon_state = "m1911"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 0
	fire_delay = 3
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/m1911
	allowed_magazines = list(/obj/item/ammo_magazine/scp/m1911)

/obj/item/gun/projectile/pistol/m1911/gold
	name = "gold trimmed M1911"
	desc = "A classic Model 1911 pistol. A trusty sidearm even to this day, usually seen by administrative staff. Now trimmed in a luxury gold."
	icon_state = "m1911-spec"
	fire_delay = 2

/obj/item/gun/projectile/pistol/usp45
	name = "Colt Mustang"
	desc = "In 1983, Colt introduced the Colt Mark IV/ Series 80 Government Model -.45 Caliber. This pocket pistol was similar in appearance, but not design, to the Colt M1911. Chambered in .45 ACP."
	icon = 'icons/obj/gun.dmi'
	icon_state = "usp"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".45"
	silenced = 0
	fire_delay = 3
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/usp45
	allowed_magazines = list(/obj/item/ammo_magazine/scp/usp45)

/obj/item/gun/projectile/automatic/scp/saiga12
	name = "Saiga12 Tactical Shotgun"
	desc = "A reliable russian-made semi automatic shotgun often used by Foundation strike and security forces."
	icon_state = "saiga12"
	item_state = "saiga12"
	w_class = ITEM_SIZE_HUGE
	force = 10
	slot_flags = SLOT_BACK
	caliber = CALIBER_SHOTGUN
	origin_tech = list(TECH_COMBAT = 6, TECH_MATERIAL = 1, TECH_ESOTERIC = 5)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/saiga12
	allowed_magazines = /obj/item/ammo_magazine/scp/saiga12

	firemodes = list(
		list(mode_name="semiauto",       burst=1, fire_delay=0, one_hand_penalty=2, burst_accuracy=null, dispersion=null))


/obj/item/gun/projectile/automatic/scp/saiga12/beanbag
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/beanbag


/obj/item/gun/projectile/automatic/scp/saiga12/buckshot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/buckshot

/obj/item/gun/projectile/automatic/scp/saiga12/stunshell
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/stunshell

/obj/item/gun/projectile/automatic/scp/saiga12/rubbershot
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/rubbershot

/obj/item/gun/projectile/automatic/scp/saiga12/flash
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/flash

/obj/item/gun/projectile/automatic/scp/saiga12/emp
	magazine_type = /obj/item/ammo_magazine/scp/saiga12/emp


/obj/item/gun/projectile/automatic/scp/saiga12/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "saiga12"
	else
		icon_state = "saiga12-empty"
	return

/obj/item/gun/projectile/pistol/p232
	name = "Sig Sauer P232"
	desc = "The Sig P232 draws it's lineage from the older P-230, which in itself comes from the Sauer 38H. The old Sauer 38H was a blowback pistol intended to compete with the Walther PPK and Mauser HSC handguns. Due to Germany's pressing need for every last handgun they could get their hands on in the Second World War, Sauer would produce the 38H until the factory was captured by the Allies in 1945. The Sig P232, carries on the legacy of the Sauer 38H in spirit, as it is very much a modernized variant of the old handgun. This version is chambered in .380 ACP."
	icon = 'icons/obj/gun.dmi'
	icon_state = "p232"
	w_class = ITEM_SIZE_NORMAL
	caliber = ".380"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/a380
	allowed_magazines = list(/obj/item/ammo_magazine/scp/a380)

/obj/item/gun/projectile/pistol/p232/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "p232"
	else
		icon_state = "p232-empty"
	return

/obj/item/gun/projectile/pistol/makarov
	name = "Makarov Pistol"
	desc = "Shortly after the Second World War, the Soviet Union reactivated its plans to replace the TT pistols and Nagant M1895 revolvers. The adoption of the future AK assault rifle relegated the pistol to a light, handy self-defense weapon. The TT was unsuited for such a role, as it was heavy and bulky. Also, the Tokarev pistols omitted a safety and magazines were deemed too easy to lose. As a result, in December 1945, two separate contests for a new service pistol were created, respectively for a 7.62mm and 9mm pistol. It was later judged that the new 9.2x18mm cartridge, designed by B. V. Semin, was the best round suited for the intended role. The lower pressures of the cartridge allowed practical straight blowback operation, while retaining low recoil and good stopping power. This version is chambered in 9x19mm."
	icon = 'icons/obj/gun.dmi'
	icon_state = "makarov"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 2
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/a9mm
	allowed_magazines = list(/obj/item/ammo_magazine/scp/a9mm)

/obj/item/gun/projectile/pistol/makarov/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "makarov"
	else
		icon_state = "makarov-empty"
	return

/obj/item/gun/projectile/pistol/glock
	name = "Glock 19"
	desc = "The Glock is a brand of polymer-framed, short recoil-operated, striker-fired, locked-breech semi-automatic pistols designed and produced by Austrian manufacturer Glock Ges.m.b.H. The firearm entered Austrian military and police service by 1982 after becoming the top performer in reliability and safety tests. Chambered in 9x19mm."
	icon = 'icons/obj/gun.dmi'
	icon_state = "glock"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 3
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)

/obj/item/gun/projectile/pistol/glock/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "glock"
	else
		icon_state = "glock-empty"
	return

/obj/item/gun/projectile/pistol/glock/spec
	name = "Glock 30"
	desc = "The Glock is a brand of polymer-framed, short recoil-operated, striker-fired, locked-breech semi-automatic pistols designed and produced by Austrian manufacturer Glock Ges.m.b.H. The firearm entered Austrian military and police service by 1982 after becoming the top performer in reliability and safety tests. This one is made to fire faster, and control better. Chambered in 9x19mm."
	icon = 'icons/obj/gun.dmi'
	icon_state = "glock-spec"
	w_class = ITEM_SIZE_NORMAL
	caliber = "9mm"
	silenced = 0
	fire_delay = 1
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2, TECH_ESOTERIC = 2)
	load_method = MAGAZINE
	magazine_type = /obj/item/ammo_magazine/scp/mk9
	allowed_magazines = list(/obj/item/ammo_magazine/scp/mk9)

/obj/item/gun/projectile/pistol/glock/spec/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "glock-spec"
	else
		icon_state = "glock-spec-empty"
	return
