/datum/map/site53

	post_round_safe_areas = list (
		/area/centcom,
		/area/site53/surface/bunker,
		/area/shuttle/escape_pod
		)

/area/turbolift
	name = "\improper Turbolift"
	icon_state = "shuttle"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

// SITE 53 ELEVATOR AREA'S

/area/turbolift/site53/basement
	name = "lift (basement)"
	lift_floor_label = "Basement"
	lift_floor_name = "Basement"
	lift_announce_str = "Arriving at Basement: Server Farm, Communication Engineers."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/surface
	name = "lift (surface)"
	lift_floor_label = "Surface"
	lift_floor_name = "Surface"
	lift_announce_str = "Arriving at Surface: Hub, Emergency Bunker, Main Control Room."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/commstower
	name = "lift (Communications Tower)"
	lift_floor_label = "Communications Tower"
	lift_floor_name = "Communications Tower"
	lift_announce_str = "Arriving at Communications Tower: Communications Office, long-range communications."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/uhcz
	name = "lift (Upper Heavy Containment Zone)"
	lift_floor_label = "UHCZ"
	lift_floor_name = "Upper Heavy Containment Zone"
	lift_announce_str = "Arriving at Upper Heavy Containment Zone: SCP-106, Hub."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/lhcz
	name = "lift (Lower Heavy Containment Zone)"
	lift_floor_label = "LHCZ"
	lift_floor_name = "Lower Heavy Containment Zone"
	lift_announce_str = "Arriving at Lower Heavy Containment Zone: SCP-049."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/scp106cont
	name = "lift (SCP-106 Containment)"
	lift_floor_label = "SCP-106 Containment"
	lift_floor_name = "SCP-106 Containment"
	lift_announce_str = "Arriving at SCP-106 Containment: SCP-106 Containment Chamber, Maintenance access."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/scp106obs
	name = "lift (SCP-106 Observation)"
	lift_floor_label = "SCP-106 Observation"
	lift_floor_name = "SCP-106 Observation"
	lift_announce_str = "Arriving at SCP-106 Observation: Containment Observation."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/logisticstorage
	name = "lift (Logistics Storage)"
	lift_floor_label = "Logistics Storage"
	lift_floor_name = "Logistics Storage"
	lift_announce_str = "Arriving at Logistics Storage: Secure Storage."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site53/logistics
	name = "lift (Logistics)"
	lift_floor_label = "Logistics"
	lift_floor_name = "Logistics"
	lift_announce_str = "Arriving at Logistics: Locker Rooms, Lobby, Loading Docks."
	requires_power = 0
	dynamic_lighting = 1

// SITE 53 TRAM AREA'S

/area/site53/tram/car1
	name = "Chaos Car"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/centcom/chaos
	name = "Chaos Insurgency"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/tram/goc1
	name = "GOC Car"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/centcom/goc
	name = "GOC"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/tram/scpcar
	name = "Car"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED


/area/site53/tram/mtf
	name = "MTF Heli"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/shuttle/escape_pod
	name = "Transfer Tram"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/supply/dock
	name = "Supply Dock"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

// SITE 53 SURFACE AREA'S
/area/site53
	base_turf = /turf/simulated/floor/plating

/area/site53/surface/surface
	name = "Surface"
	requires_power = 0
	dynamic_lighting = 0

/area/site53/surface/surface/away/bar
	name = "Away Bar"

/area/site53/surface/surface/away/hall
	name = "Away Village Hall"

/area/site53/surface/surface/away/check
	name = "Away Checkpoint"

/area/site53/surface/surface/away/storage
	name = "Away Storage 1"

/area/site53/surface/surface/away/storage2
	name = "Away Storage 2"

/area/site53/surface/surface/away/hotel
	name = "Away Hotel"

/area/site53/surface/surface/away/house1
	name = "Away House 1"

/area/site53/surface/surface/away/house2
	name = "Away House 2"

/area/site53/surface/surface/away/house3
	name = "Away House 3"

