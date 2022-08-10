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
	channels = list("Command" = 1, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "AI Private" = 1, "HCZ-Security" = 1, "LCZ-Security" = 1, "ECZ-Security" = 1)

/obj/item/device/encryptionkey/heads/comms_dispatcher
	name = "dispatcher encryption key"
	desc = "An encryption key providing access to most channels."
	icon_state = "comm_cypherkey"
	channels = list("Command" = 0, "Security" = 1, "Engineering" = 1, "Science" = 1, "Medical" = 1, "Supply" = 1, "Service" = 1, "HCZ-Security" = 1, "LCZ-Security" = 1, "ECZ-Security" = 1)

/obj/item/device/radio/headset/headset_sec_hcz
	name = "HCZ security radio headset"
	desc = "This is used by your elite security force."
	icon_state = "sec_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_sec_hcz

/obj/item/device/radio/headset/headset_sec_lcz
	name = "LCZ security radio headset"
	desc = "This is used by your elite security force."
	icon_state = "sec_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_sec_lcz

/obj/item/device/radio/headset/headset_sec_ecz
	name = "EZ security radio headset"
	desc = "This is used by your elite security force."
	icon_state = "sec_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_sec_ecz

/obj/item/device/encryptionkey/headset_sec_hcz
	name = "HCZ security radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("HCZ-Security" = 1)

/obj/item/device/encryptionkey/headset_sec_lcz
	name = "LCZ security radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("LCZ-Security" = 1)

/obj/item/device/encryptionkey/headset_sec_ecz
	name = "ECZ security radio encryption key"
	icon_state = "sec_cypherkey"
	channels = list("ECZ-Security" = 1)

/obj/item/device/radio/headset/goc
	name = "GOC headset"
	desc = "The headset of for a member of the Global Occult Coalision."
	ks2type = /obj/item/device/encryptionkey/goc


/obj/item/device/radio/headset/heads/hos/goc
	name = "GOC representative's headset"
	desc = "The headset of the humanitarian, or so they might say."
	ks2type = /obj/item/device/encryptionkey/goc

/obj/item/device/radio/headset/heads/hos/uiu
	name = "UIU representative's headset"
	desc = "The headset of the humanitarian, or so they might say."

/obj/item/device/encryptionkey/goc
	name = "GOC radio encryption key"
	icon_state = "goc_cypherkey"
	channels = list("GOC" = 1)

/obj/item/device/radio/headset/heads/hos/thi
	name = "Horizon Initiative representative's headset"
	desc = "The headset of the holy man, don't let them see 343."
