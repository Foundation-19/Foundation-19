/proc/wash_mob(mob/living/washing)
	if(!istype(washing))
		return
	var/mob/living/L = washing
	if(L.on_fire)
		L.visible_message("<span class='danger'>A cloud of steam rises up as the water hits \the [L]!</span>")
		L.ExtinguishMob()
	L.fire_stacks = -20 //Douse ourselves with water to avoid fire more easily
	washing.clean()
