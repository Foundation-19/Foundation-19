/obj/machinery/chemical_dispenser/full
	disp_reagents = list(
			/datum/reagent/hydrazine,
			/datum/reagent/lithium,
			/datum/reagent/carbon,
			/datum/reagent/ammonia,
			/datum/reagent/acetone,
			/datum/reagent/sodium,
			/datum/reagent/aluminium,
			/datum/reagent/silicon,
			/datum/reagent/phosphorus,
			/datum/reagent/sulfur,
			/datum/reagent/acid/hydrochloric,
			/datum/reagent/potassium,
			/datum/reagent/iron,
			/datum/reagent/copper,
			/datum/reagent/mercury,
			/datum/reagent/radium,
			/datum/reagent/water,
			/datum/reagent/ethanol,
			/datum/reagent/sugar,
			/datum/reagent/acid/sulphuric,
			/datum/reagent/tungsten

		)

/obj/machinery/chemical_dispenser/ert
 	name = "medicine dispenser"
// 	disp_reagents = list(
// 			/datum/reagent/medicine/inaprovaline,
// 			/datum/reagent/ryetalyn,
// 			/datum/reagent/paracetamol,
// 			/datum/reagent/tramadol,
// 			/datum/reagent/medicine/painkiller/tramadol/oxycodone,
// 			/datum/reagent/sterilizine,
// 			/datum/reagent/leporazine,
// 			/datum/reagent/kelotane,
// 			/datum/reagent/dermaline,
// 			/datum/reagent/dexalin,
// 			/datum/reagent/medicine/dexalin_plus,
// 			/datum/reagent/medicine/tricordrazine,
// 			/datum/reagent/dylovene,
// 			/datum/reagent/synaptizine,
// 			/datum/reagent/hyronalin,
// 			/datum/reagent/arithrazine,
// 			/datum/reagent/alkysine,
// 			/datum/reagent/imidazoline,
// 			/datum/reagent/peridaxon,
// 			/datum/reagent/bicaridine,
// 			/datum/reagent/hyperzine,
// 			/datum/reagent/rezadone,
// 			/datum/reagent/spaceacillin,
// 			/datum/reagent/medicine/ethylredoxrazine,
// 			/datum/reagent/soporific,
// 			/datum/reagent/chloral_hydrate,
// 			/datum/reagent/cryoxadone,
// 			/datum/reagent/clonexadone
// 		)

/obj/machinery/chemical_dispenser/bar_soft
 	name = "soft drink dispenser"
// 	desc = "A soft drink machine." //Doesn't just serve soda --BlueNexus
// 	icon_state = "soda_dispenser"
// 	ui_title = "Soda Dispenser"
// 	accept_drinking = 1
// 	core_skill = SKILL_COOKING
// 	can_contaminate = FALSE //It's not a complex panel, and I'm fairly sure that most people don't haymaker the control panel on a soft drinks machine. -- Chaoko99

/obj/machinery/chemical_dispenser/bar_soft/full
// 	disp_reagents = list(
// 			/datum/reagent/water,
// 			/datum/reagent/drink/ice,
// 			/datum/reagent/drink/coffee,
// 			/datum/reagent/drink/hot_coco,
// 			/datum/reagent/drink/milk/cream,
// 			/datum/reagent/drink/tea,
// 			/datum/reagent/drink/tea/green,
// 			/datum/reagent/drink/tea/chai,
// 			/datum/reagent/drink/tea/red,
// 			/datum/reagent/drink/space_cola,
// 			/datum/reagent/drink/spacemountainwind,
// 			/datum/reagent/drink/dr_gibb,
// 			/datum/reagent/drink/space_up,
// 			/datum/reagent/drink/tonic,
// 			/datum/reagent/drink/sodawater,
// 			/datum/reagent/drink/lemon_lime,
// 			/datum/reagent/sugar,
// 			/datum/reagent/orange,
// 			/datum/reagent/drink/juice/lime,
// 			/datum/reagent/watermelon
// 		)

/obj/machinery/chemical_dispenser/bar_alc
	name = "booze dispenser"
	desc = "A beer machine. Like a soda machine, but more fun!"
	icon_state = "booze_dispenser"
	ui_title = "Booze Dispenser"
	accept_drinking = 1
	core_skill = SKILL_COOKING
	can_contaminate = FALSE //See above.

/obj/machinery/chemical_dispenser/bar_alc/full
// 	disp_reagents = list(
// 			/datum/reagent/drink/lemon_lime,
// 			/datum/reagent/sugar,
// 			/datum/reagent/drink/juice/orange,
// 			/datum/reagent/lime,
// 			/datum/reagent/drink/sodawater,
// 			/datum/reagent/drink/tonic,
// 			/datum/reagent/ethanol/beer,
// 			/datum/reagent/kahlua,
// 			/datum/reagent/whiskey,
// 			/datum/reagent/wine,
// 			/datum/reagent/vodka,
// 			/datum/reagent/gin,
// 			/datum/reagent/rum,
// 			/datum/reagent/tequila,
// 			/datum/reagent/vermouth,
// 			/datum/reagent/cognac,
// 			/datum/reagent/ale,
// 			/datum/reagent/mead,
// 			/datum/reagent/triple_sec,
// 			/datum/reagent/creme_de_cacao,
// 			/datum/reagent/creme_de_menthe
// 		)

/obj/machinery/chemical_dispenser/bar_coffee
	name = "coffee dispenser"
	desc = "Driving crack dealers out of employment since 2280."
	icon_state = "coffee_dispenser"
	ui_title = "Coffee Dispenser"
	accept_drinking = 1
	core_skill = SKILL_COOKING
	can_contaminate = FALSE //See above.

/obj/machinery/chemical_dispenser/bar_coffee/full
// 	disp_reagents = list(
// 			/datum/reagent/drink/coffee,
// 			/datum/reagent/drink/decafcoffee,
// 			/datum/reagent/drink/coffee/espresso,
// 			/datum/reagent/drink/coffee/cafe_latte,
// 			/datum/reagent/drink/coffee/soy_latte,
// 			/datum/reagent/hot_coco,
// 			/datum/reagent/milk,
// 			/datum/reagent/cream,
// 			/datum/reagent/drink/tea,
// 			/datum/reagent/drink/tea/green,
// 			/datum/reagent/drink/tea/chai,
// 			/datum/reagent/drink/tea/red,
// 			/datum/reagent/drink/tea/decaf,
// 			/datum/reagent/drink/ice,
// 			/datum/reagent/drink/syrup_chocolate,
// 			/datum/reagent/drink/syrup_caramel,
// 			/datum/reagent/drink/syrup_vanilla,
// 			/datum/reagent/drink/syrup_pumpkin
// 		)
