/obj/machinery/button/remote
	name = "remote object control"
	desc = "It controls objects, remotely."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "doorctrl"
	power_channel = ENVIRON
	var/desiredstate = 0
	var/exposedwires = 0
	var/wires = 3
	/*
	Bitflag,	1=checkID
				2=Network Access
	*/

	anchored = 1.0
	use_power = 1
	idle_power_usage = 2
	active_power_usage = 4

/obj/machinery/button/remote/attack_ai(mob/user as mob)
	if(wires & 2)
		return src.attack_hand(user)
	else
		to_chat(user, "Error, no route to host.")

/obj/machinery/button/remote/attackby(obj/item/weapon/W, mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/button/remote/emag_act(var/remaining_charges, var/mob/user)
	if(req_access.len || req_one_access.len)
		req_access = list()
		req_one_access = list()
		playsound(src.loc, "sparks", 100, 1)
		return 1

/obj/machinery/button/remote/attack_hand(mob/user as mob)
	if(..())
		return

	if(stat & (NOPOWER|BROKEN))
		return

	if(!allowed(user) && (wires & 1))
		to_chat(user, "<span class='warning'>Access Denied</span>")
		flick("[initial(icon_state)]-denied",src)
		return

	use_power(5)
	icon_state = "[initial(icon_state)]1"
	desiredstate = !desiredstate
	trigger(user)
	spawn(15)
		update_icon()

/obj/machinery/button/remote/proc/trigger()
	return

/obj/machinery/button/remote/update_icon()
	if(stat & NOPOWER)
		icon_state = "[initial(icon_state)]-p"
	else
		icon_state = "[initial(icon_state)]"

/*
	Airlock remote control
*/

// Bitmasks for door switches.
#define OPEN   0x1
#define IDSCAN 0x2
#define BOLTS  0x4
#define SHOCK  0x8
#define SAFE   0x10

/obj/machinery/button/remote/airlock
	name = "remote door-control"
	desc = "It controls doors, remotely."

	var/specialfunctions = 1
	/*
	Bitflag, 	1= open
				2= idscan,
				4= bolts
				8= shock
				16= door safties
	*/

/obj/machinery/button/remote/airlock/trigger()
	for(var/obj/machinery/door/airlock/D in SSmachines.all_machinery)
		if(D.id_tag == src.id)
			if(specialfunctions & OPEN)
				if (D.density)
					spawn(0)
						D.open()
						return
				else
					spawn(0)
						D.close()
						return
			if(desiredstate == 1)
				if(specialfunctions & IDSCAN)
					D.set_idscan(0)
				if(specialfunctions & BOLTS)
					D.lock()
				if(specialfunctions & SHOCK)
					D.electrify(-1)
				if(specialfunctions & SAFE)
					D.set_safeties(0)
			else
				if(specialfunctions & IDSCAN)
					D.set_idscan(1)
				if(specialfunctions & BOLTS)
					D.unlock()
				if(specialfunctions & SHOCK)
					D.electrify(0)
				if(specialfunctions & SAFE)
					D.set_safeties(1)

#undef OPEN
#undef IDSCAN
#undef BOLTS
#undef SHOCK
#undef SAFE

/*
	Blast door remote control
*/
/obj/machinery/button/remote/blast_door
	name = "remote blast door-control"
	desc = "It controls blast doors, remotely."
	icon_state = "blastctrl"

/obj/machinery/button/remote/blast_door/trigger()
	for(var/obj/machinery/door/blast/M in SSmachines.all_machinery)
		if(M.id == src.id)
			if(M.density)
				spawn(0)
					M.open()
					return
			else
				spawn(0)
					M.close()
					return


/*
	Lockdown Control
*/

/obj/machinery/button/remote/blast_door/lockdown_blast_door
	name = "remote lockdown control"
	desc = "It controls the lockdown of zones, remotely."
	icon_state = "lockctrl"
	var/state = 0
	var/zone ="put the zone name here"
	var/antispam = 0
	var/glass = 1
	var/id2 = "none"
/obj/machinery/button/remote/blast_door/lockdown_blast_door/trigger(mob/user as mob)
	if(!glass)
		if(!antispam)
			for(var/obj/machinery/door/blast/M in world)
				if(M.id == src.id)
					if(M.density)
						spawn(0)
							M.open()
							return
					else
						spawn(0)
							M.close()
							return
			if(state == 0)
				priority_announcement.Announce("Attention all personnel, [zone] has entered lockdown procedures. All security personnel are to enact security protocols.","Facility Alert, Lockdown Underway!",'sound/Ai/lockdown.ogg')
				state = 1
				antispam = 1
				return


			else
				priority_announcement.Announce("Attention, [zone] has left lockdown procedures. All security personnel are to return to standard protocols.","Facility Alert, Lockdown Underway!")
				state = 0
				antispam = 1
				return
		else
			to_chat(user, "<span class='warning'>Please wait a minute, system is rebooting!</span>")
			spawn(600)
				antispam = 0
	else
		to_chat(user, "<span class='warning'>Unlock the button first!</span>")
obj/machinery/button/remote/blast_door/lockdown_blast_door/proc/glassremover()
	glass = 0
	return
obj/machinery/button/remote/blast_door/lockdown_blast_door/proc/glassadder()
	glass = 1
	return
/*
	KEYHOLE FOR LOCKDOWN
*/
/obj/machinery/lockdownkeyhole/
	name= "Lockdown Keyhole"
	desc = "This is a hole for the lockdown key, this machine is used to open the lockdown button"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "lockdownhole"
	anchored = 1.0
	use_power = 1
	idle_power_usage = 2
	active_power_usage = 4
	var/obj/item/weapon/lockdownkey/rkey = 0
	var/stateic = 0
	var/ready = 0
	var/id2 = "none"
	var/undo = 0

/obj/machinery/lockdownkeyhole/attackby(var/obj/item/W, var/mob/user)
    if(istype(W, /obj/item/weapon/lockdownkey))
        if(!rkey)
            if(!user.unEquip(W))
                to_chat(user, "<span class='warning'>You can't seem to drop \the [W]!</span>")
                return
            rkey = W
            W.forceMove(src)
            to_chat(user, "<span class='notice'>You insert \the [W] into \the [src].</span>")
            update_holeicon()
        else
            to_chat(user, "<span class='warning'>\The [src] already has a key inserted.</span>")
        return

    return ..()

/obj/machinery/lockdownkeyhole/AltClick(var/mob/user)
    if(rkey)
        rkey.dropInto(loc)
        if(user)
            to_chat(user, "<span class='notice'>You remove \the [rkey] from \the [src].</span>")
            user.put_in_hands(rkey)
        rkey = null
        update_holeicon()

/obj/machinery/lockdownkeyhole/attack_hand(var/mob/user)
    if(rkey)
        to_chat(user, "<span class='notice'>You turn the key!</span>")
        icon_state = "lockdownholekr"
        for(var/obj/machinery/button/remote/blast_door/lockdown_blast_door/M in SSmachines.all_machinery)
            if(M.id2 == src.id2)
                if(undo == 0)
                    M.glassremover()
                    undo = 1
                    playsound(src.loc,'sound/effects/caution.ogg',50,1,5)
                else
                    M.glassadder()
                    icon_state = "lockdownholek"
                    undo = 0
    else
        to_chat(user, "<span class='warning'>There is no key in \the [src]!</span>")


/obj/machinery/lockdownkeyhole/proc/update_holeicon()
	if (stateic == 0)
		icon_state = "lockdownholek"
		stateic = 1
	else
		icon_state = "lockdownhole"
		stateic = 0


/*
	KEYS FOR LOCKDOWN
*/
/obj/item/weapon/lockdownkey
	desc = "This is a lockdown key used to open the lockdown button."
	name = "Lockdown Key"
	icon = 'icons/obj/items.dmi'
	icon_state = "lockkey"
	force = 2
	throwforce = 5
	throw_speed = 8
	throw_range = 15
	w_class = ITEM_SIZE_SMALL
	attack_verb = list("cut", "pirced")


/*
	Emitter remote control
*/
/obj/machinery/button/remote/emitter
	name = "remote emitter control"
	desc = "It controls emitters, remotely."

/obj/machinery/button/remote/emitter/trigger(mob/user as mob)
	for(var/obj/machinery/power/emitter/E in SSmachines.all_machinery)
		if(E.id == src.id)
			spawn(0)
				E.activate(user)
				return

/*
	Mass driver remote control
*/
/obj/machinery/button/remote/driver
	name = "mass driver button"
	desc = "A remote control switch for a mass driver."
	icon = 'icons/obj/objects.dmi'
	icon_state = "launcherbtt"

/obj/machinery/button/remote/driver/trigger(mob/user as mob)
	set waitfor = 0
	active = 1
	update_icon()

	for(var/obj/machinery/door/blast/M in SSmachines.all_machinery)
		if (M.id == src.id)
			spawn( 0 )
				M.open()
				return

	sleep(20)

	for(var/obj/machinery/mass_driver/M in SSmachines.all_machinery)
		if(M.id == src.id)
			M.drive()

	sleep(50)

	for(var/obj/machinery/door/blast/M in SSmachines.all_machinery)
		if (M.id == src.id)
			spawn(0)
				M.close()
				return

	icon_state = "launcherbtt"
	update_icon()

	return

/obj/machinery/button/remote/driver/update_icon()
	if(!active || (stat & NOPOWER))
		icon_state = "launcherbtt"
	else
		icon_state = "launcheract"
