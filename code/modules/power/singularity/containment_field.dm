//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:33

/obj/machinery/containment_field
	name = "Containment Field"
	desc = "An energy field."
	icon = 'icons/obj/singularity.dmi'
	icon_state = "Contain_F"
	anchored = TRUE
	density = FALSE
	unacidable = TRUE
	use_power = POWER_USE_OFF
	uncreated_component_parts = null
	light_outer_range = 4
	movable_flags = MOVABLE_FLAG_PROXMOVE
	var/obj/machinery/field_generator/FG1 = null
	var/obj/machinery/field_generator/FG2 = null
	var/shock_cooldown

/obj/machinery/containment_field/Destroy()
	if(FG1 && !FG1.clean_up)
		FG1.cleanup()
	if(FG2 && !FG2.clean_up)
		FG2.cleanup()
	. = ..()

/obj/machinery/containment_field/physical_attack_hand(mob/user)
	return shock(user)

/obj/machinery/containment_field/attackby(obj/item/W, mob/user)
	shock(user)
	return TRUE

/obj/machinery/containment_field/ex_act(severity)
	return FALSE

/obj/machinery/containment_field/Move()
	qdel(src)
	return FALSE

/obj/machinery/containment_field/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(istype(mover, /mob/living) || istype(mover, /obj/machinery) || istype(mover, /obj/structure))
		return FALSE
	return TRUE

/obj/machinery/containment_field/Bumped(atom/movable/AM)
	if(shock_cooldown > world.time)
		return
	if(istype(AM, /mob/living))
		shock(AM)
		return
	if(istype(AM, /obj/machinery) || istype(AM, /obj/structure))
		bump_field(AM)
	return

/obj/machinery/containment_field/Crossed(atom/movable/AM)
	. = ..()
	if(istype(AM, /mob/living))
		shock(AM)

	if(istype(AM, /obj/machinery) || istype(AM, /obj/structure))
		bump_field(AM)

/obj/machinery/containment_field/shock(mob/living/user as mob)
	if(shock_cooldown > world.time)
		return FALSE
	if(!FG1 || !FG2)
		qdel(src)
		return FALSE
	if(isliving(user))
		shock_cooldown = world.time + 10
		var/shock_damage = min(rand(30,40),rand(30,40))
		user.electrocute_act(shock_damage, src)

		var/atom/target = get_edge_target_turf(user, get_dir(src, get_step_away(user, src)))
		user.throw_at(target, 200, 4)

		return TRUE

/obj/machinery/containment_field/proc/bump_field(atom/movable/AM as obj)
	if(shock_cooldown > world.time)
		return FALSE
	shock_cooldown = world.time + 10
	playsound(loc, "sparks", 50, 1, -1)
	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, loc)
	s.start()
	var/atom/target = get_edge_target_turf(AM, get_dir(src, get_step_away(AM, src)))
	AM.throw_at(target, 200, 4)

/obj/machinery/containment_field/proc/set_master(var/master1,var/master2)
	if(!master1 || !master2)
		return 0
	FG1 = master1
	FG2 = master2
	return 1
