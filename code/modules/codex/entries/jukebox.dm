/datum/codex_entry/jukebox
	entry_text = "Click the jukebox and then select a track on the interface. You can choose to play or stop the track, or set the volume. \
	Use a <l>wrench</l> to attach or detach the jukebox to the floor. The room it is installed in must have power for it to operate!<br>\
	A cryptographic sequencer will overload the jukebox's speakers, producing a loud blast of noise and an explosion."

/datum/codex_entry/jukebox/New()
	associated_paths = typesof(/obj/machinery/jukebox)
