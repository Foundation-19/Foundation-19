/datum/map/site13

	base_floor_type = /turf/simulated/floor/reinforced/airless
	base_floor_area = /area/site13/maint/external

	post_round_safe_areas = list (
		/area/site13/surface/shuttle/helipad1,
		/area/site13/surface/shuttle/helipad2,
		/area/site13/surface/shuttle/helipad3,
		/area/site13/surface/shuttle/helipad4,
		/area/site13/floor2/security/vault,
		/area/site13/maint/headbunker,
		/area/site13/surface/crew_quaters/bunker,
		/area/site13/floor1/security/armoury,
		/area/site13/surface/hallway/ogateb
	)


/area/site13/supply/dock
	name = "Supply Shuttle"
	icon_state = "shuttle3"
	requires_power = 0
	area_flags = HIDE_FROM_HOLOMAP


//Surface

/area/site13/maint/external
	name = "Maintenance"
	icon_state = "apmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site13/maint/maint4
	name = "Maintenance"
	icon_state = "apmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site13/maint/maint2
	name = "Maintenance"
	icon_state = "apmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED

/area/site13/maint/maintmine
	name = "Mine"
	icon_state = "apmaint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	requires_power = 0

/area/site13/maint/headbunker
	name = "Heads Shelter"
	icon_state = "Sleep"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/storage/tech
	name = "Technical Storage"
	icon_state = "storage"
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/surface/storage/medical
	name = "Medical Storage"
	icon_state = "exam_room"
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/surface/rnd/officevac
	name = "Vacant Offices"
	icon_state = "devlab"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/hallway/gatea
	name = "\improper Gate A Hallway"
	icon_state = "hallF"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/surface/hallway/gatec
	name = "\improper Gate C Hallway"
	icon_state = "hallF"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/surface/hallway/elevator
	name = "\improper Surface Elevator Hallway"
	icon_state = "hallC1"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/surface/hallway/office
	name = "\improper Office Hallway"
	icon_state = "hallA"
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/surface/hallway/headsleft
	name = "\improper Staff Heads Hallway - West"
	icon_state = "hallC1"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/hallway/headsright
	name = "\improper Staff Heads Hallway - East"
	icon_state = "hallC1"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/hallway/ogatea
	name = "Outside Gate A"
	icon_state = "hallF"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ARRIVALS

/area/site13/surface/hallway/ogateb
	name = "Outside Gate B"
	icon_state = "hallF"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/hallway/ogatec
	name = "Outside Gate C"
	icon_state = "hallF"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/site13/surface/rnd/officestorage
	name = "\improper Office Storage"
	icon_state = "toxstorage"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/surface/rnd/office
	name = "\improper Office"
	icon_state = "devlab"
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/surface/rnd/checkpoint
	name = "\improper Office Security Checkpoint"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/janitor/closet
	name = "\improper Surface Custodial Closet"
	icon_state = "janitor"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/schleep
	name = "\improper Bunk Room"
	icon_state = "Sleep"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/cryo2
	name = "\improper Auxiliary Cryogenic Storage"
	icon_state = "Sleep"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/cryo1
	name = "\improper Cryogenic Storage"
	icon_state = "Sleep"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/toilets
	name = "\improper Toilets"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/washing
	name = "\improper Washing Machine Room"
	icon_state = "toilet"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/mess
	name = "\improper Main Cafeteria"
	icon_state = "cafeteria"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/kitchen
	name = "\improper Kitchen"
	icon_state = "kitchen"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/crew_quaters/kitchenbackroom
	name = "\improper Kitchen Cold Storage"
	icon_state = "kitchen"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/quatermaster/storage
	name = "\improper Cargonia"
	icon_state = "hangar"
	sound_env = LARGE_ENCLOSED
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/site13/surface/quatermaster/secstorage
	name = "\improper Cargo Secure Storage"
	icon_state = "quartstorage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/site13/surface/quatermaster/quarters
	name = "\improper Cargo Bunk Room"
	icon_state = "quartstorage"
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/site13/surface/quatermaster/storagedepot
	name = "\improper Cargo Depot"
	icon_state = "quartstorage"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_CARGO

