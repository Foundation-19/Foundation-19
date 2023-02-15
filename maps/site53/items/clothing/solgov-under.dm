/obj/item/clothing/under/solgov
	name = "master solgov uniform"
	desc = "You shouldn't be seeing this."
	icon = 'maps/torch/icons/obj/solgov-under.dmi'
	item_icons = list(slot_w_uniform_str = 'maps/torch/icons/mob/solgov-under.dmi')
	armor = list(melee = 5, bullet = 0, laser = 5, energy = 5, bomb = 0, bio = 5, rad = 5)
	siemens_coefficient = 0.8

//PT
/obj/item/clothing/under/solgov/pt
	name = "pt uniform"
	desc = "Shorts! Shirt! Miami! Sexy!"
	icon_state = "miami"
	worn_state = "miami"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/solgov/pt/expeditionary
	name = "expeditionary pt uniform"
	desc = "A baggy shirt bearing the seal of the SCG Expeditionary Corps and some dorky looking blue shorts."
	icon_state = "expeditionpt"
	worn_state = "expeditionpt"

/obj/item/clothing/under/solgov/pt/fleet
	name = "fleet pt uniform"
	desc = "A pair of black shorts and two tank tops, seems impractical. Looks good though."
	icon_state = "fleetpt"
	worn_state = "fleetpt"

/obj/item/clothing/under/solgov/pt/marine
	name = "marine pt uniform"
	desc = "Does NOT leave much to the imagination."
	icon_state = "marinept"
	worn_state = "marinept"

// SCP Stuff

/obj/item/clothing/under/scp/utility
	desc = "A dark black uniform. This one seems to be without department insignia. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "utility uniform"
	icon = 'maps/torch/icons/obj/solgov-under.dmi'
	item_icons = list(slot_w_uniform_str = 'maps/torch/icons/mob/solgov-under.dmi')
	icon_state = "scpuniform"
	worn_state = "uniform"

/obj/item/clothing/under/scp/utility/security
	desc = "A dark black uniform. This one seems to be of the Security department. This uniform is issued to ranked personnel lower than Lieutenant. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "security uniform"
	icon_state = "scpuniform2"
	worn_state = "uniform_s"

/obj/item/clothing/under/scp/utility/security/zc
	desc = "A dark black uniform. This one seems to be of the Security department. This uniform is issued to ranked personnel of Lieutenant. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "zone commander uniform"
	icon_state = "scpuniform"
	worn_state = "uniform_zc"

/obj/item/clothing/under/scp/utility/security/gc
	desc = "A dark black uniform. This one seems to be of the Security department. This uniform is issued to ranked personnel above Lieutenant. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "guard commander uniform"
	icon_state = "scpuniform"
	worn_state = "uniform_gc"

/obj/item/clothing/under/scp/utility/medical
	desc = "A dark black uniform. This one seems to be of the Medical department. This uniform is issued regardless of rank. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "medical uniform"
	icon_state = "scpuniform2"
	worn_state = "uniform_m"

/obj/item/clothing/under/scp/utility/engineering
	desc = "A dark black uniform. This one seems to be of the Engineering department. This uniform is issued regardless of rank. On the back, in silver lettering, are the words 'SCP FOUNDATION'."
	name = "engineering uniform"
	icon_state = "scpuniform"
	worn_state = "uniform_e"

/obj/item/clothing/under/scp/utility/logistics
	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
	name = "logistics specialist uniform"
	icon_state = "scpuniform"
	worn_state = "Uniform_LS"

/obj/item/clothing/under/scp/utility/logistics/officer
	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
	name = "logistics officer uniform"
	icon_state = "scpuniform"
	worn_state = "Uniform_LO"

/obj/item/clothing/under/scp/utility/communications/tech
	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
	name = "communications technician uniform"
	icon_state = "scpuniform"
	worn_state = "Uniform_CT"

// /obj/item/clothing/under/scp/foundation_service_m
// 	name = "service uniform"
// 	desc = "A light grey uniform. It appears to be a Class B Service Dress uniform, however refitted and recolored to match the Foundation. This one appears to have a stylish pair of trousers."
// 	item_state = "service_co"
// 	icon_state = "service_co"
// 	worn_state = "service_co"
// 	rolled_sleeves = 0

// /obj/item/clothing/under/scp/foundation_service_f
// 	name = "service skirt"
// 	desc = "A light grey uniform. It appears to be a Class B Service Dress uniform, however refitted and recolored to match the Foundation. This one appears to have a skirt."
// 	item_state = "fservice_co"
// 	icon_state = "fservice_co"
// 	worn_state = "fservice_co"
// 	rolled_sleeves = 0

