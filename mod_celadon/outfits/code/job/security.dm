/datum/job/ncoofficerlcz
	title = "LCZ Sergeant"
	department = "Light Containment Personnel"
	selection_color = "#601c1c"
	department_flag = SEC|LCZ
	total_positions = 2
	spawn_positions = 2
	balance_limited = TRUE
	//duties = "<big><b>As the Guard you have more access than a Junior Guard, but do not control them. You are to guard tests and SCP's in the zone you spawned in. If in doubt, ask your Zone or Guard Commander. You also have the duty of guarding the D-Class Cell Blocks. You should not leave your zone under usual SoP.</b></big>"
	supervisors = "the LCZ Zone Commander"
	economic_power = 4
	requirements = list(EXP_TYPE_LCZ = 480)
	alt_titles = list("LCZ Senior Containment Response Agent", "LCZ Containment Response Sergeant", "LCZ Senior Combat Medic" = /decl/hierarchy/outfit/job/security/lcz_medic, "LCZ Riot Control Sergeant" = /decl/hierarchy/outfit/job/security/lcz_riot, "LCZ Senior Riot Control Agent" = /decl/hierarchy/outfit/job/security/lcz_riot, "LCZ Senior Agent")
	minimal_player_age = 5
	ideal_character_age = 25
	outfit_type = /decl/hierarchy/outfit/job/security/lcz_sergeant
	class = CLASS_C
	hud_icon = "hudlczsarge"

	access = list(
		ACCESS_SEC_COMMS,
		ACCESS_SECURITY_LVL1,
		ACCESS_SECURITY_LVL2,
		ACCESS_SECURITY_LVL3,
		ACCESS_SCIENCE_LVL1,
		ACCESS_SCIENCE_LVL2,
		ACCESS_DCLASS_KITCHEN,
		ACCESS_DCLASS_BOTANY,
		ACCESS_DCLASS_MINING,
		ACCESS_DCLASS_JANITORIAL,
		ACCESS_DCLASS_MEDICAL
	)
	minimal_access = list()

	min_skill = list(
	    SKILL_COMPUTER    = SKILL_BASIC,
	    SKILL_HAULING     = SKILL_TRAINED,
	    SKILL_COMBAT      = SKILL_TRAINED,
	    SKILL_WEAPONS     = SKILL_TRAINED,
	    SKILL_FORENSICS   = SKILL_BASIC
	)

	max_skill = list(
		SKILL_COMBAT      = SKILL_EXPERIENCED,
	    SKILL_WEAPONS     = SKILL_EXPERIENCED,
	    SKILL_FORENSICS   = SKILL_TRAINED
	)
	skill_points = 21
