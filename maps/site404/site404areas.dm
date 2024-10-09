/datum/map/site53

	post_round_safe_areas = list (
		/area/centcom
		)

/area/turbolift
	name = "\improper Turbolift"
	icon_state = "shuttle"
	requires_power = 0
	dynamic_lighting = 1
	area_flags = AREA_FLAG_RAD_SHIELDED

// THE EVIL HARDCODED EVENT AREAS. SHAME ON YOU, BLOB, GREYTIDE, AND VINES.
// Don't forget to remove these later when this spaghetti gets unravelled.

/area/site53/ulcz/hallways
/area/site53/llcz/hallways
/area/site53/uhcz/hallways
/area/site53/lhcz/hallway
/area/site53/engineering
/area/site53/engineering/maintenance
/area/site53/engineering/selfdestruct
/area/site53/engineering/lowernukeladders
/area/site53/engineering/uppernukeladders
/area/site53/medical
/area/site53/medical/mentalhealth/isolation
/area/site53/reswing
/area/site53/science
/area/site53/reswing/xenobiology
/area/site53/science/aicobservation
/area/site53/science/aiccore
/area/site53/uez
/area/site53/ulcz/maintenance
/area/site53/lhcz/maintenance
/area/site53/uez/maintenance
/area/site53/lhcz/maintenance

// SITE 404 ELEVATOR SHAFT AREAS

/area/turbolift/site404/elevator/hcz
	name = "lift (Heavy Containment Zone)"
	lift_floor_label = "Heavy Containment Zone"
	lift_floor_name = "Deck 4"
	lift_announce_str = "Arriving at Heavy Containment Zone: Objects 008, 017, 049, 055, 082, 096, 106, 280, 457, 500, 895, 1102-RU, 2398, 2427-3. Heavy Humanoid Containment."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site404/elevator/lcz
	name = "lift (Light Containment Zone)"
	lift_floor_label = "Light Containment Zone"
	lift_floor_name = "Deck 3"
	lift_announce_str = "Arriving at Light Containment Zone: Objects 012, 013, 066, 113, 131, 151, 173, 216, 247, 263, 343, 513, 527, 999, 2343. Class-D Quarters. Light Humanoid Containment."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site404/elevator/ez
	name = "lift (Entrance Zone)"
	lift_floor_label = "Entrance Zone"
	lift_floor_name = "Deck 2"
	lift_announce_str = "Arriving at Entrance Zone: Objects 294. Departments Medical, Research, Service."
	requires_power = 0
	dynamic_lighting = 1

/area/turbolift/site404/elevator/bridge
	name = "lift (Adminstration Zone)"
	lift_floor_label = "Adminstration Zone"
	lift_floor_name = "Deck 1"
	lift_announce_str = "Arriving at Adminstration Zone: Departments Command, Engineering, Logistics."
	requires_power = 0
	dynamic_lighting = 1

//Site 404

/area/site404
	name = "Site 404 Superstructure"

//Site 404's Shuttle Areas

/area/site404/shuttle/lift106
	name = "SCP-106 Access Lift"
	icon_state = "shuttle"
	requires_power = 0

/area/site404/shuttle/unit106
	name = "SCP-106 Containment Chamber"
	icon_state = "shuttle"
	requires_power = 0

//Site 404 - Adminstration Zone
/area/site404/administration
	name = "Site 404 Administration Zone"
	icon_state = "administrationdepartment"

/area/site404/administration/bridge
	name = "Administration Department - Bridge"

/area/site404/administration/commandlounge
	name = "Administration Department - Command Lounge"

/area/site404/administration/groupsofinterestlounge
	name = "Administration Department - GOI Lounge"

/area/site404/administration/office/sitemanager
	name = "Administration Department - Site Manager's Office"

/area/site404/administration/office/ethicsrep
	name = "Administration Department - Ethics Committee Liaison's Office"

/area/site404/administration/office/tribunal
	name = "Administration Department - Internal Tribunal Department Officer's Office"

/area/site404/administration/office/engineering
	name = "Administration Department - Engineering Director's Office"

/area/site404/administration/office/research
	name = "Administration Department - Research Director's Office"

