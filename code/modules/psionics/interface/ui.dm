/atom/movable/screen/psi
	icon = 'icons/hud/psi.dmi'
	var/mob/living/owner
	var/hidden = TRUE

/atom/movable/screen/psi/New(mob/living/_owner)
	.=..()
	loc = null
	owner = _owner
	update_icon()

/atom/movable/screen/psi/Destroy()
	if(owner && owner.client)
		owner.client.screen -= src
	. = ..()

/atom/movable/screen/psi/on_update_icon()
	if(hidden)
		invisibility = 101
	else
		invisibility = 0
