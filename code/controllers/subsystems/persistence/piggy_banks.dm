///This proc is used to initialize holochips, cash and coins inside our persistent piggy bank.
/datum/controller/subsystem/persistence/proc/load_piggy_bank(obj/item/piggy_bank/piggy)
	if(isnull(piggy_banks_database))
		piggy_banks_database = new("data/piggy_banks.json")

	var/list/data = piggy_banks_database.get_key(piggy.persistence_id)
	if(isnull(data))
		return

	var/total_value = 0
	for(var/iteration in 1 to length(data))
		var/money_path = text2path(data[iteration])
		if(!money_path) //For a reason or another, it was removed.
			continue

		if(ispath(money_path, /obj/item/spacecash/bundle))
			var/list/key_and_assoc = data.Copy(iteration, iteration + 1)
			var/amount = key_and_assoc["[money_path]"]
			total_value += amount
		else
			crash_with("Unsupported path found in the data of a persistent piggy bank. item: [money_path], id:[piggy.persistence_id]")
			continue

		if(total_value >= piggy.maximum_value)
			break

///This proc is used to save money stored inside our persistent the piggy bank for the next time it's loaded.
/datum/controller/subsystem/persistence/proc/save_piggy_bank(obj/item/piggy_bank/piggy)
	if(isnull(piggy_banks_database))
		return

	if(queued_broken_piggy_ids)
		for(var/broken_id in queued_broken_piggy_ids)
			piggy_banks_database.remove(broken_id)
		queued_broken_piggy_ids = null

	var/list/data = list()
	for(var/obj/item/spacecash/bundle/cash as anything in piggy.contents)
		data += list("[cash.type]" = cash.worth)

	piggy_banks_database.set_key(piggy.persistence_id, data)
