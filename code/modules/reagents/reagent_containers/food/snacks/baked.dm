// Any non-specialized foods that involve bread are here. Bread loaves, pies, pastries, biscuits, and so on.

////////////
// BREADS //
////////////

/obj/item/reagent_containers/food/snacks/sliceable/bread
	name = "bread"
	desc = "Some plain old Earthen bread."
	icon_state = "bread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/bread
	slices_num = 5
	filling_color = "#ffe396"
	center_of_mass = "x=16;y=9"
	nutriment_desc = list("bread" = 6)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/slice/bread
	name = "bread slice"
	desc = "A slice of home."
	icon_state = "breadslice"
	trash = /obj/item/trash/plate
	filling_color = "#d27332"
	bitesize = 2
	center_of_mass = "x=16;y=4"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/bread

/obj/item/reagent_containers/food/snacks/slice/bread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/creamcheesebread
	name = "cream cheese bread"
	desc = "Yum yum yum!"
	icon_state = "creamcheesebread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/creamcheesebread
	slices_num = 5
	filling_color = "#fff896"
	center_of_mass = "x=16;y=9"
	nutriment_desc = list("bread" = 6, "cream" = 3, "cheese" = 3)
	nutriment_amt = 5
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 15)

/obj/item/reagent_containers/food/snacks/slice/creamcheesebread
	name = "cream cheese bread slice"
	desc = "A slice of yum!"
	icon_state = "creamcheesebreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#fff896"
	bitesize = 2
	center_of_mass = "x=16;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/creamcheesebread

/obj/item/reagent_containers/food/snacks/slice/creamcheesebread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/twobread
	name = "two bread"
	desc = "It is very bitter and winy."
	icon_state = "twobread"
	filling_color = "#dbcc9a"
	center_of_mass = "x=15;y=12"
	nutriment_desc = list("sourness" = 2, "bread" = 2)
	nutriment_amt = 2
	bitesize = 3

/obj/item/reagent_containers/food/snacks/threebread
	name = "three bread"
	desc = "Is such a thing even possible?"
	icon_state = "threebread"
	filling_color = "#dbcc9a"
	center_of_mass = "x=15;y=12"
	nutriment_desc = list("sourness" = 2, "bread" = 3)
	nutriment_amt = 3
	bitesize = 4

/obj/item/reagent_containers/food/snacks/sliceable/meatbread
	name = "meatbread loaf"
	desc = "The culinary base of every self-respecting eloquen/tg/entleman."
	icon_state = "meatbread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/meatbread
	slices_num = 5
	filling_color = "#ff7575"
	center_of_mass = "x=19;y=9"
	nutriment_desc = list("bread" = 10)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 20)

/obj/item/reagent_containers/food/snacks/slice/meatbread
	name = "meatbread slice"
	desc = "A slice of delicious meatbread."
	icon_state = "meatbreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#ff7575"
	bitesize = 2
	center_of_mass = "x=16;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/meatbread

/obj/item/reagent_containers/food/snacks/slice/meatbread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/xenomeatbread
	name = "xenomeatbread loaf"
	desc = "The culinary base of every self-respecting eloquent gentleman. Extra Heretical."
	icon_state = "xenomeatbread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/xenomeatbread
	slices_num = 5
	filling_color = "#8aff75"
	center_of_mass = "x=16;y=9"
	nutriment_desc = list("bread" = 10)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 20)

/obj/item/reagent_containers/food/snacks/slice/xenomeatbread
	name = "xenomeatbread slice"
	desc = "A slice of delicious meatbread. Extra Heretical."
	icon_state = "xenobreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#8aff75"
	bitesize = 2
	center_of_mass = "x=16;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/xenomeatbread

/obj/item/reagent_containers/food/snacks/slice/xenomeatbread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/bananabread
	name = "banana-nut bread"
	desc = "A heavenly and filling treat."
	icon_state = "bananabread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/bananabread
	slices_num = 5
	filling_color = "#ede5ad"
	center_of_mass = "x=16;y=9"
	nutriment_desc = list("bread" = 10)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(/datum/reagent/drink/juice/banana = 20)

