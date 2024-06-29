/*eigenstate themed Chem
 *Teleports you to the creation location on consumption and back when the reagent is removed from you
 *OD teleports you randomly around the Station and gives you a status effect
 *The status effect slowly send you on a wild ride and replaces you with an alternative reality version of yourself unless you consume eigenstasium.
 *During the process you get really hungry,
 *Then some of your items slowly start teleport around you,
 *then alternative versions of yourself are brought in from a different universe and they yell at you.
 *and finally you yourself get teleported to an alternative universe, and character your playing is replaced with said alternative
*/
/datum/reagent/eigenstate
	name = "Eigenstasium"
	description = "A highly anomalous mixture that causes localised eigenstate fluxuations within the patient."
	taste_description = "wiggly cosmic dust."
	color = "#5020F4"
	overdose = 15
	flags = AFFECTS_DEAD //So if you die with it in your body, you still get teleported back to the location as a corpse
	///The return point indicator
	var/obj/effect/overlay/eigenstate
	///The point you're returning to after the reagent is removed
	var/turf/location_return = null
	/// Ghetto tracker for entry, since we don't have the same reagent systems as TG
	var/entry_tracker = FALSE
	/// Ghetto tracker for overdosing, since we don't have the same reagent systems as TG
	var/overdose_tracker = FALSE

/datum/reagent/eigenstate/affect_ingest(mob/living/living_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()

	if(overdose_percentage() < 1)
		overdose_tracker = FALSE

	if(!iscarbon(living_mob))
		return

	if(entry_tracker && volume < 0.25)
		sparks(5, FALSE, living_mob)
		to_chat(living_mob, SPAN_USERDANGER("You feel strangely whole again."))

		playsound(living_mob, 'sounds/effects/phasein.ogg')
		do_teleport(living_mob, location_return, 0) //Teleports home
		sparks(5, FALSE, living_mob)

		QDEL_NULL(eigenstate)
		qdel_self()	// just to make sure a rounding error doesn't mess us up
	else
		//make hologram at return point to indicate where someone will go back to
		eigenstate = new (living_mob.loc)
		eigenstate.add_overlay(getHologramIcon(getFlatIcon(living_mob), hologram_color = HOLOPAD_SHORT_RANGE))
		eigenstate.mouse_opacity = MOUSE_OPACITY_TRANSPARENT//So you can't click on it.
		eigenstate.layer = ABOVE_HUMAN_LAYER//Above all the other objects/mobs. Or the vast majority of them.
		eigenstate.anchored = TRUE //So space wind cannot drag it.
		eigenstate.name = "[living_mob.name]'s Eigenstate"//If someone decides to right click.
		eigenstate.set_light(1, 0.1, 2)	//hologram lighting

		location_return = get_turf(living_mob)	//sets up return point
		to_chat(living_mob, SPAN_USERDANGER("You feel like part of yourself has split off!"))

		entry_tracker = TRUE

	if(prob(20))
		sparks(5, FALSE, living_mob)

	return ..()

/datum/reagent/eigenstate/overdose(mob/living/living_mob, alien) //Overdose, makes you teleport randomly
	if(!overdose_tracker)
		to_chat(living_mob, SPAN_USERDANGER("You feel like your perspective is being ripped apart as you begin flitting in and out of reality!"))

		living_mob.set_jitter_if_lower(40 SECONDS)

		if(iscarbon(living_mob))
			var/mob/living/carbon/carbon_mob = living_mob
			carbon_mob.apply_status_effect(/datum/status_effect/eigenstasium)

		overdose_tracker = TRUE

	sparks(5, FALSE, living_mob)
	playsound(living_mob, 'sounds/effects/phasein.ogg')
	do_teleport(living_mob, get_turf(living_mob), 10)
	sparks(5, FALSE, living_mob)
	return ..()

//FOR ADDICTION-LIKE EFFECTS, SEE datum/status_effect/eigenstasium