/area/site404/administration/office/medical
	name = "Administration Department - Medical Director's Office"

/area/site404/administration/office/security
	name = "Administration Department - Guard Commander's Office"

/area/site404/administration/office/goc
	name = "Administration Department - Global Occult Coalition Representative's Office"

/area/site404/administration/office/marshalcarterdark
	name = "Administration Department - Marshal, Carter and Dark Corporate Liason's Office"

/area/site404/administration/office/uiu
	name = "Administration Department - UIU Relations Agent's Office"

/area/site404/administration/office/goldbaker
	name = "Administration Department - Goldbaker-Reinz Corporate Liaison's Office"

/area/site404/administration/assemblyhall
	name = "Administration Department - Assembly Hall"

/area/site404/administration/assemblywaitingroom
	name = "Administration Department - Assembly Hall Waiting Room"

/area/site404/administration/holodeck
	name = "Administration Department - Holodeck"

/area/site404/administration/customs
	name = "Administration Department - Docking Bay Customs Checkpoint"
	icon_state = "EZ"

/area/site404/administration/customscorridor
	name = "Administration Department - Customs Checkpoint Corridor"
	icon_state = "EZ"

/area/site404/administration/escapepodhall
	name = "Administration Zone Escape Pod Corridor"

/area/site404/administration/substation
	name = "Administration Zone Substation Compartment"
	icon_state = "engineeringdepartment"

/area/site404/administration/maintenance
	icon_state = "engineeringdepartment"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site404/administration/maintenance/elevator
	name = "Administration Zone Elevator Maintenance Shaft"

/area/site404/administration/maintenance/central/a
	name = "Administration Zone Central Maintenance Corridor A"

/area/site404/administration/maintenance/central/b
	name = "Administration Zone Central Maintenance Corridor B"

/area/site404/administration/maintenance/fore
	name = "Administration Zone Fore Maintenance"

/area/site404/administration/maintenance/portbow
	name = "Administration Zone Port Bow Maintenance"

/area/site404/administration/maintenance/portquarter
	name = "Administration Zone Port Quarter Maintenance"

/area/site404/administration/maintenance/starboardbow
	name = "Administration Zone Starboard Bow Maintenance"

/area/site404/administration/maintenance/starboardquarter
	name = "Administration Zone Starboard Quarter Maintenance"

//Site 404 - Engineering Department
/area/site404/engineering
	name = "Site 404 Engineering Zone"
	icon_state = "engineeringdepartment"

/area/site404/engineering/hallway
	name = "Engineering Department - Primary Corridor"

/area/site404/engineering/assistantengineeringdirectoroffice
	name = "Research Department - Assistant Engineering Director Office"
	icon_state = "administrationdepartment"

/area/site404/engineering/containmentengineeroffice
	name = "Research Department - Containment Engineer's Office"
	icon_state = "HCZ"

/area/site404/engineering/monitoringroom
	name = "Engineering Department - Monitoring Room"

/area/site404/engineering/securetechnicalstorage
	name = "Engineering Department - Secure Technical Storage Compartment"

/area/site404/engineering/breakroom
	name = "Engineering Department - Break Room"

/area/site404/engineering/janitorial
	name = "Engineering Department - Custodial Compartment"

/area/site404/engineering/lockerroom
	name = "Engineering Department - Locker Room"

/area/site404/engineering/workshop
	name = "Engineering Department - Workshop"

/area/site404/engineering/dronebay
	name = "Engineering Department - Maintenance Drone Bay"

/area/site404/engineering/hallway
	name = "Engineering Department - Primary Corridor"

/area/site404/engineering/atmospherics
	name = "Engineering Department - Atmospherics Compartment"

/area/site404/engineering/gravitygenerator
	name = "Engineering Department - Station Gravity Generation Facility"

/area/site404/engineering/constructionzone
	name = "Engineering Department - Construction Zone"

/area/site404/engineering/auxiliaryreactor
	name = "Research Department - Auxiliary Reactor Compartment"

/area/site404/engineering/fusionengine/interior
	name = "Engineering Department - Fusion Reactor Compartment"