/obj/item/reagent_containers/food/snacks/slice/bananabread
	name = "banana-nut bread slice"
	desc = "A slice of delicious banana bread."
	icon_state = "bananabreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#ede5ad"
	bitesize = 2
	center_of_mass = "x=16;y=8"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/bananabread

/obj/item/reagent_containers/food/snacks/slice/bananabread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/tofubread
	name = "tofubread"
	desc = "Like meatbread but for vegetarians. Not guaranteed to give superpowers."
	icon_state = "tofubread"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/tofubread
	slices_num = 5
	filling_color = "#f7ffe0"
	center_of_mass = "x=16;y=9"
	nutriment_desc = list("tofu" = 10)
	nutriment_amt = 10
	bitesize = 2

/obj/item/reagent_containers/food/snacks/slice/tofubread
	name = "tofubread slice"
	desc = "A slice of delicious tofubread."
	icon_state = "tofubreadslice"
	trash = /obj/item/trash/plate
	filling_color = "#f7ffe0"
	bitesize = 2
	center_of_mass = "x=16;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/tofubread

/obj/item/reagent_containers/food/snacks/slice/tofubread/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/baguette
	name = "baguette"
	desc = "Bon appetit!"
	icon_state = "baguette"
	filling_color = "#e3d796"
	center_of_mass = "x=18;y=12"
	nutriment_desc = list("french bread" = 6)
	nutriment_amt = 6
	bitesize = 3
	food_reagents = list(
		/datum/reagent/blackpepper = 1,
		/datum/reagent/sodiumchloride = 1
	)

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit
	name = "plump helmet biscuit"
	desc = "This is a finely-prepared plump helmet biscuit. The ingredients are exceptionally minced plump helmet, and well-minced dwarven wheat flour."
	icon_state = "phelmbiscuit"
	filling_color = "#cfb4c4"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("mushroom" = 4)
	nutriment_amt = 5
	bitesize = 2

/obj/item/reagent_containers/food/snacks/plumphelmetbiscuit/Initialize()
	. = ..()
	if(prob(10))
		name = "exceptional plump helmet biscuit"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump helmet biscuit!"
		reagents.add_reagent(/datum/reagent/nutriment, 3)
		reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 5)

/obj/item/reagent_containers/food/snacks/cracker
	name = "cracker"
	desc = "It's a salted cracker."
	icon_state = "cracker"
	filling_color = "#f5deb8"
	center_of_mass = "x=17;y=6"
	nutriment_desc = list("salt" = 1, "cracker" = 2)
	w_class = ITEM_SIZE_TINY
	nutriment_amt = 1

/obj/item/reagent_containers/food/snacks/bunbun
	name = "bun bun"
	desc = "A small bread monkey fashioned from two burger buns."
	icon_state = "bunbun"
	bitesize = 2
	center_of_mass = list("x"=16, "y"=8)
	nutriment_desc = list("bun" = 8)
	nutriment_amt = 8

/obj/item/reagent_containers/food/snacks/flatbread
	name = "flatbread"
	desc = "Bland but filling."
	icon = 'icons/obj/food_ingredients.dmi'
	icon_state = "flatbread"
	bitesize = 2
	center_of_mass = "x=16;y=16"
	nutriment_desc = list("bread" = 3)
	nutriment_amt = 3

//////////
// PIES //
//////////

/obj/item/reagent_containers/food/snacks/bananapie
	name = "banana cream pie"
	desc = "Just like back home, on clown planet! HONK!"
	icon_state = "pie"
	trash = /obj/item/trash/plate
	filling_color = "#fbffb8"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("pie" = 3, "cream" = 2)
	nutriment_amt = 4
	bitesize = 3
	food_reagents = list(/datum/reagent/drink/juice/banana = 5)

/obj/item/reagent_containers/food/snacks/bananapie/throw_impact(atom/hit_atom)
	..()
	new/obj/effect/decal/cleanable/pie_smudge(src.loc)
	src.visible_message("<span class='danger'>\The [src.name] splats.</span>","<span class='danger'>You hear a splat.</span>")
	qdel(src)

