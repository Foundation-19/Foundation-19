/////////////VISION CONE///////////////
//Vision cone code. originally by Matt and Honkertron, rewritten by Chaoko99. This vision cone code allows for mobs and/or items to blocked out from a players field of vision.
//It makes use of planes and alpha masks only possible in 513 and above. Look for fov and fov_mask vars to see how it works.
///////////////////////////////////////

//"Made specially for Otuska"
// - Honker

// Optimized by Kachnov

// "Otuska is a faggot"
// Rest in Peace, Honker. You will always be in our hearts.
// Replaced with IS12's implementation authored by Chaoko99.
// ~Tsurupeta

//Defines.
#define OPPOSITE_DIR(D) turn(D, 180)

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
	return

/mob/living/carbon/human/update_vision_cone()
	if(!client) //This doesn't actually hide shit from clientless mobs, so just keep them from running this.
		return
	check_fov()
	fov.dir = dir
	fov_mask.dir = dir

/mob/living/carbon/human/proc/SetFov(var/show)
	if(!show)
		hide_cone()
	else
		show_cone()

/mob/living/carbon/human/proc/check_fov()
	if(!client)
		return

	if(resting || lying || (client && client.eye != client.mob))
		fov.alpha = 0
		fov_mask.alpha = 0
		return
	else if(usefov)
		show_cone()
	else
		hide_cone()

//Making these generic procs so you can call them anywhere.
/mob/living/carbon/human/proc/show_cone()
	if(fov)
		fov.alpha = 255
		usefov = TRUE
		fov_mask.alpha = 255

/mob/living/carbon/human/proc/hide_cone()
	if(fov)
		fov.alpha = 0
		usefov = FALSE
		fov_mask.alpha = 0
