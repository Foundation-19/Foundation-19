/datum/codex_entry/telecrystal
	associated_paths = list(/obj/item/stack/telecrystal)
	antag_text = "Telecrystals can be activated by utilizing them on devices with an actively running uplink. They will not activate on unactivated uplinks."

/datum/codex_entry/rods
	associated_paths = list(/obj/item/stack/material/rods)
	mechanics_text = "Made from <span codexlink='steel'>steel sheets</span>. You can build a <l>grille</l> by using it in your hand. \
	Clicking on a floor without any tiles will reinforce the floor. You can make <l>reinforced glass</l> by combining rods and <span codexlink='glass'>glass sheets</span>."

/datum/codex_entry/glass
	associated_paths = list(/obj/item/stack/material/glass, /obj/item/stack/material/cyborg/glass)
	mechanics_text = "Use in your hand to build a window. Can be upgraded to reinforced glass by adding <span codexlink='rod'>metal rods</span>, \
	which are made from <span codexlink='steel'>steel sheets</span>.<br>\
	As a synthetic, you can acquire more sheets of glass by recharging."

/datum/codex_entry/glass_reinf
	associated_paths = list(/obj/item/stack/material/glass/reinforced, /obj/item/stack/material/cyborg/glass/reinforced)
	mechanics_text = "Use in your hand to build a window. Reinforced glass is much stronger against damage.<br>\
	As a synthetic, you can gain more reinforced glass by recharging."

/datum/codex_entry/steel
	associated_paths = list(/obj/item/stack/material/steel, /obj/item/stack/material/cyborg/steel)
	mechanics_text = "Use in your hand to bring up the recipe menu. If you have enough sheets, click on something on the list to build it.<br>\
	As a synthetic, you can replenish your supply of metal by recharging."
