/* Paint and crayons */

/datum/reagent/crayon_dust
	name = "Crayon dust"
	description = "Intensely coloured powder obtained by grinding crayons."
	taste_description = "the back of class"
	reagent_state = LIQUID
	color = "#888888"
	overdose = 5

/datum/reagent/crayon_dust/red
	name = "Red crayon dust"
	color = "#fe191a"

/datum/reagent/crayon_dust/orange
	name = "Orange crayon dust"
	color = "#ffbe4f"

/datum/reagent/crayon_dust/yellow
	name = "Yellow crayon dust"
	color = "#fdfe7d"

/datum/reagent/crayon_dust/green
	name = "Green crayon dust"
	color = "#18a31a"

/datum/reagent/crayon_dust/blue
	name = "Blue crayon dust"
	color = "#247cff"

/datum/reagent/crayon_dust/purple
	name = "Purple crayon dust"
	color = "#cc0099"

/datum/reagent/crayon_dust/grey //Mime
	name = "Grey crayon dust"
	color = "#808080"

/datum/reagent/crayon_dust/brown //Rainbow
	name = "Brown crayon dust"
	color = "#846f35"

/datum/reagent/paint
	name = "Paint"
	description = "This paint will stick to almost any object."
	taste_description = "chalk"
	reagent_state = LIQUID
	color = "#808080"
	overdose = REAGENTS_OVERDOSE * 0.5
	color_weight = 20

/datum/reagent/paint/touch_turf(turf/T)
	if(istype(T) && !isspaceturf(T))
		T.color = color

/datum/reagent/paint/touch_obj(obj/O)
	if(istype(O))
		O.color = color

/datum/reagent/paint/touch_mob(mob/M)
	if(istype(M) && !isobserver(M)) //painting observers: not allowed
		M.color = color //maybe someday change this to paint only clothes and exposed body parts for human mobs.

/datum/reagent/paint/get_data()
	return color

/datum/reagent/paint/initialize_data(newdata)
	color = newdata
	return

/datum/reagent/paint/mix_data(newdata, newamount)
	var/list/colors = list(0, 0, 0, 0)
	var/tot_w = 0

	var/hex1 = uppertext(color)
	var/hex2 = uppertext(newdata)
	if(length(hex1) == 7)
		hex1 += "FF"
	if(length(hex2) == 7)
		hex2 += "FF"
	if(length(hex1) != 9 || length(hex2) != 9)
		return
	colors[1] += hex2num(copytext(hex1, 2, 4)) * volume
	colors[2] += hex2num(copytext(hex1, 4, 6)) * volume
	colors[3] += hex2num(copytext(hex1, 6, 8)) * volume
	colors[4] += hex2num(copytext(hex1, 8, 10)) * volume
	tot_w += volume
	colors[1] += hex2num(copytext(hex2, 2, 4)) * newamount
	colors[2] += hex2num(copytext(hex2, 4, 6)) * newamount
	colors[3] += hex2num(copytext(hex2, 6, 8)) * newamount
	colors[4] += hex2num(copytext(hex2, 8, 10)) * newamount
	tot_w += newamount

	color = rgb(colors[1] / tot_w, colors[2] / tot_w, colors[3] / tot_w, colors[4] / tot_w)
	return

/* Things that didn't fit anywhere else */

/datum/reagent/adminordrazine //An OP chemical for admins
	name = "Adminordrazine"
	description = "It's magic. We don't have to explain it."
	taste_description = "100% abuse"
	reagent_state = LIQUID
	color = "#c8a5dc"
	flags = AFFECTS_DEAD //This can even heal dead people.

	glass_name = "liquid gold"
	glass_desc = "It's magic. We don't have to explain it."

/datum/reagent/adminordrazine/affect_touch(mob/living/carbon/M, alien, removed)
	affect_blood(M, alien, removed)

/datum/reagent/adminordrazine/affect_blood(mob/living/carbon/M, alien, removed)
	M.rejuvenate()

/datum/reagent/gold
	name = "Gold"
	description = "Gold is a dense, soft, shiny metal and the most malleable and ductile metal known."
	taste_description = "expensive metal"
	reagent_state = SOLID
	color = "#f7c430"
	value = 7

