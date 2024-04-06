/*
 * Science
 */
/obj/item/clothing/under/rank/research_director/alt
	desc = "It's a dull black comfortable turtleneck which shows no emotion, and smells slightly of chemicals, and lacks morales. It's paired with some black jeans."
	name = "research director's turtleneck"
	icon_state = "rdclothes"
	item_state = "bl_suit"
	worn_state = "rdclothes"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS

/obj/item/clothing/under/rank/research_director
	desc = "It's a jumpsuit worn by those with the know-how to achieve the position of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	name = "research director's jumpsuit"
	icon_state = "director"
	item_state = "lb_suit"
	worn_state = "director"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/research_director/rdalt
	desc = "A dress suit and slacks stained with hard work and dedication to science. Perhaps other things as well, but mostly hard work and dedication."
	name = "head researcher uniform"
	icon_state = "rdalt"
	item_state = "lb_suit"
	worn_state = "rdalt"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/research_director/dress_rd
	name = "research director dress uniform"
	desc = "Feminine fashion for the style concious RD. Its fabric provides minor protection from biological contaminants."
	icon_state = "dress_rd"
	item_state = "lb_suit"
	worn_state = "dress_rd"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/under/rank/scientist_new/senior
	desc = "A snazzy purple science-themed turtleneck usually worn by senior scientists like the highly famous Dr. Blight, and or Dr. Buck."
	name = "researcher's turtleneck"
	icon_state = "seniorscience"
	item_state = "w_suit"
	worn_state = "seniorscience"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/under/rank/scientist_new/junior
	name = "researcher's formal uniform"
	desc = "A white dress shirt, with some khahki slacks, and a purple tie in science colors, smells like chemicals."
	icon_state = "junscience"
	item_state = "w_suit"
	worn_state = "junscience"
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS

/obj/item/clothing/under/rank/chemist
	desc = "It's made of a special fiber that gives special protection against biohazards. The striping on the suit denotes the wearer as a trained pharmacist."
	name = "pharmacist's jumpsuit"
	icon_state = "chemistry"
	item_state = "w_suit"
	worn_state = "chemistrywhite"
	gender_icons = 1
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
/*
 * Medical
 */
/obj/item/clothing/under/rank/chief_medical_officer
	desc = "It's a jumpsuit worn by those with the experience to be \"Medical Director\". It provides minor biological protection."
	name = "medical director's jumpsuit"
	icon_state = "cmo"
	item_state = "w_suit"
	worn_state = "cmo"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/chief_medical_officer/turtleneck
	desc = "It's a jumpsuit worn by those with the experience to be \"Medical Director\". It provides minor biological protection."
	name = "medical director's turtleneck"
	icon_state = "cmoturtle"
	item_state = "w_suit"
	worn_state = "cmoturtle"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/chief_medical_officer/skirt
	desc = "It's a jumpskirt worn by those with the experience to be \"Medical Director\". It provides minor biological protection."
	name = "medical director's jumpskirt"
	icon_state = "cmo_skirt"
	item_state = "w_suit"
	worn_state = "cmo_skirt"

/obj/item/clothing/under/rank/geneticist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a genetics rank stripe on it."
	name = "geneticist's jumpsuit"
	icon_state = "genetics"
	item_state = "w_suit"
	worn_state = "geneticswhite"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/virologist
	desc = "It's made of a special fiber that gives special protection against biohazards. It has a virologist rank stripe on it."
	name = "virologist's jumpsuit"
	icon_state = "virology"
	item_state = "w_suit"
	worn_state = "virologywhite"
	gender_icons = 1
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/nursesuit
	desc = "It's a jumpsuit commonly worn by nursing staff in the medical department."
	name = "nurse's suit"
	icon_state = "nursesuit"
	item_state = "nursesuit"
	worn_state = "nursesuit"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/nurse
	desc = "A dress commonly worn by the nursing staff in the medical department."
	name = "nurse's dress"
	icon_state = "nurse"
	item_state = "nursesuit"
	worn_state = "nurse"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO

