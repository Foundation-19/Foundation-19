/* Stack type objects!
 * Contains:
 * 		Stacks
 * 		Recipe datum
 * 		Recipe list datum
 */

/*
 * Stacks
 */

/obj/item/stack
	gender = PLURAL
	origin_tech = list(TECH_MATERIAL = 1)
	var/list/datum/stack_recipe/recipes
	var/singular_name
	var/plural_name
	var/base_state
	var/plural_icon_state
	var/max_icon_state
	var/amount = 1
	var/max_amount //also see stack recipes initialisation, param "max_res_amount" must be equal to this max_amount
	var/stacktype //determines whether different stack types can merge
	var/build_type = null //used when directly applied to a turf
	var/uses_charge = 0
	var/list/charge_costs = null
	var/list/datum/matter_synth/synths = null
	var/list/possible_multipliers = list(1, 5, 10, 25)

/obj/item/stack/New(loc, amount=null)
	if (!stacktype)
		stacktype = type
	if (amount >= 1)
		src.amount = amount
	..()

/obj/item/stack/Initialize(mapload)
	. = ..()
	if(!plural_name)
		plural_name = "[singular_name]s"
	if (!mapload && isturf(loc))
		addtimer(CALLBACK(src, PROC_REF(stack_new)), 0)

/obj/item/stack/proc/stack_new()
	for (var/obj/item/stack/S in loc)
		if (S == src)
			continue
		if (S.stacktype == stacktype)
			transfer_to(S)

/obj/item/stack/Destroy()
	if(uses_charge)
		return 1
	return ..()

/obj/item/stack/examine(mob/user, distance)
	. = ..()
	if(distance <= 1)
		if(!uses_charge)
			to_chat(user, "There [src.amount == 1 ? "is" : "are"] [src.amount] [src.singular_name]\s in the stack.")
		else
			to_chat(user, "There is enough charge for [get_amount()].")

/obj/item/stack/attack_self(mob/user as mob)
	tgui_interact(user)

/obj/item/stack/proc/list_recipes(mob/user as mob, recipes_sublist)
	if (!recipes || !src || get_amount() <= 0)
		return

/obj/item/stack/tgui_interact(mob/user, datum/tgui/ui)
	list_recipes(user)
	if(!recipes || get_amount() <= 0)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "StackCrafting", "Constructions from [src]")
		ui.open()

/obj/item/stack/tgui_data(mob/user)
	var/list/data = list()
	data["amount"] = get_amount()
	data["singular_name"] = singular_name
	data["recipes"] = get_recipe_data(recipes, user)
	return data

/obj/item/stack/proc/get_recipe_data(list/recipe_list, mob/user)
	var/list/entries = list()
	if(!recipe_list)
		return entries
	for(var/i=1,i<=recipe_list.len,i++)
		var/E = recipe_list[i]
		if (isnull(E))
			continue

		if (istype(E, /datum/stack_recipe_list))
			var/datum/stack_recipe_list/srl = E
			entries += list(list(
				"type" = "sublist",
				"index" = i,
				"title" = srl.title,
				"recipes" = get_recipe_data(srl.recipes, user)))

		if (istype(E, /datum/stack_recipe))
			var/datum/stack_recipe/R = E
			var/max_multiplier = round(get_amount() / R.req_amount)
			var/can_build = (max_multiplier > 0)
			var/skill_label = ""
			if(!user.skill_check(SKILL_CONSTRUCTION, R.difficulty))
				var/decl/hierarchy/skill/S = decls_repository.get_decl(SKILL_CONSTRUCTION)
				skill_label = S.levels[R.difficulty]
			var/list/multipliers = list()
			if(can_build)
				multipliers += 1
			if (R.max_res_amount>1 && max_multiplier>1)
				max_multiplier = min(max_multiplier, round(R.max_res_amount/R.res_amount))
				for (var/n in possible_multipliers)
					if ((n != 1) && (max_multiplier >= n))
						multipliers += n
				if (!(max_multiplier in possible_multipliers))
					multipliers += max_multiplier
			entries += list(list(
				"type" = "recipe",
				"index" = i,
				"title" = R.display_name(),
				"req_amount" = R.req_amount,
				"res_amount" = R.res_amount,
				"can_build" = can_build,
				"skill_label" = skill_label,
				"multipliers" = multipliers))
	return entries

