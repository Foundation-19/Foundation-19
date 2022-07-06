//Food items that are eaten normally and don't leave anything behind.


/obj/item/reagent_containers/food/snacks
	name = "snack"
	desc = "Yummy!"
	icon = 'icons/obj/food.dmi'
	icon_state = null
	var/bitesize = 1
	var/bitecount = 0
	var/slice_path
	var/slices_num
	var/dried_type = null
	var/dry = 0
	var/cooks_into_type = null
	var/nutriment_amt = 0
	var/list/nutriment_desc = list("food" = 1)
	var/list/eat_sound = 'sound/items/eatfood.ogg'
	center_of_mass = "x=16;y=16"
	w_class = ITEM_SIZE_SMALL

/obj/item/reagent_containers/food/snacks/microwave_act(obj/machinery/microwave/M)
	if (cooks_into_type)
		var/obj/item/I = new cooks_into_type(loc)
		if (I.reagents)
			// Delete all reagents that come with this food type by default
			// Maintains any excess that don't, even if it's, for instance, more nutriment
			for (var/datum/reagent/R in food_reagents)
				reagents.remove_reagent(R, food_reagents[R])
			// See above
			reagents.remove_reagent(/datum/reagent/nutriment, nutriment_amt)
			reagents.trans_to_obj(I, reagents.total_volume)
		qdel(src)
		return I

/obj/item/reagent_containers/food/snacks/Initialize()
	. = ..()
	if(nutriment_amt)
		reagents.add_reagent(/datum/reagent/nutriment,nutriment_amt,nutriment_desc)

	//Placeholder for effect that trigger on eating that aren't tied to reagents.
/obj/item/reagent_containers/food/snacks/proc/On_Consume(var/mob/M)
	if(!reagents.total_volume)
		M.visible_message("<span class='notice'>[M] finishes eating \the [src].</span>","<span class='notice'>You finish eating \the [src].</span>")
		M.drop_item()
		M.update_personal_goal(/datum/goal/achievement/specific_object/food, type)
		if(trash)
			if(ispath(trash,/obj/item))
				var/obj/item/TrashItem = new trash(get_turf(M))
				M.put_in_hands(TrashItem)
			else if(istype(trash,/obj/item))
				M.put_in_hands(trash)
		qdel(src)
	return

/obj/item/reagent_containers/food/snacks/attack_self(mob/user as mob)
	return

/obj/item/reagent_containers/food/snacks/attack(mob/M as mob, mob/user as mob, def_zone)
	if(!reagents || !reagents.total_volume)
		to_chat(user, "<span class='danger'>None of [src] left!</span>")
		qdel(src)
		return 0
	if(!is_open_container())
		to_chat(user, "<span class='notice'>\The [src] isn't open!</span>")
		return 0
	if(istype(M, /mob/living/carbon))
		//TODO: replace with standard_feed_mob() call.
		var/mob/living/carbon/C = M
		var/fullness = C.get_fullness()
		if(C == user)								//If you're eating it yourself
			if(istype(C,/mob/living/carbon/human))
				var/mob/living/carbon/human/H = M
				if(!H.check_has_mouth())
					to_chat(user, "Where do you intend to put \the [src]? You don't have a mouth!")
					return
				var/obj/item/blocked = H.check_mouth_coverage()
				if(blocked)
					to_chat(user, "<span class='warning'>\The [blocked] is in the way!</span>")
					return

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)//puts a limit on how fast people can eat/drink things
			if (fullness <= 50)
				to_chat(C, "<span class='danger'>You hungrily chew out a piece of [src] and gobble it!</span>")
			if (fullness > 50 && fullness <= 150)
				to_chat(C, "<span class='notice'>You hungrily begin to eat [src].</span>")
			if (fullness > 150 && fullness <= 350)
				to_chat(C, "<span class='notice'>You take a bite of [src].</span>")
			if (fullness > 350 && fullness <= 550)
				to_chat(C, "<span class='notice'>You unwillingly chew a bit of [src].</span>")
			if (fullness > 550)
				to_chat(C, "<span class='danger'>You cannot force any more of [src] to go down your throat.</span>")
				return 0
		else
			if(!M.can_force_feed(user, src))
				return

			if (fullness <= 550)
				user.visible_message("<span class='danger'>[user] attempts to feed [M] [src].</span>")
			else
				user.visible_message("<span class='danger'>[user] cannot force anymore of [src] down [M]'s throat.</span>")
				return 0

			user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
			if(!do_after(user, 3 SECONDS, M)) return

			if (user.get_active_hand() != src)
				return

			var/contained = reagentlist()
			admin_attack_log(user, M, "Fed the victim with [name] (Reagents: [contained])", "Was fed [src] (Reagents: [contained])", "used [src] (Reagents: [contained]) to feed")
			user.visible_message("<span class='danger'>[user] feeds [M] [src].</span>")

		if(reagents) //Handle ingestion of the reagent.
			if(eat_sound)
				playsound(M, pick(eat_sound), rand(10, 50), 1)
			if(reagents.total_volume)
				if(reagents.total_volume > bitesize)
					reagents.trans_to_mob(M, bitesize, CHEM_INGEST)
				else
					reagents.trans_to_mob(M, reagents.total_volume, CHEM_INGEST)
				bitecount++
				On_Consume(M)
			return 1

	return 0

