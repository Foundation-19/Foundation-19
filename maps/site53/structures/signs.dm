/obj/structure/sign/dedicationplaque
	name = "\improper SEV Torch dedication plaque"
	desc = "S.E.V. Torch - Mako Class - Sol Expeditionary Corps Registry 95519 - Shiva Fleet Yards, Mars - First Vessel To Bear The Name - Launched 2560 - Sol Central Government - 'Never was anything great achieved without danger.'"
	icon = 'maps/torch/icons/obj/solgov-decals.dmi'
	icon_state = "lightplaque"

/obj/structure/sign/ecplaque
	name = "\improper Expeditionary Directives"
	desc = "A plaque with Expeditionary Corps logo etched in it."
	icon = 'maps/torch/icons/obj/solgov-decals.dmi'
	icon_state = "ecplaque"
	var/directives = {"<hr><center>
		1. <b>Exploring the unknown is your Primary Mission</b><br>

		You are to look for land and resources that can be used by Humanity to advance and prosper. Explore. Document. Explain. Knowledge is the most valuable resource.<br>

		2. <b>Every member of the Expeditionary Corps is an explorer</b><br>

		Some are Explorers by rank or position, but everyone has to be one when duty calls. You should always expect being assigned to an expedition if needed. You have already volunteered when you signed up.<br>

		3. <b>Danger is a part of the mission - avoid, not run away</b> <br>

		Keep your crew alive and hull intact, but remember - you are not here to sightsee. Dangers are obstacles to be cleared, not the roadblocks. Weigh risks carefully and keep your Primary Mission in mind.
		</center><hr>"}

/obj/structure/sign/ecplaque/examine()
	..()
	to_chat(usr, "The founding principles of EC are written there: <A href='?src=\ref[src];show_info=1'>Expeditionary Directives</A>")

/obj/structure/sign/ecplaque/CanUseTopic()
	return STATUS_INTERACTIVE

/obj/structure/sign/ecplaque/OnTopic(href, href_list)
	if(href_list["show_info"])
		to_chat(usr, directives)
		return TOPIC_HANDLED

/obj/effect/floor_decal/scglogo
	alpha = 230
	icon = 'maps/torch/icons/obj/solgov_floor.dmi'
	icon_state = "1,1"

/obj/structure/sign/solgov
	name = "\improper SolGov Seal"
	desc = "A sign which signifies who this vessel belongs to."
	icon = 'maps/torch/icons/obj/solgov-decals.dmi'
	icon_state = "solgovseal"

/obj/structure/sign/double/solgovflag
	name = "Sol Central Government Flag"
	desc = "The flag of the Sol Central Government, a symbol of many things to many people."
	icon = 'maps/torch/icons/obj/solgov-decals.dmi'

/obj/structure/sign/double/solgovflag/left
	icon_state = "solgovflag-left"

/obj/structure/sign/double/solgovflag/right
	icon_state = "solgovflag-right"

/* Foundation 19 Edits for Reshuffling of files*/

/obj/structure/sign/scp/topside/SecureArealv1mtf
	icon_state = "secure"
	desc = "A warning sign which reads: CAUTION, SECURE AREA. LEVEL 1+ SECURITY CLEARANCE REQUIRED."

/obj/structure/sign/scp/topside/SecureArealv2mtf
	icon_state = "secure"
	desc = "A warning sign which reads: CAUTION, SECURE AREA. LEVEL 2+ SECURITY CLEARANCE REQUIRED."

/obj/structure/sign/scp/topside/SecureArealv3mtf
	icon_state = "secure"
	desc = "A warning sign which reads: CAUTION, SECURE AREA. LEVEL 3+ SECURITY CLEARANCE REQUIRED."

/obj/structure/sign/scp/topside/SecureArealv4mtf
	icon_state = "secure"
	desc = "A warning sign which reads: CAUTION, SECURE AREA. LEVEL 4+ SECURITY CLEARANCE REQUIRED."

/obj/structure/sign/scp/topside/SecureArealv5mtf
	icon_state = "secure"
	desc = "A warning sign which reads: CAUTION, SECURE AREA. LEVEL 5+ SECURITY CLEARANCE REQUIRED."

/obj/structure/sign/scp/radiation
	icon_state = "radiationnew"
	desc = "A warning sign which reads: CAUTION, RADIATION HAZARD."

/obj/structure/sign/scp/electrical
	icon_state = "electrical"
	desc = "A warning sign which reads: CAUTION, ELECTRICAL HAZARD."

/obj/structure/sign/scp/cryogenic
	icon_state = "cryogenic"
	desc = "A warning sign which reads: CAUTION, POTENTIAL CRYOGENIC HAZARD."

/obj/structure/sign/scp/oxidizer
	icon_state = "oxidizer"
	desc = "A warning sign which reads: CAUTION, FLAMMABLE SUBSTANCE HAZARD."

/obj/structure/sign/scp/memnetic
	icon_state = "memnetic"
	desc = "A warning sign which reads: CAUTION, MEMETIC HAZARD."

/obj/structure/sign/scp/biohazardous
	icon_state = "biohazardous"
	desc = "A warning sign which reads: CAUTION, BIOHAZARD."

/obj/structure/sign/scp/amnesiac
	icon_state = "amnesiac"
	desc = "A warning sign which reads: CAUTION, AMNESTIC HAZARD."

/obj/structure/sign/scp/containers
	icon_state = "containers"
	desc = "A warning sign which reads: CAUTION, PRESSURIZED GAS STORAGE."

/obj/structure/sign/scp/corrosive
	icon_state = "corrosive"
	desc = "A warning sign which reads: CAUTION, CORROSIVE HAZARD."

/obj/structure/sign/scp/explosive
	icon_state = "explosive"
	desc = "A warning sign which reads: CAUTION, EXPLOSIVE HAZARD."

/obj/structure/sign/scp/flamable
	icon_state = "flamable"
	desc = "A warning sign which reads: CAUTION, FLAMABLE HAZARD."

/obj/structure/sign/scp/lasers
	icon_state = "lasers"
	desc = "A warning sign which reads: CAUTION, LASER HAZARD."

/obj/structure/sign/scp/poisonous
	icon_state = "poisonous"
	desc = "A warning sign which reads: CAUTION, POISONOUS HAZARD."

/obj/structure/sign/scp/magnetic
	icon_state = "magnetic"
	desc = "A warning sign which reads: CAUTION, MAGNETICAL HAZARD. NO METAL OBJECTS BEYOND THIS SIGN."

/obj/structure/sign/scp/optics
	icon_state = "optics"
	desc = "A warning sign which reads: CAUTION, OPTICS HAZARD."

/obj/structure/sign/scp/look
	icon_state = "look"
	desc = "A warning sign which reads: CAUTION, LOOK AT ANOMALOUS OBJECT."

/obj/structure/sign/scp/dontlook
	icon_state = "dontlook"
	desc = "A warning sign which reads: CAUTION, DO NOT LOOK AT ANOMALOUS OBJECT."

/obj/structure/sign/scp/dclass
	name = "\improper MIND THE ACCEPTABLE ZONES!"
	icon_state = "securearea2"
	desc = "A warning sign which reads: REMEMBER YOUR PLACE. DO NOT MOVE BEYOND THE YELLOW HAZARD MARKINGS IF RED HATCHED MARKINGS ARE PRESENT! IMMEDIATE TERMINATION TO VIOLATIONS!"