/area/site13/surface/security/gateco
	name = "\improper Gate C Outside"
	icon_state = "checkpoint"
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/security/gatebo
	name = "\improper Gate B Outside"
	icon_state = "checkpoint"
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/security/gateao
	name = "\improper Gate A Outside"
	icon_state = "checkpoint"
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/security/gateci
	name = "\improper Gate C Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/security/gatebi
	name = "\improper Gate B Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/security/gateai
	name = "\improper Gate A Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/surface/acting/backstage
	name = "\improper Surface Common Room Storage"
	icon_state = "red"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/acting/stage
	name = "\improper Surface Common Room"
	icon_state = "yellow"
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/site13/surface/desert
	dynamic_lighting = 0
	requires_power = 0
	icon_state = "yellow"
	area_flags = list(list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP))

/area/site13/surface/tcommsat/main
	name = "\improper Telecoms"
	icon_state = "tcomsatcomp"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/tcommsat/office
	name = "\improper Telecoms Office"
	icon_state = "red"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/shuttle/helipad1
	icon_state = "shuttle"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/shuttle/helipad2
	icon_state = "shuttle"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/shuttle/helipad3
	icon_state = "shuttle"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/shuttle/helipad4
	icon_state = "shuttle"
	dynamic_lighting = 0
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/security/headarmory
	name = "\improper External Emergency Storage"
	icon_state = "security"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/security/headmedical
	name = "\improper External Medical Storage"
	icon_state = "security"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/maintenance/battery
	name = "\improper Surface Power Storage"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/surface/maintenance/kitchapcom
	name = "\improper Surface Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/surface/maintenance/cryoff
	name = "\improper Surface Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/surface/maintenance/cargo
	name = "\improper Surface Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/surface/crew_quaters/sd
	name = "\improper SD's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/rd
	name = "\improper RD's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/sc
	name = "\improper SC's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/ce
	name = "\improper CE's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/clo
	name = "\improper LO's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/cmo
	name = "\improper CMO's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/hop
	name = "\improper HoP's Office"
	icon_state = "head_quarters"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/conference
	name = "\improper Conference Room"
	icon_state = "bridge"
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/surface/crew_quaters/bunker
	name = "\improper Evacuation Shelter"
	icon_state = "bridge"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/surface/engineering/solars
	name = "\improper Solar Farm"
	icon_state = "engine_smes"
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor1/security/lczwo
	name = "\improper LCZ Floor West Checkpoint Outside"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lczso
	name = "\improper LCZ Floor South Checkpoint Outside"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lczno
	name = "\improper LCZ Floor North Checkpoint Outside"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lczni
	name = "\improper LCZ Floor North Checkpoint Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lczsi
	name = "\improper LCZ Floor South Checkpoint Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lczwi
	name = "\improper LCZ Floor West Checkpoint Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/hallway/elevator
	name = "\improper LCZ Floor Elevator Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/floor1/hallway/lczeast
	name = "\improper Light Containment Zone East Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/floor1/rnd/lounge
	name = "\improper Scientist Lounge"
	icon_state = "researchbreak"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/archives
	name = "\improper Archives"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/flora
	name = "\improper Flora Lab"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/briefing
	name = "\improper Briefing Room"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/scp173
	name = "\improper SCP 173's Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/humanoid
	name = "Humanoid Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/humanoid2
	name = "Humanoid Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/scp151
	name = "\improper SCP 151's Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/securestorage1
	name = "\improper Secure Storage 1 - SCP 113, SCP 500"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/rnd/lowstorage
	name = "\improper Lesser Anomalous Object Storage"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor1/crew_quarters/rd
	name = "\improper RD's Office"
	icon_state = "head_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/floor1/crew_quarters/sc
	name = "\improper SC's Office"
	icon_state = "head_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/floor2/crew_quarters/ce
	name = "\improper CE's Office"
	icon_state = "head_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/floor1/crew_quarters/cmo
	name = "\improper CMO's Office"
	icon_state = "head_quarters"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_COMMAND