/obj/item/clothing/under/rank/orderly
	desc = "A white suit to be worn by medical attendants."
	name = "orderly's uniform"
	icon_state = "orderly"
	item_state = "nursesuit"
	worn_state = "orderly"
	gender_icons = 1
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/medical
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpsuit"
	icon_state = "medical"
	item_state = "w_suit"
	worn_state = "medical"
	gender_icons = 1
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/medical/paramedic
	name = "medical utility jumpsuit"
	desc = "It's made of a special fiber that provides minor protection against biohazards. This one has a medical cross on the back denoting that the wearer is trained medical personnel."
	icon_state = "medical"
	item_state = "medical_short"
	worn_state = "medical_short"

/obj/item/clothing/under/rank/medical/scrubs
	name = "white scrubs"
	desc = "A sterile pair of scrubs, usually helpful in the case of biohazardous spills."
	icon_state = "scrubs"
	worn_state = "scrubs"

/obj/item/clothing/under/rank/medical/scrubs/blue
	name = "blue scrubs"
	icon_state = "scrubsblue"
	worn_state = "scrubsblue"

/obj/item/clothing/under/rank/medical/scrubs/green
	name = "green scrubs"
	icon_state = "scrubsgreen"
	worn_state = "scrubsgreen"

/obj/item/clothing/under/rank/medical/scrubs/purple
	name = "purple scrubs"
	icon_state = "scrubspurple"
	worn_state = "scrubspurple"

/obj/item/clothing/under/rank/medical/scrubs/black
	name = "black scrubs"
	icon_state = "scrubsblack"
	worn_state = "scrubsblack"

/obj/item/clothing/under/rank/medical/scrubs/navyblue
	name = "navy blue scrubs"
	icon_state = "scrubsnavyblue"
	worn_state = "scrubsnavyblue"

/obj/item/clothing/under/rank/medical/scrubs/lilac
	name = "lilac scrubs"
	color = "#c8a2c8"

/obj/item/clothing/under/rank/medical/scrubs/teal
	name = "teal scrubs"
	color = "#008080"

/obj/item/clothing/under/rank/medical/scrubs/heliodor
	name = "heliodor scrubs"
	color = "#aad539"

/obj/item/clothing/under/rank/psych
	desc = "A basic white jumpsuit. It has turqouise markings that denote the wearer as a psychiatrist."
	name = "psychiatrist's jumpsuit"
	icon_state = "psych"
	item_state = "w_suit"
	worn_state = "psych"
	gender_icons = 1

/obj/item/clothing/under/rank/psych/turtleneck
	desc = "A turqouise sweater and a pair of dark blue slacks."
	name = "turqouise turtleneck"
	icon_state = "psychturtle"
	item_state = "b_suit"
	worn_state = "psychturtle"


/*
 * Medsci, unused (i think) stuff
 */
/obj/item/clothing/under/rank/geneticist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "geneticist's jumpsuit"
	icon_state = "genetics_new"
	item_state = "w_suit"
	worn_state = "genetics_new"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/chemist_new
	desc = "It's made of a special fiber which provides minor protection against biohazards."
	name = "chemist's jumpsuit"
	icon_state = "chemist_new"
	item_state = "w_suit"
	worn_state = "chemist_new"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/scientist_new
	desc = "Made of a special fiber that gives special protection against biohazards and small explosions."
	name = "scientist's jumpsuit"
	icon_state = "scientist_new"
	item_state = "w_suit"
	worn_state = "scientist_new"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/virologist_new
	desc = "Made of a special fiber that gives increased protection against biohazards."
	name = "virologist's jumpsuit"
	icon_state = "virologist_new"
	item_state = "w_suit"
	worn_state = "virologist_new"
	permeability_coefficient = 0.50
	armor = list(
		bio = ARMOR_BIO_MINOR
		)

/obj/item/clothing/under/rank/medical/skirt
	desc = "It's made of a special fiber that provides minor protection against biohazards. It has a cross on the chest denoting that the wearer is trained medical personnel."
	name = "medical doctor's jumpskirt"
	icon_state = "medical_skirt"
	item_state = "w_suit"
	worn_state = "medical_skirt"