/datum/reagent/silver
	name = "Silver"
	description = "A soft, white, lustrous transition metal, it has the highest electrical conductivity of any element and the highest thermal conductivity of any metal."
	taste_description = "expensive yet reasonable metal"
	reagent_state = SOLID
	color = "#d0d0d0"
	value = 4

/datum/reagent/uranium
	name = "Uranium"
	description = "A silvery-white metallic chemical element in the actinide series, weakly radioactive."
	taste_description = "the inside of a reactor"
	reagent_state = SOLID
	color = "#b8b8c0"
	value = 9

/datum/reagent/uranium/affect_touch(mob/living/carbon/M, alien, removed)
	affect_ingest(M, alien, removed)

/datum/reagent/uranium/affect_blood(mob/living/carbon/M, alien, removed)
	M.apply_damage(5 * removed, IRRADIATE, armor_pen = 100)

/datum/reagent/uranium/touch_turf(turf/T)
	if(volume >= 3)
		if(!isspaceturf(T))
			var/obj/effect/decal/cleanable/greenglow/glow = locate(/obj/effect/decal/cleanable/greenglow, T)
			if(!glow)
				new /obj/effect/decal/cleanable/greenglow(T)
			return

/datum/reagent/water/holywater
	name = "Holy Water"
	description = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."
	color = "#e0e8ef"

	glass_name = "holy water"
	glass_desc = "An ashen-obsidian-water mix, this solution will alter certain sections of the brain's rationality."

/datum/reagent/water/holywater/affect_ingest(mob/living/carbon/M, alien, removed)
	..()
	if(ishuman(M)) // Any location
		if(iscultist(M))
			if(prob(10))
				GLOB.cult.offer_uncult(M)
			if(prob(2))
				var/obj/effect/spider/spiderling/S = new /obj/effect/spider/spiderling(M.loc)
				M.visible_message(SPAN_WARNING("\The [M] coughs up \the [S]!"))

/datum/reagent/water/holywater/touch_turf(turf/T)
	if(volume >= 5)
		T.holy = 1
	return

/datum/reagent/diethylamine
	name = "Diethylamine"
	description = "A secondary amine, mildly corrosive."
	taste_description = "iron"
	reagent_state = LIQUID
	color = "#604030"
	value = 0.9

/datum/reagent/surfactant // Foam precursor
	name = "Azosurfactant"
	description = "A isocyanate liquid that forms a foam when mixed with water."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#9e6b38"
	value = 0.05

/datum/reagent/foaming_agent // Metal foaming agent. This is lithium hydride. Add other recipes (e.g. LiH + H2O -> LiOH + H2) eventually.
	name = "Foaming agent"
	description = "A agent that yields metallic foam when mixed with light metal and a strong acid."
	taste_description = "metal"
	reagent_state = SOLID
	color = "#664b63"

/datum/reagent/thermite
	name = "Thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	taste_description = "sweet tasting metal"
	reagent_state = SOLID
	color = "#673910"
	touch_met = 50
	value = 6

/datum/reagent/thermite/touch_turf(turf/T)
	if(volume >= 5)
		if(istype(T, /turf/simulated/wall))
			var/turf/simulated/wall/W = T
			W.thermite = 1
			W.add_overlay(image('icons/effects/effects.dmi',icon_state = "#673910"))
			remove_self(5)
	return

/datum/reagent/thermite/touch_mob(mob/living/L, amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 5)

/datum/reagent/thermite/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjustFireLoss(3 * removed)

/datum/reagent/napalm
	name = "Napalm"
	description = "A sticky volatile substance made from mixing quick burning goo with slow burning goo, to make a viscous average burning goo that sticks to everything."
	taste_description = "burnt corn"
	reagent_state = LIQUID
	color = "#673910"
	touch_met = 50

/datum/reagent/napalm/touch_turf(turf/T)
	new /obj/effect/decal/cleanable/liquid_fuel(T, volume)
	remove_self(volume)

/datum/reagent/napalm/touch_mob(mob/living/L, amount)
	if(istype(L))
		L.adjust_fire_stacks(amount / 100)