/obj/item/stack/proc/produce_recipe(datum/stack_recipe/recipe, quantity, mob/user)
	var/required = quantity*recipe.req_amount
	var/produced = min(quantity*recipe.res_amount, recipe.max_res_amount)

	var/area/A = get_area(user)
	if (!A.can_modify_area())
		visible_message("You can't seem to make anything with \the [src] here.")
		return

	if (!can_use(required))
		if (produced>1)
			to_chat(user, SPAN_WARNING("You haven't got enough [src] to build \the [produced] [recipe.display_name()]\s!"))
		else
			to_chat(user, SPAN_WARNING("You haven't got enough [src] to build \the [recipe.display_name()]!"))
		return

	if(!recipe.can_make(user))
		return

	if (recipe.time)
		to_chat(user, SPAN_NOTICE("Building [recipe.display_name()] ..."))
		if (!user.do_skilled(recipe.time, SKILL_CONSTRUCTION))
			return

	if (use(required))
		if(user.skill_fail_prob(SKILL_CONSTRUCTION, 90, recipe.difficulty))
			to_chat(user, SPAN_WARNING("You waste some [name] and fail to build \the [recipe.display_name()]!"))
			return
		var/atom/O = recipe.spawn_result(user, user.loc, produced)
		O.add_fingerprint(user)

		user.put_in_hands(O)
		SEND_SIGNAL(user, COMSIG_PRODUCED_RECIPE, recipe, O)

/obj/item/stack/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	if ((usr.restrained() || usr.stat || usr.get_active_hand() != src))
		return TRUE
	switch(action)
		if("make")
			if (src.get_amount() < 1)
				qdel(src) //Never should happen
				return TRUE

			var/list/recipes_list = recipes
			if (params["sublist"])
				var/datum/stack_recipe_list/srl = recipes_list[text2num(params["sublist"])]
				if(!istype(srl))
					return TRUE
				recipes_list = srl.recipes

			var/datum/stack_recipe/R = recipes_list[text2num(params["make"])]
			var/multiplier = text2num(params["multiplier"])
			if(!R)
				return TRUE
			if (!multiplier || (multiplier <= 0)) //href exploit protection
				return TRUE

			// max multiplier calculation stolen from recipe logic
			var/max_multiplier = round(src.get_amount() / R.req_amount)
			if (R.max_res_amount > 1 && max_multiplier > 1)
				max_multiplier = min(max_multiplier, round(R.max_res_amount/R.res_amount))
			if(max_multiplier < 1)
				return TRUE
			if (!((multiplier in possible_multipliers) || (multiplier == max_multiplier))) // more href exploit protection
				return TRUE

			src.produce_recipe(R, multiplier, usr)
			return TRUE
	return FALSE

//Return 1 if an immediate subsequent call to use() would succeed.
//Ensures that code dealing with stacks uses the same logic
/obj/item/stack/proc/can_use(used)
	if (get_amount() < used)
		return 0
	return 1

/obj/item/stack/proc/use(used)
	if (!can_use(used))
		return 0
	if(!uses_charge)
		amount -= used
		if (amount <= 0)
			qdel(src) //should be safe to qdel immediately since if someone is still using this stack it will persist for a little while longer
		else
			update_icon()
		return 1
	else
		if(get_amount() < used)
			return 0
		for(var/i = 1 to charge_costs.len)
			var/datum/matter_synth/S = synths[i]
			S.use_charge(charge_costs[i] * used) // Doesn't need to be deleted
		return 1

/obj/item/stack/proc/add(extra)
	if(!uses_charge)
		if(amount + extra > get_max_amount())
			return 0
		else
			amount += extra
			update_icon()
		return 1
	else if(!synths || synths.len < uses_charge)
		return 0
	else
		for(var/i = 1 to uses_charge)
			var/datum/matter_synth/S = synths[i]
			S.add_charge(charge_costs[i] * extra)

/*
	The transfer and split procs work differently than use() and add().
	Whereas those procs take no action if the desired amount cannot be added or removed these procs will try to transfer whatever they can.
	They also remove an equal amount from the source stack.
*/

//attempts to transfer amount to S, and returns the amount actually transferred
/obj/item/stack/proc/transfer_to(obj/item/stack/S, tamount=null, type_verified)
	if (!get_amount())
		return 0
	if ((stacktype != S.stacktype) && !type_verified)
		return 0
	if (isnull(tamount))
		tamount = src.get_amount()

	var/transfer = max(min(tamount, src.get_amount(), (S.get_max_amount() - S.get_amount())), 0)

	var/orig_amount = src.get_amount()
	if (transfer && src.use(transfer))
		S.add(transfer)
		if (prob(transfer/orig_amount * 100))
			transfer_fingerprints_to(S)
		return transfer
	return 0

//creates a new stack with the specified amount
/obj/item/stack/proc/split(tamount)
	if (!amount)
		return null

	tamount = Floor(tamount)	// sanity check to prevent duping
	if(tamount <= 0)				// if tamount was rounded to 0 (or below, somehow) just quit here
		return null

	var/transfer = max(min(tamount, src.amount, initial(max_amount)), 0)

	var/orig_amount = src.amount
	if (transfer && src.use(transfer))
		var/obj/item/stack/newstack
		if(uses_charge)
			newstack = new src.stacktype(loc, transfer)
		else
			newstack = new src.type(loc, transfer)
		newstack.copy_from(src)
		if (prob(transfer/orig_amount * 100))
			transfer_fingerprints_to(newstack)
		return newstack
	return null

/obj/item/stack/proc/copy_from(obj/item/stack/other)
	color = other.color