/area/site404/engineering/fusionengine/control
	name = "Engineering Department - Fusion Reactor Control Compartment"

//Site 404 - Logistic Department
/area/site404/logistics
	name = "Site 404 Logistics Zone"
	icon_state = "logisticsdepartment"

/area/site404/logistics/logisticsofficer
	name = "Logistics Department - Logistics Officer's Office"
	icon_state = "administrationdepartment"

/area/site404/logistics/unloadingbay
	name = "Logistics Department - Unloading Bay"

/area/site404/logistics/lockerroom
	name = "Logistics Department - Locker Room"

/area/site404/logistics/warehouse
	name = "Logistics Department - Warehouse"

/area/site404/logistics/logisticsoffice
	name = "Logistics Department - Logistics Central Office"

/area/site404/logistics/hallway
	name = "Logistics Department - Logistics Hallway"

//Site 404 - Entrance Zone
/area/site404/entrancezone
	name = "Site 404 Entrance Zone"
	icon_state = "EZ"

/area/site404/entrancezone/dockingbay
	name = "Entrance Zone - Docking Bay"
	sound_env = LARGE_ENCLOSED

/area/site404/entrancezone/shelter
	name = "Entrance Zone - Emergency Shelter"

/area/site404/entrancezone/hallway/lowerprimary
	name = "Entrance Zone - Lower Primary Hallway"

/area/site404/entrancezone/hallway/port
	name = "Entrance Zone - Upper Portside Hallway"

/area/site404/entrancezone/hallway/starboard
	name = "Entrance Zone - Upper Starboard Hallway"

/area/site404/entrancezone/dormitory
	name = "Entrance Zone - Dormitories"
	icon_state = "servicedepartment"

/area/site404/entrancezone/lockerroom
	name = "Entrance Zone - Public Locker Room"
	icon_state = "servicedepartment"

/area/site404/entrancezone/waitingroom/lower
	name = "Entrance Zone - Deck Two Waiting Room"

/area/site404/entrancezone/waitingroom/upper
	name = "Entrance Zone - Deck One Waiting Room"

/area/site404/entrancezone/securityoffice/checkpoint
	name = "EZ Security Office - Checkpoint"

/area/site404/entrancezone/securityoffice/securitymeetingroom
	name = "EZ Security Office - Zone Commander Meeting Room"

/area/site404/entrancezone/securityoffice/breakroom
	name = "EZ Security Office - Security Office Break Room"

/area/site404/entrancezone/securityoffice/brig
	name = "EZ Security Office - Security Office Brig"

/area/site404/entrancezone/securityoffice/briefingroom
	name = "EZ Security Office - Security Office Briefing Room"

/area/site404/entrancezone/securityoffice/detective
	name = "EZ Security Office - Investigations Office"

/area/site404/entrancezone/securityoffice/commanderoffice
	name = "EZ Security Office - Zone Commander's Office"
	icon_state = "administrationdepartment"

/area/site404/entrancezone/securityoffice/guardfacilities
	name = "EZ Security Office - Guard Facilities"

/area/site404/entrancezone/securityoffice/raisa
	name = "EZ Security Office - RAISA Agent's Office"

/area/site404/entrancezone/securityoffice/atrium
	name = "EZ Security Office - Upper Atrium"

/area/site404/entrancezone/securityoffice/hallway
	name = "EZ Security Office - Upper Corridor"

/area/site404/entrancezone/escapepodhall
	name = "Entrance Zone Escape Pod Corridor"
	icon_state = "administrationdepartment"

/area/site404/entrancezone/substation
	name = "Entrance Zone Substation Compartment"
	icon_state = "engineeringdepartment"

/area/site404/entrancezone/maintenance
	icon_state = "engineeringdepartment"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site404/entrancezone/maintenance/elevator
	name = "EZ Elevator Maintenance Shaft"

/area/site404/entrancezone/maintenance/fore
	name = "EZ Fore Maintenance"

/area/site404/entrancezone/maintenance/portbow
	name = "EZ Port Bow Maintenance"

/area/site404/entrancezone/maintenance/portquarter
	name = "EZ Port Quarter Maintenance"