/datum/reagent/napalm/b
	name = "Napalm B"
	taste_description = "burnt plastic and metal"

/datum/reagent/hydroxylsan
	name = "Hydroxylsan"
	description = "A compound used to clean things. The name \"Hydroxylsan\" is derived from \"hydroxyl,\" which is a chemical group consisting of H2O and NH3 elements (NH4OH), often found in cleaning agents and sanitizers, and \"san\" representing \"sanitization\" or \"sanitize.\" holding quaternary ammonium compounds!"
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#a5f0ee"
	touch_met = 50
	value = 0.7

/datum/reagent/hydroxylsan/touch_obj(obj/O)
	O.clean_blood()

/datum/reagent/hydroxylsan/touch_turf(turf/T)
	if(volume >= 1)
		if(istype(T, /turf/simulated))
			var/turf/simulated/S = T
			S.dirt = 0
			if(S.wet > 1)
				S.unwet_floor(FALSE)
		T.clean_blood()


		for(var/mob/living/carbon/slime/M in T)
			M.adjustToxLoss(rand(5, 10))

/datum/reagent/hydroxylsan/affect_touch(mob/living/carbon/M, alien, removed)
	if(M.r_hand)
		M.r_hand.clean_blood()
	if(M.l_hand)
		M.l_hand.clean_blood()
	if(M.wear_mask)
		if(M.wear_mask.clean_blood())
			M.update_inv_wear_mask(0)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.head)
			if(H.head.clean_blood())
				H.update_inv_head(0)
		if(H.wear_suit)
			if(H.wear_suit.clean_blood())
				H.update_inv_wear_suit(0)
		else if(H.w_uniform)
			if(H.w_uniform.clean_blood())
				H.update_inv_w_uniform(0)
		if(H.shoes)
			if(H.shoes.clean_blood())
				H.update_inv_shoes(0)
		else
			H.clean_blood(1)
			return
	M.update_icons()
	M.clean_blood()

/datum/reagent/medicine/sterilizine
	name = "Sterilizine"
	description = "Sterilizes wounds in preparation for surgery and thoroughly removes blood."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#c8a5dc"
	touch_met = 5
	value = 2.2

/datum/reagent/medicine/sterilizine/affect_touch(mob/living/carbon/M, alien, removed)
	if (M.germ_level < INFECTION_LEVEL_TWO) // rest and antibiotics is required to cure serious infections
		M.germ_level -= min(removed*20, M.germ_level)
	for (var/obj/item/I in M.contents)
		I.was_bloodied = null
	M.was_bloodied = null

/datum/reagent/medicine/sterilizine/touch_obj(obj/O)
	O.germ_level -= min(volume*20, O.germ_level)
	O.was_bloodied = null

/datum/reagent/medicine/sterilizine/touch_turf(turf/T)
	T.germ_level -= min(volume*20, T.germ_level)
	for (var/obj/item/I in T.contents)
		I.was_bloodied = null
	for (var/obj/effect/decal/cleanable/blood/B in T)
		qdel(B)

/datum/reagent/slippery_oil
	name = "Slippery Motor Oil"
	description = "An extra slippery motor oil. Designed to reduce friction in moving machinery parts."
	taste_description = "motor oil"
	reagent_state = LIQUID
	color = "#009ca8"
	value = 0.6
	should_admin_log = TRUE
	var/overlay_icon = "lubed_floor"
	var/slip_strength = 30

/datum/reagent/slippery_oil/touch_turf(turf/simulated/T)
	if(!istype(T))
		return
	if(volume >= 1)
		T.wet_floor(slip_strength, overlay_state = overlay_icon, dissipate_time = 2 SECONDS)

/datum/reagent/oil
	name = "Oil"
	description = "A thick greasy industrial lubricant. Commonly found in robotics."
	taste_description = "greasy diesel"
	color = "#000000"

/datum/reagent/oil/touch_turf(turf/simulated/T)
	if(!isspaceturf(T))
		new /obj/effect/decal/cleanable/blood/oil/streak(T)

