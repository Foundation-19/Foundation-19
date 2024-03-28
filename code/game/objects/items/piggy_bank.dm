/**
 * Piggy banks. They store your hard-earned money until you or someone destroys it.
 * If the persistence id is set, money will be carried between rounds until broken.
 */
/obj/item/piggy_bank
	name = "piggy bank"
	desc = "A pig-shaped money container made of porkelain, oink. <i>Do not throw.</i>" //pun very intended.
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "piggy_bank"
	w_class = ITEM_SIZE_NORMAL
	force = 12
	throwforce = 15
	throw_speed = 3
	throw_range = 7
	///Some piggy banks are persistent, meaning they carry dosh between rounds.
	var/persistence_id
	///Callback to execute upon roundend to save the current amount of cash it has stored, IF persistent.
	var/datum/callback/persistence_cb
	///How much dosh can this piggy bank hold.
	var/maximum_value = 1000
	///A limit to much dosh can you put inside this piggy bank each round. If 0, there's no limit. Only applies to persistent piggies.
	var/maximum_savings_per_shift = 0
	///How much dosh this piggy bank spawns with.
	var/initial_value = 0

/obj/item/piggy_bank/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/can_shatter, shattering_sound = SFX_SHATTER, shatters_as_weapon = TRUE)
	if(!persistence_id)
		if(initial_value)
			new /obj/item/spacecash/bundle(src, initial_value)
		return

	SSpersistence.load_piggy_bank(src)
	persistence_cb = CALLBACK(src, PROC_REF(save_cash))
	SSticker.OnRoundend(persistence_cb)

	if(initial_value & initial_value + calculate_dosh_amount() <= maximum_value)
		new /obj/item/spacecash/bundle(src, initial_value)

	if(maximum_savings_per_shift)
		maximum_value = calculate_dosh_amount() + maximum_savings_per_shift

/obj/item/piggy_bank/proc/save_cash()
	SSpersistence.save_piggy_bank(src)

/obj/item/piggy_bank/Destroy()
	if(persistence_cb)
		LAZYREMOVE(SSticker.round_end_events, persistence_cb) //cleanup the callback.
		persistence_cb = null
	return ..()

/obj/item/piggy_bank/decons(disassembled = TRUE)
	for(var/obj/item/thing as anything in contents)
		thing.forceMove(loc)
	//Smashing the piggy after the round is over doesn't count.
	if(persistence_id && GAME_STATE < RUNLEVEL_POSTGAME)
		LAZYADD(SSpersistence.queued_broken_piggy_ids, persistence_id)
	return ..()

/obj/item/piggy_bank/attack_self(mob/user, modifiers)
	. = ..()
	if(DOING_INTERACTION_WITH_TARGET(user, src))
		return
	balloon_alert(user, "rattle rattle...")
	if(!do_after(user, 0.5 SECONDS, src))
		return
	var/percentile = round(calculate_dosh_amount() / maximum_value * 100, 1)
	if(percentile >= 10)
		playsound(src, SFX_RATTLE, percentile * 0.5, FALSE, FALSE)
	switch(percentile)
		if(0)
			balloon_alert(user, "it's empty")
		if(1 to 9)
			balloon_alert(user, "it's almost empty")
		if(10 to 25)
			balloon_alert(user, "it's some cash")
		if(25 to 45)
			balloon_alert(user, "it's plenty of cash")
		if(45 to 70)
			balloon_alert(user, "it feels almost full")
		if(70 to 95)
			balloon_alert(user, "it feels full")
		if(95 to INFINITY)
			balloon_alert(user, "brimming with cash")

/obj/item/piggy_bank/attackby(obj/item/item, mob/user, params)
	if (!istype(item, /obj/item/spacecash/bundle))
		return ..()

	var/obj/item/spacecash/bundle/C = item

	var/dosh_amount = calculate_dosh_amount()

	if(dosh_amount >= maximum_value)
		balloon_alert(user, "it's full!")
	else if(dosh_amount + C.worth > maximum_value)
		balloon_alert(user, "too much cash!")
	else if(!user.unEquip(item, src))
		balloon_alert(user, "stuck in your hands!")
	else
		balloon_alert(user, "inserted [C.worth] creds")
	return TRUE

///Returns the total amount of credits that its contents amount to.
/obj/item/piggy_bank/proc/calculate_dosh_amount()
	var/total_value = 0
	for(var/obj/item/spacecash/bundle/bundle in contents)
		total_value += bundle.worth
	return total_value

/obj/item/piggy_bank/vault
	name = "vault piggy bank"
	desc = "A pig-shaped money container made of porkelain, containing the station's emergency funds carried between shifts, oink. <i>Do not throw.</i>"
	persistence_id = "vault_piggy"
	maximum_value = 1500
	initial_value = 25 //it takes about 60 shifts for it to hit its max value on its own.
	maximum_savings_per_shift = 750 //and 2 if you actively use it.

/obj/item/piggy_bank/vault/Initialize(mapload)
	. = ..()
	//one piggy bank should exist, preferibly inside the vault's safe.
	REGISTER_REQUIRED_MAP_ITEM(1, 1)