/area/site404/entrancezone/maintenance/starboardbow
	name = "EZ Starboard Bow Maintenance"

/area/site404/entrancezone/maintenance/starboardquarter
	name = "EZ Starboard Quarter Maintenance"

//Site 404 - Medical Department
/area/site404/medical
	name = "Site 404 Medical Zone"
	icon_state = "medicaldepartment"

/area/site404/medical/waitingroom
	name = "Medical Department - Waiting Room"

/area/site404/medical/treatment
	name = "Medical Department - Treatment Room"

/area/site404/medical/exam
	name = "Medical Department - Examination Room"

/area/site404/medical/reception
	name = "Medical Department - Reception Compartment"

/area/site404/medical/chemistry
	name = "Medical Department - Chemical Laboratory"

/area/site404/medical/breakroom
	name = "Medical Department - Break Room"

/area/site404/medical/equipmentstorage
	name = "Medical Department - Equipment Storage"

/area/site404/medical/surgery/operatingroom1
	name = "Medical Department - Operating Room 1"

/area/site404/medical/surgery/operatingroom2
	name = "Medical Department - Operating Room 2"

/area/site404/medical/surgery/operatingroom3
	name = "Medical Department - Operating Room 3"

/area/site404/medical/psychologistoffice
	name = "Medical Department - Psychologist Office"

/area/site404/medical/assistantmedicaldirectoroffice
	name = "Medical Department - Assistant Medical Director's Office"
	icon_state = "administrationdepartment"

/area/site404/medical/securitystation
	name = "Medical Department - Security Station"
	icon_state = "EZ"

/area/site404/medical/virology
	name = "Medical Department - Virology Laboratory"

/area/site404/medical/hallway
	name = "Medical Department - Primary Corridor"

/area/site404/medical/morgue/coroner
	name = "Medical Department - Coroner's Office"

/area/site404/medical/morgue/corpsestorage
	name = "Medical Department - Morgue"

/area/site404/medical/morgue/crematorium
	name = "Medical Department - Incineration Compartment"

//Site 404 - Service Department
/area/site404/service
	name = "Site 404 Service Zone"
	icon_state = "servicedepartment"

/area/site404/service/canteen
	name = "Entrance Zone - Canteen"

/area/site404/service/kitchen
	name = "Entrance Zone - Kitchen"

/area/site404/service/coldroom
	name = "Entrance Zone - Kitchen Coldroom"

/area/site404/service/baroffice
	name = "Entrance Zone - Canteen Office Compartment"

/area/site404/service/hydroponics
	name = "Entrance Zone - Hydroponics Compartment"

/area/site404/service/janitorial
	name = "Entrance Zone - Janitorial Compartment"

/area/site404/service/chapel/main
	name = "Entrance Zone - Chapel Atrium"

/area/site404/service/chapel/office
	name = "Entrance Zone - Chapel Office"

/area/site404/service/chapel/coffinstore
	name = "Entrance Zone - Coffin Store"

/area/site404/service/archive
	name = "Entrance Zone - Lower Archive"

/area/site404/service/archive/upper
	name = "Entrance Zone - Upper Archive"

//Site 404 - Research Department
/area/site404/research
	name = "Site 404 Research Zone"
	icon_state = "researchdepartment"

/area/site404/research/hallway
	name = "Research Department - Primary Corridor"

/area/site404/research/researchdevelopment
	name = "Research Department - Research and Development Compartment"

/area/site404/research/xenobiology
	name = "Research Department - Xenobiological Laboratory"

/area/site404/research/xenoflora
	name = "Research Department - Xenoflora Laboratory"

/area/site404/research/chemistry
	name = "Research Department - Medicinal Development & Maintenance Laboratory"

/area/site404/research/anomaly
	name = "Research Department - Anomalous Object Laboratory"

/area/site404/research/xenoarcheology
	name = "Research Department - Xenoarcheological Laboratory"

/area/site404/research/canisterstorage
	name = "Research Department - Secure Canister Storage Compartment"

/area/site404/research/janitorial
	name = "Research Department - Custodial Compartment"
	icon_state = "servicedepartment"

