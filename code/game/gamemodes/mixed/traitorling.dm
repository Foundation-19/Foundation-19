/datum/game_mode/traitorling
	name = "Changeling & Traitor"
	round_description = "There are traitors and alien changelings. Do not let the changelings succeed!"
	extended_round_description = "Traitors and changelings both spawn during this mode."
	config_tag = "traitorling"
	required_players = 15
	required_enemies = 5
	end_on_antag_death = FALSE
	antag_tags = list(MODE_DCLASS, MODE_CHANGELING, MODE_TRAITOR)
	require_all_templates = TRUE