/datum/reagent/glycerol
	name = "Glycerol"
	description = "Glycerol is a simple polyol compound. Glycerol is sweet-tasting and of low toxicity."
	taste_description = "sweetness"
	reagent_state = LIQUID
	color = "#808080"
	value = 8

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	taste_description = "oil"
	reagent_state = LIQUID
	color = "#808080"
	value = 9

/datum/reagent/nitroglycerin/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.add_chemical_effect(CE_PULSE, 2)

#define COOLANT_LATENT_HEAT 19000 //Twice as good at cooling than water is, but may cool below 20c. It'll cause freezing that atmos will have to deal with..
/datum/reagent/coolant
	name = "Coolant"
	description = "Industrial cooling substance."
	taste_description = "sourness"
	taste_mult = 1.1
	reagent_state = LIQUID
	color = "#c8a5dc"
	value = 0.8

/datum/reagent/coolant/touch_turf(turf/simulated/T)
	if(!istype(T))
		return

	var/datum/gas_mixture/environment = T.return_air()
	var/min_temperature = 0 // Room temperature + some variance. An actual diminishing return would be better, but this is *like* that. In a way. . This has the potential for weird behavior, but I says fuck it. Water grenades for everyone.

	var/hotspot = (locate(/obj/fire) in T)
	if(hotspot && !isspaceturf(T))
		var/datum/gas_mixture/lowertemp = T.remove_air(T:air:total_moles)
		lowertemp.temperature = max(min(lowertemp.temperature-2000, lowertemp.temperature / 2), 0)
		lowertemp.react()
		T.assume_air(lowertemp)
		qdel(hotspot)

	if (environment && environment.temperature > min_temperature) // Abstracted as steam or something
		var/removed_heat = between(0, volume * COOLANT_LATENT_HEAT, -environment.get_thermal_energy_change(min_temperature))
		environment.add_thermal_energy(-removed_heat)
		if (prob(5) && environment && environment.temperature > T100C)
			T.visible_message(SPAN_WARNING("The water sizzles as it lands on \the [T]!"))


/datum/reagent/ultraglue
	name = "Ultra Glue"
	description = "An extremely powerful bonding agent."
	taste_description = "a special education class"
	color = "#ffffcc"

/datum/reagent/woodpulp
	name = "Wood Pulp"
	description = "A mass of wood fibers."
	taste_description = "wood"
	reagent_state = SOLID
	color = WOOD_COLOR_GENERIC

/datum/reagent/bamboo
	name = "Bamboo Pulp"
	description = "A mass of bamboo fibers."
	taste_description = "grass"
	reagent_state = SOLID
	color = WOOD_COLOR_PALE2

/datum/reagent/resinpulp
	name = "Resin Pulp"
	description = "A mass of goopy resin."
	taste_description = "gooey"
	reagent_state = SOLID
	color = "#3a4e1b"

/datum/reagent/luminol
	name = "Luminol"
	description = "A compound that interacts with blood on the molecular level."
	taste_description = "metal"
	reagent_state = LIQUID
	color = "#f2f3f4"
	value = 1.4

/datum/reagent/luminol/touch_obj(obj/O)
	O.reveal_blood()

/datum/reagent/luminol/touch_mob(mob/living/L)
	L.reveal_blood()

/datum/reagent/helium
	name = "Helium"
	description = "A noble gas. It makes your voice squeaky."
	taste_description = "nothing"
	reagent_state = LIQUID
	color = COLOR_GRAY80
	metabolism = 0.05 // So that low dosages have a chance to build up in the body.

/datum/reagent/helium/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	..()
	M.add_chemical_effect(CE_SQUEAKY, 1)

// This is only really used to poison vox.
/datum/reagent/oxygen
	name = "Oxygen"
	description = "An ubiquitous oxidizing agent."
	taste_description = "nothing"
	reagent_state = LIQUID
	color = COLOR_GRAY80

/datum/reagent/oxygen/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_VOX)
		M.adjustToxLoss(removed * 6)

/datum/reagent/carbon_monoxide
	name = "Carbon Monoxide"
	description = "A dangerous carbon comubstion byproduct."
	taste_description = "stale air"
	reagent_state = LIQUID
	color = COLOR_GRAY80
	metabolism = 0.05 // As with helium.

