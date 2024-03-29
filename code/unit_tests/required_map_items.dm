/**
 * Tests that all expected items are mapped in roundstart.
 *
 * How to add an item to this test:
 * - Add the typepath(s) to setup_expected_types
 * - In the type's initialize, REGISTER_REQUIRED_MAP_ITEM() a minimum and maximum
 */

/// Global assoc list of required mapping items, [item typepath] to [required item datum].
GLOBAL_LIST_EMPTY(required_map_items)

/datum/unit_test/required_map_items
	name = "MAP: Required items check"
	/// A list of all typepaths that we expect to be in the required items list
	var/list/expected_types = list()

/// Used to fill the expected types list with all the types we look for on the map.
/// This list will just be full of typepaths that we expect.
/// More detailed information about each item (mainly, how much of each should exist) is set on a per item basis
/datum/unit_test/required_map_items/proc/setup_expected_types()
	expected_types += /obj/item/piggy_bank/logistics

/datum/unit_test/required_map_items/start_test()
	setup_expected_types()

	var/working = TRUE

	var/list/required_map_items = GLOB.required_map_items.Copy()
	for(var/got_type in expected_types)
		var/datum/required_item/item = required_map_items[got_type]
		var/items_found = item?.total_amount || 0
		required_map_items -= got_type
		if(items_found <= 0)
			fail("Item [got_type] was not found, but is expected to be mapped in on mapload!")
			working = FALSE
			continue

		if(items_found < item.minimum_amount)
			fail("Item [got_type] should have at least [item.minimum_amount] mapped in but only had [items_found] on mapload!")
			working = FALSE
			continue

		if(items_found > item.maximum_amount)
			fail("Item [got_type] should have at most [item.maximum_amount] mapped in but had [items_found] on mapload!")
			working = FALSE
			continue

	// This primarily serves as a reminder to include the typepath in the expected types list above.
	// However we can easily delete this line in the future if it runs into false positives.
	if(length(required_map_items))
		log_bad("The following paths were found in required map items, but weren't checked: [english_list(required_map_items)]")

	if(working == TRUE)
		pass("All required map items within valid ranges.")
		return TRUE
	else
		return FALSE

/// Datum for tracking required map items
/datum/required_item
	/// Type (exact) being tracked
	var/tracked_type
	/// How many exist in the world
	var/total_amount = 0
	/// Min. amount of this type that should exist roundstart (inclusive)
	var/minimum_amount = 1
	/// Max. amount of this type that should exist roundstart (inclusive)
	var/maximum_amount = 1

/datum/required_item/New(tracked_type, minimum_amount = 1, maximum_amount = 1)
	src.tracked_type = tracked_type
	src.minimum_amount = minimum_amount
	src.maximum_amount = maximum_amount
	total_amount += 1
