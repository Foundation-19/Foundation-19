//TORCH NanoTrasen Uniforms - DO NOT ADD NEW UNIFORMS TO UNIFORM.DMI - TORCH NANOTRASEN UNIFORMS GO IN NANOTRASEN.DMI

/obj/item/clothing/under/rank/guard
	desc = "A durable uniform worn by Foundation corporate security."
	name = "\improper Foundation security uniform"
	icon_state = "ntguard"
	item_state = "r_suit"
	worn_state = "ntguard"
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/nanotrasen.dmi')
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/Unathi/nanotrasen.dmi',
		)

/obj/item/clothing/under/rank/scientist
	name = "\improper Foundation polo and pants"
	desc = "A fashionable polo and pair of trousers made from patented biohazard-resistant synthetic fabrics. The colors denote the wearer as a member of the Foundation."
	icon_state = "ntsmock"
	item_state = "w_suit"
	worn_state = "ntsmock"
	permeability_coefficient = 0.50
	armor = list(melee = 0, bullet = 0, laser = 0,energy = 0, bomb = 10, bio = 0, rad = 0)
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/nanotrasen.dmi')
	starting_accessories = list(/obj/item/clothing/accessory/nt_tunic)
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/Unathi/nanotrasen.dmi',
		)

/obj/item/clothing/under/rank/scientist/executive
	name = "\improper Foundation executive polo and pants"
	desc = "A fashionable polo and pair of trousers made from expensive biohazard-resistant fabrics. The colors denote the wearer as a member of the Foundation's higher-ups."
	icon_state = "ntsmockexec"
	worn_state = "ntsmockexec"
	starting_accessories = list(/obj/item/clothing/accessory/nt_tunic/exec)

/obj/item/clothing/under/rank/ntwork
	name = "\improper Foundation coveralls"
	desc = "A pair of beige coveralls made out of a strong, canvas-like material. The coloring on the fringes denotes it as a Foundation-branded suit, typically given to their more blue-collared employees."
	icon_state = "ntwork"
	item_state = "lb_suit"
	worn_state = "ntwork"
	armor = list(melee = 5, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 5, rad = 0)
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/nanotrasen.dmi')
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/Unathi/nanotrasen.dmi',
		)

/obj/item/clothing/under/rank/ntpilot
	name = "\improper Foundation flightsuit"
	desc = "A sleek dark red Foundation flightsuit. It proudly sports three different patches with the Foundation logo on it, as well as several unnecessary looking flaps and pockets for effect."
	icon_state = "ntpilot"
	item_state = "r_suit"
	worn_state = "ntpilot"
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/nanotrasen.dmi')
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/Unathi/nanotrasen.dmi',
		)

/obj/item/clothing/under/suit_jacket/nt
	name = "\improper Foundation executive suit"
	desc = "A suit that the Foundation gives to its executives."
	icon_state = "ntsuit"
	item_state = "bl_suit"
	worn_state = "ntsuit"
	item_icons = list(slot_w_uniform_str = 'icons/mob/onmob/nanotrasen.dmi')
	starting_accessories = list(/obj/item/clothing/accessory/toggleable/nanotrasen_jacket, /obj/item/clothing/accessory/nt)
	sprite_sheets = list(
		SPECIES_UNATHI = 'icons/mob/onmob/Unathi/nanotrasen.dmi',
		)
