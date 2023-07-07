#if !defined(using_map_DATUM)

	#include "site53_announcements.dm"
	#include "site53areas.dm"
	#include "site53elevators.dm"
	#include "site53_presets.dm"
	#include "site_53_ranks.dm"
	#include "site53shuttles.dm"

	#include "items/cards_ids.dm"
	#include "items/encryption_keys.dm"
	#include "items/headsets.dm"
	#include "items/items.dm"
	#include "items/manuals.dm"
	#include "items/stamps.dm"
	#include "items/rigs.dm"
	#include "items/clothing/solgov-accessory.dm"
	#include "items/clothing/solgov-armor.dm"
	#include "items/clothing/solgov-feet.dm"
	#include "items/clothing/solgov-head.dm"
	#include "items/clothing/solgov-suit.dm"
	#include "items/clothing/solgov-under.dm"

	#include "job/headsets.dm"
	#include "job/papers.dm"
	#include "job/access/access.dm"
	#include "job/access/access_containment.dm"
	#include "structures/mapstuff.dm"
	#include "structures/signs.dm"
	#include "structures/closets/command.dm"
	#include "structures/closets/medical.dm"
	#include "structures/closets/misc.dm"
	#include "structures/closets/research.dm"
	#include "structures/closets/security.dm"
	#include "structures/closets/services.dm"
	#include "structures/closets/supply.dm"

	#include "site53-1.dmm"
	#include "site53-2.dmm"
	#include "site53-3.dmm"
	#include "site53-4.dmm"
	#include "site53-5.dmm"
	#include "z1_admin.dmm"
	#include "z2_transit.dmm"
	#include "away_mission-1.dmm"

	#define using_map_DATUM /datum/map/site53

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Site 53

#endif
