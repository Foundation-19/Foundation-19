/datum/admin_secret_item/fun_secret/send_strike_team
	name = "Send Strike Team"

/datum/admin_secret_item/fun_secret/send_strike_team/can_execute(mob/user)
	if(!ticker) return 0
	return ..()

/datum/admin_secret_item/fun_secret/send_strike_team/execute(mob/user)
	. = ..()
	if(.)
		return user.client.strike_team()
