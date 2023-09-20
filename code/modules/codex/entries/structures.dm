/datum/codex_entry/girder
	associated_paths = list(/obj/structure/girder)
	entry_text = "Use metal sheets on this to build a normal wall.  Adding plasteel instead will make a reinforced wall.<br>\
	A false wall can be made by using a <l>crowbar</l> on this girder, and then adding metal or plasteel.<br>\
	You can dismantle the grider with a <l>wrench</l>."

/datum/codex_entry/grille
	associated_paths = list(/obj/structure/grille)
	entry_text = "A powered and knotted wire underneath this will cause the grille (provided it is made of a conductive material) to shock anyone not wearing insulated gloves.<br>\
	<l>Wirecutters</l> will turn the grille into rods instantly.  Grilles are typically made with steel rods."

/datum/codex_entry/lattice
	associated_paths = list(/obj/structure/lattice)
	entry_text = "Add a metal floor tile to build a floor on top of the lattice.<br>\
	Lattices can be made by applying rods to a space tile."

/datum/codex_entry/bed
	associated_paths = list(/obj/structure/bed)
	entry_text = "Click and drag yourself (or anyone) to this to buckle in. Click on this with an empty hand to undo the buckles.<br>\
	Anyone with restraints, such as handcuffs, will not be able to unbuckle themselves. They must use the Resist button, or verb, to break free of \
	the buckles, instead."

/datum/codex_entry/cheval
	associated_paths = list(/obj/structure/barricade/spike)
	entry_text = "Constructed by adding rods of any material to a barricade constructed of any material, this structure will injure anyone who moves into it."

/datum/codex_entry/vending_refill
	associated_paths = list(/obj/structure/vending_refill)
	entry_text = "Drag to a vendor to restock. Generally can not be opened."

/datum/codex_entry/window
	associated_paths = list()
	entry_text = "If damaged, it can be repaired by applying more material, then welding it. To fully repair damage, full windows need 4 sheets, and directional windows need 1 sheet."

/datum/codex_entry/window/New()
	associated_paths += typesof(/obj/structure/window)
	. = ..()