/obj/item/reagent_containers/food/snacks/meatpie
	name = "meat-pie"
	icon_state = "meatpie"
	desc = "An old barber recipe, very delicious!"
	trash = /obj/item/trash/plate
	filling_color = "#948051"
	center_of_mass = "x=16;y=13"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

/obj/item/reagent_containers/food/snacks/tofupie
	name = "tofu-pie"
	icon_state = "meatpie"
	desc = "A delicious tofu pie."
	trash = /obj/item/trash/plate
	filling_color = "#fffee0"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("tofu" = 2, "pie" = 8)
	nutriment_amt = 10
	bitesize = 2

/obj/item/reagent_containers/food/snacks/amanita_pie
	name = "amanita pie"
	desc = "Sweet and tasty poison pie."
	icon_state = "amanita_pie"
	filling_color = "#ffcccc"
	center_of_mass = "x=17;y=9"
	nutriment_desc = list("sweetness" = 3, "mushroom" = 3, "pie" = 2)
	nutriment_amt = 5
	bitesize = 3
	food_reagents = list(
		/datum/reagent/toxin/amatoxin = 3,
		/datum/reagent/psilocybin = 1
	)

/obj/item/reagent_containers/food/snacks/plump_pie
	name = "plump pie"
	desc = "I bet you love stuff made out of plump helmets!"
	icon_state = "plump_pie"
	filling_color = "#b8279b"
	center_of_mass = "x=17;y=9"
	nutriment_desc = list("heartiness" = 2, "mushroom" = 3, "pie" = 3)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/plump_pie/Initialize()
	. = ..()
	if(prob(10))
		name = "exceptional plump pie"
		desc = "Microwave is taken by a fey mood! It has cooked an exceptional plump pie!"
		reagents.add_reagent(/datum/reagent/medicine/tricordrazine, 5)

/obj/item/reagent_containers/food/snacks/xemeatpie
	name = "xeno-pie"
	icon_state = "xenomeatpie"
	desc = "A delicious meatpie. Probably heretical."
	trash = /obj/item/trash/plate
	filling_color = "#43de18"
	center_of_mass = "x=16;y=13"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

/obj/item/reagent_containers/food/snacks/applepie
	name = "apple pie"
	desc = "A pie containing sweet sweet love... or apple."
	icon_state = "applepie"
	filling_color = "#e0edc5"
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("sweetness" = 2, "apple" = 2, "pie" = 2)
	nutriment_amt = 4
	bitesize = 3

/obj/item/reagent_containers/food/snacks/cherrypie
	name = "cherry pie"
	desc = "Taste so good, make a grown man cry."
	icon_state = "cherrypie"
	filling_color = "#ff525a"
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("sweetness" = 2, "cherry" = 2, "pie" = 2)
	nutriment_amt = 4
	bitesize = 3

///////////
// CAKES //
///////////

/obj/item/reagent_containers/food/snacks/sliceable/carrotcake
	name = "carrot cake"
	desc = "A favorite desert of a certain wascally wabbit. Not a lie."
	icon_state = "carrotcake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/carrotcake
	slices_num = 5
	filling_color = "#ffd675"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "carrot" = 15)
	nutriment_amt = 25
	bitesize = 2
	food_reagents = list(/datum/reagent/medicine/imidazoline = 10)

/obj/item/reagent_containers/food/snacks/slice/carrotcake
	name = "carrot cake slice"
	desc = "Carrotty slice of carrot cake, carrots are good for your eyes! Also not a lie."
	icon_state = "carrotcake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#ffd675"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/carrotcake

/obj/item/reagent_containers/food/snacks/slice/carrotcake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/braincake
	name = "brain cake"
	desc = "A squishy cake-thing."
	icon_state = "braincake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/braincake
	slices_num = 5
	filling_color = "#e6aedb"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "slime" = 15)
	nutriment_amt = 5
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 25,
		/datum/reagent/medicine/alkysine = 10
	)

