/////////////VISION CONE///////////////
//Vision cone code by Matt and Honkertron. This vision cone code allows for mobs and/or items to blocked out from a players field of vision.
//This code makes use of the "cone of effect" proc created by Lummox, contributed by Jtgibson. More info on that here:
//http://www.byond.com/forum/?post=195138
///////////////////////////////////////

//"Made specially for Otuska"
// - Honker

// Optimized by Kachnov

//Defines.
#define OPPOSITE_DIR(D) turn(D, 180)

/client
	var/list/hidden_images = list()

/mob/living/carbon/human
	var/list/hidden_atoms = list()
	var/list/hidden_mobs = list()

/atom/proc/InCone(atom/center, dir = NORTH)
	if(!get_dist(center, src))
		return FALSE

	var/d = get_dir(center, src)
	var/dx = abs(x - center.x)
	var/dy = abs(y - center.y)

	if(!d || d == dir)
		return TRUE
	else if(dir & (dir-1))
		return (d & ~dir) ? FALSE : TRUE
	else if(!(d & dir))
		return FALSE
	else if(dx == dy)
		return TRUE
	else if(dy > dx)
		return (dir & (NORTH|SOUTH)) ? TRUE : FALSE

	return (dir & (EAST|WEST)) ? TRUE : FALSE

/mob/dead/InCone(mob/center, dir = NORTH)
	return FALSE

/mob/living/InCone(mob/center, dir = NORTH)
	. = ..()

	for (var/grab in grabbed_by)
		var/obj/item/grab/G = grab
		if (G.assailant == center)
			return FALSE
	return .

/proc/cone(atom/center, dir = NORTH, list/L, typecheck = /atom)
	. = list()
	for(var/atom in L)
		var/atom/A = atom
		if (typecheck == /atom || istype(A, typecheck))
			if(A.InCone(center, dir))
				. += A

/mob/proc/update_vision_cone()
	return FALSE

/mob/living/carbon/human/update_vision_cone()

	set waitfor = FALSE

	if (reset_vision_cone())

		fov.dir = dir
		if(fov.alpha)
			var/image/I = null
			for(var/living in cone(src, OPPOSITE_DIR(dir), oviewers(src), /mob/living))

				var/mob/living/L = living
			
				var/list/things = L.vis_contents+L
				
				for (var/thing in things)
					I = image("split", thing)
					I.override = TRUE
						
					client.images += I
					client.hidden_images += I
					hidden_atoms += thing
					
					if (thing == things[1])
						hidden_mobs += L

						if(pulling == L)//If we're pulling them we don't want them to be invisible, too hard to play like that.
							I.override = FALSE
						else if (L.footstep >= 1)
							L.in_vision_cones[client] = TRUE

			// items are invisible too
			for(var/item in cone(src, OPPOSITE_DIR(dir), oview(get_turf(src)), /obj/item)) // http://www.byond.com/docs/ref/info.html#/proc/view
				I = image("split", item)
				I.override = TRUE
				client.images += I
				client.hidden_images += I
				hidden_atoms += item

/mob/living/carbon/human/proc/reset_vision_cone()
	var/delay = 10
	if(client)
		for(var/image in client.hidden_images)
			var/image/I = image
			client.images -= I
			I.override = FALSE
			delete_image(I, delay)
			delay += 10
		check_fov()
		client.hidden_images.Cut()
		hidden_atoms.Cut()
		hidden_mobs.Cut()
		return TRUE 
	return FALSE

/mob/living/carbon/human/proc/delete_image(image, delay)
	set waitfor = FALSE 
	sleep(delay)
	qdel(image)

/mob/living/carbon/human/proc/SetFov(var/n)
	if(!n)
		hide_cone()
	else
		show_cone()

/mob/living/carbon/human/proc/check_fov()

	if(resting || lying || (client.eye != client.mob && client.eye != client.mob.loc))
		fov.alpha = 0
		return

	else if(usefov)
		show_cone()

	else
		hide_cone()

//Making these generic procs so you can call them anywhere.
/mob/living/carbon/human/proc/show_cone()
	if(fov)
		fov.alpha = 255
		usefov = 1

mob/living/carbon/human/proc/hide_cone()
	if(fov)
		fov.alpha = 0
		usefov = 0