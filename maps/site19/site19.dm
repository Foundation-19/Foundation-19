#if !defined(using_map_DATUM)

	#include "site19_announcements.dm"
	#include "site19_areas.dm"
	#include "../torch/torch_areas.dm"
	#include "site19_elevators.dm"
	#include "site19_presets.dm"
	#include "site_19_ranks.dm"
	#include "site19_shuttles.dm"
//	#include "torch_unit_testing.dm"
//	#include "torch_antagonism.dm"
//	#include "torch_npcs.dm"
	#include "site19_securitystate.dm"

//	#include "datums/uniforms.dm"
//	#include "datums/uniforms_expedition.dm"
//	#include "datums/uniforms_fleet.dm"
//	#include "datums/supplypacks/security.dm"
//	#include "datums/supplypacks/science.dm"

	#include "items/cards_ids.dm"
	#include "items/encryption_keys.dm"
	#include "items/headsets.dm"
	#include "items/items.dm"
//	#include "items/machinery.dm"
	#include "items/manuals.dm"
	#include "items/stamps.dm"
//	#include "items/uniform_vendor.dm"
	#include "items/rigs.dm"

//	#include "items/clothing/clothing.dm"
	#include "items/clothing/solgov-accessory.dm"
	#include "items/clothing/solgov-armor.dm"
	#include "items/clothing/solgov-feet.dm"
	#include "items/clothing/solgov-head.dm"
	#include "items/clothing/solgov-suit.dm"
	#include "items/clothing/solgov-under.dm"

	#include "job/access.dm"
	#include "job/jobs.dm"
	#include "job/outfits.dm"

	#include "structures/closets.dm"
	#include "structures/signs.dm"
	#include "structures/closets/command.dm"
	#include "structures/closets/engineering.dm"
	#include "structures/closets/medical.dm"
	#include "structures/closets/misc.dm"
	#include "structures/closets/research.dm"
	#include "structures/closets/security.dm"
	#include "structures/closets/services.dm"
	#include "structures/closets/supply.dm"
//	#include "structures/closets/exploration.dm"*/

//	#include "loadout/_defines.dm"
//	#include "loadout/loadout_accessories.dm"
/*	#include "loadout/loadout_eyes.dm"
	#include "loadout/loadout_gloves.dm"
	#include "loadout/loadout_head.dm"
	#include "loadout/loadout_shoes.dm"
	#include "loadout/loadout_suit.dm"
	#include "loadout/loadout_uniform.dm"
	#include "loadout/loadout_xeno.dm"*/
//	#include "loadout/~defines.dm"

	#include "site19-1.dmm"
	#include "site19-2.dmm"
	#include "site19-3.dmm"
	#include "site19-4.dmm"
	#include "site19-5.dmm"
	#include "site19-7.dmm"

	#include "../../code/modules/lobby_music/Perdition.dm"
	#include "../../code/modules/lobby_music/hie.dm"
	#include "../../code/modules/lobby_music/std.dm"
	#include "../../code/modules/lobby_music/foundation.dm"
	#include "../../code/modules/lobby_music/humanity.dm"
	#include "../../code/modules/lobby_music/days.dm"


	#define using_map_DATUM /datum/map/site19

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Site 19

#endif
