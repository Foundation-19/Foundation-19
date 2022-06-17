/obj/item/device/radio/headset/heads/commsofficer
	name = "communication officer's headset"
	desc = "The headset of the creepy guy behind the consoles."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/comms_admin

/obj/item/device/radio/headset/commsdispatcher
	name = "communication dispatcher's headset"
	desc = "The headset of the calm voice of certainty."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/comms_dispatcher

/obj/item/device/encryptionkey/heads/comms_admin
	name = "comms admin encryption key"
	desc = "An encryption key providing access to all channels."
	icon_state = "comm_cypherkey"
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1, "HCZ-Security" = 1, "LCZ-Security" =1, "ECZ-Security" = 1)

/obj/item/device/encryptionkey/heads/comms_dispatcher
	name = "dispatcher encryption key"
	desc = "An encryption key providing access to most channels."
	icon_state = "comm_cypherkey"
	channels = list("Command" = 0, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "HCZ-Security" = 1, "LCZ-Security" =1, "ECZ-Security" = 1)
