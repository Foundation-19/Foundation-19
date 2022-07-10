/obj/machinery/chemical_dispenser/full
	disp_reagents = list(
		"Acetone" = /datum/reagent/acetone,
		"Aluminium" = /datum/reagent/aluminium,
		"Ammonia" = /datum/reagent/ammonia,
		"Carbon" = /datum/reagent/carbon,
		"Copper" = /datum/reagent/copper,
		"Ethanol" = /datum/reagent/ethanol,
		"Hydrazine" = /datum/reagent/hydrazine,
		"Hydrochloric Acid" = /datum/reagent/acid/hydrochloric,
		"Iron" = /datum/reagent/iron,
		"Lithium" = /datum/reagent/lithium,
		"Mercury" = /datum/reagent/mercury,
		"Phosphorus" = /datum/reagent/phosphorus,
		"Potassium" = /datum/reagent/potassium,
		"Radium" = /datum/reagent/radium,
		"Silicon" = /datum/reagent/silicon,
		"Sodium" = /datum/reagent/sodium,
		"Sugar" = /datum/reagent/sugar,
		"Sulfur" = /datum/reagent/sulfur,
		"Sulphuric Acid" = /datum/reagent/acid/sulphuric,
		"Tungsten" = /datum/reagent/tungsten,
		"Water" = /datum/reagent/water
			)

/obj/machinery/chemical_dispenser/ert
	name = "medicine dispenser"
	disp_reagents = list(
		"Alkysine" = /datum/reagent/alkysine,
		"Arithrazine" = /datum/reagent/arithrazine,
		"Bicaridine" = /datum/reagent/bicaridine,
		"Chloral Hydrate" = /datum/reagent/chloral_hydrate,
		"Clonexadone" = /datum/reagent/clonexadone,
		"Cryoxadone" = /datum/reagent/cryoxadone,
		"Dermaline" = /datum/reagent/dermaline,
		"Dexalin Plus" = /datum/reagent/medicine/dexalin_plus,
		"Dexalin" = /datum/reagent/dexalin,
		"Dylovene" = /datum/reagent/dylovene,
		"Ethylredoxrazine" = /datum/reagent/medicine/ethylredoxrazine,
		"Hyperzine" = /datum/reagent/hyperzine,
		"Hyronalin" = /datum/reagent/hyronalin,
		"Imidazoline" = /datum/reagent/imidazoline,
		"Inaprovaline" = /datum/reagent/medicine/inaprovaline,
		"Kelotane" = /datum/reagent/kelotane,
		"Leporazine" = /datum/reagent/leporazine,
		"Oxycodone" = /datum/reagent/medicine/painkiller/tramadol/oxycodone,
		"Paracetamol" = /datum/reagent/paracetamol,
		"Peridaxon" = /datum/reagent/peridaxon,
		"Rezadone" = /datum/reagent/rezadone,
		"Ryetalyn" = /datum/reagent/ryetalyn,
		"Soporific" = /datum/reagent/soporific,
		"Spaceacillin" = /datum/reagent/spaceacillin,
		"Sterilizine" = /datum/reagent/sterilizine,
		"Synaptizine" = /datum/reagent/synaptizine,
		"Tramadol" = /datum/reagent/tramadol,
		"Tricordrazine" = /datum/reagent/medicine/tricordrazine
			)

/obj/machinery/chemical_dispenser/bar_soft
	name = "soft drink dispenser"
	desc = "A soft drink machine." //Doesn't just serve soda --BlueNexus
	icon_state = "soda_dispenser"
	ui_title = "Soda Dispenser"
	accept_drinking = 1
	core_skill = SKILL_COOKING
	can_contaminate = FALSE //It's not a complex panel, and I'm fairly sure that most people don't haymaker the control panel on a soft drinks machine. -- Chaoko99