/datum/reagent/carbon_monoxide/affect_blood(mob/living/carbon/human/M, alien, removed)
	if(!istype(M) || alien == IS_DIONA)
		return
	var/warning_message
	var/warning_prob = 10
	var/dosage = M.chem_doses[type]
	if(dosage >= 3)
		warning_message = pick("extremely dizzy","short of breath","faint","confused")
		warning_prob = 15
		M.adjustOxyLoss(10,20)
		M.co2_alert = 1
	else if(dosage >= 1.5)
		warning_message = pick("dizzy","short of breath","faint","momentarily confused")
		M.co2_alert = 1
		M.adjustOxyLoss(3,5)
	else if(dosage >= 0.25)
		warning_message = pick("a little dizzy","short of breath")
		warning_prob = 10
		M.co2_alert = 0
	else
		M.co2_alert = 0
	if(warning_message && prob(warning_prob))
		to_chat(M, SPAN_WARNING("You feel [warning_message]."))

/datum/reagent/dye
	name = "Dye"
	description = "Non-toxic artificial coloration used for food and drinks. When mixed with reagents, the compound will take on the dye's coloration."
	color = "#ffffff"
	color_weight = 40
	color_transfer = TRUE
	color_foods = TRUE
	taste_mult = 0

/datum/reagent/dye/strong
	name = "Strong Dye"
	description = "An extra-strength dye. Used for tinting food, but is especially effective with drinks and other fluids."
	color_weight = 100

/datum/reagent/capilliumate
	name = "Capilliumate"
	description = "Used across the Sol system by balding men to retrieve their lost youth."
	taste_description = "mothballs"
	reagent_state = LIQUID
	color = "#33270b"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/capilliumate/affect_touch(mob/living/carbon/human/M, alien, removed)
	if (!alien)
		var/datum/sprite_accessory/hair/newhair = /datum/sprite_accessory/hair/longest
		var/datum/sprite_accessory/facial_hair/newbeard = /datum/sprite_accessory/facial_hair/vlongbeard
		M.change_hair(initial(newhair.name))
		M.change_facial_hair(initial(newbeard.name))
		M.visible_message(
			SPAN_NOTICE("\The [M]'s hair grows to extraordinary lengths!"),
			SPAN_NOTICE("Your hair grows to extraordinary lengths!")
		)
	remove_self(volume)

/datum/reagent/capilliumate/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	if (prob(10))
		to_chat(M, SPAN_WARNING("Your tongue feels... fuzzy."))
	M.slurring = max(M.slurring, 10)

/datum/reagent/hair_dye
	name = "Hair Dye"
	description = "Some hair dye. Be fabulous! Requires an extra color to mix with."
	taste_description = "bad choices"
	reagent_state = LIQUID
	color = "#b6f0ef"
	overdose = REAGENTS_OVERDOSE

/datum/reagent/colored_hair_dye
	name = "Hair Dye"
	description = "Apply to your head to add some color to your life!"
	reagent_state = LIQUID
	taste_description = "bad choices"

/datum/reagent/colored_hair_dye/proc/apply_dye_color(mob/living/carbon/human/H, red, green, blue)
	if (H.h_style && H.species.appearance_flags & HAS_HAIR_COLOR)
		var/datum/sprite_accessory/hair/hair_style = GLOB.hair_styles_list[H.h_style]
		if (~hair_style.flags & HAIR_BALD)
			H.change_hair_color(red, green, blue)
			H.change_facial_hair_color(red, green, blue)
			H.visible_message(
				SPAN_NOTICE("\The [H]'s hair changes color!"),
				SPAN_NOTICE("Your hair changes color!")
			)
	remove_self(volume)

/datum/reagent/colored_hair_dye/affect_touch(mob/living/carbon/human/H, alien, removed)
	var/list/dye_args = list(H) + GetHexColors(color)
	apply_dye_color(arglist(dye_args))

/datum/reagent/colored_hair_dye/red
	name = "Red Hair Dye"
	color = "#b33636"

/datum/reagent/colored_hair_dye/orange
	name = "Orange Hair Dye"
	color = "#b5772f"

