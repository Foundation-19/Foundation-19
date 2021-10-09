/obj/item/device/radio/headset/torchnanotrasen
	name = "nanotrasen headset"
	desc = "A headset for corporate drones."
	icon_state = "nt_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_torchnt

/obj/item/device/radio/headset/heads/torchcaptain
	name = "commanding officer's headset"
	desc = "The skipper's headset."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/torchcaptain

/obj/item/device/radio/headset/heads/torchxo
	name = "executive officer's headset"
	desc = "The headset of the guy who will one day be CO."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/torchxo

/obj/item/device/radio/headset/heads/torchntcommand
	name = "nanotrasen command headset"
	desc = "Headset of the corporate overlords."
	icon_state = "nt_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_torchrd

/obj/item/device/radio/headset/heads/cos
	name = "guard commander's headset"
	desc = "The headset of the man who protects your worthless lives."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/hos

/obj/item/device/radio/headset/headset_deckofficer
	name = "logistics officer's radio headset"
	desc = "The headset of the chief box pusher."
	icon_state = "cargo_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/heads/qm

/obj/item/weapon/storage/box/headset/torchxo
	name = "box of spare executive officer headsets"
	desc = "A box full of executive officer headsets."
	startswith = list(/obj/item/device/radio/headset/heads/torchxo = 7)

/obj/item/weapon/storage/box/encryptionkeys
	name = "box of spare encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(
		/obj/item/device/encryptionkey/headset_sci = 4,
		/obj/item/device/encryptionkey/headset_med = 4,
		/obj/item/device/encryptionkey/headset_cargo = 4,
		/obj/item/device/encryptionkey/headset_service = 4,
		/obj/item/device/encryptionkey/headset_eng = 4,
		/obj/item/device/encryptionkey/headset_sec = 4
	)

/obj/item/weapon/storage/box/encryptionkeys/sci
	name = "science encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_sci = 8)

/obj/item/weapon/storage/box/encryptionkeys/med
	name = "medical encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_med = 8)

/obj/item/weapon/storage/box/encryptionkeys/cargo
	name = "cargo encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_cargo = 8)

/obj/item/weapon/storage/box/encryptionkeys/service
	name = "service encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_service = 8)

/obj/item/weapon/storage/box/encryptionkeys/eng
	name = "engineering encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_eng = 8)

/obj/item/weapon/storage/box/encryptionkeys/sec
	name = "security encryption keys"
	desc = "A box full of spare encryption keys."
	startswith = list(/obj/item/device/encryptionkey/headset_sec = 8)

/obj/item/device/radio/headset/bridgeofficer
	name = "bridge officer's headset"
	desc = "A headset with access to the command, engineering and exploration channels."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/bridgeofficer

/obj/item/device/radio/headset/exploration
	name = "exploration headset"
	desc = "A headset for real tools, with access to the exploration channel."
	icon_state = "srv_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/exploration

/obj/item/device/radio/headset/pathfinder
	name = "pathfinder's headset"
	desc = "A headset with access to the command and exploration channels."
	icon_state = "com_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/pathfinder

/obj/item/device/radio/headset/torchroboticist
	name = "roboticist's headset"
	desc = "A headset with access to the engineering and medical channels."
	icon_state = "eng_headset"
	item_state = "headset"
	ks2type = /obj/item/device/encryptionkey/headset_torchroboticist