/area/site404/research/breakroom
	name = "Research Department - Research Break Room"

/area/site404/research/robotics/roboticsfabrication
	name = "Research Department - Robotics Fabrication Laboratory"

/area/site404/research/robotics/roboticsdevelopment
	name = "Research Department - Robotics Development Compartment"

/area/site404/research/robotics/roboticsmaintenancebay
	name = "Research Department - Robotics Maintenance Bay"

/area/site404/research/robotics/roboticssurgery
	name = "Research Department - Robotics Surgical Compartment"

/area/site404/research/assistantresearchdirectoroffice
	name = "Research Department - Assistant Research Director Office"
	icon_state = "administrationdepartment"

/area/site404/research/office/A
	name = "Research Department - Senior Researcher Office A"

/area/site404/research/office/B
	name = "Research Department - Senior Researcher Office B"

/area/site404/research/office/C
	name = "Research Department - Senior Researcher Office C"

/area/site404/research/office/mentalist
	name = "Research Department - Psychic Phenomena Laboratory"

/area/site404/research/aic
	icon_state = "administrationdepartment"

/area/site404/research/aic/foyer
	name = "AIAD Sector - Division Foyer"

/area/site404/research/aic/hallway
	name = "AIAD Sector - AIC Unit Access Corridor"

/area/site404/research/aic/electrical
	name = "AIAD Sector - Division Electrical Compartment"
	icon_state = "engineeringdepartment"

/area/site404/research/aic/cores
	area_flags = AREA_FLAG_ION_SHIELDED

/area/site404/research/aic/cores/one
	name = "AIAD Sector - AIC Unit One"

/area/site404/research/aic/cores/two
	name = "AIAD Sector - AIC Unit Two"

/area/site404/research/aic/cores/three
	name = "AIAD Sector - AIC Unit Three"

/area/site404/research/aic/cores/four
	name = "AIAD Sector - AIC Unit Four"

//Site 404 - Light Containment Zone
/area/site404/lightcontainmentzone
	name = "Site 404 Light Containment Zone"
	icon_state = "LCZ"

/area/site404/lightcontainmentzone/waitingroom
	name = "Light Containment Zone Waiting Room"

/area/site404/lightcontainmentzone/safestorage
	name = "LCZ Safe Object Containment Facilities"

/area/site404/lightcontainmentzone/securityoffice/checkpoint
	name = "LCZ Security Office - Checkpoint"

/area/site404/lightcontainmentzone/securityoffice/cryogenics
	name = "LCZ Security Office - Cryogenics"
	icon_state = "servicedepartment"

/area/site404/lightcontainmentzone/securityoffice/hallway
	name = "LCZ Security Office - Hallway"

/area/site404/lightcontainmentzone/securityoffice/cadets
	name = "LCZ Security Office - Cadet Lockers Compartment"

/area/site404/lightcontainmentzone/securityoffice/riotarmory
	name = "LCZ Security Office - Riot Armory"

/area/site404/lightcontainmentzone/securityoffice/clinic
	name = "LCZ Security Office - Clinic"
	icon_state = "medicaldepartment"

/area/site404/lightcontainmentzone/securityoffice/briefingroom
	name = "LCZ Security Office - Briefing Room"

/area/site404/lightcontainmentzone/securityoffice/commanderoffice
	name = "LCZ Security Office - Zone Commander Office"
	icon_state = "administrationdepartment"

/area/site404/lightcontainmentzone/securityoffice/sargeoffice
	name = "LCZ Security Office - Sergeant Offices"

/area/site404/lightcontainmentzone/securityoffice/armory
	name = "LCZ Security Office - Primary Armory"

/area/site404/lightcontainmentzone/hallway/north
	name = "LCZ Fore Hallway"

/area/site404/lightcontainmentzone/hallway/south
	name = "LCZ Aft Hallway"

/area/site404/lightcontainmentzone/humanoidcontainment/hallway
	name = "LCZ Humanoid Containment Hallway"

/area/site404/lightcontainmentzone/humanoidcontainment/one
	name = "LCZ Humanoid Containment Unit One"

