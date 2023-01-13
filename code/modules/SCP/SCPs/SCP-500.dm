/datum/scp/scp_500
	name = "SCP-500"
	designation = "500"
	classification = SAFE

/obj/item/reagent_containers/pill/scp500
	name = "SCP-500"
	desc = "A pill."
	icon_state = "pill9"
	SCP = /datum/scp/scp_500

/obj/item/reagent_containers/pill/scp500/New()
	. = ..()
	reagents.add_reagent(/datum/reagent/adminordrazine, 1)

//is this shitcode? kinda. does it work? absolutely.
//these 2 lines of code make it so you can't dissolve scp 500 in water for multiplication, do not remove it.
/obj/item/reagent_containers/pill/scp500/afterattack(obj/target, mob/user, proximity)
	return 0


/obj/item/storage/pill_bottle/scp500
	name = "pill bottle (SCP-500)"
	desc = "This Pill Bottle has the words \'SCP-500\' written on its cover. There's a sticky note on it that reads, \'Due to repeated unauthorized usage, SCP-500 has been transferred to a secure Site. 10 pills have been kept for research purposes. Contact a RAISA official for more details.\'."
	max_storage_space = 10 // gotta store those pills

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 10
	)