/obj/item/reagent_containers/food/snacks/slice/braincake
	name = "brain cake slice"
	desc = "Lemme tell you something about prions. THEY'RE DELICIOUS."
	icon_state = "braincakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#e6aedb"
	bitesize = 2
	center_of_mass = "x=16;y=12"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/braincake

/obj/item/reagent_containers/food/snacks/slice/braincake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/cheesecake
	name = "cheese cake"
	desc = "DANGEROUSLY cheesy."
	icon_state = "cheesecake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/cheesecake
	slices_num = 5
	filling_color = "#faf7af"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "cream" = 10, "cheese" = 15)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 15)

/obj/item/reagent_containers/food/snacks/slice/cheesecake
	name = "cheese cake slice"
	desc = "Slice of pure cheestisfaction."
	icon_state = "cheesecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#faf7af"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/cheesecake

/obj/item/reagent_containers/food/snacks/slice/cheesecake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/plaincake
	name = "vanilla cake"
	desc = "A plain cake, not a lie."
	icon_state = "plaincake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/plaincake
	slices_num = 5
	filling_color = "#f7edd5"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "vanilla" = 15)
	nutriment_amt = 20

/obj/item/reagent_containers/food/snacks/slice/plaincake
	name = "vanilla cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "plaincake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#f7edd5"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/plaincake

/obj/item/reagent_containers/food/snacks/slice/plaincake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/orangecake
	name = "orange cake"
	desc = "A cake with added orange."
	icon_state = "orangecake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/orangecake
	slices_num = 5
	filling_color = "#fada8e"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "orange" = 15)
	nutriment_amt = 20

/obj/item/reagent_containers/food/snacks/slice/orangecake
	name = "orange cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "orangecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#fada8e"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/orangecake

/obj/item/reagent_containers/food/snacks/slice/orangecake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/limecake
	name = "lime cake"
	desc = "A cake with added lime."
	icon_state = "limecake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/limecake
	slices_num = 5
	filling_color = "#cbfa8e"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "lime" = 15)
	nutriment_amt = 20

/obj/item/reagent_containers/food/snacks/slice/limecake
	name = "lime cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "limecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#cbfa8e"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/limecake

/obj/item/reagent_containers/food/snacks/slice/limecake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/lemoncake
	name = "lemon cake"
	desc = "A cake with added lemon."
	icon_state = "lemoncake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/lemoncake
	slices_num = 5
	filling_color = "#fafa8e"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "lemon" = 15)
	nutriment_amt = 20

/obj/item/reagent_containers/food/snacks/slice/lemoncake
	name = "lemon cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "lemoncake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#fafa8e"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/lemoncake

/obj/item/reagent_containers/food/snacks/slice/lemoncake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/chocolatecake
	name = "chocolate cake"
	desc = "A cake with added chocolate."
	icon_state = "chocolatecake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/chocolatecake
	slices_num = 5
	filling_color = "#805930"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "chocolate" = 15)
	nutriment_amt = 20

/obj/item/reagent_containers/food/snacks/slice/chocolatecake
	name = "chocolate cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "chocolatecake_slice"
	trash = /obj/item/trash/plate
	filling_color = "#805930"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/chocolatecake

/obj/item/reagent_containers/food/snacks/slice/chocolatecake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/birthdaycake
	name = "birthday cake"
	desc = "Happy birthday!"
	icon_state = "birthdaycake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/birthdaycake
	slices_num = 5
	filling_color = "#ffd6d6"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10)
	nutriment_amt = 20
	bitesize = 3
	food_reagents = list(/datum/reagent/nutriment/sprinkles = 10)


/obj/item/reagent_containers/food/snacks/slice/birthdaycake
	name = "birthday cake slice"
	desc = "A slice of your birthday."
	icon_state = "birthdaycakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#ffd6d6"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/birthdaycake

/obj/item/reagent_containers/food/snacks/slice/birthdaycake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/applecake
	name = "apple cake"
	desc = "A cake centred with apples."
	icon_state = "applecake"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/applecake
	slices_num = 5
	filling_color = "#ebf5b8"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("cake" = 10, "sweetness" = 10, "apple" = 15)
	nutriment_amt = 15

