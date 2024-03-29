/// This proc is used to initialize holochips, cash and coins inside our persistent piggy bank.
/datum/controller/subsystem/persistence/proc/load_piggy_bank(obj/item/piggy_bank/piggy)
	if(isnull(piggy_banks_database))
		piggy_banks_database = new("data/piggy_banks.json")

	piggy.current_wealth = min(piggy_banks_database.get_key(piggy.persistence_id), piggy.maximum_value)

/// This proc is used to save money stored inside our persistent the piggy bank for the next time it's loaded.
/datum/controller/subsystem/persistence/proc/save_piggy_bank(obj/item/piggy_bank/piggy)
	if(isnull(piggy_banks_database))
		return

	if(queued_broken_piggy_ids)
		for(var/broken_id in queued_broken_piggy_ids)
			piggy_banks_database.remove(broken_id)
		queued_broken_piggy_ids = null

	piggy_banks_database.set_key(piggy.persistence_id, piggy.current_wealth)
