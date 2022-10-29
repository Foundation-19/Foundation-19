/datum/scp/scp_500
	name = "SCP-500"
	designation = "500"
	classification = SAFE

/obj/item/reagent_containers/pill/scp500
	name = "SCP-500"
	desc = "A pill that, when taken orally, cures the subject of all disease."
	icon_state = "pill9"
	SCP = /datum/scp/scp_500

/obj/item/reagent_containers/pill/scp500/New()
	. = ..()
	reagents.add_reagent(/datum/reagent/adminordrazine, 1)

/obj/item/storage/pill_bottle/scp500
	name = "pill bottle (Panacea)"
	desc = "Contains pills of SCP-500."

	max_storage_space = 47 // gotta store those pills

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 47
	)