/area/site404/lightcontainmentzone/humanoidcontainment/two
	name = "LCZ Humanoid Containment Unit Two"

/area/site404/lightcontainmentzone/humanoidcontainment/three
	name = "LCZ Humanoid Containment Unit Three"

/area/site404/lightcontainmentzone/humanoidcontainment/four
	name = "LCZ Humanoid Containment Unit Four"

/area/site404/lightcontainmentzone/humanoidcontainment/five
	name = "LCZ Humanoid Containment Unit Five"

/area/site404/lightcontainmentzone/humanoidcontainment/six
	name = "LCZ Humanoid Containment Unit Six"

/area/site404/lightcontainmentzone/humanoidbreakroom
	name = "LCZ Humanoid Recreation Compartment"

/area/site404/lightcontainmentzone/safestorage
	name = "LCZ Safe Object Containment Facilities"

/area/site404/lightcontainmentzone/officebreakroom
	name = "LCZ Office Worker Breakroom"

/area/site404/lightcontainmentzone/escapepodhall
	name = "Light Containment Zone Escape Pod Corridor"
	icon_state = "administrationdepartment"

/area/site404/lightcontainmentzone/eva
	name = "LCZ EVA Compartment"

/area/site404/lightcontainmentzone/substation
	name = "LCZ Substation Compartment"
	icon_state = "engineeringdepartment"

/area/site404/lightcontainmentzone/maintenance
	icon_state = "engineeringdepartment"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site404/lightcontainmentzone/maintenance/elevator
	name = "LCZ Elevator Maintenance Shaft"

/area/site404/lightcontainmentzone/maintenance/fore
	name = "LCZ Fore Maintenance"

/area/site404/lightcontainmentzone/maintenance/port
	name = "LCZ Portside Maintenance"

/area/site404/lightcontainmentzone/maintenance/aft
	name = "LCZ Aft Maintenance"

/area/site404/lightcontainmentzone/maintenance/starboard
	name = "LCZ Starboard Maintenance"

//Site 404 - Class-D Containment Zone
/area/site404/classdzone
	name = "Site 404 Class-D Housing Area"
	icon_state = "CDZ"

/area/site404/classdzone/canteen
	name = "CDZ - Canteen"

/area/site404/classdzone/restroom
	name = "CDZ - Restroom"

/area/site404/classdzone/atrium
	name = "CDZ - Atrium"

/area/site404/classdzone/labor/mining
	icon_state = "logisticsdepartment"

/area/site404/classdzone/labor/mining/equipment
	name = "CDZ - Mining Bay Equipment Storage"

/area/site404/classdzone/labor/mining/refinery
	name = "CDZ - Mining Bay Refinery"

/area/site404/classdzone/labor/mining/checkpoint
	name = "CDZ - Mining Bay Security Checkpoint"
	icon_state = "CDZ"

/area/site404/classdzone/labor/clinic
	name = "CDZ - Medical Bay"
	icon_state = "medicaldepartment"

/area/site404/classdzone/labor/kitchen
	name = "CDZ - Kitchen Compartment"
	icon_state = "servicedepartment"

/area/site404/classdzone/labor/hydroponics
	name = "CDZ - Hydroponics Compartment"
	icon_state = "servicedepartment"

/area/site404/classdzone/quarters/hallway
	name = "Class-D Quarters - Hallway"

/area/site404/classdzone/quarters/one
	name = "Class-D Quarters - Cell One"

/area/site404/classdzone/quarters/two
	name = "Class-D Quarters - Cell Two"

/area/site404/classdzone/quarters/three
	name = "Class-D Quarters - Cell Three"

/area/site404/classdzone/quarters/four
	name = "Class-D Quarters - Cell Four"

/area/site404/classdzone/quarters/five
	name = "Class-D Quarters - Cell Five"

/area/site404/classdzone/quarters/six
	name = "Class-D Quarters - Cell Six"

/area/site404/classdzone/quarters/seven
	name = "Class-D Quarters - Cell Seven"

/area/site404/classdzone/quarters/eight
	name = "Class-D Quarters - Cell Eight"

