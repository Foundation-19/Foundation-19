/obj/structure/diona_gestalt/attack_generic(mob/user, damage, attack_message)
	if(user.loc == src)
		return

	if(istype(user, /mob/living/carbon/alien/diona) && user.a_intent != I_HURT)
		can_roll_up_atom(user)
		return

	visible_message("<span class='danger'>\The [user] has [attack_message] \the [src]!</span>")
	shed_atom(forcefully = TRUE)

/obj/structure/diona_gestalt/attackby(obj/item/thing, mob/user)
	. = ..()
	if(thing.force) shed_atom(forcefully = TRUE)

/obj/structure/diona_gestalt/hitby()
	. = ..()
	shed_atom(forcefully = TRUE)

/obj/structure/diona_gestalt/bullet_act(obj/item/projectile/P, def_zone)
	. = ..()
	if(P && (P.damage_type == BRUTE || P.damage_type == BURN))
		shed_atom(forcefully = TRUE)

/obj/structure/diona_gestalt/ex_act()
	var/shed_count = rand(1,3)
	while(shed_count && nymphs && nymphs.len)
		shed_count--
		shed_atom(forcefully = TRUE)

/obj/structure/diona_gestalt/proc/handle_member_click(mob/living/carbon/alien/diona/clicker)
	return