/area/site53/surface/cryogenicsprimary
	name = "\improper Primary Cryogenic Storage"
	icon_state = "Sleep"
	requires_power = 0
	dynamic_lighting = 1

	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/surface/bunker
	name = "\improper Secure Bunker"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/surface/explorers
	name = "\improper Scouts Prep-room"
	icon_state = "centcom"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/surface/explorers/surrounding
	name = "\improper Scouts Prep Surrounding"

// Site 53 upper surface area's

/area/site53/upper_surface/entrancehallway
	name = "\improper Site 53 Entrance"
	icon_state = "hallC1"
//	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/upper_surface/innerentrancehallway
	name = "\improper Site 53 Inner Entrance"
	icon_state = "hallC1"
//	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/upper_surface/commstower
	name = "\improper Communications Tower"
	icon_state = "checkpoint1"
//	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site53/upper_surface/serverfarmcontrol
	name = "\improper Server Farm Control Room"
	icon_state = "checkpoint1"
//	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site53/upper_surface/serverfarminterior
	name = "\improper Server Farm Interior"
	icon_state = "checkpoint1"
//	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site53/upper_surface/serverfarmtunnel
	name = "\improper Server Farm Tunnel"
	icon_state = "checkpoint1"
//	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site53/maintenance/upper_surface
	name = "\improper Upper Surface Maintenance"
	icon_state = "maint_exterior"


// Site 53 upper surface area's
/area/site53/lowertrams/brownline
	name = "\improper Brown Line"
	icon_state = "hallA"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED

/area/site53/lowertrams/hczmaint
	name = "\improper Heavy Containment Maintenance"
	icon_state = "hallA"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/lowertrams/hczmaint/east
	name = "\improper Eastern Heavy Containment Maintenance"

/area/site53/lowertrams/hczmaint/south
	name = "\improper Southern Heavy Containment Maintenance"

/area/site53/lowertrams/redline
	name = "\improper Red Line"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED

/area/site53/lowertrams/restaurantkitchenarea
	name = "\improper Restaurant Kitchen Area"
	icon_state = "cafeteria"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = MEDIUM_SOFTFLOOR

/area/site53/lowertrams/janitoroffice
	name = "\improper Primary Janitor's Office"
	icon_state = "janitor"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lowertrams/hub
	name = "\improper Hub"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED


/area/site53/maintenance
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/maintenance/surfacewest
	name = "\improper Surface Maintenance West"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/maintenance/surfaceeast
	name = "\improper Surface Maintenance East"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/ulcz/scp151
	name = "\improper SCP-151"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/generalpurpose
	name = "\improper General Purpose Testing Laboratory"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/generalpurpose2
	name = "\improper Second General Purpose Testing Laboratory"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/scp078
	name = "\improper SCP-078"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/scp173
	name = "\improper SCP-173"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/scp2427_3
	name = "\improper SCP-2427-3"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/humanoidcontainment
	name = "\improper Humanoid Containment"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/scp999
	name = "\improper SCP-999"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/ulcz/scp216
	name = "\improper SCP-216"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp500
	name = "\improper SCP-500"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp113
	name = "\improper SCP-113"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp2398
	name = "\improper SCP-2398"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp012
	name = "\improper SCP-012"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp013
	name = "\improper SCP-013"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp131
	name = "\improper SCP-131"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp263
	name = "\improper SCP-263"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp5295
	name = "\improper SCP-5295"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp263research
	name = "\improper SCP-263 Research Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/ulcz/scp914
	name = "\improper SCP-914"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED
	// Looping music
	forced_ambience = list('sounds/music/914.ogg')

/area/site53/llcz/genstorage1
	name = "\improper General Storage #1"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/hallways
	name = "\improper Lower Light Containment Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED
	ambience = list(
	'sounds/ambience/lcz/general/Ambient1.ogg',
	'sounds/ambience/lcz/general/Ambient2.ogg',
	'sounds/ambience/lcz/general/Ambient3.ogg',
	'sounds/ambience/lcz/general/Ambient4.ogg',
	'sounds/ambience/lcz/general/Ambient5.ogg',
	'sounds/ambience/lcz/general/Ambient6.ogg',
	'sounds/ambience/lcz/general/Ambient7.ogg',
	'sounds/ambience/lcz/general/Ambient8.ogg',
	'sounds/ambience/lcz/general/Ambient9.ogg'
	)