/obj/item/reagent_containers/food/snacks/slice/applecake
	name = "apple cake slice"
	desc = "A slice of heavenly cake."
	icon_state = "applecakeslice"
	trash = /obj/item/trash/plate
	filling_color = "#ebf5b8"
	bitesize = 2
	center_of_mass = "x=16;y=14"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/applecake

/obj/item/reagent_containers/food/snacks/slice/applecake/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/pumpkinpie
	name = "pumpkin pie"
	desc = "A delicious treat for the autumn months."
	icon_state = "pumpkinpie"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/pumpkinpie
	slices_num = 5
	filling_color = "#f5b951"
	center_of_mass = "x=16;y=10"
	nutriment_desc = list("pie" = 5, "cream" = 5, "pumpkin" = 5)
	nutriment_amt = 15

/obj/item/reagent_containers/food/snacks/slice/pumpkinpie
	name = "pumpkin pie slice"
	desc = "A slice of pumpkin pie, with whipped cream on top. Perfection."
	icon_state = "pumpkinpieslice"
	trash = /obj/item/trash/plate
	filling_color = "#f5b951"
	bitesize = 2
	center_of_mass = "x=16;y=12"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/pumpkinpie

/obj/item/reagent_containers/food/snacks/slice/pumpkinpie/filled
	filled = TRUE

///////////
// PIZZA //
///////////

/obj/item/reagent_containers/food/snacks/sliceable/pizza
	slices_num = 6
	filling_color = "#baa14c"

/obj/item/reagent_containers/food/snacks/sliceable/pizza/margherita
	name = "margherita"
	desc = "The golden standard of pizzas."
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/margherita
	slices_num = 6
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("pizza crust" = 10, "tomato" = 10, "cheese" = 15)
	nutriment_amt = 35
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 5,
		/datum/reagent/drink/juice/tomato = 6
	)

/obj/item/reagent_containers/food/snacks/slice/margherita
	name = "margherita slice"
	desc = "A slice of the classic pizza."
	icon_state = "pizzamargheritaslice"
	filling_color = "#baa14c"
	bitesize = 2
	center_of_mass = "x=18;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/pizza/margherita

/obj/item/reagent_containers/food/snacks/slice/margherita/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/pizza/meatpizza
	name = "meatpizza"
	desc = "A pizza with meat topping."
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/meatpizza
	slices_num = 6
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("pizza crust" = 10, "tomato" = 10, "cheese" = 15)
	nutriment_amt = 10
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 34,
		/datum/reagent/drink/juice/tomato = 6
	)

/obj/item/reagent_containers/food/snacks/slice/meatpizza
	name = "meatpizza slice"
	desc = "A slice of a meaty pizza."
	icon_state = "meatpizzaslice"
	filling_color = "#baa14c"
	bitesize = 2
	center_of_mass = "x=18;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/pizza/meatpizza

/obj/item/reagent_containers/food/snacks/slice/meatpizza/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/pizza/mushroompizza
	name = "mushroompizza"
	desc = "Very special pizza."
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/mushroompizza
	slices_num = 6
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("pizza crust" = 10, "tomato" = 10, "cheese" = 5, "mushroom" = 10)
	nutriment_amt = 35
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 5)

/obj/item/reagent_containers/food/snacks/slice/mushroompizza
	name = "mushroompizza slice"
	desc = "Maybe it is the last slice of pizza in your life."
	icon_state = "mushroompizzaslice"
	filling_color = "#baa14c"
	bitesize = 2
	center_of_mass = "x=18;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/pizza/mushroompizza

/obj/item/reagent_containers/food/snacks/slice/mushroompizza/filled
	filled = TRUE

/obj/item/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza
	name = "vegetable pizza"
	desc = "No one of Tomato Sapiens were harmed during making this pizza."
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/slice/vegetablepizza
	slices_num = 6
	center_of_mass = "x=16;y=11"
	nutriment_desc = list("pizza crust" = 10, "tomato" = 10, "cheese" = 5, "eggplant" = 5, "carrot" = 5, "corn" = 5)
	nutriment_amt = 25
	bitesize = 2
	food_reagents = list(
		/datum/reagent/nutriment/protein = 5,
		/datum/reagent/drink/juice/tomato = 6,
		/datum/reagent/medicine/imidazoline = 12
	)

