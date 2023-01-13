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
	desc = "This Pill Bottle has \'SCP-500\' written on its label. The label also notes, \'Storage of more than 10 instances of SCP-500 are limited to secure Sites only. Contact a RAISA official for more details.\'."
	max_storage_space = 10 // gotta store those pills

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 10
	)