//	ambience_crb = list(
//	'sounds/ambience/lcz/crb/Commotion15.ogg',
//	'sounds/ambience/lcz/crb/Commotion19.ogg',
//	'sounds/ambience/lcz/crb/Commotion21.ogg'
//	)

/area/site53/llcz/entrance_checkpoint
	name = "\improper Light Containment Zone Checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/ulcz/hallways
	name = "\improper Upper Light Containment Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED
	ambience = list(
	'sounds/ambience/lcz/general/Ambient1.ogg',
	'sounds/ambience/lcz/general/Ambient2.ogg',
	'sounds/ambience/lcz/general/Ambient3.ogg',
	'sounds/ambience/lcz/general/Ambient4.ogg',
	'sounds/ambience/lcz/general/Ambient5.ogg',
	'sounds/ambience/lcz/general/Ambient6.ogg',
	'sounds/ambience/lcz/general/Ambient7.ogg',
	'sounds/ambience/lcz/general/Ambient8.ogg',
	'sounds/ambience/lcz/general/Ambient9.ogg'
	)
/*	ambience_crb = list(
	'sounds/ambience/lcz/crb/EmilyScream.ogg',
	'sounds/ambience/lcz/crb/AnnouncAfter1.ogg',
	'sounds/ambience/lcz/crb/alarm.ogg',
	'sounds/ambience/lcz/crb/Commotion3.ogg',
	'sounds/ambience/lcz/crb/Commotion15.ogg',
	'sounds/ambience/lcz/crb/Commotion19.ogg',
	'sounds/ambience/lcz/crb/Commotion21.ogg',
	'sounds/ambience/lcz/crb/Ambient2.ogg',
	'sounds/ambience/lcz/crb/Ambient3.ogg',
	'sounds/ambience/lcz/crb/Ambient8.ogg'
	)
*/

/area/site53/ulcz/office
	name = "\improper Upper Light Containment Office"
	icon_state = "conference"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/lowertrams/maintenance
	name = "\improper Lower Hub Maintenance"
	icon_state = "conference"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/lowertrams/escape
	name = "\improper Departures Train Station"
	icon_state = "centcom"
	area_flags = AREA_FLAG_RAD_SHIELDED
	requires_power = 0
	dynamic_lighting = 1

/area/site53/engineering/maintenance/maintenancetunnel
	name = "\improper Engineering Maintenance Tunnels"
	icon_state = "conference"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/engineering/maintenance/llczmaint
	name = "\improper Lower Light Containment Maintenance Tunnels"
	icon_state = "conference"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/llcz/scp513
	name = "\improper SCP-513"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp066
	name = "\improper SCP-066"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/scp263
	name = "\improper SCP-263"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = SMALL_ENCLOSED

/area/site53/llcz/maintenance
	name = "\improper LLCZ Substation"
	icon_state = "pmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uez/repoffice/internaltribunal
	name = "\improper Internal Tribunal Departments Office"
	sound_env = MEDIUM_SOFTFLOOR
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "head_quarters"

/area/site53/uez/repoffice/ethics
	name = "\improper Ethics Representative's Office"
	sound_env = MEDIUM_SOFTFLOOR
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "head_quarters"

/area/site53/uez/goirepoffice
	name = "\improper GoI Representative's Office"
	sound_env = MEDIUM_SOFTFLOOR
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "head_quarters"

/area/site53/uez/commandpanicbunker
	name = "\improper Administration Panic Bunker"
	sound_env = MEDIUM_SOFTFLOOR
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "head_quarters"

/area/site53/uez/hallway
	name = "\improper Upper Entrance Zone"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"
	sound_env = LARGE_ENCLOSED

/area/site53/uez/canteen
	name = "\improper Canteen"
	icon_state = "bar"
	sound_env = LARGE_SOFTFLOOR

/area/site53/uez/conference
	name = "\improper Conference Room A"
	icon_state = "bar"
	sound_env = LARGE_SOFTFLOOR

/area/site53/uez/janitor
	name = "\improper Janitor's Office"
	icon_state = "janitor"

