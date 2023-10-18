/*eigenstate themed Chem
 *Teleports you to the creation location on consumption and back when the reagent is removed from you
 *OD teleports you randomly around the Station and gives you a status effect
 *The status effect slowly send you on a wild ride and replaces you with an alternative reality version of yourself unless you consume eigenstasium/bluespace dust/stabilising agent.
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
	data = list("ingested" = FALSE)//So we retain the target location and creator between reagent instances
	///The return point indicator
	var/obj/effect/overlay/eigenstate
	///The point you're returning to after the reagent is removed
	var/turf/location_return = null

/datum/reagent/eigenstate/on_new(list/data)
	. = ..()
	if(!data)
		return

/datum/reagent/eigenstate/expose_mob(mob/living/living_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()
	if(!(methods & INGEST) || !iscarbon(living_mob))
		return
	//This looks rediculous, but expose is usually called from the donor reagents datum - we want to edit the post exposure version present in the mob.
	var/mob/living/carbon/carby = living_mob
	//But because carbon mobs have stomachs we have to search in there because we're ingested
	var/obj/item/organ/internal/stomach/stomach = carby.get_organ_slot(ORGAN_SLOT_STOMACH)
	var/datum/reagent/eigenstate/eigen
	if(stomach)
		eigen = stomach.reagents.has_reagent(/datum/reagent/eigenstate)
	if(!eigen)//But what if they have no stomach! I want to get off expose_mob's wild ride
		eigen = carby.reagents.has_reagent(/datum/reagent/eigenstate)
	//Because expose_mob and on_mob_add() across all of the different things call them in different orders, so I want to make sure whatever is the first one to call it sets up the location correctly.
	eigen.data["ingested"] = TRUE

//Main functions
/datum/reagent/eigenstate/on_mob_add(mob/living/living_mob, amount)
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

	return ..()

/datum/reagent/eigenstate/on_mob_life(mob/living/carbon/living_mob)
	if(prob(20))
		sparks(5, FALSE, living_mob)

	return ..()

/datum/reagent/eigenstate/on_mob_delete(mob/living/living_mob) //returns back to original location
	sparks(5, FALSE, living_mob)
	to_chat(living_mob, SPAN_USERDANGER("You feel strangely whole again."))
	if(!living_mob.reagents.has_reagent(/datum/reagent/stabilizing_agent))
		do_teleport(living_mob, location_return, 0, asoundin = 'sound/effects/phasein.ogg') //Teleports home
		sparks(5, FALSE, living_mob)
	qdel(eigenstate)
	return ..()

/datum/reagent/eigenstate/overdose_start(mob/living/living_mob) //Overdose, makes you teleport randomly
	to_chat(living_mob, SPAN_USERDANGER("You feel like your perspective is being ripped apart as you begin flitting in and out of reality!"))
	living_mob.set_jitter_if_lower(40 SECONDS)
	metabolization_rate += 0.5 //So you're not stuck forever teleporting.
	if(iscarbon(living_mob))
		var/mob/living/carbon/carbon_mob = living_mob
		carbon_mob.apply_status_effect(/datum/status_effect/eigenstasium)
	return ..()

/datum/reagent/eigenstate/overdose_process(mob/living/living_mob) //Overdose, makes you teleport randomly
	sparks(5, FALSE, living_mob)
	do_teleport(living_mob, get_turf(living_mob), 10, asoundin = 'sound/effects/phasein.ogg')
	sparks(5, FALSE, living_mob)
	return ..()

//FOR ADDICTION-LIKE EFFECTS, SEE datum/status_effect/eigenstasium
