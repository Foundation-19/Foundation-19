/mob/observer/ghost/say(message)
	sanitize_and_communicate(/decl/communication_channel/dsay, client, message)
	dsay_log += "([time_stamp()]) - [message]"