/datum/reagent/colored_hair_dye/yellow
	name = "Yellow Hair Dye"
	color = "#a6a035"

/datum/reagent/colored_hair_dye/green
	name = "Green Hair Dye"
	color = "#61a834"

/datum/reagent/colored_hair_dye/blue
	name = "Blue Hair Dye"
	color = "#3470a8"

/datum/reagent/colored_hair_dye/purple
	name = "Purple Hair Dye"
	color = "#6d2d91"

/datum/reagent/colored_hair_dye/grey
	name = "Grey Hair Dye"
	color = "#696969"

/datum/reagent/colored_hair_dye/brown
	name = "Brown Hair Dye"
	color = "#3b2d0f"

/datum/reagent/colored_hair_dye/light_brown
	name = "Light Brown Hair Dye"
	color = "#3d3729"

/datum/reagent/colored_hair_dye/black
	name = "Black Hair Dye"
	color = "#000000"

/datum/reagent/colored_hair_dye/white
	name = "White Hair Dye"
	color = "#ffffff"

/datum/reagent/colored_hair_dye/chaos
	name = "Chaotic Hair Dye"
	description = "This hair dye can be any color! Only one way to find out what kind!"

/datum/reagent/colored_hair_dye/chaos/affect_touch(mob/living/carbon/human/H, alien, removed)
	apply_dye_color(H, RAND_F(1, 254), RAND_F(1, 254), RAND_F(1, 254))


// Sleeping agent, produced by breathing N2O.
/datum/reagent/nitrous_oxide
	name = "Nitrous Oxide"
	description = "An ubiquitous sleeping agent also known as laughing gas."
	taste_description = "dental surgery"
	reagent_state = LIQUID
	color = COLOR_GRAY80
	metabolism = 0.05 // So that low dosages have a chance to build up in the body.
	var/do_giggle = TRUE

/datum/reagent/nitrous_oxide/xenon
	name = "Xenon"
	description = "A nontoxic gas used as a general anaesthetic."
	do_giggle = FALSE
	taste_description = "nothing"
	color = COLOR_GRAY80

/datum/reagent/nitrous_oxide/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_DIONA)
		return
	var/dosage = M.chem_doses[type]
	if (dosage >= 1)
		if (prob(5)) M.Sleeping(3)
		M.dizziness =  max(M.dizziness, 3)
		M.confused =   max(M.confused, 3)
	if (dosage >= 0.3)
		if (prob(5)) M.Paralyse(1)
		M.drowsyness = max(M.drowsyness, 3)
		M.slurring =   max(M.slurring, 3)
	if (do_giggle && prob(20))
		M.emote(pick("giggle", "laugh"))
	M.add_chemical_effect(CE_PULSE, -1)

/datum/reagent/vaccine
	//data must contain virus type
	name = "Vaccine"
	color = "#c81040" // rgb: 200, 16, 64
	taste_description = "slime"

/datum/reagent/vaccine/affect_blood(mob/living/carbon/M, alien, removed)
	. = ..()
	if(!islist(data))
		return

	for(var/thing in M.diseases)
		var/datum/disease/infection = thing
		if(infection.GetDiseaseID() in data)
			infection.Cure()
	LAZYOR(M.disease_resistances, data)

/datum/reagent/vaccine/mix_data(list/newdata, newamount)
	if(istype(newdata))
		src.data |= newdata.Copy()

/* Abominable Infestation reagents */

// Grauel - Basically a healing chem that can implant a larva into its user.
/datum/reagent/grauel
	name = "Grauel"
	description = "Reagent responsible for incubation of unknown lifeforms within its host. Has healing properties, but using it as medicine is a concerning idea."
	taste_description = "vomit"
	taste_mult = 1.4
	reagent_state = LIQUID
	color = COLOR_MAROON
	value = 4
	heating_products = list(/datum/reagent/nutriment/protein, /datum/reagent/laich)
	heating_point = 120 CELSIUS
	heating_message = "turns into a fleshy mess."