/obj/item/reagent_containers/food/snacks/slice/vegetablepizza
	name = "vegetable pizza slice"
	desc = "A slice of the most green pizza of all pizzas not containing green ingredients."
	icon_state = "vegetablepizzaslice"
	filling_color = "#baa14c"
	bitesize = 2
	center_of_mass = "x=18;y=13"
	whole_path = /obj/item/reagent_containers/food/snacks/sliceable/pizza/vegetablepizza

/obj/item/reagent_containers/food/snacks/slice/vegetablepizza/filled
	filled = TRUE

//////////////////////////
// PANCAKES AND WAFFLES //
//////////////////////////

/obj/item/reagent_containers/food/snacks/waffles
	name = "waffles"
	desc = "Mmm, waffles."
	icon_state = "waffles"
	trash = /obj/item/trash/waffles
	filling_color = "#e6deb5"
	center_of_mass = "x=15;y=11"
	nutriment_desc = list("waffle" = 8)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/pancakesblu
	name = "blueberry pancakes"
	desc = "Pancakes with blueberries, delicious."
	icon_state = "pancakes"
	trash = /obj/item/trash/plate
	center_of_mass = "x=15;y=11"
	nutriment_desc = list("pancake" = 8)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/pancakes
	name = "pancakes"
	desc = "Pancakes without blueberries, still delicious."
	icon_state = "pancakes"
	trash = /obj/item/trash/plate
	center_of_mass = "x=15;y=11"
	nutriment_desc = list("pancake" = 8)
	nutriment_amt = 8
	bitesize = 2

/obj/item/reagent_containers/food/snacks/soylentgreen
	name = "soylent green"
	desc = "Not made of people. Honest."//Totally people.
	icon_state = "soylent_green"
	trash = /obj/item/trash/waffles
	filling_color = "#b8e6b5"
	center_of_mass = "x=15;y=11"
	bitesize = 2
	food_reagents = list(/datum/reagent/nutriment/protein = 10)

/obj/item/reagent_containers/food/snacks/soylenviridians
	name = "soylen virdians"
	desc = "Not made of people. Honest."//Actually honest for once.
	icon_state = "soylent_yellow"
	trash = /obj/item/trash/waffles
	filling_color = "#e6fa61"
	center_of_mass = "x=15;y=11"
	nutriment_desc = list("some sort of protein" = 10)//seasoned vERY well.
	nutriment_amt = 10
	bitesize = 2

//////////////
// PASTRIES //
//////////////

/obj/item/reagent_containers/food/snacks/muffin
	name = "muffin"
	desc = "A delicious and spongy little cake."
	icon_state = "muffin"
	filling_color = "#e0cf9b"
	center_of_mass = "x=17;y=4"
	nutriment_desc = list("sweetness" = 3, "muffin" = 3)
	nutriment_amt = 6
	bitesize = 2

/obj/item/reagent_containers/food/snacks/berryclafoutis
	name = "berry clafoutis"
	desc = "No black birds, this is a good sign."
	icon_state = "berryclafoutis"
	trash = /obj/item/trash/plate
	center_of_mass = "x=16;y=13"
	nutriment_desc = list("sweetness" = 2, "pie" = 3)
	nutriment_amt = 4
	bitesize = 3
	food_reagents = list(/datum/reagent/drink/juice/berry = 5)

/obj/item/reagent_containers/food/snacks/donut
	name = "donut"
	desc = "Goes great with Robust Coffee."
	icon_state = "donut1"
	filling_color = "#d9c386"
	var/overlay_state = "box-donut1"
	center_of_mass = "x=13;y=16"
	nutriment_desc = list("sweetness", "donut")
	food_reagents = list(/datum/reagent/nutriment/sprinkles = 3)

/obj/item/reagent_containers/food/snacks/donut/normal
	name = "donut"
	desc = "Goes great with Robust Coffee."
	icon_state = "donut1"
	nutriment_amt = 3
	bitesize = 3

