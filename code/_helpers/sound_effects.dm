/*
Current icons:
default - full size circle
small - small circle
boom - Jagged circle

Source variable is used for mobs that make sounds to remove them from all those who these sounds should be shown to.
So you don't see your own footsteps. Could use oview, but meh
~Tsuru
*/

#define SFX_ICON_FULL "default"
#define SFX_ICON_SMALL "small"
#define SFX_ICON_JAGGED "boom"

/proc/show_sound_effect(turf/T, mob/living/source, soundicon = SFX_ICON_FULL)
	var/list/clients_to_show = list()

	for(var/mob/living/M in view(7, T))
		var/client/C = M.get_client()
		if(!M.can_hear(source ? source : T) || !C)
			continue
		clients_to_show += C
	if(!length(clients_to_show))
		return
	if(source)
		clients_to_show -= source.get_client()
		source.lastsound = world.time //Ensures that these things are tracked for 939 and future sound-based SCPs
	var/image/I = image('icons/effects/sound_effect.dmi', loc = T, icon_state = soundicon)
	I.plane = INSIDE_VISION_CONE_PLANE
	flick_overlay(I, clients_to_show, 6)

