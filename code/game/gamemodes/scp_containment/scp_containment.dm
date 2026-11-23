/datum/game_mode/scp_containment
	name = "SCP Containment"
	config_tag = "scp_containment"
	required_players = 15
	probability = 10
	round_description = "Site-53 duty shift. The anomalies are all accounted for... for now."
	extended_round_description = "A routine Foundation shift at Site-53. Researchers advance SCP studies, guards keep the corridors quiet, and Class-D personnel do what they are told - usually. Every anomaly is in its chamber at shift start, but nothing stays contained forever. Keep the site running, push research tiers, and be ready when something gets loose."
	round_autoantag = FALSE
	antag_scaling_coeff = 0
	addantag_allowed = ADDANTAG_ADMIN
	end_on_antag_death = FALSE
	votable = TRUE

/datum/game_mode/scp_containment/post_setup()
	. = ..()
	log_and_message_staff("SCP Containment round initialized. All tracked anomalies begin contained; research and containment systems are active.")
	minor_announcement.Announce(
		"Site-53 shift commencing. All anomalous objects are to remain in their assigned containment zones. Research staff: consult the SCP Database terminal for current directives.",
		"Site Director"
	)