/obj/item/reagent_containers/food/snacks/examine(mob/user, distance)
	. = ..()
	if(distance > 1)
		return
	if (bitecount)
		if (bitecount == 1)
			to_chat(user, "<span class='notice'>\The [src] was bitten by someone!</span>")
		else if (bitecount <= 3)
			to_chat(user, "<span class='notice'>\The [src] was bitten [bitecount] time\s!</span>")
		else
			to_chat(user, "<span class='notice'>\The [src] was bitten multiple times!</span>")
	if (cooks_into_type && (user.get_skill_value(SKILL_COOKING) >= SKILL_TRAINED || isobserver(user)))
		var/obj/item/cooks_into = cooks_into_type
		to_chat(user, SPAN_NOTICE("You could microwave it to turn it into \a [initial(cooks_into.name)]."))

/obj/item/reagent_containers/food/snacks/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/storage))
		..()// -> item/attackby()
		return
	if(!is_open_container())
		to_chat(user, "<span class='notice'>\The [src] isn't open!</span>")
		return 0
	// Eating with forks
	if(istype(W,/obj/item/material/kitchen/utensil))
		var/obj/item/material/kitchen/utensil/U = W
		if(U.scoop_food)
			if(!U.reagents)
				U.create_reagents(5)

			if (U.reagents.total_volume > 0)
				to_chat(user, "<span class='warning'>You already have something on your [U].</span>")
				return

			to_chat(user, SPAN_NOTICE("You scoop up some [src] with \the [U]!"))

			src.bitecount++
			U.cut_overlays()
			U.loaded = "[src]"
			var/image/I = new(U.icon, "loadedfood")
			I.color = src.filling_color
			U.add_overlay(I)

			if(!reagents)
				crash_with("A snack [type] failed to have a reagent holder when attacked with a [W.type]. It was [QDELETED(src) ? "" : "not"] being deleted.")
			else
				reagents.trans_to_obj(U, min(reagents.total_volume,5))
				if (reagents.total_volume <= 0)
					qdel(src)
			return

	if (is_sliceable())
		//these are used to allow hiding edge items in food that is not on a table/tray
		var/can_slice_here = isturf(src.loc) && ((locate(/obj/structure/table) in src.loc) || (locate(/obj/machinery/optable) in src.loc) || (locate(/obj/item/tray) in src.loc))
		var/hide_item = !has_edge(W) || !can_slice_here

		if (hide_item)
			if (W.w_class >= src.w_class || is_robot_module(W) || istype(W,/obj/item/reagent_containers/food/condiment))
				return
			if(!user.unEquip(W, src))
				return

			to_chat(user, "<span class='warning'>You slip \the [W] inside \the [src].</span>")
			add_fingerprint(user)
			W.forceMove(src)
			return

		if (has_edge(W))
			if (!can_slice_here)
				to_chat(user, "<span class='warning'>You cannot slice \the [src] here! You need a table or at least a tray to do it.</span>")
				return

			var/slices_lost = 0
			if (W.w_class > 3)
				user.visible_message("<span class='notice'>\The [user] crudely slices \the [src] with [W]!</span>", "<span class='notice'>You crudely slice \the [src] with your [W]!</span>")
				slices_lost = rand(1,min(1,round(slices_num/2)))
			else
				user.visible_message("<span class='notice'>\The [user] slices \the [src]!</span>", "<span class='notice'>You slice \the [src]!</span>")

			var/reagents_per_slice = reagents.total_volume/slices_num
			for(var/i=1 to (slices_num-slices_lost))
				var/obj/slice = new slice_path (src.loc)
				reagents.trans_to_obj(slice, reagents_per_slice)
			qdel(src)
			return

/obj/item/reagent_containers/food/snacks/proc/is_sliceable()
	return (slices_num && slice_path && slices_num > 0)

/obj/item/reagent_containers/food/snacks/Destroy()
	if(contents)
		for(var/atom/movable/something in contents)
			something.dropInto(loc)
	. = ..()

