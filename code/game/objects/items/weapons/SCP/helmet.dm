/obj/item/clothing/head/helmet/scp/security
	name = "\improper foundation security helmet"
	desc = "A heavy non-descript helmet with built-in padding, and armor. It has a poly-carbonate yellow riot visor on it."
	icon_state = "guard-helm"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_MID, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS|BLOCKHAIR
	action_button_name = "Toggle Visor"

/obj/item/clothing/head/helmet/scp/security/ruined
	name = "\improper ruined foundation security helmet"
	desc = "A heavy non-descript helmet with built-in padding, and armor, however age has deminished it's quality, scratching the paint off. It has a cracked, and shattered poly-carbonate yellow riot visor on it, devestating blow to it's previous owner."
	icon_state = "forgotten-guard-helm"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_RESISTANT, bullet = ARMOR_BALLISTIC_VERY_SMALL, laser = ARMOR_LASER_VERY_SMALL, energy = 0, bomb = ARMOR_BOMB_MINOR, bio = 0, rad = 0)
	acid_resistance = 1.5
	flags_inv = HIDEEARS|BLOCKHAIR
	action_button_name = null

/obj/item/clothing/head/helmet/scp/security/medic
	name = "\improper foundation security medical helmet"
	desc = "A light non-descript helmet with built-in padding, and armor. It has a red cross on the front, and a red visor. Durability lessened to cope with faster response."
	icon_state = "medichelm"
	body_parts_covered = HEAD|EYES
	armor = list(melee = ARMOR_MELEE_VRESISTANT, bullet = ARMOR_BALLISTIC_MID, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_MINOR, bio = ARMOR_BIO_RESISTANT, rad = ARMOR_RAD_SMALL)
	acid_resistance = 1.5
	flags_inv = HIDEEARS|BLOCKHAIR|HIDEEYES
	action_button_name = null

/obj/item/clothing/head/helmet/scp/security/recontain
	name = "\improper foundation security response helmet"
	desc = "A heavy non-descript helmet with extra built-in padding, and armor. The massive amount of armor makes the helmet look thicker, it has a cyan visor."
	icon_state = "reconhelm"
	body_parts_covered = HEAD|EYES
	armor = list(melee = ARMOR_MELEE_VRESISTANT, bullet = ARMOR_BALLISTIC_PISTOL, laser = ARMOR_LASER_HANDGUNS_PLUS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS|BLOCKHAIR|HIDEEYES
	action_button_name = null

/obj/item/clothing/head/helmet/scp/security/riot
	name = "\improper foundation security riot helmet"
	desc = "A heavy non-descript helmet with a heavy durathread armor plating in the helmet, giving it a massive defense against melee. It has a poly-carbonate modernized white riot visor on it."
	icon_state = "guardriothelm"
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_VVSMALL, laser = ARMOR_LASER_SMALL, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/head/helmet/scp/security/lczcom
	name = "\improper heavy-plated foundation security helmet"
	desc = "A heavy non-descript helmet with more built-in padding, and armor. The golden badge on the front of the helmet incidates the rank of 'Lieutenant', looks important. It has a poly-carbonate yellow riot visor on it."
	icon_state = "heavy-guard-helm"
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_MID_PLUS, laser = ARMOR_LASER_HANDGUNS_PLUS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/head/helmet/scp/security/cadet
	name = "\improper foundation security trainee helmet"
	desc = "A light non-descript helmet given to Light Containment Zone cadets, with barely any built-in armor plating, nothing special really."
	icon_state = "cadethelm"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_SMALL, laser = ARMOR_LASER_SMALL_MID, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_MINOR, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS|BLOCKHAIR
	action_button_name = null

/obj/item/clothing/head/helmet/scp/security/cadet/hat
	name = "\improper foundation security trainee hat"
	desc = "A hat given to Entrance Zone probationary agents, it's given light padding to keep those craniums intact."
	icon_state = "cadethat"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_MID, bullet = ARMOR_BALLISTIC_VVSMALL, laser = ARMOR_LASER_VERY_SMALL, energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_MINOR, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = null
	action_button_name = null

/obj/item/clothing/head/helmet/scp/hczsecurityofficer
	name = "\improper Tactical Security Officer Helmet"
	desc = "The markings on this helmet indicate that it belongs to a SD zone commander."
	icon_state = "helmet_merc"
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	cold_protection = HEAD
	body_parts_covered = HEAD
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/hczsecurityguard
	name = "\improper Tactical Security Guard Helmet"
	desc = "A tactical Foundation SD Guard helmet."
	icon_state = "helmet"
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_RESISTANT, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	cold_protection = HEAD
	body_parts_covered = HEAD
	flags_inv = HIDEEARS



/obj/item/clothing/head/helmet/scp/securitystab
	name = "\improper Armored Anti-stab Helmet"
	desc = "An anti-stab SCP Foundation helmet normally issued to detention facility guards."
	icon_state = "guard-helm"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_MID, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS


/obj/item/clothing/head/helmet/scp/security/attack_self(mob/user)
	body_parts_covered ^= EYES|FACE
	icon_state = initial(icon_state)
	var/action = "lowers"
	if (~body_parts_covered & EYES)
		icon_state += "_up"
		action = "raises"
	visible_message(SPAN_ITALIC("\The [user] [action] the visor on \the [src]."), range = 3)
	update_clothing_icon()


/obj/item/clothing/head/helmet/scp/chaos
	name = "Chaos Insurgency helmet"
	desc = "A russian type of ballistics helmet usually seen worn by modern russian military forces, this one is colored tan and is used by the Chaos Insurgency."
	icon_state = "ci_helmet"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_RESISTANT, bullet = ARMOR_BALLISTIC_RESISTANT, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/security/chaos
	name = "Chaos Insurgency K6-3 Altyn helmet"
	desc = "A heavy russian type of helmet usually seen worn by modern russian military forces, this one has a face shield and is used by heavy soldiers, this one is colored tan and is used by the Chaos Insurgency."
	icon_state = "ci_heavy_helmet"
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_RESISTANT, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_SMALL, rad = ARMOR_RAD_MINOR)

