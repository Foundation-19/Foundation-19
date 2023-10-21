// These aren't "snacks" in a traditional sense. People shouldn't be eating them. Instead, they should be putting them in water for xenobio, etc.
// Humans ARE, however, 60% water...
// What these actually do is create monkeys when water is added. They're mostly meant for feeding slimes. If you eat one, bad things happen.

/obj/item/reagent_containers/food/snacks/monkeycube
	name = "monkey cube"
	desc = "Just add water!"
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_OPEN_CONTAINER
	icon_state = "monkeycube"
	bitesize = 12
	filling_color = "#adac7f"
	center_of_mass = "x=16;y=14"
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

	var/wrapped = FALSE
	var/monkey_type = /mob/living/carbon/human/monkey
	var/required_reagent_type = /datum/reagent/water

/obj/item/reagent_containers/food/snacks/monkeycube/attack_self(mob/user)
	if (wrapped)
		Unwrap(user)

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Expand()
	visible_message(SPAN_NOTICE("\The [src] expands!"))
	var/mob/monkey = new monkey_type
	monkey.dropInto(loc)
	qdel(src)

/obj/item/reagent_containers/food/snacks/monkeycube/proc/Unwrap(mob/user)
	to_chat(user, SPAN_NOTICE("You unwrap \the [src]."))
	icon_state = "monkeycube"
	desc = "Just add water!"
	wrapped = FALSE
	atom_flags |= ATOM_FLAG_OPEN_CONTAINER
	var/trash = new /obj/item/trash/cubewrapper(get_turf(user))
	user.put_in_hands(trash)

/obj/item/reagent_containers/food/snacks/monkeycube/On_Consume(mob/M)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		H.visible_message(
			SPAN_WARNING("Something bursts out of [M]'s chest!"),
			SPAN_DANGER(FONT_LARGE("Something bursts out of your chest in a shower of [H.species.get_blood_name()]!"))
		) // alien (1979)
		playsound(H, 'sounds/effects/splat.ogg', 50, FALSE)
		var/datum/reagent/blood/B = locate(/datum/reagent/blood) in H.vessel.reagent_list
		blood_splatter(H, B, 1)
		var/obj/item/organ/external/organ = H.get_organ(BP_CHEST)
		organ.take_external_damage(50, 0, 0, "Animal escaping the ribcage")
		organ.fracture()
	Expand()

/obj/item/reagent_containers/food/snacks/monkeycube/on_reagent_change()
	if (reagents.has_reagent(required_reagent_type))
		Expand()

// Coarse - Returns meat of the animal within cube
// 1:1 - Returns random animal cube with same reagent requirement, but different mob type
// Fine - Returns the mob within it
// Very fine - Returns the mob within it, and applies the Conversion914 on same mode
/obj/item/reagent_containers/food/snacks/monkeycube/Conversion914(mode = MODE_ONE_TO_ONE, mob/user = usr)
	switch(mode)
		if(MODE_COARSE)
			var/mob/living/L = monkey_type
			var/list/return_list = list()
			for(var/i = 1 to initial(L.meat_amount))
				return_list += initial(L.meat_type)
			playsound(get_turf(src), 'sounds/effects/splat.ogg', 25, TRUE)
			return length(return_list) ? return_list : null
		if(MODE_ONE_TO_ONE)
			var/list/potential_return = list()
			for(var/thing in typesof(/obj/item/reagent_containers/food/snacks/monkeycube))
				var/obj/item/reagent_containers/food/snacks/monkeycube/M = thing
				if(initial(M.required_reagent_type) != required_reagent_type || initial(M.monkey_type) == monkey_type)
					continue
				potential_return += M
				if(!LAZYLEN(potential_return))
					return src
				return pick(potential_return)
		if(MODE_FINE)
			return monkey_type
		if(MODE_VERY_FINE)
			var/mob/M = new monkey_type(get_turf(src))
			M.Conversion914(mode, user)
			return M
	return ..()

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped
	desc = "Still wrapped in some paper."
	icon_state = "monkeycubewrap"
	item_flags = 0
	obj_flags = 0
	wrapped = TRUE

/obj/item/reagent_containers/food/snacks/monkeycube/farwacube
	name = "farwa cube"
	monkey_type = /mob/living/carbon/human/farwa

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/farwacube
	name = "farwa cube"
	monkey_type = /mob/living/carbon/human/farwa

/obj/item/reagent_containers/food/snacks/monkeycube/stokcube
	name = "stok cube"
	monkey_type = /mob/living/carbon/human/stok

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/stokcube
	name = "stok cube"
	monkey_type = /mob/living/carbon/human/stok

/obj/item/reagent_containers/food/snacks/monkeycube/neaeracube
	name = "neaera cube"
	monkey_type = /mob/living/carbon/human/neaera

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/neaeracube
	name = "neaera cube"
	monkey_type = /mob/living/carbon/human/neaera

/obj/item/reagent_containers/food/snacks/monkeycube/spidercube
	name = "spider cube"
	monkey_type = /obj/effect/spider/spiderling

/obj/item/reagent_containers/food/snacks/monkeycube/wrapped/spidercube
	name = "spider cube"
	monkey_type = /obj/effect/spider/spiderling

/obj/item/reagent_containers/food/snacks/monkeycube/abominationcube
	name = "larva cube"
	desc = "Requires blood to expand."
	monkey_type = /mob/living/simple_animal/hostile/infestation/larva
	required_reagent_type = /datum/reagent/blood
	color = COLOR_MAROON
	filling_color = COLOR_MAROON

/obj/item/reagent_containers/food/snacks/monkeycube/abominationcube/friendly
	monkey_type = /mob/living/simple_animal/hostile/infestation/larva/friendly