////////////////////////////////////////////////////////////////////////////////
/// FOOD END
////////////////////////////////////////////////////////////////////////////////
/obj/item/reagent_containers/food/snacks/attack_animal(var/mob/living/user)
	if(!isanimal(user) && !isalien(user))
		return
	user.visible_message("<b>[user]</b> nibbles away at \the [src].","You nibble away at \the [src].")
	bitecount++
	if(reagents && user.reagents)
		reagents.trans_to_mob(user, bitesize, CHEM_INGEST)
	spawn(5)
		if(!src && !user.client)
			user.custom_emote(1,"[pick("burps", "cries for more", "burps twice", "looks at the area where the food was")]")
			qdel(src)
	On_Consume(user)

//////////////////////////////////////////////////
////////////////////////////////////////////Snacks
//////////////////////////////////////////////////
//Items in the "Snacks" subcategory are food items that people actually eat. The key points are that they are created
//	already filled with reagents and are destroyed when empty. Additionally, they make a "munching" noise when eaten.

//Notes by Darem: Food in the "snacks" subtype can hold a maximum of 50 units Generally speaking, you don't want to go over 40
//	total for the item because you want to leave space for extra condiments. If you want effect besides healing, add a reagent for
//	it. Try to stick to existing reagents when possible (so if you want a stronger healing effect, just use Tricordrazine). On use
//	effect (such as the old officer eating a donut code) requires a unique reagent (unless you can figure out a better way).

//The nutriment reagent and bitesize variable replace the old heal_amt and amount variables. Each unit of nutriment is equal to
//	2 of the old heal_amt variable. bitesize is the rate at which the reagents are consumed. So if you have 6 nutriment and a
//	bitesize of 2, then it'll take 3 bites to eat. Unlike the old system, the contained reagents are evenly spread among all
//	the bites. No more contained reagents = no more bites.

//Here is an example of the new formatting for anyone who wants to add more food items.
///obj/item/reagent_containers/food/snacks/xenoburger			//Identification path for the object.
//	name = "Xenoburger"													//Name that displays in the UI.
//	desc = "Smells caustic. Tastes like heresy."						//Duh
//	icon_state = "xburger"												//Refers to an icon in food.dmi
//	New()																//Don't mess with this.
//		..()															//Same here.
//		reagents.add_reagent(/datum/reagent/xenomicrobes, 10)						//This is what is in the food item. you may copy/paste
//		reagents.add_reagent(/datum/reagent/nutriment, 2)							//	this line of code for all the contents.
//		bitesize = 3													//This is the amount each bite consumes.



// The remainder of this file is for miscellaneous food that doesn't fit anywhere else.
// If you can, please put your food item into one of the subfiles in the "snacks" folder!
// You can check the horrifyingly-large "recipes_stove.dm" for the recipes for all food.

/obj/item/reagent_containers/food/snacks/badrecipe
	name = "burned mess"
	desc = "Someone should be demoted from chef for this."
	icon_state = "badrecipe"
	filling_color = "#211f02"
	center_of_mass = "x=16;y=12"
	bitesize = 2
	food_reagents = list(
		/datum/reagent/toxin = 1,
		/datum/reagent/carbon = 3
	)

/obj/item/reagent_containers/food/snacks/friedegg
	name = "fried egg"
	desc = "A fried egg, with a touch of salt and pepper."
	icon_state = "friedegg"
	filling_color = "#ffdf78"
	center_of_mass = "x=16;y=14"
	bitesize = 1
	food_reagents = list(
		/datum/reagent/nutriment/protein/egg = 3,
		/datum/reagent/sodiumchloride = 1,
		/datum/reagent/blackpepper = 1
	)

/obj/item/reagent_containers/food/snacks/boiledegg
	name = "boiled egg"
	desc = "A hard boiled egg."
	icon_state = "egg"
	filling_color = "#ffffff"
	food_reagents = list(/datum/reagent/nutriment/protein/egg = 2)

/obj/item/reagent_containers/food/snacks/organ
	name = "organ"
	desc = "It's good for you."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "appendix"
	filling_color = "#e00d34"
	center_of_mass = "x=16;y=16"
	bitesize = 3

/obj/item/reagent_containers/food/snacks/organ/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/nutriment/protein, rand(3,5))
	reagents.add_reagent(/datum/reagent/toxin, rand(1,3))

