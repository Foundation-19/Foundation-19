/obj/item/clothing/head/goc
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/head/scp
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

//Utility
/obj/item/clothing/head/soft/goc
	name = "\improper United Nations cap"
	desc = "It's a ballcap in UN colors."
	icon_state = "solsoft"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')

/obj/item/clothing/head/soft/goc/ptolemy
	name = "\improper GOC PTOLEMY cap"
	desc = "It's a black ballcap bearing the GOC's PTOLEMY divisional crest."
	icon_state = "expeditionsoft"

/obj/item/clothing/head/soft/goc/nexus
	name = "\improper UNGOC NEXUS command cap"
	desc = "It's a black ballcap bearing the GOC's NEXUS divisional crest. The brim has gold trim."
	icon_state = "expeditioncomsoft"

/obj/item/clothing/head/soft/goc/physics
	name = "GOC PHYSICS cap"
	desc = "It's a navy blue ballcap with the GOC's PHYSICS divisional crest."
	icon_state = "fleetsoft"

/obj/item/clothing/head/goc/utility
	name = "utility cover"
	desc = "An eight-point utility cover."
	icon_state = "greyutility"
	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet",
		)
	body_parts_covered = 0

/obj/item/clothing/head/goc/utility/ptolemy
	name = "PTOLEMY utility cover"
	desc = "A navy blue utility cover bearing the crest of the GOC's PTOLEMY division."
	icon_state = "navyutility"

/obj/item/clothing/head/goc/utility/physics
	name = "PHYSICS utility cover"
	desc = "A green utility cover bearing the crest of the GOC's PHYSICS division."
	icon_state = "greenutility"

/obj/item/clothing/head/goc/utility/physics/tan
	name = "PHYSICS tan utility cover"
	desc = "A tan utility cover bearing the crest of the GOC's PHYSICS division."
	icon_state = "tanutility"

/obj/item/clothing/head/goc/utility/physics/urban
	name = "PHYSICS urban utility cover"
	desc = "A grey utility cover bearing the crest of the GOC's PHYSICS division."
	icon_state = "greyutility"

//Service

/obj/item/clothing/head/goc/service
	name = "service cover"
	desc = "A service uniform cover."
	icon_state = "greenwheelcap"
	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet")
	body_parts_covered = 0

/obj/item/clothing/head/goc/service/ptolemy
	name = "PTOLEMY peaked cap"
	desc = "A peaked grey uniform cap belonging to the GOC's PTOLEMY division."
	icon_state = "greydresscap"

/obj/item/clothing/head/goc/service/ptolemy/command
	name = "PTOLEMY quartermaster's peaked cap"
	desc = "A peaked grey uniform cap belonging to the GOC's PTOLEMY divison. This one is trimmed in gold."
	icon_state = "greydresscap_com"

/obj/item/clothing/head/goc/service/physics
	name = "PHYSICS wheel cover"
	desc = "A green service uniform cover with an GOC PHYSICS divisional crest."
	icon_state = "greenwheelcap"

/obj/item/clothing/head/goc/service/physics/command
	name = "GOC officer's wheel cover"
	desc = "A green service uniform cover with an GOC PHYSICS divisional crest and gold stripe."
	icon_state = "greenwheelcap_com"

/obj/item/clothing/head/goc/service/physics/garrison
	name = "GOC garrison cap"
	desc = "A green garrison cap belonging to the GOC'S PHYSICS divison."
	icon_state = "greengarrisoncap"

/obj/item/clothing/head/goc/service/physics/garrison/command
	name = "GOC officer's garrison cap"
	desc = "A green garrison cap belonging to the GOC's PHYSICS divison. This one has a gold pin."
	icon_state = "greengarrisoncap_com"

/obj/item/clothing/head/goc/service/physics/campaign
	name = "campaign cover"
	desc = "A green campaign cover with an GOC PHYSICS divisional crest. Only found on the heads of Drill Instructors."
	icon_state = "greendrill"

//Dress

