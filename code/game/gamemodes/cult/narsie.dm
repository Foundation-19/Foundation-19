var/global/narsie_behaviour = "CultStation13"
var/global/narsie_cometh = 0
var/global/list/scarletking_list = list()
/obj/singularity/scarletking
	name = "The Scarlet King"
	desc = "Your mind begins to bubble and ooze as it tries to comprehend what it sees."
	icon = 'icons/obj/scarlet-king.dmi'
	icon_state = "narsie-small"
	pixel_x = -236
	pixel_y = -256

	current_size = 9 //It moves/eats like a max-size singulo, aside from range. --NEO.
	contained = 0 // Are we going to move around?
	dissipate = 0 // Do we lose energy over time?
	grav_pull = 10 //How many tiles out do we pull?
	consume_range = 3 //How many tiles out do we eat

/obj/singularity/narsie/New() //for the oldies out there
	..()
	new /obj/singularity/scarletking/large(get_turf(src))
	return INITIALIZE_HINT_QDEL

/obj/singularity/scarletking/New()
	..()
	scarletking_list.Add(src)

/obj/singularity/scarletking/Destroy()
	scarletking_list.Remove(src)
	..()

/obj/singularity/scarletking/large // the nar'sie that actually gets summoned
	icon_state = "scarlet-king"//mobs perceive the geometer of blood through their see_narsie proc

	// Pixel stuff centers Narsie.
	pixel_x = -236
	pixel_y = -256
	light_outer_range = 1
	light_color = "#3e0000"

	current_size = 6
	consume_range = 6 // How many tiles out do we eat.
	var/announce=1
	var/cause_hell = 1

/obj/singularity/scarletking/large/New()
	..()
	if(announce)
		sound_to(world, sound('sounds/effects/wind/wind_5_1.ogg'))
		switch(scarletking_list.len)
			if(1)
				sound_to(world, sound('sounds/magic/scarlet/rise.ogg'))
				to_world("<font size='15' color='red'><b>I HAVE RISEN.</b></font>")
			if(2)
				sound_to(world, sound('sounds/magic/scarlet/second_rise.ogg'))
				to_world("<font size='15' color='red'><b>IT'S EVEN FUNNIER THE SECOND TIME.</b></font>")
			if(3)
				sound_to(world, sound('sounds/magic/scarlet/third_rise.ogg'))
				to_world("<font size='15' color='red'><b>THIRD TIME'S THE CHARM.</b></font>")
			else
				sound_to(world, sound('sounds/magic/scarlet/rise.ogg'))
				to_world("<font size='15' color='red'><b>[pick("AND THUS I WEPT, FOR I KNEW I HAD NO MORE WORLDS LEFT TO CONQUER.", "DID YOU EXPECT TO JUST SEE THE THREE OF ME?", "NONE WILL BE LEFT.", "CRY TO YOUR FATHER, GOD.", "I WILL BE YOUR UNDOING.")]</b></font>")

	narsie_spawn_animation()

	if(!narsie_cometh)//so we don't initiate Hell more than one time.
		if(cause_hell)
			SetUniversalState(/datum/universal_state/hell)
		narsie_cometh = 1

		spawn(10 SECONDS)
			if(evacuation_controller)
				evacuation_controller.call_evacuation(null, TRUE, 1)
				evacuation_controller.evac_no_return = 0 // Cannot recall

/obj/singularity/scarletking/Process()
	eat()

	if (!target || prob(5))
		pickcultist()

	move()

	if (prob(25))
		mezzer()

/obj/singularity/scarletking/large/eat()
	for (var/turf/A in orange(consume_range, src))
		consume(A)

/obj/singularity/scarletking/mezzer()
	for(var/mob/living/carbon/M in oviewers(8, src))
		if(M.stat == CONSCIOUS)
			if(M.status_flags & GODMODE)
				continue
			if(!iscultist(M))
				to_chat(M, SPAN_DANGER(" You feel your sanity crumble away in an instant as you gaze upon [src.name]..."))
				M.apply_effect(3, STUN)


/obj/singularity/scarletking/large/Bump(atom/A)
	if(!cause_hell) return
	if(isturf(A))
		scarletwall(A)
	else if(istype(A, /obj/structure/cult))
		qdel(A)