/obj/item/reagent_containers/food/snacks/tofurkey
	name = "tofurkey"
	desc = "A fake turkey made from tofu."
	icon_state = "tofurkey"
	filling_color = "#fffee0"
	center_of_mass = "x=16;y=8"
	nutriment_amt = 12
	nutriment_desc = list("turkey" = 3, "tofu" = 5, "goeyness" = 4)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/stuffing
	name = "stuffing"
	desc = "Moist, peppery breadcrumbs for filling the body cavities of dead birds. Dig in!"
	icon_state = "stuffing"
	filling_color = "#c9ac83"
	center_of_mass = "x=16;y=10"
	nutriment_amt = 3
	nutriment_desc = list("dryness" = 2, "bread" = 2)
	bitesize = 1

/obj/item/reagent_containers/food/snacks/donkpocket/sinpocket
	name = "sin-pocket"
	desc = "The food of choice for the veteran. Do <b>NOT</b> overconsume."
	filling_color = "#6d6d00"
	heated_reagents = list(/datum/reagent/drink/doctor_delight = 5, /datum/reagent/medicine/stimulant/hyperzine = 0.75, /datum/reagent/medicine/stimulant/synaptizine = 0.25)
	var/has_been_heated = 0 // Unlike the warm var, this checks if the one-time self-heating operation has been used.

/obj/item/reagent_containers/food/snacks/donkpocket/sinpocket/attack_self(mob/user)
	if(has_been_heated)
		to_chat(user, "<span class='notice'>The heating chemicals have already been spent.</span>")
		return
	has_been_heated = 1
	user.visible_message("<span class='notice'>[user] crushes \the [src] package.</span>", "You crush \the [src] package and feel a comfortable heat build up.")
	addtimer(CALLBACK(src, .proc/heat, weakref(user)), 20 SECONDS)

/obj/item/reagent_containers/food/snacks/donkpocket/sinpocket/heat(weakref/message_to)
	..()
	if(message_to)
		var/mob/user = message_to.resolve()
		if(user)
			to_chat(user, "You think \the [src] is ready to eat about now.")

/obj/item/reagent_containers/food/snacks/donkpocket
	name = "donk-pocket"
	desc = "The food of choice for the seasoned traitor."
	icon_state = "donkpocket"
	filling_color = "#dedeab"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("heartiness" = 1, "dough" = 2)
	nutriment_amt = 2
	var/warm = 0
	var/list/heated_reagents = list(/datum/reagent/medicine/tricordrazine = 5)

/obj/item/reagent_containers/food/snacks/donkpocket/microwave_act(obj/machinery/microwave/M)
	heat()

/obj/item/reagent_containers/food/snacks/donkpocket/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/nutriment/protein, 2)

/obj/item/reagent_containers/food/snacks/donkpocket/proc/heat()
	if(warm)
		return
	warm = 1
	for(var/reagent in heated_reagents)
		reagents.add_reagent(reagent, heated_reagents[reagent])
	bitesize = 6
	SetName("warm " + name)
	addtimer(CALLBACK(src, .proc/cool), 7 MINUTES)

/obj/item/reagent_containers/food/snacks/donkpocket/proc/cool()
	if(!warm)
		return
	warm = 0
	for(var/reagent in heated_reagents)
		reagents.del_reagent(reagent)
	SetName(initial(name))

/obj/item/reagent_containers/food/snacks/omelette
	name = "cheese omelette"
	desc = "Omelette with cheese!"
	icon_state = "omelette"
	trash = /obj/item/trash/plate
	filling_color = "#fff9a8"
	center_of_mass = "x=16;y=13"
	bitesize = 1
	food_reagents = list(/datum/reagent/nutriment/protein = 8)

