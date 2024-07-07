
//Bartender
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chefhat"
	item_state = "chefhat"
	hidden_from_codex = FALSE

//Captain
/obj/item/clothing/head/caphat
	name = "captain's hat"
	icon_state = "captain"
	desc = "It's good being the king."
	item_state_slots = list(
		slot_l_hand_str = "caphat",
		slot_r_hand_str = "caphat",
		)
	body_parts_covered = 0
	hidden_from_codex = FALSE

/obj/item/clothing/head/caphat/cap
	name = "captain's cap"
	desc = "You fear to wear it for the negligence it brings."
	icon_state = "capcap"

/obj/item/clothing/head/caphat/formal
	name = "parade hat"
	desc = "No one in a commanding position should be without a perfect, white hat of ultimate authority."
	icon_state = "officercap"

//HOP
/obj/item/clothing/head/caphat/hop
	name = "crew resource's hat"
	desc = "A stylish hat that both protects you from enraged former-crewmembers and gives you a false sense of authority."
	icon_state = "hopcap"

//Chaplain
/obj/item/clothing/head/chaplain_hood
	name = "chaplain's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD
	hidden_from_codex = FALSE

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags_inv = BLOCKHAIR
	body_parts_covered = HEAD
	hidden_from_codex = FALSE

//Medical
/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A surgical cap worn by surgeons for the room to be sterile. Keeps the wearer's hair from falling into the open wounds of the patient."
	icon_state = "surgcap"
	flags_inv = BLOCKHEADHAIR
	hidden_from_codex = FALSE

/obj/item/clothing/head/surgery/purple
	name = "purple surgical cap"
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/blue
	name = "blue surgical cap"
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/green
	name = "green surgical cap"
	icon_state = "surgcap_green"

/obj/item/clothing/head/surgery/black
	name = "black surgical cap"
	icon_state = "surgcap_black"

/obj/item/clothing/head/surgery/navyblue
	name = "navy blue surgical cap"
	icon_state = "surgcap_navyblue"

/obj/item/clothing/head/surgery/lilac
	name = "lilac surgical cap"
	color = "#c8a2c8"

/obj/item/clothing/head/surgery/teal
	name = "teal surgical cap"
	color = "#008080"

/obj/item/clothing/head/surgery/heliodor
	name = "heliodor surgical cap"
	color = "#aad539"

//Berets
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, an artists favorite headwear."
	icon_state = "beret"
	body_parts_covered = 0
	hidden_from_codex = FALSE

/obj/item/clothing/head/beret/sec
	name = "Security Officer Beret"
	desc = "Usually worn by superior officers of Foundation SD."
	icon_state = "beret_corporate_red"

/obj/item/clothing/head/beret/sec/navy/officer
	name = "corporate security officer beret"
	desc = "A navy blue beret with an officer's rank emblem. For officers that are more inclined towards style than safety."
	icon_state = "beret_corporate_navy_officer"

/obj/item/clothing/head/beret/sec/navy/hos
	name = "Security Officer Beret"
	desc = "SD issue beret distributed to the officer corps of the Security Department."
	icon_state = "beret_corporate_navy_hos"

/obj/item/clothing/head/beret/sec/navy/warden
	name = "Security Senior Beret"
	desc = "SD issue beret distributed to senior agents and guards."
	icon_state = "beret_corporate_navy_warden"

/obj/item/clothing/head/beret/sec/corporate/officer
	name = "Security Beret"
	desc = "SD issue beret distributed to agents and guards."
	icon_state = "beret_corporate_officer"

/obj/item/clothing/head/beret/sec/corporate/hos
	name = "Security Officer Beret"
	desc = "Issued to SD ranking officers."
	icon_state = "beret_corporate_hos"

/obj/item/clothing/head/beret/sec/corporate/warden
	name = "Security Senior Beret"
	desc = "Issued to SD senior guards, agents and NCO's"
	icon_state = "beret_corporate_warden"

// STARTING NEW SECURITY BERETS //

/obj/item/clothing/head/beret/sec/guard
	name = "Guard Beret"
	desc = "A black beret with a red badge, in the shape of two chevrons, it feels durable due to the materials it's been made from."
	icon_state = "beret_guard"

/obj/item/clothing/head/beret/sec/sergeant
	name = "Non-Commissioned Officer Beret"
	desc = "A black beret with a silver badge, in the shape of three chevrons, it feels durable due to the materials it's been made from."
	icon_state = "beret_sergeant"

/obj/item/clothing/head/beret/sec/commander
	name = "Zone Officer Beret"
	desc = "A black beret with a golden badge in the shape of a shield, it feels durable due to the materials it's been made from."
	icon_state = "beret_commander"

