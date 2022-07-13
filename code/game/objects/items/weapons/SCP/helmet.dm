/obj/item/clothing/head/helmet/scp/security
	name = "\improper foundation security helmet"
	desc = "A helmet with 'FOUNDATION SECURITY' printed on the back lettering."
	icon_state = "guard-helm"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = 40, bullet = 60, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	flags_inv = HIDEEARS
	action_button_name = "Toggle Visor"

/obj/item/clothing/head/helmet/scp/hczsecurityofficer
	name = "\improper Tactical Security Officer Helmet"
	desc = "The markings on this helmet indicate that it belongs to a SD zone commander."
	icon_state = "helmet_merc"
	armor = list(melee = 40, bullet = 70, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	cold_protection = HEAD
	body_parts_covered = HEAD
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/hczsecurityguard
	name = "\improper Tactical Security Guard Helmet"
	desc = "A tactical Foundation SD Guard helmet."
	icon_state = "helmet"
	armor = list(melee = 40, bullet = 65, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	cold_protection = HEAD
	body_parts_covered = HEAD
	flags_inv = HIDEEARS



/obj/item/clothing/head/helmet/scp/securitystab
	name = "\improper Armored Anti-stab Helmet"
	desc = "An anti-stab SCP Foundation helmet normally issued to detention facility guards."
	icon_state = "guard-helm"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = 70, bullet = 40, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
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
	name = "\improper chaos helmet"
	desc = "A helmet with 'CHAOS INSURGENCY' symbol printed on the back lettering."
	icon_state = "chaos-helm"
	body_parts_covered = HEAD //face shield
	armor = list(melee = 50, bullet = 83, laser = 50,energy = 25, bomb = 40, bio = 10, rad = 10)
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/donor
	name = "\improper tactical helmet"
	desc = "Tactical Helmet."
	icon_state = "donor_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = 50, bullet = 70, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/donor2
	name = "\improper security heavy helmet"
	desc = "Security Helmet."
	icon_state = "donate_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = 50, bullet = 70, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/donor3
	name = "\improper security heavy helmet"
	desc = "Heavy Helmet."
	icon_state = "don_sec"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = 50, bullet = 60, laser = 50,energy = 25, bomb = 30, bio = 10, rad = 10)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR

/obj/item/clothing/head/helmet/scp/eta
	name = "Visored Helmet"
	action_button_name = "Adjust Visor"
	desc = "A anti-memetic helmet with a special visor to deal to visual memetic SCP's."
	icon_state = "eta-helmet-open"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	cold_protection = HEAD|FACE|EYES
	armor = list(melee = 70, bullet = 50, laser = 70, energy = 70, bomb = 30, bio = 15, rad = 10)
	tint = TINT_NONE

/obj/item/clothing/head/helmet/scp/eta/attack_self(mob/user)
	var/action
	if (tint == TINT_BLIND)
		action = "de-activates"
		icon_state = "eta-helmet-open"
		tint = TINT_NONE
	else if (tint == TINT_NONE)
		action = "activates"
		icon_state = "eta-helmet"
		tint = TINT_BLIND
	visible_message(SPAN_ITALIC("\The [user] [action] the visor on the [src]."), range = 3)
	update_clothing_icon()


/obj/item/clothing/head/helmet/scp/beta
	name = "Armored Anti-Biological Hood"
	desc = "A hood combined kevlar and other materials to shield it against biological attacks, radiation and physical harm."
	icon_state = "beta-helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|BLOCKHAIR
	body_parts_covered = HEAD|FACE|EYES
	cold_protection = HEAD|FACE|EYES
	armor = list(melee = 90, bullet = 70, laser = 40, energy = 25, bomb = 50, bio = 90, rad = 90)
