/datum/scp/scp_500
	name = "SCP-500"
	designation = "500"
	classification = SAFE

/obj/item/reagent_containers/pill/scp500
	name = "pill"
	desc = "A pill."
	icon_state = "pill9"
	SCP = /datum/scp/scp_500

/obj/item/reagent_containers/pill/scp500/New()
	. = ..()
	reagents.add_reagent(/datum/reagent/adminordrazine, 1)

/obj/item/reagent_containers/pill/scp500/afterattack(obj/target, mob/user, proximity)
	return 0


/obj/item/storage/pill_bottle/scp500
	name = "pill bottle (Panacea)"
	desc = "This Pill Bottle has the words panacea written in it's cover, you also notice a ductaped note to it, it says - DUE TO UNAUTHORIZED USAGE OF 3 PILLS TO CURE STDs IN ZONE COMMANDERS THE REST OF THE PILLS HAVE BEEN DELIVERED TO [REDACTED] FOR PROPER CONTAINMENT."

	max_storage_space = 8 // gotta store those pills

	startswith = list(
		/obj/item/reagent_containers/pill/scp500 = 8
	)
