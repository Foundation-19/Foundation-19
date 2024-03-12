/**
 * Used for registering typepaths of item to be tracked as a "required map item"
 * This is used to ensure that that all station maps have certain items mapped in that they should have
 * Or that people aren't mapping in an excess of items that they shouldn't be
 *
 * Min is inclusive, Max is inclusive (so 1, 1 means min of 1, max of 1, or only 1 allowed)
 *
 * This should only be used in Initialize(). And don't forget to update the unit test with the type itself!
 */
#ifdef UNIT_TEST
#define REGISTER_REQUIRED_MAP_ITEM(min, max) \
	do { \
		if(mapload) { \
			var/turf/spawn_turf = get_turf(src); \
			if(is_station_level(spawn_turf?.z || 0)) { \
				var/datum/required_item/existing_value = GLOB.required_map_items[type]; \
				if(isnull(existing_value)) { \
					var/datum/required_item/new_value = new(type, min, max); \
					GLOB.required_map_items[type] = new_value; \
				} else { \
					existing_value.total_amount += 1; \
				}; \
			}; \
		}; \
	} while (FALSE)
#else
#define REGISTER_REQUIRED_MAP_ITEM(min, max)
#endif