// /obj/item/clothing/under/scp/foundation_work
// 	name = "work uniform"
// 	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
// 	item_state = "Uniform_CT_s"
// 	icon_state = "Uniform_CT_s"
// 	worn_state = "Uniform_CT_s"

// /obj/item/clothing/under/scp/foundation_work_lo
// 	name = "logistics officer's work uniform"
// 	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
// 	icon_state = "Uniform_LO_s"
// 	item_state = "Uniform_LO_s"
// 	worn_state = "Uniform_LO_s"

// /obj/item/clothing/under/scp/foundation_work_ls
// 	name = "logistics specialist's work uniform"
// 	desc = "A dark gray work uniform marked clearly with the Foundation symbol."
// 	icon_state = "Uniform_LS_s"
// 	item_state = "Uniform_LS_s"
// 	worn_state = "Uniform_LS_s"

/obj/item/clothing/under/scp/utility/communications/officer
	desc = "A light grey uniform. It appears to be a Class B Service Dress uniform, however refitted and recolored to match the Foundation. This one appears to have a stylish pair of trousers."
	name = "communications officer uniform"
	icon_state = "communiform_m"
	worn_state = "com_uniform_m"

/obj/item/clothing/under/scp/utility/communications/officerfem
	desc = "A light grey uniform. It appears to be a Class B Service Dress uniform, however refitted and recolored to match the Foundation. This one appears to have a skirt."
	name = "communications officer uniform"
	icon_state = "communiform_f"
	worn_state = "com_uniform_f"
	rolled_sleeves = 0

//Utility

/obj/item/clothing/under/solgov/utility
	name = "utility uniform"
	desc = "A comfortable turtleneck and black utility trousers."
	icon_state = "blackutility"
	item_state = "bl_suit"
	worn_state = "blackutility"
	sprite_sheets = list(
		SPECIES_TAJARA = 'icons/mob/species/tajaran/uniform.dmi'
		)

/obj/item/clothing/under/solgov/utility/expeditionary
	name = "expeditionary uniform"
	desc = "The utility uniform of the SCG Expeditionary Corps, made from biohazard resistant material. This one has silver trim."
	icon_state = "blackutility_crew"
	worn_state = "blackutility_crew"
	sprite_sheets = list(
		SPECIES_TAJARA = 'icons/mob/species/tajaran/uniform.dmi'
		)

/obj/item/clothing/under/solgov/utility/expeditionary_skirt
	name = "expeditionary skirt"
	desc = "A black turtleneck and skirt, the elusive ladies' uniform of the Expeditionary Corps."
	icon_state = "blackservicef"
	worn_state = "blackservicef"
	sprite_sheets = list(
		SPECIES_TAJARA = 'icons/mob/species/tajaran/uniform.dmi'
		)

/obj/item/clothing/under/solgov/utility/expeditionary_skirt/officer
	name = "expeditionary officer skirt"
	desc = "A black turtleneck and skirt, the elusive ladies' uniform of the Expeditionary Corps. This one has gold trim."
	icon_state = "blackservicef_com"
	worn_state = "blackservicef_com"

/obj/item/clothing/under/solgov/utility/expeditionary/command
	accessories = list(/obj/item/clothing/accessory/solgov/department/command)

/obj/item/clothing/under/solgov/utility/expeditionary/engineering
	accessories = list(/obj/item/clothing/accessory/solgov/department/engineering)

/obj/item/clothing/under/solgov/utility/expeditionary/security
	accessories = list(/obj/item/clothing/accessory/solgov/department/security)

/obj/item/clothing/under/solgov/utility/expeditionary/medical
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical)

/obj/item/clothing/under/solgov/utility/expeditionary/supply
	accessories = list(/obj/item/clothing/accessory/solgov/department/supply)

/obj/item/clothing/under/solgov/utility/expeditionary/service
	accessories = list(/obj/item/clothing/accessory/solgov/department/service)

/obj/item/clothing/under/solgov/utility/expeditionary/exploration
	accessories = list(/obj/item/clothing/accessory/solgov/department/exploration)

/obj/item/clothing/under/solgov/utility/expeditionary/officer
	name = "expeditionary officer's uniform"
	desc = "The utility uniform of the SCG Expeditionary Corps, made from biohazard resistant material. This one has gold trim."
	icon_state = "blackutility_com"
	worn_state = "blackutility_com"

/obj/item/clothing/under/solgov/utility/expeditionary/officer/command
	accessories = list(/obj/item/clothing/accessory/solgov/department/command)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/engineering
	accessories = list(/obj/item/clothing/accessory/solgov/department/engineering)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/security
	accessories = list(/obj/item/clothing/accessory/solgov/department/security)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/medical
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/supply
	accessories = list(/obj/item/clothing/accessory/solgov/department/supply)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/service
	accessories = list(/obj/item/clothing/accessory/solgov/department/service)

