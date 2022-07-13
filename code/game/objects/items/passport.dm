/obj/item/passport
	name = "passport"
	icon = 'icons/obj/passport.dmi'
	icon_state = "passport"
	force = 0.5
	w_class = ITEM_SIZE_SMALL
	attack_verb = list("whipped")
	hitsound = 'sound/weapons/towelwhip.ogg'
	desc = "A passport. Its origin seems unknown."
	var/info
	var/fingerprint

/obj/item/passport/proc/set_info(mob/living/carbon/human/H)
	if(!istype(H))
		return
	var/decl/cultural_info/culture = H.get_cultural_value(TAG_HOMEWORLD)
	var/pob = culture ? culture.name : "Unset"
	if(H.dna)
		fingerprint = md5(H.dna.uni_identity)
	else
		fingerprint = "N/A"
	info = "\icon[src] [src]:\nName: [H.real_name]\nSpecies: [H.get_species()]\nGender: [gender2text(H.gender)]\nAge: [H.age]\nPlace of Birth: [pob]\nFingerprint: [fingerprint]"

/obj/item/passport/attack_self(mob/user as mob)
	user.visible_message(
		SPAN_ITALIC("[user] opens and checks [src]."),
		SPAN_ITALIC("You open [src] and check for some main information."),
		SPAN_ITALIC("You hear the faint rustle of pages."),
		5
	)
	to_chat(user, info || SPAN_WARNING("[src] is completely blank!"))

/obj/item/passport/scg
	name = "\improper SCG passport"
	icon_state = "passport_scg"
	desc = "A passport from the Sol Central Government."

/obj/item/passport/earth
	name = "\improper Earth passport"
	icon_state = "passport_scg2"
	desc = "A passport from the Earth, within Sol Central Government space."

/obj/item/passport/venus
	name = "\improper Venusian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Venus, within Sol Central Government space."

/obj/item/passport/luna
	name = "\improper Luna passport"
	icon_state = "passport_scg2"
	desc = "A passport from Luna, within Sol Central Government space."

/obj/item/passport/mars
	name = "\improper Martian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Mars, within Sol Central Government space."

/obj/item/passport/phobos
	name = "\improper Phobos passport"
	icon_state = "passport_scg2"
	desc = "A passport from Phobos, within Sol Central Government space."

/obj/item/passport/ceres
	name = "\improper Ceres passport"
	icon_state = "passport_scg2"
	desc = "A passport from Ceres, within Sol Central Government space."

/obj/item/passport/pluto
	name = "\improper Plutonian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Pluto, within Sol Central Government space."

/obj/item/passport/tiamat
	name = "\improper Tiamat passport"
	icon_state = "passport_scg2"
	desc = "A passport from Tiamat, within Sol Central Government space."

/obj/item/passport/eos
	name = "\improper Eos passport"
	icon_state = "passport_scg2"
	desc = "A passport from Eos, within Sol Central Government space."

/obj/item/passport/ceti_epsilon
	name = "\improper Cetite passport"
	icon_state = "passport_scg2"
	desc = "A passport from Ceti Epsilon, within Sol Central Government space."

/obj/item/passport/lordania
	name = "\improper Lordanian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Lordania, within Sol Central Government space."

/obj/item/passport/kingston
	name = "\improper Kingstonian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Kingston, within Sol Central Government space."

/obj/item/passport/cinu
	name = "\improper Cinusian passport"
	icon_state = "passport_scg2"
	desc = "A passport from Cinu, within Sol Central Government space."

/obj/item/passport/yuklid
	name = "\improper Yuklid V passport"
	icon_state = "passport_scg2"
	desc = "A passport from Yuklid V, within Sol Central Government space."

/obj/item/passport/lorriman
	name = "\improper Lorriman passport"
	icon_state = "passport_scg2"
	desc = "A passport from Yuklid V, within Sol Central Government space."

/obj/item/passport/tersten
	name = "\improper Tersten passport"
	icon_state = "passport_scg2"
	desc = "A passport from Tersten, within Sol Central Government space."

/obj/item/passport/south_gaia
	name = "\improper Southern Gaian passport"
	icon_state = "passport_scg2"
	desc = "A passport from the southern part of Gaia, under control of the Sol Central Government."

/obj/item/passport/terran
	name = "\improper ICCG passport"
	icon_state = "passport_terragov"
	desc = "A passport from the Terran Government."

/obj/item/passport/north_gaia
	name = "\improper Northern Gaian passport"
	icon_state = "passport_terragov2"
	desc = "A passport from the northern part of Gaia, under control of the Terran Government."

/obj/item/passport/terra
	name = "\improper Terran passport"
	icon_state = "passport_terragov2"
	desc = "A passport from Terra, within TerraGov space."

/obj/item/passport/new_earth
	name = "\improper New Earth passport"
	icon_state = "passport_terragov2"
	desc = "A passport from New Earth, within TerraGov space."

/obj/item/passport/saveel
	name = "\improper Saveel passport"
	icon_state = "passport"
	desc = "A passport from Saveel, an isolationist frontier colony."

/obj/item/passport/magnitka
	name = "\improper Magnitkan passport"
	icon_state = "passport"
	desc = "A passport from Magnitka, an independant colony."

/obj/item/passport/empiremohranda
	name = "\improper Mohrandade passport"
	icon_state = "passport"
	desc = "A passport from the Empire of Mohranda, a frontier empire established on Lohrene and Mohranda, in the Luggust system."

//EARTH SHIT
/obj/item/passport/earth/usa
	name = "\improper US passport"
	desc = "A patriotic passport, to identify yourself as a citizien of the greatest country on earth while abroad."