/area/site53/uez/maintenance
	name = "Upper Entrance Zone Maintenance"
	icon_state = "SolarcontrolS"
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uez/substation
	name = "Upper Entrance Zone Substation"
	icon_state = "SolarcontrolS"
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uez/equipmentroom
	name = "Upper Entrance Zone Equipment Room"
	icon_state = "security"

/area/site53/uez/senioragentoffice
	name = "Upper Entrance Zone Senior Agent Office"
	icon_state = "security"

/area/site53/uez/armory
	name = "Upper Entrance Zone Armory"
	icon_state = "security"

/area/site53/uez/bridge
	name = "\improper Bridge"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED
	requires_power = 0
	dynamic_lighting = 1

/area/site53/uez/mcrsubstation
	name = "Main Control Room Substation"
	icon_state = "SolarcontrolS"
	sound_env = SMALL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/ulcz/maintenance
	name = "Upper Light Containment Maintenance"
	icon_state = "maint_security_starboard"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = TUNNEL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/llcz/mining/miningops
	name = "\improper Mining Operations"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"

/area/site53/llcz/dclass/recreationhallway
	name = "\improper Recreation Hallway"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"

/area/site53/llcz/dclass/checkpoint
	name = "\improper Primary D-Class Checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint"

/area/site53/llcz/dclass/checkpointoverlook
	name = "\improper Primary D-Class Checkpoint Overlook"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/prep
	name = "\improper Primary D-Class Checkpoint Preparation"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/med_checkpoint
	name = "\improper Medical D-Class Checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint"

/area/site53/llcz/dclass/med_checkpointoverlook
	name = "\improper Medical D-Class Checkpoint Overlook"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/kitchenbotanybubble
	name = "\improper Kitchen and Botany Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/assignmentbubble
	name = "\improper Assignments Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/cellbubble
	name = "\improper Cell Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/entrance_checkpoint
	name = "\improper D-Class Cells Zone Checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/assignmentline
	name = "\improper Assignment Line Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/reeducation
	name = "\improper Reeducation Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/canteenbubble
	name = "\improper Canteen Security Bubble"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/checkequip
	name = "\improper Primary Checkpoint Equipment"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/checkequip
	name = "\improper Primary D-Class Checkpoint Equipment"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/checkcryo
	name = "\improper Primary D-Class Checkpoint Cryo"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/armory
	name = "\improper Primary D-Class Checkpoint Armory"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "checkpoint1"

/area/site53/llcz/dclass/janitorial
	name = "\improper Janitorial Closet"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "janitor"

/area/site53/llcz/dclass/cells
	name = "\improper D-Class Cell Area"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/isolation
	name = "\improper D-Class Isolation"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/briefing
	name = "\improper D-Class Briefing Center"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "conference"
	sound_env = LARGE_ENCLOSED

/area/site53/llcz/dclass/primaryhallway
	name = "\improper D-Class Cell Hallway"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"
	sound_env = LARGE_ENCLOSED

/area/site53/llcz/dclass/luxurysleep
	name = "\improper D-Class Luxury Barracks"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"
	sound_env = LARGE_ENCLOSED

/area/site53/llcz/dclass/luxuryhall
	name = "\improper D-Class Luxury Barracks Hallway"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"
	sound_env = LARGE_ENCLOSED

/area/site53/llcz/dclass/luxurylibrary
	name = "\improper D-Class Luxury Library"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"
	sound_env = LARGE_ENCLOSED

/area/site53/llcz/dclass/shower
	name = "\improper D-Class Shower Area"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/canteen
	name = "\improper D-Class Canteen"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "cafeteria"
	sound_env = LARGE_SOFTFLOOR

/area/site53/llcz/dclass/kitchen
	name = "\improper D-Class Kitchen"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "kitchen"

/area/site53/llcz/dclass/botany
	name = "\improper D-Class Botany"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "kitchen"

/area/site53/llcz/dclass/assignment
	name = "\improper D-Class Assingments"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/cryo
	name = "\improper D-Class Cryo Area"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/medicalpost
	name = "\improper D-Class Medical Post"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "exam_room"

/area/site53/llcz/dclass/medicalpost/surgery
	name = "\improper D-Class Medical Post Surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "kitchen"

