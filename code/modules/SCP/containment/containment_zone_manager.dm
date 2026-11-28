// Zone-driven containment system.
//
// Replaces the map-placed containment monitor machines: zone datums are
// created from a static designation->area list here, and ticked by this
// subsystem, so no map objects are required. The area list is derived from
// the monitor placements that used to exist on site53 — one zone per SCP
// chamber, exactly where the monitors stood.

SUBSYSTEM_DEF(scp_containment)
	name = "SCP Containment"
	init_order = SS_INIT_MISC_LATE // after atoms so map areas exist
	flags = SS_BACKGROUND
	wait = 5 SECONDS
	runlevels = RUNLEVELS_DEFAULT

	var/setup_complete = FALSE

/datum/controller/subsystem/scp_containment/Initialize()
	setup_zones()
	setup_complete = TRUE
	log_game("SCP Containment: Registered [GLOB.containment_zones.len] containment zones.")
	. = ..()

/datum/controller/subsystem/scp_containment/fire()
	if(!setup_complete)
		return
	for(var/datum/containment_zone/CZ in GLOB.containment_zones)
		CZ.process()

/// Creates one zone per designation from the static map list. If a zone
/// for the area already exists it is reused; otherwise one is built and
/// linked to the SCP if it exists by round start.
/datum/controller/subsystem/scp_containment/proc/setup_zones()
	for(var/desg in GLOB.containment_zone_areas)
		var/area_type = text2path(GLOB.containment_zone_areas[desg])
		var/area/A = area_type ? locate(area_type) : null
		if(!A)
			log_game("SCP Containment: no area [GLOB.containment_zone_areas[desg]] for SCP-[desg], zone skipped.")
			continue
		// Reuse an existing zone if something else already registered this area.
		var/datum/containment_zone/existing = A.get_containment_zone()
		if(existing)
			if(!existing.scp_designation && desg)
				existing.scp_designation = desg
			continue
		var/datum/containment_zone/CZ = new(A, desg)
		var/datum/scp/scp_datum = find_scp_by_designation(desg)
		if(scp_datum)
			CZ.link_scp(scp_datum)

/proc/find_scp_by_designation(desg)
	for(var/atom/A in GLOB.SCP_list)
		if(A.SCP && A.SCP.designation == desg)
			return A.SCP
	return null

// Designation -> containment area type. Areas resolve at runtime via
// text paths (text2path + locate in setup_zones) so a missing area
// declaration on a downstream fork logs a skip instead of failing the
// compile.
GLOBAL_LIST_INIT(containment_zone_areas, list(
	"008" = "/area/site53/uhcz/scp8containment",
	"012" = "/area/site53/llcz/scp012",
	"013" = "/area/site53/llcz/scp013",
	"035" = "/area/site53/lhcz/scp035room",
	"049" = "/area/site53/lhcz/scp049containment",
	"066" = "/area/site53/llcz/scp066",
	"082" = "/area/site53/ulcz/scp082",
	"096" = "/area/site53/uhcz/scp096",
	"106" = "/area/site53/uhcz/scp106containment",
	"1102" = "/area/site53/lhcz/scp1102room",
	"113" = "/area/site53/llcz/scp113",
	"131-A" = "/area/site53/llcz/scp131",
	"1507" = "/area/site53/uhcz/scp1507containment",
	"151" = "/area/site53/ulcz/scp151",
	"173" = "/area/site53/ulcz/scp173",
	"216" = "/area/site53/ulcz/scp216",
	"2398" = "/area/site53/llcz/scp2398",
	"247" = "/area/site53/uhcz/scp247containment",
	"263" = "/area/site53/llcz/scp263",
	"294" = "/area/site53/llcz/scp294",
	"457" = "/area/site53/uhcz/scp457containment",
	"500" = "/area/site53/llcz/scp500",
	"513" = "/area/site53/llcz/scp513",
	"895" = "/area/site53/lhcz/scp895",
	"912" = "/area/site53/ulcz/scp912",
	"914" = "/area/site53/ulcz/scp914",
	"939" = "/area/site53/uhcz/generalpurpose3",
	"999" = "/area/site53/ulcz/scp999",
))
