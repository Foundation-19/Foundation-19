/area/turbolift
	name = "\improper Turbolift"
	icon_state = "shuttle"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED


/area/turbolift/start
	name = "\improper Turbolift Start"

/area/turbolift/gatea
	name = "\improper Topside Gate A"
	base_turf = /turf/simulated/open

/area/turbolift/entrancezone
	name = "\improper Entrance Zone"
	base_turf = /turf/simulated/open


// Elevator areas.
/area/turbolift/ds90_surf
	name = "lift (topside)"
	lift_floor_label = "Surface"
	lift_floor_name = "Surface"
	lift_announce_str = "Arriving at Surface: General staff amenities, Security base."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/ds90_ez
	name = "lift (entrance zone)"
	lift_floor_label = "Entrance Zone"
	lift_floor_name = "Entrance Zone"
	lift_announce_str = "Arriving at Entrance Zone: Research Laboratories, Administrative Offices, Medical Bay, Security and Engineering."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/gatebsurf
	name = "lift (surface)"
	lift_floor_label = "Surface"
	lift_floor_name = "Surface"
	lift_announce_str = "Arriving at Surface: General staff amenities, Security base."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/gatebent
	name = "lift (entrance zone)"
	lift_floor_label = "Entrance Zone"
	lift_floor_name = "Entrance zone"
	lift_announce_str = "Arriving at Entrance Zone: Research Laboratories, Administrative Offices, Medical Bay, Security and Engineering."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/torch_ground
	name = "lift (lower deck)"
	lift_floor_label = "Deck 4"
	lift_floor_name = "Hangar Deck"
	lift_announce_str = "Arriving at Hangar Deck: Shuttle Docks. Cargo Storage. Main Hangar. Supply Office. Expedition Preparation. Mineral Processing."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/upperentrance
	name = "lift (upper entrance zone)"
	lift_floor_label = "Upper Entrance Zone"
	lift_floor_name = "Upper Entrance Zone"
	lift_announce_str = "Arriving at Upper Entrance Zone: Offices. Conference Rooms. Gate B. Gate A."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/lowerentrance
	name = "lift (lower entrance zone)"
	lift_floor_label = "Lower Entrance Zone"
	lift_floor_name = "Lower Entrance Zone"
	lift_announce_str = "Arriving at Lower Entrance Zone: Management Department. Medical Bay. Access to High Containment Zone."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/lowerentrance4
	name = "lift (lower entrance zone)"
	lift_floor_label = "Lower Entrance Zone"
	lift_floor_name = "Lower Entrance Zone"
	lift_announce_str = "Arriving at Lower Entrance Zone: Management Department. Medical Bay. Access to High Containment Zone."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/hcz
	name = "lift (high containment zone)"
	lift_floor_label = "Heavy Containment Zone"
	lift_floor_name = "Heavy Containment Zone"
	lift_announce_str = "Arriving at High Containment Zone: Keter SCP Containment. HCZ Maintenance. LCZ Access."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/plag2hcz
	name = "lift (SCP-049)"
	lift_floor_label = "SCP-049 Containment"
	lift_floor_name = "SCP-049 Containment Chamber"
	lift_announce_str = "Arriving at SCP-049 Containment. Extreme caution necessary."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/hcz2plag
	name = "lift (Heavy Containment Zone)"
	lift_floor_label = "Heavy Containment Zone"
	lift_floor_name = "Heavy Containment Zone"
	lift_announce_str = "Arriving at High Containment Zone: Keter SCP Containment. HCZ Maintenance. LCZ Access."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/dmh2hcz
	name = "lift (SCP-106)"
	lift_floor_label = "SCP-106 Containment"
	lift_floor_name = "SCP-106 Containment"
	lift_announce_str = "Arriving at SCP-106 Containment: Extreme caution required."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/hcz2dmh
	name = "lift (Heavy Containment Zone)"
	lift_floor_label = "Heavy Containment Zone"
	lift_floor_name = "Heavy Containment Zone"
	lift_announce_str = "Arriving at High Containment Zone: Keter SCP Containment. HCZ Maintenance. LCZ Access."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/lhcz2lcz
	name = "lift (Lower Heavy Containment Zone)"
	lift_floor_label = "Lower Heavy Containment Zone"
	lift_floor_name = "Lower Heavy Containment Zone"
	lift_announce_str = "Arriving at Lower Heavy Containment Zone. Keter SCP Containment. HCZ Maintenance. LCZ Access."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/lcz2lhcz
	name = "lift (Light Containment Zone)"
	lift_floor_label = "Light Containment Zone"
	lift_floor_name = "Light Containment Zone"
	lift_announce_str = "Arriving at Light Containment Zone. Euclid and Safe SCP Containment."
	base_turf = /turf/simulated/floor
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/ulcz2llcz
	name = "lift (Lower Light Containment)"
	lift_floor_label = "Upper LCZ"
	lift_floor_name = "Upper Light Containment Zone"
	lift_announce_str = "Arriving at Upper Light Containment Zone. Euclid and Safe SCP Containment."
	base_turf = /turf/simulated/floor

/area/turbolift/llcz2ulcz
	name = "lift (Upper Low Containment)"
	lift_floor_label = "Lower LCZ"
	lift_floor_name = "Lower Light Containment Zone"
	lift_announce_str = "Arriving at Lower Light Containment Zone. Euclid and Safe SCP Containment."
	base_turf = /turf/simulated/floor




// NEW AREA'S.

/area/ds90/uez/hallways
	name = "\improper Upper Entrance Zone Hallways"
	icon_state = "hallC1"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/ds90/uez/aircloset
	name = "\improper Air Closet"
	icon_state = "firingrange"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/ds90/uez/firecloset
	name = "\improper Fire Closet"
	icon_state = "firingrange"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/ds90/uez/auxmonitoring
	name = "\improper Auxiliary Monitoring Room"
	icon_state = "checkpoint1"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/ds90/uez/gatea
	name = "\improper Gate A Elevator"
	icon_state = "shuttlered"
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/ds90/uez/gatebsecuritypost
	name = "\improper Gate B Security Post"
	icon_state = "checkpoint1"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/ds90/uez/gateb
	name = "\improper Gate B"
	icon_state = "shuttlered"
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/ds90/uez/gatebbunker
	name = "\improper Gate B Bunker"
	icon_state = "checkpoint1"
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/ds90/uez/uezlift2lez
	name = "\improper Entrance Zone Elevator"
	icon_state = "shuttlered"
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/ds90/uez/mcr
	name = "\improper Main Control Room"
	icon_state = "bridge"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/ds90/uez/armory
	name = "\improper Entrance Zone Armory"
	icon_state = "checkpoint1"
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/ds90/uez/maintenance
	name = "Maintenance"
	icon_state = "pmaint"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/ds90/uez/substation
	name = "\improper Entrance Zone Substation"
	icon_state = "hallF"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/ds90/uez/engineeringentry
	name = "\improper Engineering Entrance"
	icon_state = "engineering_foyer"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/ds90/uez/janitor
	name = "\improper Custodial Closet"
	icon_state = "janitor"

/area/ds90/uez/cryo
	name = "\improper General Cryogenic Storage"
	icon_state = "locker"
	requires_power = 0