/area/site53/llcz/dclass/medicalpost/storage
	name = "\improper D-Class Medical Post Storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "Sleep"

/area/site53/llcz/dclass/medicalpost/chem
	name = "\improper D-Class Medical Post Chemistry"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "hallC1"

/area/site53/llcz/dclass/medicalpost/morgue
	name = "\improper D-Class Medical Post Morgue"
	area_flags = AREA_FLAG_RAD_SHIELDED
	icon_state = "kitchen"

/area/site53/llcz/mine/explored
	name = "Mine"
	icon_state = "explored"

/area/site53/llcz/mine/unexplored
	name = "Mine"
	icon_state = "unexplored"

/area/site53/engineering/lowernukeladders
	name = "\improper Lower Self Destruct Ladders"
	icon_state = "nuke_storage"

/area/site53/engineering/uppernukeladders
	name = "\improper Upper Self Destruct Ladders"
	icon_state = "nuke_storage"

/area/site53/engineering/selfdestruct
	name = "\improper Self-Destruct Room"
	icon_state = "nuke_storage"

/area/site53/engineering/maintenance/lowerselfdestruct
	name = "Lower Self Destruct Maintenance"
	icon_state = "SolarcontrolS"
	sound_env = SMALL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/engineering/maintenance/upperselfdestruct
	name = "Upper Self Destruct Maintenance"
	icon_state = "SolarcontrolS"
	sound_env = SMALL_ENCLOSED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uhcz/scp457containment
	name = "\improper SCP-457 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp106observ
	name = "\improper SCP-106 Observation"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp106parts
	name = "\improper SCP-106 Maintenance"
	icon_state = "fpmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uhcz/scp106maintup
	name = "\improper SCP-106 Upper Maintenance"
	icon_state = "fpmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/uhcz/hallways
	name = "\improper HCZ Hallways"
	icon_state = "fpmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp106containment
	name = "\improper SCP-106 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp247containment
	name = "\improper SCP-247 Enclosure"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	requires_power = 0
	dynamic_lighting = 0

/area/site53/uhcz/scp8containment
	name = "\improper SCP-008 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp247observation
	name = "\improper SCP-247 Observation"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp1507observation
	name = "\improper SCP-1507 Observation"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp1507containment
	name = "\improper SCP-1507 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	requires_power = 0
	dynamic_lighting = 0

/area/site53/lhcz/scp049containment
	name = "\improper SCP-049 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	ambience = list('sounds/ambience/hcz/049/Room049.ogg')
//	ambience_crb = list('sounds/ambience/hcz/049/Room049.ogg')

/area/site53/lhcz/hallway
	name = "\improper Lower Heavy Containment Hallways"
	icon_state = "hallC3"
	area_flags = AREA_FLAG_RAD_SHIELDED
	sound_env = LARGE_ENCLOSED

/area/site53/lhcz/maintenance
	name = "\improper Lower Heavy Containment Maintenance"
	icon_state = "fpmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/engineering/controlroom
	name = "\improper Engineering Control Room"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED
	turf_initializer = /decl/turf_initializer/maintenance