/obj/item/reagent_containers/food/snacks/eggplantparm
	name = "eggplant parmigiana"
	desc = "The only good recipe for eggplant."
	icon_state = "eggplantparm"
	trash = /obj/item/trash/plate
	filling_color = "#4d2f5e"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("cheese" = 3, "eggplant" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/tofukabob
	name = "tofu-kabob"
	icon_state = "kabob"
	desc = "Vegan meat, on a stick."
	trash = /obj/item/stack/material/rods
	filling_color = "#fffee0"
	center_of_mass = "x=17;y=15"
	nutriment_desc = list("tofu" = 3, "metal" = 1)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/popcorn
	name = "popcorn"
	desc = "Now let's find some cinema."
	icon_state = "popcorn"
	trash = /obj/item/trash/popcorn
	filling_color = "#fffad4"
	center_of_mass = "x=16;y=8"
	nutriment_desc = list("popcorn" = 3)
	nutriment_amt = 2
	bitesize = 0.1

/obj/item/reagent_containers/food/snacks/loadedbakedpotato
	name = "loaded baked potato"
	desc = "Totally baked."
	icon_state = "loadedbakedpotato"
	filling_color = "#9c7a68"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("baked potato" = 3)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/fries
	name = "space fries"
	desc = "AKA: French Fries, Freedom Fries, etc."
	icon_state = "fries"
	trash = /obj/item/trash/plate
	filling_color = "#eddd00"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("fresh fries" = 4)
	nutriment_amt = 4
	bitesize = 2

/obj/item/reagent_containers/food/snacks/onionrings
	name = "onion rings"
	desc = "Like circular fries but better."
	icon_state = "onionrings"
	trash = /obj/item/trash/plate
	filling_color = "#eddd00"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("fried onions" = 5)
	nutriment_amt = 5
	bitesize = 2

/obj/item/reagent_containers/food/snacks/soydope
	name = "soy dope"
	desc = "Dope from a soy."
	icon_state = "soydope"
	trash = /obj/item/trash/plate
	filling_color = "#c4bf76"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("slime" = 2, "soy" = 2)
	nutriment_amt = 2
	bitesize = 2

/obj/item/reagent_containers/food/snacks/cheesyfries
	name = "cheesy fries"
	desc = "Fries. Covered in cheese. Duh."
	icon_state = "cheesyfries"
	trash = /obj/item/trash/plate
	filling_color = "#eddd00"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("fresh fries" = 3, "cheese" = 3)
	nutriment_amt = 4
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 2)

/obj/item/reagent_containers/food/snacks/fortunecookie
	name = "fortune cookie"
	desc = "A true prophecy in each cookie!"
	icon_state = "fortune_cookie"
	filling_color = "#e8e79e"
	center_of_mass = "x=15;y=14"
	nutriment_desc = list("fortune cookie" = 2)
	nutriment_amt = 3
	bitesize = 2

/obj/item/reagent_containers/food/snacks/enchiladas
	name = "enchiladas"
	desc = "Viva La Space Mexico!"
	icon_state = "enchiladas"
	trash = /obj/item/trash/tray
	filling_color = "#a36a1f"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("tortilla" = 3, "corn" = 3)
	nutriment_amt = 2
	bitesize = 4
	food_reagents = list(
		/datum/reagent/nutriment/protein = 6,
		/datum/reagent/capsaicin = 6
	)

/obj/item/reagent_containers/food/snacks/monkeysdelight
	name = "monkey's delight"
	desc = "Eeee Eee!"
	icon_state = "monkeysdelight"
	trash = /obj/item/trash/tray
	filling_color = "#5c3c11"
	center_of_mass = "x=16;y=13"
	bitesize = 6
	food_reagents = list(
		/datum/reagent/nutriment/protein = 10,
		/datum/reagent/drink/juice/banana = 5,
		/datum/reagent/blackpepper = 1,
		/datum/reagent/sodiumchloride = 1
	)

/obj/item/reagent_containers/food/snacks/fishandchips
	name = "fish and chips"
	desc = "I do say so myself chap."
	icon_state = "fishandchips"
	filling_color = "#e3d796"
	center_of_mass = "x=16;y=16"
	nutriment_desc = list("salt" = 1, "chips" = 3)
	nutriment_amt = 3
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/rofflewaffles
	name = "roffle waffles"
	desc = "Waffles from Roffle. Co."
	icon_state = "rofflewaffles"
	trash = /obj/item/trash/waffles
	filling_color = "#ff00f7"
	center_of_mass = "x=15;y=11"
	nutriment_desc = list("waffle" = 7, "sweetness" = 1)
	nutriment_amt = 8
	bitesize = 4
	food_reagents = list(
		/datum/reagent/psilocybin = 8
	)


/obj/item/reagent_containers/food/snacks/stewedsoymeat
	name = "stewed soy meat"
	desc = "Even non-vegetarians will LOVE this!"
	icon_state = "stewedsoymeat"
	trash = /obj/item/trash/plate
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("soy" = 4, "tomato" = 4)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/boiledrice
	name = "boiled rice"
	desc = "A boring dish of boring rice."
	icon_state = "boiledrice"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#fffbdb"
	center_of_mass = "x=17;y=11"
	nutriment_desc = list("rice" = 2)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/boiledrice/chazuke
	name = "chazuke"
	desc = "An ancient way of using up day-old rice, this dish is composed of plain green tea poured over plain white rice. Hopefully you have something else to put in."
	icon_state = "chazuke"
	filling_color = "#f1ffdb"
	nutriment_desc = list("chazuke" = 2)
	bitesize = 3