/area/site404/classdzone/quarters/nine
	name = "Class-D Quarters - Cell Nine"

/area/site404/classdzone/quarters/ten
	name = "Class-D Quarters - Cell Ten"

/area/site404/classdzone/luxury/hallway
	name = "CDZ Luxury Zone - Hallway"

/area/site404/classdzone/luxury/lounge1
	name = "CDZ Luxury Zone - Lounge One"

/area/site404/classdzone/luxury/lounge2
	name = "CDZ Luxury Zone - Lounge Two"

/area/site404/classdzone/luxury/quarters/one
	name = "CDZ Luxury Zone - Quarters One"

/area/site404/classdzone/luxury/quarters/two
	name = "CDZ Luxury Zone - Quarters Two"

/area/site404/classdzone/luxury/quarters/three
	name = "CDZ Luxury Zone - Quarters Three"

/area/site404/classdzone/luxury/quarters/four
	name = "CDZ Luxury Zone - Quarters Four"

/area/site404/classdzone/luxury/quarters/five
	name = "CDZ Luxury Zone - Quarters Five"

/area/site404/classdzone/luxury/quarters/six
	name = "CDZ Luxury Zone - Quarters Six"

/area/site404/classdzone/security/briefingroom
	name = "CDZ - Briefing Desk"

/area/site404/classdzone/security/controlroom
	name = "CDZ - Zone Control Compartment"

/area/site404/classdzone/security/hallway
	name = "CDZ - Zone Entrance Hallway"

//Site 404 - Heavy Containment Zone
/area/site404/heavycontainmentzone
	name = "DON'T USE ME PLEASE!"
	icon_state = "HCZ"

/area/site404/heavycontainmentzone/securityoffice/commanderoffice
	name = "HCZ Security Office - Zone Commander Office"
	icon_state = "administrationdepartment"

/area/site404/heavycontainmentzone/securityoffice/checkpoint
	name = "\improper HCZ Security Office - Checkpoint"

/area/site404/heavycontainmentzone/securityoffice/briefingroom
	name = "HCZ Security Office - Briefing Room"

/area/site404/heavycontainmentzone/securityoffice/clinic
	name = "HCZ Security Office - Clinic"
	icon_state = "medicaldepartment"

/area/site404/heavycontainmentzone/securityoffice/cells
	name = "HCZ Security Office - Holding Cells"

/area/site404/heavycontainmentzone/securityoffice/easthall
	name = "HCZ Security Office - Starboard Corridor"

/area/site404/heavycontainmentzone/securityoffice/westhall
	name = "HCZ Security Office - Portside Corridor"

/area/site404/heavycontainmentzone/securityoffice/armory
	name = "HCZ Security Office - Armory"

/area/site404/heavycontainmentzone/hallway/central
	name = "HCZ Central Hallway"

/area/site404/heavycontainmentzone/hallway/east
	name = "HCZ Starboard Hallway"

/area/site404/heavycontainmentzone/hallway/west
	name = "HCZ Portside Hallway"

/area/site404/heavycontainmentzone/guardfacilities
	name = "HCZ Guard Facilities"

/area/site404/heavycontainmentzone/eva
	name = "HCZ EVA Compartment"

/area/site404/heavycontainmentzone/humanoidcontainment
	name = "HCZ Humanoid Containment Facilities"

/area/site404/heavycontainmentzone/safestorage
	name = "HCZ Safe Object Containment Facilities"

/area/site404/heavycontainmentzone/substation
	name = "HCZ Substation Compartment"
	icon_state = "engineeringdepartment"

/area/site404/heavycontainmentzone/escapepodhall
	name = "Heavy Containment Zone Escape Pod Corridor"
	icon_state = "administrationdepartment"

/area/site404/heavycontainmentzone/maintenance
	icon_state = "engineeringdepartment"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site404/heavycontainmentzone/maintenance/elevator
	name = "HCZ Elevator Maintenance Shaft"

/area/site404/heavycontainmentzone/maintenance/forea
	name = "HCZ Fore Maintenance Corridor A"

/area/site404/heavycontainmentzone/maintenance/foreb
	name = "HCZ Fore Maintenance Corridor B"