/obj/item/clothing/head/goc/dress
	name = "dress cover"
	desc = "A dress uniform cover."
	icon_state = "greenwheelcap"
	item_state_slots = list(
		slot_l_hand_str = "helmet",
		slot_r_hand_str = "helmet")
	body_parts_covered = 0

/obj/item/clothing/head/goc/dress/ptolemy
	name = "PTOLEMY dress wheel cover"
	desc = "A white dress uniform cover. This one has an GOC PTOLEMY divisional crest."
	icon_state = "whitepeakcap"

/obj/item/clothing/head/goc/dress/nexus
	name = "NEXUS officer's dress wheel cover"
	desc = "A white dress uniform cover. This one has a gold stripe and a NEXUS divisional crest."
	icon_state = "whitepeakcap_com"

/obj/item/clothing/head/goc/dress/physics
	name = "PHYSICS dress wheel cover"
	desc = "A white dress uniform cover with an GOC PHYSICS divisional crest."
	icon_state = "whitewheelcap"

/obj/item/clothing/head/goc/dress/physics/command
	name = "PHYSICS officer's dress wheel cover"
	desc = "A white dress uniform cover with an GOC PHYSICS divisional crest and gold stripe."
	icon_state = "whitewheelcap_com"

//Berets

/obj/item/clothing/head/beret/solgov
	name = "peacekeeper beret"
	desc = "A beret in UN colors. For peacekeepers that are more inclined towards style than safety."
	icon_state = "beret_lightblue"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')

/obj/item/clothing/head/beret/solgov/homeguard
	name = "home guard beret"
	desc = "A red beret denoting service in the Sol Home Guard. For personnel that are more inclined towards style than safety."
	icon_state = "beret_red"

/obj/item/clothing/head/beret/solgov/gateway
	name = "gateway administration beret"
	desc = "An orange beret denoting service in the Gateway Administration. For personnel that are more inclined towards style than safety."
	icon_state = "beret_orange"

/obj/item/clothing/head/beret/solgov/customs
	name = "customs and trade beret"
	desc = "A purple beret denoting service in the Customs and Trade Bureau. For personnel that are more inclined towards style than safety."
	icon_state = "beret_purpleyellow"

/obj/item/clothing/head/beret/solgov/orbital
	name = "orbital assault beret"
	desc = "A blue beret denoting orbital assault training. For helljumpers that are more inclined towards style than safety."
	icon_state = "beret_blue"

/obj/item/clothing/head/beret/solgov/research
	name = "GOC research beret"
	desc = "A green beret denoting service in the GOC's PTOLEMY division. For explorers that are more inclined towards style than safety."
	icon_state = "beret_green"

/obj/item/clothing/head/beret/solgov/health
	name = "health service beret"
	desc = "A white beret denoting service in the World Parahealth Organization. For medics that are more inclined towards style than safety."
	icon_state = "beret_white"

/obj/item/clothing/head/beret/solgov/marcom
	name = "\improper Guard Commander Beret"
	desc = "A red beret with a gold insignia issued to the highest ranked SD commander of a Foundation site or area.."
	icon_state = "beret_redgold"

/obj/item/clothing/head/beret/solgov/stratcom
	name = "\improper STRATCOM beret"
	desc = "A grey beret with a silver insignia, denoting service in the GOC Strategic Command. For intelligence personnel who are more inclined towards style than safety."
	icon_state = "beret_graysilver"

/obj/item/clothing/head/beret/solgov/diplomatic
	name = "diplomatic security beret"
	desc = "A tan beret denoting service in the GOC's PSYCHE Diplomatic Security Group. For security personnel who are more inclined towards style than safety."
	icon_state = "beret_tan"

/obj/item/clothing/head/beret/solgov/borderguard
	name = "border security beret"
	desc = "A green beret with a silver emblem, denoting service in the Bureau of Border Security. For border guards who are more inclined towards style than safety."
	icon_state = "beret_greensilver"