/obj/item/reagent_containers/food/snacks/katsucurry
	name = "katsu curry"
	desc = "An oriental curry dish made from apples, potatoes, and carrots. Served with rice and breaded chicken."
	icon_state = "katsu"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#faa005"
	center_of_mass = "x=17;y=11"
	nutriment_desc = list("rice" = 2, "apple" = 2, "potato" = 2, "carrot" = 2, "bread" = 2, )
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/ricepudding
	name = "rice pudding"
	desc = "Where's the jam?"
	icon_state = "rpudding"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#fffbdb"
	center_of_mass = "x=17;y=11"
	nutriment_desc = list("rice" = 2)
	nutriment_amt = 4
	bitesize = 2
/obj/item/reagent_containers/food/snacks/carrotfries
	name = "carrot fries"
	desc = "Tasty fries from fresh carrots."
	icon_state = "carrotfries"
	trash = /obj/item/trash/plate
	filling_color = "#faa005"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("carrot" = 3, "salt" = 1)
	nutriment_amt = 3
	bitesize = 2
	food_reagents = list(/datum/reagent/medicine/imidazoline = 4)

/obj/item/reagent_containers/food/snacks/boiledslimecore
	name = "boiled slime core"
	desc = "A boiled red thing."
	icon_state = "boiledslimecore"//nonexistant?
	bitesize = 3
	food_reagents = list(/datum/reagent/slime_jelly = 5)

/obj/item/reagent_containers/food/snacks/chawanmushi
	name = "chawanmushi"
	desc = "A legendary egg custard that makes friends out of enemies. Probably too hot for a cat to eat."
	icon_state = "chawanmushi"
	trash = /obj/item/trash/snack_bowl
	filling_color = "#f0f2e4"
	center_of_mass = "x=17;y=10"
	bitesize = 1
	food_reagents = list(/datum/reagent/nutriment/protein = 5)


/////////////////////////////////////////////////Sliceable////////////////////////////////////////
// All the food items that can be sliced into smaller bits like meatbread and cheesewheels

// sliceable is just an organization type path, it doesn't have any additional code or variables tied to it.

/obj/item/reagent_containers/food/snacks/sliceable
	w_class = ITEM_SIZE_NORMAL //whole pizzas and cakes shouldn't fit in a pocket, you can slice them if you want to do that.

/**
 *  A food item slice
 *
 *  This path contains some extra code for spawning slices pre-filled with
 *  reagents.
 */
/obj/item/reagent_containers/food/snacks/slice
	name = "slice of... something"
	var/whole_path // path for the item from which this slice comes
	var/filled = FALSE // should the slice spawn with any reagents

/**
 *  Spawn a new slice of food
 *
 *  If the slice's filled is TRUE, this will also fill the slice with the
 *  appropriate amount of reagents. Note that this is done by spawning a new
 *  whole item, transferring the reagents and deleting the whole item, which may
 *  have performance implications.
 */
/obj/item/reagent_containers/food/snacks/slice/Initialize()
	. = ..()
	if(filled)
		var/obj/item/reagent_containers/food/snacks/whole = new whole_path()
		if(whole && whole.slices_num)
			var/reagent_amount = whole.reagents.total_volume/whole.slices_num
			whole.reagents.trans_to_obj(src, reagent_amount)

		qdel(whole)

/obj/item/reagent_containers/food/snacks/watermelonslice
	name = "watermelon slice"
	desc = "A slice of watery goodness."
	icon_state = "watermelonslice"
	filling_color = "#ff3867"
	bitesize = 2
	center_of_mass = "x=16;y=10"

/////////////////////////////////////////////////PIZZA////////////////////////////////////////


/obj/item/pizzabox
	name = "pizza box"
	desc = "A box suited for pizzas."
	icon = 'icons/obj/food.dmi'
	icon_state = "pizzabox1"

	var/open = 0 // Is the box open?
	var/ismessy = 0 // Fancy mess on the lid
	var/obj/item/reagent_containers/food/snacks/sliceable/pizza/pizza // content pizza
	var/list/boxes = list()// If the boxes are stacked, they come here
	var/boxtag = ""