/area/site404/heavycontainmentzone/maintenance/portbow
	name = "HCZ Portside Bow Maintenance"

/area/site404/heavycontainmentzone/maintenance/portquarter
	name = "HCZ Portside Quarter Maintenance"

/area/site404/heavycontainmentzone/maintenance/aft
	name = "HCZ Aft Maintenance"

/area/site404/heavycontainmentzone/maintenance/starboard
	name = "HCZ Starboard Maintenance"

//Site 404 - Containment Units
/area/site404/containmentchambers
	name = "Site 404 Containment Unit Area"

/area/site404/containmentchambers/scp008/researchoffice
	name = "SCP-008 Research Office"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp008/laboratory
	name = "SCP-008 Pathogen Laboratory"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp008/storage
	name = "SCP-008 Sample Storage"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp008/maintenance
	name = "SCP-008 Maintenance Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp008/testroom
	name = "SCP-008 Test Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp008/incineration
	name = "SCP-008 Contaminate Incineration"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp012
	name = "SCP-012 Containment Chamber"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp017
	name = "SCP-017 Containment Facilities"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/maintenance
	name = "SCP-049 Observation Maintenance Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/storage
	name = "SCP-049 Observation Storage Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/observation
	name = "SCP-049 Observation Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/study
	name = "SCP-049 Containment Study"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/quarters
	name = "SCP-049 Containment Quarters"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/office
	name = "SCP-049 Containment Office"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/storage
	name = "SCP-049 Containment Storage"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/kitchen
	name = "SCP-049 Containment Kitchen"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp049/chamber/clinic
	name = "SCP-049 Containment Clinic"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp066
	name = "SCP-066 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp082/maintenance
	name = "SCP-082 Maintenance Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/janitorial
	name = "SCP-082 Janitorial Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/prep
	name = "SCP-082 Preperation Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/lowerhallway
	name = "SCP-082 Lower Hallway"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/upperhallway
	name = "SCP-082 Upper Hallway"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/chamber/main
	name = "SCP-082 Main Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/chamber/kitchen
	name = "SCP-082 Containment Kitchen"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/chamber/janitorial
	name = "SCP-082 Containment Janitorial"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/chamber/quarters
	name = "SCP-082 Containment Quarters"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp082/chamber/park
	name = "SCP-082 Containment Park"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp096/chamber
	name = "SCP-096 Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp096/observation
	name = "SCP-096 Containment Facilities"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/chamber/lowercontainment
	name = "SCP-106 Lower Exterior Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/chamber/uppercontainment
	name = "SCP-106 Upper Exterior Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/lowermaintenance
	name = "SCP-106 Lower Maintenance Corridor"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/lowerhallway
	name = "SCP-106 Lower Observation Corridor"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/uppermaintenance
	name = "SCP-106 Maintenance Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/upperobservation
	name = "SCP-106 Observation Compartment"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp106/entrance
	name = "SCP-106 Containment Facilities Entrance Corridor"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp173/chamber
	name = "SCP-173 Containment Chamber"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp173/observation
	name = "SCP-173 Observation Compartment"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp280/chamber
	name = "SCP-280 Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp280/observation
	name = "SCP-280 Containment Facilities"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp294
	name = "SCP-294 Containment Chamber"
	icon_state = "researchdepartment"

/area/site404/containmentchambers/scp343
	name = "SCP-343 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp457
	name = "SCP-457 Containment Facilities"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp513
	name = "SCP-513 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp529
	name = "SCP-529 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp895
	name = "SCP-895 Containment Facilities"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp999
	name = "SCP-999 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp914
	name = "SCP-914 Containment Facilities"
	icon_state = "LCZscp"

/area/site404/containmentchambers/scp2427/chamber
	name = "SCP-2427-3 Containment Chamber"
	icon_state = "HCZscp"

/area/site404/containmentchambers/scp2427/observation
	name = "SCP-2427-3 Containment Facilities"
	icon_state = "HCZscp"

//SCP-106's realm
/area/pocketdimension
	name = "Pocket Dimension"
	requires_power = 0
	dynamic_lighting = 0