/obj/item/clothing/head/helmet/scp/chaos/officer
	name = "Chaos Insurgency field cap"
	desc = "A durable, unquestionably bulletproof russian type of field cap used by mainly officers of the russian military forces, this one is colored tan and is used by the Chaos Insurgency."
	icon_state = "ci_officer"
	armor = list(melee = ARMOR_MELEE_HIGH, bullet = ARMOR_BALLISTIC_MID_PLUS, laser = ARMOR_LASER_SMALL,energy = ARMOR_ENERGY_MINOR, bomb = ARMOR_BOMB_MINOR, bio = 0, rad = 0)

/obj/item/clothing/head/helmet/scp/chaos/pilot
	name = "Chaos Insurgency pilot helmet"
	desc = "A pilot helmet worn by air pilots usually wanting the utmost defense while flying a plane. Also keeps the bugs out of your eyes if your windshield ever breaks. usually seen worn by modern russian military forces, this one is colored tan and is used by the Chaos Insurgency."
	icon_state = "ci_pilot_helmet"
	body_parts_covered = EYES|FACE
	armor = list(melee = ARMOR_MELEE_SMALL, bullet = ARMOR_BALLISTIC_VVSMALL, laser = ARMOR_LASER_MINOR, energy = 0, bomb = 0, bio = 0, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/donor
	name = "\improper tactical helmet"
	desc = "Tactical Helmet."
	icon_state = "donor_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/donor2
	name = "\improper security heavy helmet"
	desc = "Security Helmet."
	icon_state = "donate_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/donor3
	name = "\improper security heavy helmet"
	desc = "Heavy Helmet."
	icon_state = "don_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_PISTOLP, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/eta
	name = "Visored Helmet"
	action_button_name = "Adjust Visor"
	desc = "A anti-memetic helmet with a special visor to deal with visual memetic SCP's."
	icon_state = "eta-helmet-open"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	cold_protection = HEAD|FACE|EYES
	armor = list(melee = ARMOR_MELEE_VERY_HIGH, bullet = ARMOR_BALLISTIC_PISTOL, laser = ARMOR_LASER_RIFLES, energy = ARMOR_ENERGY_STRONG, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	tint = TINT_NONE
	visual_insulation = V_INSL_NONE

/obj/item/clothing/head/helmet/scp/eta/attack_self(mob/user)
	var/action
	if (tint == TINT_BLIND)
		action = "de-activates"
		icon_state = "eta-helmet-open"
		tint = TINT_NONE
		visual_insulation = V_INSL_NONE
	else if (tint == TINT_NONE)
		action = "activates"
		icon_state = "eta-helmet"
		tint = TINT_BLIND
		visual_insulation = V_INSL_PERFECT
	visible_message(SPAN_ITALIC("\The [user] [action] the visor on the [src]."), range = 3)
	update_clothing_icon()


/obj/item/clothing/head/helmet/scp/beta
	name = "Armored Anti-Biological Hood"
	desc = "A hood combined kevlar and other materials to shield it against biological attacks, heavy acids, radiation and physical harm."
	icon_state = "beta-helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	cold_protection = HEAD|FACE|EYES
	permeability_coefficient = 0.5
	armor = list(melee = ARMOR_MELEE_VERY_VERY_HIGH, bullet = ARMOR_BALLISTIC_VRESISTANT, laser = ARMOR_LASER_HANDGUNS, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_RESISTANT, bio = ARMOR_BIO_SHIELDED, rad = ARMOR_RAD_SHIELDED)
	acid_resistance = 5