/obj/item/pizzabox/on_update_icon()

	cut_overlays()

	// Set appropriate description
	if( open && pizza )
		desc = "A box suited for pizzas. It appears to have a [pizza.name] inside."
	else if( boxes.len > 0 )
		desc = "A pile of boxes suited for pizzas. There appears to be [boxes.len + 1] boxes in the pile."

		var/obj/item/pizzabox/topbox = boxes[boxes.len]
		var/toptag = topbox.boxtag
		if( toptag != "" )
			desc = "[desc] The box on top has a tag, it reads: '[toptag]'."
	else
		desc = "A box suited for pizzas."

		if( boxtag != "" )
			desc = "[desc] The box has a tag, it reads: '[boxtag]'."

	// Icon states and overlays
	if( open )
		if( ismessy )
			icon_state = "pizzabox_messy"
		else
			icon_state = "pizzabox_open"

		if( pizza )
			var/image/pizzaimg = image("food.dmi", icon_state = pizza.icon_state)
			pizzaimg.pixel_y = -3
			add_overlay(pizzaimg)

		return
	else
		// Stupid code because byondcode sucks
		var/doimgtag = 0
		if( boxes.len > 0 )
			var/obj/item/pizzabox/topbox = boxes[boxes.len]
			if( topbox.boxtag != "" )
				doimgtag = 1
		else
			if( boxtag != "" )
				doimgtag = 1

		if( doimgtag )
			var/image/tagimg = image("food.dmi", icon_state = "pizzabox_tag")
			tagimg.pixel_y = boxes.len * 3
			add_overlay(tagimg)

	icon_state = "pizzabox[boxes.len+1]"

/obj/item/pizzabox/attack_hand( mob/user as mob )

	if( open && pizza )
		user.put_in_hands( pizza )

		to_chat(user, "<span class='warning'>You take \the [src.pizza] out of \the [src].</span>")
		src.pizza = null
		update_icon()
		return

	if( boxes.len > 0 )
		if( user.get_inactive_hand() != src )
			..()
			return

		var/obj/item/pizzabox/box = boxes[boxes.len]
		boxes -= box

		user.put_in_hands( box )
		to_chat(user, "<span class='warning'>You remove the topmost [src] from your hand.</span>")
		box.update_icon()
		update_icon()
		return
	..()

/obj/item/pizzabox/attack_self( mob/user as mob )

	if( boxes.len > 0 )
		return

	open = !open

	if( open && pizza )
		ismessy = 1

	update_icon()

/obj/item/pizzabox/attackby( obj/item/I as obj, mob/user as mob )
	if( istype(I, /obj/item/pizzabox/) )
		var/obj/item/pizzabox/box = I

		if( !box.open && !src.open )
			// make a list of all boxes to be added
			var/list/boxestoadd = list()
			boxestoadd += box
			for(var/obj/item/pizzabox/i in box.boxes)
				boxestoadd += i

			if( (boxes.len+1) + boxestoadd.len <= 5 )
				if(!user.unEquip(box, src))
					return
				box.boxes = list()// clear the box boxes so we don't have boxes inside boxes. - Xzibit
				src.boxes.Add( boxestoadd )

				box.update_icon()
				update_icon()

				to_chat(user, "<span class='warning'>You put \the [box] ontop of \the [src]!</span>")
			else
				to_chat(user, "<span class='warning'>The stack is too high!</span>")
		else
			to_chat(user, "<span class='warning'>Close \the [box] first!</span>")

		return

	if( istype(I, /obj/item/reagent_containers/food/snacks/sliceable/pizza/) )

		if( src.open )
			if(!user.unEquip(I, src))
				return
			src.pizza = I

			update_icon()

			to_chat(user, "<span class='warning'>You put \the [I] in \the [src]!</span>")
		else
			to_chat(user, "<span class='warning'>You try to push \the [I] through the lid but it doesn't work!</span>")
		return

	if( istype(I, /obj/item/pen/) )

		if( src.open )
			return

		var/t = sanitize(input("Enter what you want to add to the tag:", "Write", null, null) as text, 30)

		var/obj/item/pizzabox/boxtotagto = src
		if( boxes.len > 0 )
			boxtotagto = boxes[boxes.len]

		boxtotagto.boxtag = copytext("[boxtotagto.boxtag][t]", 1, 30)

		update_icon()
		return
	..()

/obj/item/pizzabox/margherita/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/margherita(src)
	boxtag = "Margherita Deluxe"

/obj/item/pizzabox/vegetable/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza(src)
	boxtag = "Gourmet Vegatable"

/obj/item/pizzabox/mushroom/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/mushroompizza(src)
	boxtag = "Mushroom Special"

/obj/item/pizzabox/meat/Initialize()
	. = ..()
	pizza = new /obj/item/reagent_containers/food/snacks/sliceable/pizza/meatpizza(src)
	boxtag = "Meatlover's Supreme"

/obj/item/reagent_containers/food/snacks/dionaroast
	name = "roast diona"
	desc = "It's like an enormous, leathery carrot. With an eye."
	icon_state = "dionaroast"
	trash = /obj/item/trash/plate
	filling_color = "#75754b"
	center_of_mass = "x=16;y=7"
	nutriment_desc = list("a chorus of flavor" = 6)
	nutriment_amt = 6
	bitesize = 2
	food_reagents = list(/datum/reagent/radium = 2)

