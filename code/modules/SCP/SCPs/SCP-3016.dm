/datum/scp/scp_3016/
	name = "SCP-3016"
	designation = "3016"

/obj/item/scp3016/
	name = "SCP-3016"
	desc = "A top spinning excessively quickly."
	icon = 'icons/scp/scp-3016.dmi'
	icon_state = "slow"
	var/rotationspeed = 0

/obj/item/scp3016/Process()

	rotationspeed += 20 + rand(0,10)

/obj/machinery/scp3016
	name = "SCP-3016 containment apparatus"
	desc = "An assortment of electromagnets and braking clamps to maintain the safety of SCP-3016."