/area/site53/engineering/atmos
	name = "\improper Atmospherics"
	icon_state = "atmos"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/primaryhallway
	name = "\improper Engineering Hallway"
	icon_state = "engineering_foyer"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/vacant/prototype/engine
	name = "\improper Prototype Engine"
	icon_state = "engineering"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/vacant/prototype/control
	name = "\improper Prototype Engine Control"
	icon_state = "engineering"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/entrancezone/securitypost
	name = "\improper Entrance Zone Security Post"
	icon_state = "head_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/entrancezone/hallway
	name = "\improper Entrance Zone Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/entrancezone/substation
	name = "\improper Entrance Zone Substation"
	icon_state = "substation"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/entrancezone/forensics
	name = "\improper Forensics Laboratory"
	icon_state = "detective"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/infirmreception
	name = "\improper Infirmary Reception"
	icon_state = "medbay2"
	ambience = list('sounds/ambience/signal.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/infirmreception/waiting
	name = "\improper Infirmary Reception Waiting Area"
	icon_state = "medbay2"
	ambience = list('sounds/ambience/signal.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/infirmary
	name = "\improper Infirmary Hallway"
	icon_state = "medbay"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/surgery/op1
	name = "\improper Operating Theatre #1"
	icon_state = "surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/surgery/op2
	name = "\improper Operating Theatre #2"
	icon_state = "surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/surgery/hall
	name = "\improper Surgical Hallway"
	icon_state = "surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/isolation
	name = "\improper Isolation Quarantine"
	icon_state = "medbay3"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/mentalhealth/isolation
	name = "\improper Mental Health Isolation"
	icon_state = "medbay3"
	ambience = list('sounds/ambience/signal.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/mentalhealth/office
	name = "\improper Psychiatrist's Office"
	icon_state = "medbay3"
	ambience = list('sounds/ambience/signal.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/medical/equipstorage
	name = "\improper Equipment Storage"
	icon_state = "medbay4"
	ambience = list('sounds/ambience/signal.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/engine_smes
	name = "\improper Engineering SMES"
	icon_state = "engine_smes"
	sound_env = SMALL_ENCLOSED
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/biosupplies
	name = "\improper Engineering Bio supplies"
	icon_state = "engine_smes"
	sound_env = SMALL_ENCLOSED
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/bathrooms
	name = "\improper Engineering Bathrooms"
	icon_state = "engine_smes"
	sound_env = SMALL_ENCLOSED
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "engineering_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/auxstorage
	name = "\improper Auxiliary Engineering Storage"
	icon_state = "engineering_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/janitorial
	name = "\improper Auxiliary Engineering Storage"
	icon_state = "janitor"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/locker_room
	name = "\improper Engineering Locker Room"
	icon_state = "engineering_locker"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/breakroom
	name = "\improper Engineering Break Room"
	icon_state = "engineering_locker"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/containment_engineer
	name = "\improper Containment Engineer Office"
	icon_state = "engineering_locker"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/sleeproom
	name = "\improper Engineering Sleep Room"
	icon_state = "engineering_locker"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/engineering/server_room
	name = "\improper Server Room"
	icon_state = "crew_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/securitypost
	name = "\improper HCZ Checkpoint"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/commanderoffice
	name = "\improper HCZ Commander's Office"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp895
	name = "\improper Lower SCP-895"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp895
	name = "\improper Upper SCP-895"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/zonecommanderoffice
	name = "\improper Zone Commander's Office"
	icon_state = "security"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/reswing/xenobiology
	name = "\improper Xenobiology Laboratory"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/reswing/robotics
	name = "\improper Robotics Laboratory"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/logistics/logistics
	name = "\improper Logistics"
	icon_state = "quart"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/logistics/logisticsofficer
	name = "\improper Logistics Officer Office"
	icon_state = "quart"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/logistics/logisticsbreak
	name = "\improper Logistics Break Area"
	icon_state = "quart"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/hczguardgear
	name = "\improper HCZ Guard Gear Room"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp1102entrance
	name = "\improper SCP-1102 Bunker Entrance"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp1102room
	name = "\improper SCP-1102-RU Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp035room
	name = "\improper SCP-035 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp343entrance
	name = "\improper SCP-343 Containment Chamber Entrance"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/lhcz/scp343room
	name = "\improper SCP-343 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	requires_power = 0
	dynamic_lighting = 1

/area/site53/uhcz/generalpurpose3
	name = "\improper Third General Purpose Testing Laboratory"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site53/uhcz/scp096
	name = "\improper SCP-096 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED

//Site 53's science areas

/area/site53/science/aicobservation
	name = "\improper AIC Observation"
	icon_state = "research"

/area/site53/science/aiccore
	name = "\improper AIC Server Room"
	icon_state = "research"

/area/site53/science/seniorresearchera
	name = "\improper Senior Researcher's Office A"
	icon_state = "research"

/area/site53/science/seniorresearcherb
	name = "\improper Senior Researcher's Office B"
	icon_state = "research"

//Logistics
/area/quartermaster/hangar
	name ="\improper Logistics Hangar"
	icon_state = "quart"

//SCP-106's realm
/area/pocketdimension
	name = "Pocket Dimension"
	requires_power = 0
	dynamic_lighting = 0