/datum/reagent/grauel/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	var/heal_rate = 4
	if(M.chem_doses[/datum/reagent/laich] >= 1)
		heal_rate *= 2.5
	M.heal_organ_damage(heal_rate * removed, 0) // Effectively weaker bicaridine, just with a tiny issue...
	M.add_chemical_effect(CE_PAINKILLER, 5)

	var/dosage = M.chem_doses[type]
	if(dosage < 5) // Only implant larvas on somewhat "high" dose
		return
	if(!prob(max(10, dosage*0.5)))
		return

	var/list/valid_organs = list()
	for(var/obj/item/organ/external/O in M.organs)
		if(istype(O, /obj/item/organ/external/stump))
			continue
		if(locate(/mob/living/simple_animal/hostile/infestation/larva) in O.implants) // One larva per limb
			continue
		valid_organs += O
	if(!LAZYLEN(valid_organs))
		return
	var/obj/item/organ/external/target_organ = pick(valid_organs)
	var/mob/living/simple_animal/hostile/infestation/larva/implant/L = new(target_organ, TRUE)
	target_organ.implants += L
	L.transformation_time = world.time + rand(180 SECONDS, 360 SECONDS)
	L.ai_holder.speak_chance = 0

// Laich - Reagent needed for creating of larva cube.
/datum/reagent/laich
	name = "Laich"
	description = "An important ingridient in creation of life. Causes mild suffocation. When consumed/injected alongside with Grauel - the later's healing properties were increased."
	taste_description = "disgusting mess"
	color = COLOR_ORANGE

/datum/reagent/laich/affect_blood(mob/living/carbon/M, alien, removed)
	if(alien == IS_DIONA)
		return
	if(prob(20))
		M.adjustOxyLoss(8)
	if(ishuman(M) && prob(2))
		var/mob/living/carbon/human/H = M
		H.vomit(2, 2, rand(2 SECONDS, 4 SECONDS))

// Gottheit - VERY addictive drug that essentially makes you a god. Take it once and there's no coming back.
/datum/reagent/gottheit
	name = "Gottheit"
	description = "An impossibly powerful medicine, which is just as impossibly addictive."
	taste_description = "pleasantly burning acid"
	taste_mult = 5
	reagent_state = LIQUID
	color = COLOR_YELLOW
	value = 50
	metabolism = 0.1
	addiction_types = list(/datum/addiction/gottheit = 600) // Near instant addiction

/datum/reagent/gottheit/affect_blood(mob/living/carbon/human/M, alien, removed)
	if(alien == IS_DIONA)
		return

	// Heal all conventional damage types
	M.adjustCloneLoss(-40 * removed)
	M.adjustOxyLoss(-40 * removed)
	M.heal_organ_damage(80 * removed, 80 * removed)
	M.adjustToxLoss(-80 * removed)

	// Restore blood
	M.regenerate_blood(8 * removed)

	// Some useful chem effects, including painkilling
	M.add_chemical_effect(CE_PAINKILLER, 400)
	M.add_chemical_effect(CE_SPEEDBOOST, 1)

	// Reduce bad effects
	M.drowsyness = max(M.drowsyness - 50, 0)
	M.adjust_hallucination(-50)
	M.AdjustParalysis(-10)
	M.AdjustStunned(-10)
	M.AdjustWeakened(-10)

	// Super low doses won't do cool stuff
	var/dosage = M.chem_doses[type]
	if(dosage < 2)
		return

	// Heal organs
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/internal/I in H.internal_organs)
			if((I.status & ORGAN_DEAD) && prob(25))
				I.revive()
			if(!BP_IS_ROBOTIC(I))
				I.heal_damage(20 * removed)
		for(var/obj/item/organ/external/E in H.organs)
			if(E.status & ORGAN_ARTERY_CUT)
				E.status &= ~ORGAN_ARTERY_CUT
			if(E.status & ORGAN_TENDON_CUT)
				E.status &= ~ORGAN_TENDON_CUT
			if(E.status & ORGAN_BLEEDING)
				E.status &= ~ORGAN_BLEEDING
			if(E.status & ORGAN_BROKEN)
				E.status &= ~ORGAN_BROKEN
			if(E.status & ORGAN_DEAD)
				E.revive()

	// Remove all diseases
	for(var/datum/disease/D in M.diseases)
		qdel(D)
