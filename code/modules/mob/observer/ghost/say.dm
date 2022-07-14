/mob/observer/ghost/say(var/message)
	sanitize_and_communicate(/decl/communication_channel/dsay, client, message)
	client.dsay_log += "([time_stamp()]) - [message]"