/area/site13/floor1/medical/cages
	name = "\improper Animal Cages"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/dboiexam
	name = "\improper Class D Exam Room"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/dequipstorage
	name = "\improper Class D Medical Storage"
	icon_state = "medbay4"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/dsleeper
	name = "\improper Class D Treatment Centre"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/dentrance
	name = "\improper Class D Medical Reception"
	icon_state = "medbay3"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/dsurgery
	name = "\improper Class D Operating Theatre"
	icon_state = "surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/sleeper
	name = "\improper Acute Treatment Centre"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/bed
	name = "\improper Sub-Acute Treatment Centre"
	icon_state = "medbay"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/equipstorage
	name = "\improper Locker Room"
	icon_state = "medbay4"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/barracks
	name = "\improper Barracks"
	icon_state = "medbay"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/mentalhealth
	name = "\improper Mental Health"
	icon_state = "medbay3"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/chemistry
	name = "\improper Chemistry"
	icon_state = "chem"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/morgue
	name = "\improper Morgue"
	icon_state = "morgue"
	ambience = list('sound/ambience/ambimo1.ogg','sound/ambience/ambimo2.ogg','sound/music/main.ogg')
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/infirmary
	name = "\improper Infirmary Hallway"
	icon_state = "medbay"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/infirmreception
	name = "\improper Infirmary Reception"
	icon_state = "medbay2"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/security/medical
	name = "\improper LCZ Floor Infirmary Checkpoint"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/medical/medkits
	name = "\improper Medical Supplies Storage"
	icon_state = "chem"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/surgery
	name = "\improper Operating Theatre"
	icon_state = "surgery"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/medical/exam_room
	name = "\improper Exam Room"
	icon_state = "exam_room"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/maintenance/battery
	name = "\improper LCZ Floor Power Storage"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor1/medical/toilets
	name = "\improper Toilets"
	icon_state = "toilet"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_MEDICAL

/area/site13/floor1/security/toilets
	name = "\improper Toilets"
	icon_state = "toilet"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/armoury
	name = "\improper Armory"
	icon_state = "Warden"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/dwest
	name = "\improper Class D Cells - West"
	icon_state = "brig"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/deast
	name = "\improper Class D Cells - East"
	icon_state = "sec_prison"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/process
	name = "\improper Processing Cells"
	icon_state = "sec_prison"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/interrogation
	name = "\improper Interrogation Chamber"
	icon_state = "brig"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/wing
	name = "\improper Security Wing"
	icon_state = "security"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/ops
	name = "\improper Security Briefing Room"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/exec
	name = "\improper Disposal Room"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/range
	name = "\improper Firing Range"
	icon_state = "nuke_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/lockers
	name = "\improper Security Locker Room"
	icon_state = "brig"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/schleep
	name = "\improper Sleeping Quaters"
	icon_state = "sec_prison"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/hydroponics/prison
	name = "\improper Class D Garden"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/crew_quarters/gym
	name = "\improper Class D Recreational Area"
	icon_state = "fitness"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/dshowers
	name = "\improper Class D Shower Room"
	icon_state = "toilet"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/crew_quarters/mess
	name = "\improper Class D Cafeteria"
	icon_state = "cafeteria"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/crew_quarters/kitchen
	name = "\improper Class D Kitchen"
	icon_state = "kitchen"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/janitor/closet
	name = "\improper Class D Custodial Closet"
	icon_state = "janitor"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/rnd/library
	name = "\improper Class D Library"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/delivery
	name = "\improper Class D Deliveries"
	icon_state = "sec_prison"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/security/brigcontrol
	name = "\improper Cell Guard Quaters"
	icon_state = "sec_prison"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor1/maintenance/science
	name = "\improper LCZ Floor Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor1/maintenance/dbois
	name = "\improper LCZ Floor Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor1/maintenance/lczsec
	name = "\improper LCZ Floor Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor2/rnd/scp106
	name = "\improper SCP 106 Containment Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor2/rnd/servers
	name = "\improper Server Room"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor2/rnd/vac1
	name = "\improper Vacant High Security Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor2/rnd/vac2
	name = "\improper Vacant High Security Chamber"
	icon_state = "research"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SCIENCE

/area/site13/floor2/security/nuke
	name = "\improper Omega Warhead"
	icon_state = "nuke_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor2/security/hczwo
	name = "\improper HCZ Floor West Checkpoint Outside"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor2/security/hczwi
	name = "\improper HCZ Floor West Checkpoint Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor2/security/hczno
	name = "\improper HCZ Floor North Checkpoint Outside"
	icon_state = "checkpoint"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor2/security/hczni
	name = "\improper HCZ Floor North Checkpoint Inside"
	icon_state = "checkpoint1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_SECURITY

/area/site13/floor2/security/vault
	name = "\improper Vault"
	icon_state = "nuke_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ESCAPE

/area/site13/floor2/hallway/elevator
	name = "\improper HCZ Floor Elevator Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/floor2/hallway/hcz
	name = "\improper Heavy Containment Zone East Hallway"
	icon_state = "hallC1"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/site13/floor2/engineering/hallway
	name = "\improper Engineering Hallway"
	icon_state = "engineering_foyer"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/storage
	name = "\improper Engineering Storage"
	icon_state = "engineering_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/schleep
	name = "\improper Engineering Sleeping Quaters"
	icon_state = "Sleep"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/containment
	name = "\improper Containment Engineer Storage"
	icon_state = "engineering_supply"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/lockers
	name = "\improper Engineering Locker Room"
	icon_state = "engineering_supply"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/monitor
	name = "\improper Engineering Monitoring Room"
	icon_state = "engineering"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/atmostorage
	name = "\improper Atmospherics Storage"
	icon_state = "atmos_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/circuit
	name = "\improper Engineering Circuit Storage"
	icon_state = "engineering_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/atmos
	name = "\improper Atmospherics"
	icon_state = "atmos"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/engineering/engine
	name = "\improper Engine Room"
	icon_state = "nuke_storage"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_ENGINEERING

