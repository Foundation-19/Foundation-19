/datum/codex_entry/implant
	associated_paths = list(/obj/item/implant)
	mechanics_text = "Implants are devices that can be injected into a person and have varying effects. To inject an implant, you require an <l>implanter</l>. \
	Once injected, implants can only be removed through surgery."

/datum/codex_entry/implanter
	associated_paths = list(/obj/item/implanter)
	mechanics_text = "The implanter allows you to inject an <l>implant</l> into another mob or person.<br>\
	To implant someone, you must first insert the desired implant into the implanter, select a target region to implant into, then click on your target to implant them.<br>\
	Implanting takes time and can be interrupted.<br>\
	Implants can only be removed through surgery."

/datum/codex_entry/implant/imprinting
	associated_paths = list(/obj/item/implant/imprinting, /obj/item/implanter/imprinting)
	antag_text = "Imprinting implants are a special form of <l>implant</l> that allows you to force your victim to obey the instructions you program it with. \
	For the implant to work correctly, you must first inject your victim with <span codexlink='mindbreaker toxin (chemical)'>mindbreaker toxin</span> (should be included in the implanter kit).<br>"