/obj/item/clothing/head/beret/solgov/expedition
	name = "expeditionary beret"
	desc = "A black beret belonging to the SCG Expeditionary Corps. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black"

/obj/item/clothing/head/beret/solgov/expedition/security
	name = "expeditionary security beret"
	desc = "An SCG Expeditionary Corps beret with a security crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_security"

/obj/item/clothing/head/beret/solgov/expedition/medical
	name = "expeditionary medical beret"
	desc = "An SCG Expeditionary Corps beret with a medical crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_medical"

/obj/item/clothing/head/beret/solgov/expedition/engineering
	name = "expeditionary engineering beret"
	desc = "An SCG Expeditionary Corps beret with an engineering crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_engineering"

/obj/item/clothing/head/beret/solgov/expedition/supply
	name = "expeditionary supply beret"
	desc = "An SCG Expeditionary Corps beret with a supply crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_supply"

/obj/item/clothing/head/beret/solgov/expedition/service
	name = "expeditionary service beret"
	desc = "An SCG Expeditionary Corps beret with a service crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_service"

/obj/item/clothing/head/beret/solgov/expedition/exploration
	name = "expeditionary exploration beret"
	desc = "An SCG Expeditionary Corps beret with an exploration crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_exploration"

/obj/item/clothing/head/beret/solgov/expedition/command
	name = "expeditionary officer's beret"
	desc = "An SCG Expeditionary Corps beret with a golden crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_black_command"

/obj/item/clothing/head/beret/solgov/fleet
	name = "fleet beret"
	desc = "A navy blue beret belonging to the SCG Fleet. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy"

/obj/item/clothing/head/beret/solgov/fleet/security
	name = "fleet security beret"
	desc = "An SCG Fleet beret with a security crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_security"

/obj/item/clothing/head/beret/solgov/fleet/medical
	name = "fleet medical beret"
	desc = "An SCG Fleet beret with a medical crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_medical"

/obj/item/clothing/head/beret/solgov/fleet/engineering
	name = "fleet engineering beret"
	desc = "An SCG Fleet with an engineering crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_engineering"

/obj/item/clothing/head/beret/solgov/fleet/supply
	name = "fleet supply beret"
	desc = "An SCG Fleet beret with a supply crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_supply"

/obj/item/clothing/head/beret/solgov/fleet/service
	name = "fleet service beret"
	desc = "An SCG Fleet beret with a service crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_service"

/obj/item/clothing/head/beret/solgov/fleet/exploration
	name = "fleet exploration beret"
	desc = "An SCG Fleet beret with an exploration crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_exploration"

/obj/item/clothing/head/beret/solgov/fleet/command
	name = "fleet officer's beret"
	desc = "An SCG Fleet beret with a golden crest. For personnel that are more inclined towards style than safety."
	icon_state = "beret_navy_command"

//ushanka

/obj/item/clothing/head/ushanka/goc
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')

/obj/item/clothing/head/ushanka/goc/ptolemy
	name = "PTOLEMY fur hat"
	desc = "An GOC PTOLEMY synthfur-lined hat for operating in cold environments."
	icon_state = "ecushankadown"
	icon_state_up = "ecushankaup"

/obj/item/clothing/head/ushanka/goc/fleet
	name = "GOC NEXUS fur hat"
	desc = "An GOC NEXUS synthfur-lined hat for operating in cold environments."
	icon_state = "flushankadown"
	icon_state_up = "flushankaup"

/obj/item/clothing/head/ushanka/goc/marine
	name = "PHYSICS fur hat"
	desc = "An GOC PHYSICS synthfur-lined hat for operating in cold environments."
	icon_state = "bmcushankadown"
	icon_state_up = "bmcushankaup"

/obj/item/clothing/head/ushanka/goc/marine/green
	name = "green PHYSICS fur hat"
	desc = "An GOC PHYSICS synthfur-lined hat for operating in cold environments."
	icon_state = "mcushankadown"
	icon_state_up = "mcushankaup"