/obj/item/clothing/head/beret/sec/guardcom
	name = "Guard Commander Beret"
	desc = "A white beret with a golden badge in the shape of a shield, it feels durable due to the materials it's been made from."
	icon_state = "beret_guardcom"

// ENDING NEW SECURITY BERETS //

/obj/item/clothing/head/beret/goc
	name = "Global Occult Coalition Beret"
	desc = "A cyan beret with a golden Global Occult Coalition badge on the front, smells of lead."
	icon_state = "goc-beret"

/obj/item/clothing/head/beret/goc/lead
	name = "Global Occult Coalition Leader Beret"
	desc = "A dark blue beret with a white United Nations badge on the front, smells of bad decisions."
	icon_state = "goc_lead_beret"
	armor = list(melee = 50, bullet = 80, laser = 50,energy = 25, bomb = 50, bio = 50, rad = 60)

/obj/item/clothing/head/beret/isd
	name = "Internal Security field cap"
	desc = "A dull black cap. It has ISD in white printed on it on the front. Used by the Internal Security Department. It's padded with some extreme armor."
	icon_state = "isd_cap"
	armor = list(melee = 50, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 50, rad = 60)
	body_parts_covered = HEAD

/obj/item/clothing/head/beret/isd/fedora
	name = "Internal Security fedora"
	desc = "A fancy black fedora with a red strap along it. Used by the Internal Security Department. It's padded with some extreme armor."
	icon_state = "isd_fedora"

/obj/item/clothing/head/beret/mtf
	name = "'Nine Tailed Fox' tactical beret"
	desc = "A heavy padded beret used by MTF Epsilon-11, it's quite armored, more than traditional helmets."
	icon_state = "beret_epsilon11"
	permeability_coefficient = 0
	gas_transfer_coefficient = 0
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	max_pressure_protection = FIRESUIT_MAX_PRESSURE
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_PHORONGUARD|ITEM_FLAG_AIRTIGHT
	armor = list(melee = 90, bullet = 90, laser = 50,energy = 25, bomb = 50, bio = 50, rad = 60)
	cold_protection = HEAD
	item_flags = ITEM_FLAG_THICKMATERIAL|ITEM_FLAG_AIRTIGHT
	body_parts_covered = HEAD|FACE|EYES

/obj/item/clothing/head/beret/mtf/alpha
	name = "'Red Right Hand' tactical beret"
	desc = "A heavy padded beret used by MTF Alpha-1, it's quite armored, more than traditional helmets."
	icon_state = "beret_alpha1"

/obj/item/clothing/head/beret/mtf/omega
	name = "'Laws Left Hand' tactical beret"
	desc = "A heavy padded beret used by MTF Omega-1, it's quite armored, more than traditional helmets."
	icon_state = "beret_omega1"

/obj/item/clothing/head/beret/engineering
	name = "corporate engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety."
	icon_state = "beret_orange"

/obj/item/clothing/head/beret/purple
	name = "purple beret"
	desc = "A stylish, if purple, beret. For personnel that are more inclined towards style than safety."
	icon_state = "beret_purple"

/obj/item/clothing/head/beret/centcom/officer
	name = "asset protection beret"
	desc = "A navy blue beret adorned with the crest of corporate asset protection. For asset protection agents that are more inclined towards style than safety."
	icon_state = "beret_corporate_navy"

/obj/item/clothing/head/beret/centcom/captain
	name = "asset protection command beret"
	desc = "A white beret adorned with the crest of corporate asset protection. For asset protection leaders that are more inclined towards style than safety."
	icon_state = "beret_corporate_white"

/obj/item/clothing/head/beret/deathsquad
	name = "heavy asset protection beret"
	desc = "An armored red beret adorned with the crest of corporate asset protection. Doesn't sacrifice style or safety."
	icon_state = "beret_red"
	armor = list(
		melee = ARMOR_MELEE_VERY_HIGH,
		bullet = ARMOR_BALLISTIC_RIFLE,
		laser = ARMOR_LASER_HANDGUNS,
		energy = ARMOR_ENERGY_SMALL,
		bomb = ARMOR_BOMB_PADDED,
		bio = ARMOR_BIO_RESISTANT,
		rad = ARMOR_RAD_MINOR
	)
	siemens_coefficient = 0.9

/obj/item/clothing/head/beret/guard
	name = "corporate security beret"
	desc = "A white beret adorned with a corporate logo. For security guards that are more inclined towards style than safety."
	icon_state = "corpsec_beret"

/obj/item/clothing/head/beret/plaincolor
	name = "beret"
	desc = "A simple, solid color beret. This one has no emblems or insignia on it."
	icon_state = "beret_white"