/obj/item/clothing/under/solgov/utility/expeditionary/officer/exploration
	accessories = list(/obj/item/clothing/accessory/solgov/department/exploration)

/obj/item/clothing/under/solgov/utility/fleet
	name = "utility coveralls"
	desc = "The utility uniform of the SCP Foundation, made from an insulated material."
	icon_state = "navyutility"
	item_state = "jensensuit"
	worn_state = "navyutility"

/obj/item/clothing/under/solgov/utility/fleet/command
	accessories = list(/obj/item/clothing/accessory/solgov/department/command/fleet)

/obj/item/clothing/under/solgov/utility/fleet/command/pilot
	accessories = list(/obj/item/clothing/accessory/solgov/speciality/pilot)

/obj/item/clothing/under/solgov/utility/fleet/engineering
	accessories = list(/obj/item/clothing/accessory/solgov/department/engineering/fleet)

/obj/item/clothing/under/solgov/utility/fleet/security
	accessories = list(/obj/item/clothing/accessory/solgov/department/security/fleet)

/obj/item/clothing/under/solgov/utility/fleet/medical
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical/fleet)

/obj/item/clothing/under/solgov/utility/fleet/supply
	accessories = list(/obj/item/clothing/accessory/solgov/department/supply/fleet)

/obj/item/clothing/under/solgov/utility/fleet/service
	accessories = list(/obj/item/clothing/accessory/solgov/department/service/fleet)

/obj/item/clothing/under/solgov/utility/fleet/exploration
	accessories = list(/obj/item/clothing/accessory/solgov/department/exploration/fleet)

/obj/item/clothing/under/solgov/utility/fleet/combat
	name = "fleet fatigues"
	desc = "Alternative utility uniform of the Foundation, for when coveralls are impractical."
	icon_state = "navycombat"
	worn_state = "navycombat"

/obj/item/clothing/under/solgov/utility/fleet/combat/security
	accessories = list(/obj/item/clothing/accessory/solgov/department/security/fleet)

/obj/item/clothing/under/solgov/utility/fleet/combat/medical
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical/fleet, /obj/item/clothing/accessory/armband/medblue)


/obj/item/clothing/under/solgov/utility/marine
	name = "security fatigues"
	desc = "The utility uniform of the Security Branch, made from durable material."
	icon_state = "greenutility"
	item_state = "jensensuit"
	worn_state = "greenutility"

/obj/item/clothing/under/solgov/utility/marine/command
	accessories = list(/obj/item/clothing/accessory/solgov/department/command/marine)

/obj/item/clothing/under/solgov/utility/marine/engineering
	accessories = list(/obj/item/clothing/accessory/solgov/department/engineering/marine)

/obj/item/clothing/under/solgov/utility/marine/security
	accessories = list(/obj/item/clothing/accessory/solgov/department/security/marine)

/obj/item/clothing/under/solgov/utility/marine/medical
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical/marine)

/obj/item/clothing/under/solgov/utility/marine/medical/banded
	accessories = list(/obj/item/clothing/accessory/solgov/department/medical/marine, /obj/item/clothing/accessory/armband/medblue)

/obj/item/clothing/under/solgov/utility/marine/supply
	accessories = list(/obj/item/clothing/accessory/solgov/department/supply/marine)

/obj/item/clothing/under/solgov/utility/marine/service
	accessories = list(/obj/item/clothing/accessory/solgov/department/service/marine)

/obj/item/clothing/under/solgov/utility/marine/exploration
	accessories = list(/obj/item/clothing/accessory/solgov/department/exploration/marine)

/obj/item/clothing/under/solgov/utility/marine/urban
	name = "urban fatigues"
	desc = "An urban version of the marine utility uniform, made from durable material."
	icon_state = "greyutility"
	item_state = "gy_suit"
	worn_state = "greyutility"

/obj/item/clothing/under/solgov/utility/marine/tan
	name = "tan fatigues"
	desc = "Foundation issue utility jumpsuit, normally assigned to Logistic Department staff."
	icon_state = "tanutility"
	item_state = "johnny"
	worn_state = "tanutility"

//Service