//FOUNDATION
/obj/item/clothing/head/helmet/site53/guard
	name = "guard's helmet"
	desc = "A helmet with 'GUARD' printed on the back in red lettering."
	icon_state = "helmet_pcrc"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
	accessories = null

/obj/item/clothing/head/helmet/site53/guardcomm
	name = "guard commander's helmet"
	desc = "A helmet with 'GUARD COMMANDER' printed on the back in gold lettering."
	icon_state = "helmet_command"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
	accessories = null

/obj/item/clothing/head/scp/service/site53
	name = "service cap"
	desc = "A grey garrison cap, with the SCP Foundation logo in the interior. A purple insignia is on it's crest."
	icon_state = "service_co_cap"
	item_state = "service_co_cap_om"

//MTF
/obj/item/clothing/head/helmet/site53/zonecomm
	name = "zone commander's helmet"
	desc = "A helmet with 'ZONE COMMANDER' printed on the back in silver lettering."
	icon_state = "helmet_security"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
	accessories = null

/obj/item/clothing/head/helmet/site53/guard/mtf_epsilon
	name = "MTF Epsilon-6 helmet"
	desc = "A helmet with 'MTF Epsilon-6' printed on the back in red lettering."
	icon_state = "helmet_command"
	icon = 'maps/torch/icons/obj/solgov-head.dmi'
	item_icons = list(slot_head_str = 'maps/torch/icons/mob/solgov-head.dmi')
//	accessories = list(/obj/item/clothing/accessory/armor/helmcover/green)

/obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/leader
//	accessories = list(/obj/item/clothing/accessory/armor/helmcover/saare)

/obj/item/clothing/head/helmet/site53/guard/mtf_epsilon/medic
//	accessories = list(/obj/item/clothing/accessory/armor/helmcover/nt)

/obj/item/clothing/head/beret/scp/alpha
	name = "Alpha-1 beret"
	desc = "A dark red beret worn by members of the 'Red Right Hand' MTF unit, it feels kind of heavy for a beret."
	icon_state = "alpha-beret"
	item_state = "alpha-beret"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_SHIELDED, bullet = ARMOR_BALLISTIC_AP, laser = ARMOR_LASER_HEAVY, energy = ARMOR_ENERGY_SHIELDED, bomb = ARMOR_BOMB_SHIELDED, bio = ARMOR_BIO_SHIELDED, rad = 0)

//GOC
/obj/item/clothing/head/helmet/scp/goc
	name = "Global Occult Coalition helmet"
	desc = "A cyan standard issue helmet, with the United Nations' initials on the front. A lightweight helmet for their military forces."
	icon_state = "goc_helm"
	item_state = "goc_helm"
	body_parts_covered = HEAD
	armor = list(melee = ARMOR_MELEE_VVRESISTANT, bullet = ARMOR_BALLISTIC_RIFLE, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED)
	flags_inv = HIDEEARS

/obj/item/clothing/head/helmet/scp/security/goc
	name = "Global Occult Coalition heavy helmet"
	desc = "A cyan helmet with an added bulletproof visor, with the United Nations' initials on the front. A lightweight helmet for their superior military forces ranks."
	icon_state = "goc_helmet"
	body_parts_covered = HEAD|FACE|EYES //face shield
	armor = list(melee = ARMOR_MELEE_MAJOR, bullet = ARMOR_BALLISTIC_HEAVY, laser = ARMOR_LASER_MAJOR, energy = ARMOR_ENERGY_SMALL, bomb = ARMOR_BOMB_PADDED, bio = ARMOR_BIO_MINOR, rad = ARMOR_RAD_MINOR)
	acid_resistance = 1.5
	flags_inv = HIDEEARS
	action_button_name = "Toggle Visor"

/obj/item/clothing/head/beret/scp/goc
	name = "GOC beret"
	desc = "A light blue beret with a officer's rank emblem. For officers that are more inclined towards style than safety."
	icon_state = "goc-beret"
	item_state = "goc-beret"