/obj/machinery/chemical_dispenser/bar_soft/full
	disp_reagents = list(
		"Black Tea" = /datum/reagent/drink/tea,
		"Chai Tea" = /datum/reagent/drink/tea/chai,
		"Coffee" = /datum/reagent/drink/coffee,
		"Cream" = /datum/reagent/drink/milk/cream,
		"Dr. Gibb" = /datum/reagent/drink/dr_gibb,
		"Green Tea" = /datum/reagent/drink/tea/green,
		"Hot Chocolate" = /datum/reagent/drink/hot_coco,
		"Ice" = /datum/reagent/drink/ice,
		"Lemon Lime" = /datum/reagent/drink/lemon_lime,
		"Lime Juice" = /datum/reagent/drink/juice/lime,
		"Mountain Wind" = /datum/reagent/drink/spacemountainwind,
		"Orange juice" = /datum/reagent/drink/juice/orange,
		"Rooibos Tea" = /datum/reagent/drink/tea/red,
		"Soda Water" = /datum/reagent/drink/sodawater,
		"Space Cola" = /datum/reagent/drink/space_cola,
		"Space-Up" = /datum/reagent/drink/space_up,
		"Sugar" = /datum/reagent/sugar,
		"Tonic Water" = /datum/reagent/drink/tonic,
		"Watermelon Juice" = /datum/reagent/drink/juice/watermelon,
		"Water" = /datum/reagent/water
			)

/obj/machinery/chemical_dispenser/bar_alc
	name = "booze dispenser"
	desc = "A beer machine. Like a soda machine, but more fun!"
	icon_state = "booze_dispenser"
	ui_title = "Booze Dispenser"
	accept_drinking = 1
	core_skill = SKILL_COOKING
	can_contaminate = FALSE //See above.

/obj/machinery/chemical_dispenser/bar_alc/full
	disp_reagents = list(
		"Ale" = /datum/reagent/ethanol/ale,
		"Beer" = /datum/reagent/ethanol/beer,
		"Cognac" = /datum/reagent/ethanol/cognac,
		"Creme de Cacao" = /datum/reagent/ethanol/creme_de_cacao,
		"Creme de Menthe" = /datum/reagent/ethanol/creme_de_menthe,
		"Gin" = /datum/reagent/ethanol/gin,
		"Kahlua" = /datum/reagent/ethanol/coffee/kahlua,
		"Lemon Lime" = /datum/reagent/drink/lemon_lime,
		"Lime Juice" = /datum/reagent/drink/juice/lime,
		"Mead" = /datum/reagent/ethanol/mead,
		"Orange juice" = /datum/reagent/drink/juice/orange,
		"Rum" = /datum/reagent/ethanol/rum,
		"Soda Water" = /datum/reagent/drink/sodawater,
		"Sugar" = /datum/reagent/sugar,
		"Tequila" = /datum/reagent/ethanol/tequilla,
		"Tonic Water" = /datum/reagent/drink/tonic,
		"Triple Sec" = /datum/reagent/ethanol/triple_sec,
		"Vermouth" = /datum/reagent/ethanol/vermouth,
		"Vodka" = /datum/reagent/ethanol/vodka,
		"Whiskey" = /datum/reagent/ethanol/whiskey,
		"Wine" = /datum/reagent/ethanol/wine
			)

/obj/machinery/chemical_dispenser/bar_coffee
	name = "coffee dispenser"
	desc = "Driving crack dealers out of employment since 2280."
	icon_state = "coffee_dispenser"
	ui_title = "Coffee Dispenser"
	accept_drinking = 1
	core_skill = SKILL_COOKING
	can_contaminate = FALSE //See above.

/obj/machinery/chemical_dispenser/bar_coffee/full
	disp_reagents = list(
		"Black Tea" = /datum/reagent/drink/tea,
		"Cafe Latte" = /datum/reagent/drink/coffee/cafe_latte,
		"Caramel Syrup" = /datum/reagent/drink/syrup_caramel,
		"Chai Tea" = /datum/reagent/drink/tea/chai,
		"Chocolate Syrup" = /datum/reagent/drink/syrup_chocolate,
		"Coffee" = /datum/reagent/drink/coffee,
		"Cream" = /datum/reagent/drink/milk/cream,
		"Decaffeinated Coffee" = /datum/reagent/drink/decafcoffee,
		"Decaffeinated Tea" = /datum/reagent/drink/tea/decaf,
		"Espresso" = /datum/reagent/drink/coffee/espresso,
		"Green Tea" = /datum/reagent/drink/tea/green,
		"Hot Chocolate" = /datum/reagent/drink/hot_coco,
		"Ice" = /datum/reagent/drink/ice,
		"Milk" = /datum/reagent/drink/milk,
		"Pumpkin Spice Syrup" = /datum/reagent/drink/syrup_pumpkin,
		"Rooibos Tea" = /datum/reagent/drink/tea/red,
		"Soy Latte" = /datum/reagent/drink/coffee/soy_latte,
		"Vanilla Syrup" = /datum/reagent/drink/syrup_vanilla
			)