/obj/singularity/scarletking/large/Bumped(atom/A)
	if(!cause_hell) return
	if(isturf(A))
		scarletwall(A)
	else if(istype(A, /obj/structure/cult))
		qdel(A)

/obj/singularity/scarletking/move(force_move = 0)
	if(!move_self)
		return 0

	var/movement_dir = pick(GLOB.alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move

	if(target && prob(60))
		movement_dir = get_dir(src,target)

	spawn(0)
		step(src, movement_dir)
	spawn(1)
		step(src, movement_dir)
	return 1

/obj/singularity/scarletking/large/move(force_move = 0)
	if(!move_self)
		return 0

	var/movement_dir = pick(GLOB.alldirs - last_failed_movement)

	if(force_move)
		movement_dir = force_move

	if(target && prob(60))
		movement_dir = get_dir(src,target)
	spawn(0)
		step(src, movement_dir)
		narsiefloor(get_turf(loc))
		for(var/mob/M in GLOB.player_list)
			if(M.client)
				M.see_narsie(src,movement_dir)
	spawn(10)
		step(src, movement_dir)
		narsiefloor(get_turf(loc))
		for(var/mob/M in GLOB.player_list)
			if(M.client)
				M.see_narsie(src,movement_dir)
	return 1

/obj/singularity/scarletking/proc/narsiefloor(turf/T)//leaving "footprints"
	if(!(istype(T, /turf/simulated/wall/cult) || isspaceturf(T)))
		if(T.icon_state != "cult-narsie")
			T.desc = "Something that goes beyond your understanding went this way."
			T.icon = 'icons/turf/flooring/cult.dmi'
			T.icon_state = "cult-narsie"
			T.set_light(1)

/obj/singularity/scarletking/proc/scarletwall(turf/T)
	T.desc = "An opening has been made on that wall, but who can say if what you seek truly lies on the other side?"
	T.icon = 'icons/turf/walls.dmi'
	T.icon_state = "cult-narsie"
	T.set_opacity(0)
	T.set_density(0)
	set_light(1)

/obj/singularity/scarletking/large/consume(const/atom/A) //Has its own consume proc because it doesn't need energy and I don't want BoHs to explode it. --NEO
//NEW BEHAVIOUR
	if(narsie_behaviour == "CultStation13")
	//MOB PROCESSING
		new_narsie(A)

//OLD BEHAVIOUR
	else if(narsie_behaviour == "Nar-Singulo")
		old_narsie(A)

/obj/singularity/scarletking/proc/new_narsie(const/atom/A)
	if (istype(A, /mob/) && (get_dist(A, src) <= 7))
		var/mob/M = A

		if(M.status_flags & GODMODE)
			return 0

		M.cultify()

//TURF PROCESSING
	else if (isturf(A))
		var/dist = get_dist(A, src)

		for (var/atom/movable/AM in A.contents)
			if (dist <= consume_range)
				consume(AM)
				continue

		if (dist <= consume_range && !isspaceturf(A))
			var/turf/T = A
			if(T.holy)
				T.holy = 0 //the scarlet king doesn't give a shit about sacred grounds.
			T.cultify()

/obj/singularity/scarletking/proc/old_narsie(const/atom/A)
	if(!(A.singuloCanEat()))
		return 0

	if (istype(A, /mob/living/))
		var/mob/living/C2 = A

		if(C2.status_flags & GODMODE)
			return 0

		C2.dust() // Changed from gib(), just for less lag.

	else if (istype(A, /obj/))
		qdel(A)

		if (A)
			qdel(A)
	else if (isturf(A))
		var/dist = get_dist(A, src)

		for (var/atom/movable/AM2 in A.contents)
			if (AM2 == src) // This is the snowflake.
				continue

			if (dist <= consume_range)
				consume(AM2)
				continue

		if (dist <= consume_range && !istype(A, get_base_turf_by_area(A)))
			var/turf/T2 = A
			T2.ChangeTurf(get_base_turf_by_area(A))

/obj/singularity/scarletking/consume(const/atom/A) //This one is for the small ones.
	if(!(A.singuloCanEat()))
		return 0

	if (istype(A, /mob/living/))
		var/mob/living/C2 = A

		if(C2.status_flags & GODMODE)
			return 0

		C2.dust() // Changed from gib(), just for less lag.

	else if (istype(A, /obj/))
		qdel(A)

		if (A)
			qdel(A)
	else if (isturf(A))
		var/dist = get_dist(A, src)

		for (var/atom/movable/AM2 in A.contents)
			if (AM2 == src) // This is the snowflake.
				continue

			if (dist <= consume_range)
				consume(AM2)
				continue

			if (dist > consume_range)
				if(!(AM2.singuloCanEat()))
					continue

				if (101 == AM2.invisibility)
					continue

				addtimer(CALLBACK(AM2, TYPE_PROC_REF(/atom, singularity_pull), src, current_size), 0)

		if (dist <= consume_range && !istype(A, get_base_turf_by_area(A)))
			var/turf/T2 = A
			T2.ChangeTurf(get_base_turf_by_area(A))

/obj/singularity/scarletking/ex_act(severity) //No throwing bombs at it either. --NEO
	return

/obj/singularity/scarletking/proc/pickcultist() //Narsie rewards his cultists with being devoured first, then picks a ghost to follow. --NEO
	var/list/cultists = list()
	for(var/datum/mind/cult_nh_mind in GLOB.cult.current_antagonists)
		if(!cult_nh_mind.current)
			continue
		if(cult_nh_mind.current.stat)
			continue
		if(get_z(cult_nh_mind.current) != z)
			continue
		cultists += cult_nh_mind.current
	if(cultists.len)
		acquire(pick(cultists))
		return
		//If there was living cultists, it picks one to follow.
	for(var/mob/living/carbon/human/food in GLOB.living_mob_list_)
		if(food.stat)
			continue
		var/turf/pos = get_turf(food)
		if(!pos)	//Catches failure of get_turf.
			continue
		if(pos.z != src.z)
			continue
		cultists += food
	if(cultists.len)
		acquire(pick(cultists))
		return
		//no living cultists, pick a living human instead.
	for(var/mob/observer/ghost/ghost in GLOB.player_list)
		if(!ghost.client)
			continue
		var/turf/pos = get_turf(ghost)
		if(pos.z != src.z)
			continue
		cultists += ghost
	if(cultists.len)
		acquire(pick(cultists))
		return
		//no living humans, follow a ghost instead.

/obj/singularity/scarletking/proc/acquire(const/mob/food)
	var/capname = uppertext(name)

	to_chat(target, SPAN_NOTICE("<b>[capname] HAS LOST INTEREST IN YOU.</b>"))
	target = food

	if (ishuman(target))
		to_chat(target, SPAN_DANGER("[capname] HUNGERS FOR YOUR SOUL."))
	else
		to_chat(target, SPAN_DANGER("[capname] HAS CHOSEN YOU TO LEAD HIM TO HIS NEXT MEAL."))
/obj/singularity/scarletking/on_capture()
	chained = 1
	move_self = 0
	icon_state ="sk-small-chains"

/obj/singularity/scarletking/on_release()
	chained = 0
	move_self = 1
	icon_state ="sk-small"

/obj/singularity/scarletking/large/on_capture()
	chained = 1
	move_self = 0
	icon_state ="sk-chains"
	for(var/mob/M in SSmobs.mob_list)//removing the client image of nar-sie while it is chained
		if(M.client)
			M.see_narsie(src)

/obj/singularity/scarletking/large/on_release()
	chained = 0
	move_self = 1
	icon_state ="scarlet-king"

/**
 * Wizard narsie.
 */
/obj/singularity/scarletking/wizard
	grav_pull = 0

/obj/singularity/scarletking/wizard/eat()
	for (var/turf/T in trange(consume_range, src))
		consume(T)

/obj/singularity/scarletking/proc/narsie_spawn_animation()
	icon = 'icons/obj/narsie_spawn_anim.dmi'
	dir = SOUTH
	move_self = 0
	flick("narsie_spawn_anim",src)
	sleep(11)
	move_self = 1
	icon = initial(icon)