/obj/item/reagent_containers/food/snacks/taco
	name = "taco"
	desc = "Take a bite!"
	icon_state = "taco"
	bitesize = 3
	center_of_mass = "x=21;y=12"
	nutriment_desc = list("cheese" = 2,"taco shell" = 2)
	nutriment_amt = 4
	food_reagents = list(/datum/reagent/nutriment/protein = 3)

/obj/item/reagent_containers/food/snacks/hotdog
	name = "hotdog"
	desc = "Unrelated to dogs, maybe."
	icon_state = "hotdog"
	bitesize = 2
	center_of_mass = "x=16;y=17"
	food_reagents = list(/datum/reagent/nutriment/protein = 6)

/obj/item/reagent_containers/food/snacks/classichotdog
	name = "classic hotdog"
	desc = "Going literal."
	icon_state = "hotcorgi"
	bitesize = 6
	center_of_mass = "x=16;y=17"
	food_reagents = list(/datum/reagent/nutriment/protein = 16)

// potato + knife = raw sticks
/obj/item/reagent_containers/food/snacks/grown/potato/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W,/obj/item/material/knife))
		new /obj/item/reagent_containers/food/snacks/rawsticks(src)
		to_chat(user, "You cut the potato.")
		qdel(src)
	else
		..()

/obj/item/reagent_containers/food/snacks/rawsticks
	name = "raw potato sticks"
	desc = "Raw fries, not very tasty."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "rawsticks"
	bitesize = 2
	center_of_mass = "x=16;y=12"
	nutriment_desc = list("raw potato" = 3)
	nutriment_amt = 3

/obj/item/reagent_containers/food/snacks/proteinbar
	name = "protein bar"
	desc = "SwoleMAX brand protein bars, guaranteed to get you feeling perfectly overconfident."
	icon_state = "proteinbar"
	trash = /obj/item/trash/proteinbar
	nutriment_amt = 9
	bitesize = 6
	atom_flags = ATOM_FLAG_OPEN_CONTAINER | ATOM_FLAG_NO_REACT
	food_reagents = list(/datum/reagent/nutriment/protein = 4)

/obj/item/reagent_containers/food/snacks/proteinbar/Initialize()
	. = ..()
	var/flavor = pick(GLOB.proteinbar_flavors)
	var/flavor_type = GLOB.proteinbar_flavors[flavor]
	var/count = length(flavor_type)
	if (count)
		for (var/type in flavor_type)
			reagents.add_reagent(type, round(4 / count, 0.1))
	else
		reagents.add_reagent(flavor_type, 4)
	name = "[flavor] [name]"

//inedible old vendor food

/obj/item/reagent_containers/food/snacks/old
	name = "master old-food"
	desc = "They're all inedible and potentially dangerous items."
	center_of_mass = "x=15;y=12"
	nutriment_desc = list("rot" = 5, "mold" = 5)
	nutriment_amt = 10
	bitesize = 3
	filling_color = "#336b42"

/obj/item/reagent_containers/food/snacks/old/Initialize()
	. = ..()
	reagents.add_reagent(pick(list(
				/datum/reagent/fuel,
				/datum/reagent/toxin/amatoxin,
				/datum/reagent/toxin/carpotoxin,
				/datum/reagent/toxin/zombie_powder,
				/datum/reagent/cryptobiolin,
				/datum/reagent/psilocybin)), 5)


/obj/item/reagent_containers/food/snacks/old/pizza
	name = "pizza"
	desc = "It's so stale you could probably cut something with the cheese."
	icon_state = "ancient_pizza"

/obj/item/reagent_containers/food/snacks/old/burger
	name = "giga burger"
	desc = "At some point in time this probably looked delicious."
	icon_state = "ancient_burger"

/obj/item/reagent_containers/food/snacks/old/hamburger
	name = "horse burger"
	desc = "Even if you were hungry enough to eat a horse, it'd be a bad idea to eat this."
	icon_state = "ancient_hburger"

/obj/item/reagent_containers/food/snacks/old/fries
	name = "space fries"
	desc = "The salt appears to have preserved these, still stale and gross."
	icon_state = "ancient_fries"

/obj/item/reagent_containers/food/snacks/old/hotdog
	name = "space dog"
	desc = "This one is probably only marginally less safe to eat than when it was first created.."
	icon_state = "ancient_hotdog"

/obj/item/reagent_containers/food/snacks/old/taco
	name = "taco"
	desc = "Interestingly, the shell has gone soft and the contents have gone stale."
	icon_state = "ancient_taco"