/area/site13/floor2/maintenance/battery
	name = "\improper HCZ Floor Power Storage"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor2/maintenance/engin
	name = "\improper HCZ Engineering North Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor2/maintenance/centr
	name = "\improper HCZ Maintenance"
	icon_state = "apmaint"
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)

/area/site13/floor2/hallway/toilets
	name = "\improper Toilets"
	icon_state = "toilet"
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_DORMS

/area/turbolift/site13_hcz_1
	name = "lift (hcz)"
	lift_floor_label = "Floor -2"
	lift_floor_name = "HCZ, Engineering, Omega Warhead"
	lift_announce_str = "Lift 1 Arriving at Floor -2: Heavy Contaimnent, Engineering, Omega Warhead."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_hcz_2
	name = "lift (hcz)"
	lift_floor_label = "Floor -2"
	lift_floor_name = "HCZ, Engineering, Omega Warhead"
	lift_announce_str = "Lift 2 Arriving at Floor -2: Heavy Contaimnent, Engineering, Omega Warhead."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_hcz_c
	name = "lift (hcz)"
	lift_floor_label = "Floor -2"
	lift_floor_name = "HCZ, Engineering, Omega Warhead"
	lift_announce_str = "Cargo Lift Arriving at Floor -2: Heavy Contaimnent, Engineering, Omega Warhead."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint2_1
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Lift 1 Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint2_2
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Lift 2 Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint2_c
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Cargo Lift Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_lcz_1
	name = "lift (hcz)"
	lift_floor_label = "Floor -1"
	lift_floor_name = "LCZ, Medical Bay, Security, Jail Block"
	lift_announce_str = "Lift 1 Arriving at Floor -2: Light Containment, Medical, Security, Class D Jail Block."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_lcz_2
	name = "lift (hcz)"
	lift_floor_label = "Floor -1"
	lift_floor_name = "LCZ, Medical Bay, Security, Jail Block"
	lift_announce_str = "Lift 2 Arriving at Floor -2: Light Containment, Medical, Security, Class D Jail Block."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_lcz_c
	name = "lift (hcz)"
	lift_floor_label = "Floor -1"
	lift_floor_name = "LCZ, Medical Bay, Security, Jail Block"
	lift_announce_str = "Cargo Lift Arriving at Floor -2: Light Containment, Medical, Security, Class D Jail Block."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint4_1
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Lift 1 Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint4_2
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Lift 2 Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_maint4_c
	name = "lift (hcz)"
	lift_floor_label = "Maintenance"
	lift_floor_name = "**Stop at halfway**"
	lift_announce_str = "Cargo Lift Stopping in Maintenance."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_surf_1
	name = "lift (hcz)"
	lift_floor_label = "Floor 0"
	lift_floor_name = "Gates, Administration, Recreation"
	lift_announce_str = "Lift 1 Arriving at Floor 0: Administration, Outside Gates, Food and Recreation, Cargo."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_surf_2
	name = "lift (hcz)"
	lift_floor_label = "Floor 0"
	lift_floor_name = "Gates, Administration, Recreation"
	lift_announce_str = "Lift 2 Arriving at Floor 0: Administration, Outside Gates, Food and Recreation, Cargo."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/turbolift/site13_surf_c
	name = "lift (hcz)"
	lift_floor_label = "Floor 0"
	lift_floor_name = "Gates, Administration, Recreation, Cargo"
	lift_announce_str = "Cargo Lift Arriving at Floor 0: Administration, Outside Gates, Food and Recreation, Cargo."
	requires_power = 0
	dynamic_lighting = 0
	area_flags = AREA_FLAG_RAD_SHIELDED
	holomap_color = HOLOMAP_AREACOLOR_HALLWAYS

/area/acting/stage
	name = "Pocket Dimension"
	requires_power = 0
	dynamic_lighting = 0
	area_flags = list(AREA_FLAG_RAD_SHIELDED, HIDE_FROM_HOLOMAP)
