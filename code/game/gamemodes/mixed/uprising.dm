/datum/game_mode/uprising
	name = "Cult & Revolution"
	round_description = "Some crewmembers are attempting to start a revolution while a cult plots in the shadows!"
	extended_round_description = "Cultists and revolutionaries spawn in this round."
	config_tag = "uprising"
	required_players = 20
	required_enemies = 6
	end_on_antag_death = FALSE
	auto_recall_shuttle = FALSE
	shuttle_delay = 2
	antag_tags = list(MODE_TRADER, MODE_INFORMANT, MODE_REVOLUTIONARY, MODE_LOYALIST, MODE_CULTIST)
	require_all_templates = TRUE
