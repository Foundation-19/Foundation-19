
/datum/map/site404

	holodeck_programs = list(
		"picnicarea" = new/datum/holodeck_program((/area/holodeck/source_picnicarea), list('sounds/effects/helicopter.ogg')),
		"emergency_medical" = new/datum/holodeck_program((/area/holodeck/emergency_medical), list('sounds/effects/helicopter.ogg'))
	)

	holodeck_supported_programs = list(
		"FoundationApprovedPrograms" = list(
		"Picnic Area" = "picnicarea",
		"Emergency Medical" = "emergency_medical"
		)
	)

	holodeck_restricted_programs = list(list())
