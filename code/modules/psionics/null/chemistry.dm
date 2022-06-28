/datum/chemical_reaction/nullglass
	name = "Soulstone"
	result = null
	required_reagents = list(/datum/reagent/blood = 15, /datum/reagent/crystallizing_agent = 1)
	result_amount = 1

/datum/chemical_reaction/nullglass/get_reaction_flags(var/datum/reagents/holder)
	for(var/datum/reagent/blood/blood in holder.reagent_list)
		var/weakref/donor_ref = islist(blood.data) && blood.data["donor"]
		if(istype(donor_ref))
			var/mob/living/donor = donor_ref.resolve()
			if(istype(donor) && (donor.psi || (donor.mind && GLOB.wizards.is_antagonist(donor.mind))))
				return TRUE

/datum/chemical_reaction/nullglass/on_reaction(var/datum/reagents/holder, var/created_volume, var/reaction_flags)
	var/location = get_turf(holder.my_atom)
	if(reaction_flags)
		for(var/i = 1, i <= created_volume, i++)
			new /obj/item/device/soulstone(location)
	else
		for(var/i = 1, i <= created_volume*2, i++)
			new /obj/item/material/shard(location, MATERIAL_CRYSTAL)
