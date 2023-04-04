/////////////////
// SCP DRAWERS //
/////////////////

// SAFE DRAWERS

/obj/structure/filingcabinet/scp/safe/scp1to999
	name = "SCP Documents - Safe - 1 to 999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/obj/structure/filingcabinet/scp/safe/scp1to999/New()
	..()
	new /obj/item/paper/scp/safe/scp013(src)
	new /obj/item/paper/scp/safe/scp113(src)
	new /obj/item/paper/scp/safe/scp131(src)
	new /obj/item/paper/scp/safe/scp500(src)
	new /obj/item/paper/scp/safe/scp999(src)
	update_icon()

/obj/structure/filingcabinet/scp/safe/scp1000to1999
	name = "SCP Documents - Safe - 1000 to 1999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

/obj/structure/filingcabinet/scp/safe/scp2000to2999
	name = "SCP Documents - Safe - 2000 to 2999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/obj/structure/filingcabinet/scp/safe/scp2000to2999/New()
	..()
	new /obj/item/paper/scp/safe/scp2398(src)
	update_icon()

/obj/structure/filingcabinet/scp/safe/scp3000to3999
	name = "SCP Documents - Safe - 3000 to 3999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

// EUCLID DRAWERS

/obj/structure/filingcabinet/scp/euclid/scp1to999
	name = "SCP Documents - Euclid - 1 to 999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/obj/structure/filingcabinet/scp/euclid/scp1to999/New()
	..()
	new /obj/item/paper/scp/euclid/scp012(src)
	new /obj/item/paper/scp/euclid/scp049(src)
	new /obj/item/paper/scp/euclid/scp078(src)
	new /obj/item/paper/scp/euclid/scp096(src)
	new /obj/item/paper/scp/euclid/scp096/addendum1(src)
	new /obj/item/paper/scp/euclid/scp151(src)
	new /obj/item/paper/scp/euclid/scp151/addendum1(src)
	new /obj/item/paper/scp/euclid/scp153(src)
	new /obj/item/paper/scp/euclid/scp153/addendum1(src)
	new /obj/item/paper/scp/euclid/scp173(src)
	new /obj/item/paper/scp/euclid/scp513(src)
	new /obj/item/paper/scp/euclid/scp895(src)
	update_icon()

/obj/structure/filingcabinet/scp/euclid/scp1000to1999
	name = "SCP Documents - Euclid - 1000 to 1999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

/obj/structure/filingcabinet/scp/euclid/scp2000to2999
	name = "SCP Documents - Euclid - 2000 to 2999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

/obj/structure/filingcabinet/scp/euclid/scp3000to3999
	name = "SCP Documents - Euclid - 3000 to 3999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new
		update_icon()
*/

// KETER DRAWERS

/obj/structure/filingcabinet/scp/keter/scp1to999
	name = "SCP Documents - Keter - 1 to 999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/obj/structure/filingcabinet/scp/keter/scp1to999/New()
	..()
	new /obj/item/paper/scp/keter/scp106(src)
	new /obj/item/paper/scp/keter/scp939(src)
	update_icon()


/obj/structure/filingcabinet/scp/keter/scp1000to1999
	name = "SCP Documents - Keter - 1000 to 1999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

/obj/structure/filingcabinet/scp/keter/scp2000to2999
	name = "SCP Documents - Keter - 2000 to 2999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE

/*	New()
		..()
		new /obj/item/paper/scp999(src)
		update_icon()
*/

/obj/structure/filingcabinet/scp/keter/scp3000to3999
	name = "SCP Documents - Keter - 3000 to 3999"
	desc = "A large cabinet with drawers."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "filingcabinet"
	density = TRUE
	anchored = TRUE
	atom_flags = ATOM_FLAG_CLIMBABLE
	obj_flags = OBJ_FLAG_ANCHORABLE
