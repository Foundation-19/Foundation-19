/*
Current types:
default - full size circle
small - small circle
boom - Jagged circle
*/


/proc/show_sound_effect(turf/T, mob/source, soundtype = "default")
	var/list/clients_to_show = list()

	for(var/mob/living/carbon/human/H in view(7, T))
		clients_to_show += H.get_client()
	if(!length(clients_to_show))
		return
	//if(source)
		//clients_to_show -= source.get_client()
	var/image/I = image('icons/effects/sound_effect.dmi', loc = T, icon_state = soundtype)
	I.plane = ABOVE_VISION_CONE_PLANE
	flick_overlay(I, clients_to_show, 6)