/obj/item/clothing/under/solgov/service
	name = "service uniform"
	desc = "A service uniform of some kind."
	icon_state = "whiteservice"
	worn_state = "whiteservice"
	armor = list(melee = 5, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 5, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/solgov/service/expeditionary
	name = "expeditionary service uniform"
	desc = "The service uniform of the SCG Expeditionary Corps in silver trim."
	icon_state = "greydress"
	worn_state = "greydress"

/obj/item/clothing/under/solgov/service/expeditionary/skirt
	name = "expeditionary service skirt"
	desc = "A feminine version of the SCG Expeditionary Corps service uniform in silver trim."
	icon_state = "greydressfem"
	worn_state = "greydressfem"

/obj/item/clothing/under/solgov/service/expeditionary/command
	name = "expeditionary officer's service uniform"
	desc = "The service uniform of the SCG Expeditionary Corps in gold trim."
	icon_state = "greydress_com"
	worn_state = "greydress_com"

/obj/item/clothing/under/solgov/service/expeditionary/command/skirt
	name = "expeditionary officer's service skirt"
	desc = "A feminine version of the SCG Expeditionary Corps service uniform in gold trim."
	icon_state = "greydressfem_com"
	worn_state = "greydressfem_com"

/obj/item/clothing/under/solgov/service/fleet
	name = "fleet service uniform"
	desc = "The service uniform of the SCG Fleet, made from immaculate white fabric."
	icon_state = "whiteservice"
	item_state = "nursesuit"
	worn_state = "whiteservice"
	accessories = list(/obj/item/clothing/accessory/navy)

/obj/item/clothing/under/solgov/service/fleet/skirt
	name = "fleet service skirt"
	desc = "The service uniform skirt of the SCG Fleet, made from immaculate white fabric."
	icon_state = "whiteservicefem"
	worn_state = "whiteservicefem"

/obj/item/clothing/under/solgov/service/marine
	name = "marine service uniform"
	desc = "The service uniform of the SCG Marine Corps. Slimming."
	icon_state = "greenservice"
	item_state = "johnny"
	worn_state = "greenservice"
	accessories = list(/obj/item/clothing/accessory/brown)

/obj/item/clothing/under/solgov/service/marine/skirt
	name = "marine service skirt"
	desc = "The service uniform skirt of the SCG Marine Corps. Slimming."
	icon_state = "greenservicefem"
	worn_state = "greenservicefem"

/obj/item/clothing/under/solgov/service/marine/command
	name = "marine officer's service uniform"
	desc = "The service uniform of the SCG Marine Corps. Slimming and stylish."
	icon_state = "greenservice_com"
	item_state = "johnny"
	worn_state = "greenservice_com"
	accessories = list(/obj/item/clothing/accessory/brown)

/obj/item/clothing/under/solgov/service/marine/command/skirt
	name = "marine officer's service skirt"
	desc = "The service uniform skirt of the SCG Marine Corps. Slimming and stylish."
	icon_state = "greenservicefem_com"
	worn_state = "greenservicefem_com"

//Dress
/obj/item/clothing/under/solgov/mildress
	name = "dress uniform"
	desc = "A dress uniform of some kind."
	icon_state = "greydress"
	worn_state = "greydress"
	armor = list(melee = 5, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 5, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/solgov/mildress/marine
	name = "marine dress uniform"
	desc = "The dress uniform of the SCG Marine Corps, class given form."
	icon_state = "blackdress"
	worn_state = "blackdress"

/obj/item/clothing/under/solgov/mildress/marine/skirt
	name = "marine dress skirt"
	desc = "A  feminine version of the SCG Marine Corps dress uniform, class given form."
	icon_state = "blackdressfem"
	worn_state = "blackdressfem"

/obj/item/clothing/under/solgov/mildress/marine/command
	name = "marine officer's dress uniform"
	desc = "The dress uniform of the SCG Marine Corps, even classier in gold."
	icon_state = "blackdress"
	worn_state = "blackdress_com"

/obj/item/clothing/under/solgov/mildress/marine/command/skirt
	name = "marine officer's dress skirt"
	desc = "A feminine version of the SCG Marine Corps dress uniform, even classier in gold."
	icon_state = "blackdressfem"
	worn_state = "blackdressfem_com"

//misc garbage
/obj/item/clothing/under/rank/internalaffairs/plain/solgov
	desc = "A plain shirt and pair of pressed black pants."
	name = "formal outfit"
	accessories = list(/obj/item/clothing/accessory/blue_clip)

/obj/item/clothing/under/solgov/utility/expeditionary/monkey
	name = "adjusted expeditionary uniform"
	desc = "The utility uniform of the SCG Expeditionary Corps, made from biohazard resistant material. This one has silver trim. It was also mangled to fit a monkey. This better be worth the NJP you'll get for making it."
	species_restricted = list("Monkey")
	sprite_sheets = list("Monkey" = 'icons/mob/species/monkey/uniform.dmi')
//	accessories = list(/obj/item/clothing/accessory/solgov/rank/fleet/officer/wo1_monkey)

/obj/item/clothing/under/scp/utility/chaos
	desc = "A dark black uniform. On the back, in silver lettering, are the words 'CHAOS INSURGENCY'."
	name = "chaos uniform"
	icon_state = "scpuniform3"
	worn_state = "chaos"
