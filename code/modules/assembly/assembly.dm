#define WIRE_RECEIVE 		(1<<0)
#define WIRE_PULSE 			(1<<1)
#define WIRE_PULSE_SPECIAL 	(1<<2)
#define WIRE_RADIO_RECEIVE 	(1<<3)
#define WIRE_RADIO_PULSE 	(1<<4)

/obj/item/device/assembly
	name = "assembly"
	desc = "A small electronic device that should never exist."
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = ""
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_SMALL
	matter = list(MATERIAL_STEEL = 100)
	throwforce = 2
	throw_speed = 3
	throw_range = 10
	origin_tech = list(TECH_MAGNET = 1)

	var/secured = 1
	var/list/attached_overlays = null
	var/obj/item/device/assembly_holder/holder = null
	var/cooldown = 0//To prevent spam
	var/wires = WIRE_RECEIVE|WIRE_PULSE

/obj/item/device/assembly/tgui_state()
	return GLOB.deep_inventory_tgui_state

/obj/item/device/assembly/Destroy()
	if(holder)
		holder = null
	if(attached_overlays)
		attached_overlays.Cut()
	. = ..()

/obj/item/device/assembly/proc/activate()									//What the device does when turned on
	if(!secured || (cooldown > 0))	return 0
	cooldown = 2
	spawn(10)
		process_cooldown()
	return 1

/obj/item/device/assembly/proc/pulsed(radio = 0)						//Called when another assembly acts on this one, radio will determine where it came from for wire calcs
	if(holder && (wires & WIRE_RECEIVE))
		activate()
	if(radio && (wires & WIRE_RADIO_RECEIVE))
		activate()
	return 1

/obj/item/device/assembly/proc/pulse(radio = 0)							//Called when this device attempts to act on another device, radio determines if it was sent via radio or direct
	if(holder && (wires & WIRE_RECEIVE|WIRE_PULSE))
		holder.process_activation(src, 1, 0)
	return 1

/obj/item/device/assembly/proc/toggle_secure()								//Code that has to happen when the assembly is un\secured goes here
	secured = !secured
	update_icon()
	return secured

/obj/item/device/assembly/proc/attach_assembly(obj/A, mob/user)		//Called when an assembly is attacked by another
	holder = new/obj/item/device/assembly_holder(get_turf(src))
	if(holder.attach(A,src,user))
		to_chat(user, SPAN_NOTICE("You attach \the [A] to \the [src]!"))
		return 1
	return 0

/obj/item/device/assembly/proc/process_cooldown()							//Called via spawn(10) to have it count down the cooldown var
	cooldown--
	if(cooldown <= 0)	return 0
	spawn(10)
		process_cooldown()
	return 1

/obj/item/device/assembly/attackby(obj/item/W as obj, mob/user as mob)
	if(isassembly(W))
		var/obj/item/device/assembly/A = W
		if((!A.secured) && (!secured))
			attach_assembly(A,user)
			return
	if(W.isscrewdriver())
		if(toggle_secure())
			to_chat(user, SPAN_NOTICE("\The [src] is ready!"))
		else
			to_chat(user, SPAN_NOTICE("\The [src] can now be attached!"))
		return
	..()

/obj/item/device/assembly/Process()
	STOP_PROCESSING(SSobj, src)
	return

/obj/item/device/assembly/examine(mob/user)
	.=..()
	if((in_range(src, user) || loc == usr))
		if(secured)
			to_chat(user, "[src] is ready!")
		else
			to_chat(user, "[src] can be attached!")

/obj/item/device/assembly/attack_self(mob/user)
	..()

	if(!user)
		return

	user.set_machine(src)
	interact(user)

/obj/item/device/assembly/proc/holder_movement()							//Called when the holder is moved
		return

/obj/item/device/assembly/interact(mob/user as mob)							//Called when attack_self is called
		return