/obj/item/stack/proc/get_amount()
	if(uses_charge)
		if(!synths || synths.len < uses_charge)
			return 0
		var/datum/matter_synth/S = synths[1]
		. = round(S.get_charge() / charge_costs[1])
		if(charge_costs.len > 1)
			for(var/i = 2 to charge_costs.len)
				S = synths[i]
				. = min(., round(S.get_charge() / charge_costs[i]))
		return
	return amount

/obj/item/stack/proc/get_max_amount()
	if(uses_charge)
		if(!synths || synths.len < uses_charge)
			return 0
		var/datum/matter_synth/S = synths[1]
		. = round(S.max_energy / charge_costs[1])
		if(uses_charge > 1)
			for(var/i = 2 to uses_charge)
				S = synths[i]
				. = min(., round(S.max_energy / charge_costs[i]))
		return
	return max_amount

/obj/item/stack/proc/add_to_stacks(mob/user, check_hands)
	var/list/stacks = list()
	if(check_hands)
		if(isstack(user.l_hand))
			stacks += user.l_hand
		if(isstack(user.r_hand))
			stacks += user.r_hand
	for (var/obj/item/stack/item in user.loc)
		stacks += item
	for (var/obj/item/stack/item in stacks)
		if (item==src)
			continue
		var/transfer = src.transfer_to(item)
		if (transfer)
			to_chat(user, SPAN_NOTICE("You add a new [item.singular_name] to the stack. It now contains [item.amount] [item.singular_name]\s."))
		if(!amount)
			break

/obj/item/stack/get_storage_cost()	//Scales storage cost to stack size
	. = ..()
	if (amount < max_amount)
		. = ceil(. * amount / max_amount)

/obj/item/stack/Crossed(obj/o)
	addtimer(CALLBACK(src, PROC_REF(stack_crossed), o), 0)
	. = ..()

/obj/item/stack/proc/stack_crossed(obj/o)
	if (!o.throwing && loc == o.loc && isturf(loc) && istype(o, /obj/item/stack))
		var/obj/item/stack/S = o
		transfer_to(S)

/obj/item/stack/attack_hand(mob/user as mob)
	if (user.get_inactive_hand() == src)
		var/N = input("How many stacks of [src] would you like to split off?", "Split stacks", 1) as num|null
		if(N)
			var/obj/item/stack/F = src.split(N)
			if (F)
				user.put_in_hands(F)
				src.add_fingerprint(user)
				F.add_fingerprint(user)
				spawn(0)
					if (src)
						SStgui.update_uis(src)
	else
		..()
	return

/obj/item/stack/attackby(obj/item/W as obj, mob/user as mob)
	if (istype(W, /obj/item/stack))
		var/obj/item/stack/S = W
		src.transfer_to(S)

		spawn(0) //give the stacks a chance to delete themselves if necessary
			if (S)
				SStgui.update_uis(S)
			if (src)
				SStgui.update_uis(src)
	else
		return ..()

/*
 * Recipe datum
 */
/datum/stack_recipe
	var/title = "ERROR"
	var/result_type
	var/req_amount = 1 //amount of material needed for this recipe
	var/res_amount = 1 //amount of stuff that is produced in one batch (e.g. 4 for floor tiles)
	var/max_res_amount = 1
	var/time = 0
	var/one_per_turf = 0
	var/on_floor = 0
	var/use_material
	var/use_reinf_material
	var/difficulty = 1 // higher difficulty requires higher skill level to make.
	var/send_material_data = 0 //Whether the recipe will send the material name as an argument when creating product.
	var/apply_material_name = 1 //Whether the recipe will prepend a material name to the title - 'steel clipboard' vs 'clipboard'

/datum/stack_recipe/New(material/material, reinforce_material)
	if(material)
		use_material = material.name
		difficulty += material.construction_difficulty
	if(reinforce_material)
		use_reinf_material = reinforce_material

/datum/stack_recipe/proc/display_name()
	if(!use_material || !apply_material_name)
		return title
	. = "[material_display_name(use_material)] [title]"
	if(use_reinf_material)
		. = "[material_display_name(use_reinf_material)]-reinforced [.]"

/datum/stack_recipe/proc/spawn_result(mob/user, location, amount)
	var/atom/O
	if(send_material_data && use_material)
		O = new result_type(location, use_material, use_reinf_material)
	else
		O = new result_type(location)
	O.setDir(user.dir)
	return O

/datum/stack_recipe/proc/can_make(mob/user)
	if (one_per_turf && (locate(result_type) in user.loc))
		to_chat(user, SPAN_WARNING("There is another [display_name()] here!"))
		return FALSE

	var/turf/T = get_turf(user.loc)
	if (on_floor && !T.is_floor())
		to_chat(user, SPAN_WARNING("\The [display_name()] must be constructed on the floor!"))
		return FALSE

	return TRUE

/*
 * Recipe list datum
 */
/datum/stack_recipe_list
	var/title = "ERROR"
	var/list/recipes = null

/datum/stack_recipe_list/New(title, recipes)
	src.title = title
	src.recipes = recipes
