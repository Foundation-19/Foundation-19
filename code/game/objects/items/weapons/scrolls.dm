/obj/item/teleportation_scroll
	name = "scroll of teleportation"
	desc = "A scroll for moving around."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll"
	var/uses = 4.0
	w_class = ITEM_SIZE_TINY
	item_state = "paper"
	throw_speed = 4
	throw_range = 20
	origin_tech = list(TECH_BLUESPACE = 4)

/obj/item/teleportation_scroll/attack_self(mob/user as mob)
	if((user.mind && !GLOB.wizards.is_antagonist(user.mind)))
		to_chat(usr, SPAN_WARNING("You stare at the scroll but cannot make sense of the markings!"))
		return

	tgui_interact(user)

/obj/item/teleportation_scroll/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Scrolls", "Teleportation Scroll")
		ui.open()

/obj/item/teleportation_scroll/tgui_data(mob/user)
	var/list/data = list()
	data["uses"] = uses
	return data

/obj/item/teleportation_scroll/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	var/mob/living/carbon/human/H = usr
	if (!( istype(H, /mob/living/carbon/human)))
		return TRUE
	if (!(usr == src.loc || (in_range(src, usr) && istype(src.loc, /turf))))
		return TRUE
	switch(action)
		if("spell_teleport")
			if (src.uses >= 1)
				teleportscroll(H)
			return TRUE
	return FALSE

/obj/item/teleportation_scroll/proc/teleportscroll(mob/user)
	var/area/thearea = input(user, "Area to jump to", "BOOYEA") as null|anything in wizteleportlocs
	thearea = thearea ? wizteleportlocs[thearea] : thearea

	if (!thearea || CanUseTopic(user) != STATUS_INTERACTIVE)
		return

	var/datum/effect/effect/system/smoke_spread/smoke = new /datum/effect/effect/system/smoke_spread()
	smoke.set_up(5, 0, user.loc)
	smoke.attach(user)
	smoke.start()
	var/turf/end = user.try_teleport(thearea)

	if(!end)
		to_chat(user, "The spell matrix was unable to locate a suitable teleport destination for an unknown reason. Sorry.")
		return
	smoke.start()
	src.uses -= 1