/obj/item/reagent_containers/food/snacks/donut/normal/Initialize()
	. = ..()
	if(prob(30))
		icon_state = "donut2"
		overlay_state = "box-donut2"
		SetName("frosted donut")
	center_of_mass = "x=19;y=16"

/obj/item/reagent_containers/food/snacks/donut/chaos
	name = "chaos donut"
	desc = "Like life, it never quite tastes the same."
	icon_state = "donut1"
	filling_color = "#ed11e6"
	nutriment_amt = 2
	bitesize = 10

/obj/item/reagent_containers/food/snacks/donut/chaos/Initialize()
	. = ..()
	reagents.add_reagent(pick(list(
		/datum/reagent/nutriment,
		/datum/reagent/capsaicin,
		/datum/reagent/frostoil,
		/datum/reagent/nutriment/sprinkles,
		/datum/reagent/toxin/phoron,
		/datum/reagent/nutriment/coco,
		/datum/reagent/slime_jelly,
		/datum/reagent/drink/juice/banana,
		/datum/reagent/drink/juice/berry,
		/datum/reagent/fuel,
		/datum/reagent/medicine/tricordrazine)), 3)
	if(prob(30))
		icon_state = "donut2"
		overlay_state = "box-donut2"
		SetName("frosted chaos donut")

/obj/item/reagent_containers/food/snacks/donut/jelly
	name = "jelly donut"
	desc = "You jelly?"
	icon_state = "jdonut1"
	filling_color = "#ed1169"
	center_of_mass = "x=16;y=11"
	nutriment_amt = 3
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/sprinkles = 3,
		/datum/reagent/drink/juice/berry = 5
	)

/obj/item/reagent_containers/food/snacks/donut/jelly/Initialize()
	. = ..()
	if(prob(30))
		icon_state = "jdonut2"
		overlay_state = "box-donut2"
		SetName("frosted jelly donut")

/obj/item/reagent_containers/food/snacks/donut/slimejelly
	name = "jelly donut"
	desc = "You jelly?"
	icon_state = "jdonut1"
	filling_color = "#ed1169"
	center_of_mass = "x=16;y=11"
	nutriment_amt = 3
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/sprinkles = 3,
		/datum/reagent/slime_jelly = 5
	)

/obj/item/reagent_containers/food/snacks/donut/slimejelly/Initialize()
	. = ..()
	if(prob(30))
		src.icon_state = "jdonut2"
		src.overlay_state = "box-donut2"
		src.SetName("frosted jelly donut")

/obj/item/reagent_containers/food/snacks/donut/cherryjelly
	name = "jelly donut"
	desc = "You jelly?"
	icon_state = "jdonut1"
	filling_color = "#ed1169"
	center_of_mass = "x=16;y=11"
	nutriment_amt = 3
	bitesize = 5
	food_reagents = list(
		/datum/reagent/nutriment/sprinkles = 3,
		/datum/reagent/nutriment/cherryjelly = 5
	)

/obj/item/reagent_containers/food/snacks/donut/cherryjelly/Initialize()
	. = ..()
	if(prob(30))
		icon_state = "jdonut2"
		overlay_state = "box-donut2"
		SetName("frosted jelly donut")

// jellied toast is a pastry as a stone axe is a piece of scientific equipment, but it has nowhere better to go
/obj/item/reagent_containers/food/snacks/jelliedtoast
	name = "jellied toast"
	desc = "A slice of bread covered with delicious jam."
	icon_state = "jellytoast"
	trash = /obj/item/trash/plate
	filling_color = "#b572ab"
	center_of_mass = "x=16;y=8"
	nutriment_desc = list("toasted bread" = 2)
	nutriment_amt = 1
	bitesize = 3

/obj/item/reagent_containers/food/snacks/jelliedtoast/cherry
	food_reagents = list(/datum/reagent/nutriment/cherryjelly = 5)

/obj/item/reagent_containers/food/snacks/jelliedtoast/slime
	food_reagents = list(/datum/reagent/slime_jelly = 5)
