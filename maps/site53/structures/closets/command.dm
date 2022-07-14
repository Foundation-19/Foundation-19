/*
 * Site53 Command
 */

/obj/structure/closet/secure_closet/administration/facilityadmin
	name = "facility director's locker"
	req_access = list(access_adminlvl5)
	icon_state = "flocked"
	icon_closed = "funlocked"
	icon_locked = "flocked"
	icon_opened = "fopen"
	icon_off = "foff"

/obj/structure/closet/secure_closet/administration/facilityadmin/WillContain()
	return list(
//		/obj/item/clothing/under/suittie,
		/obj/item/clothing/shoes/dress,
		/obj/item/device/radio,
		/obj/item/clothing/suit/storage/toggle/suit/black,
	)

/obj/structure/closet/secure_closet/administration/commsofficer
	name = "communications officer's locker"
	req_access = list(access_adminlvl4)
	icon_state = "commolocked"
	icon_closed = "commounlocked"
	icon_locked = "commolocked"
	icon_opened = "commoopen"
	icon_off = "commooff"

/obj/structure/closet/secure_closet/administration/commsofficer/WillContain()
	return list(
		/obj/item/clothing/under/scp/utility/communications/officerfem,
		/obj/item/clothing/under/scp/utility/communications/officer,
		/obj/item/device/radio,
		/obj/item/device/megaphone,
		/obj/item/storage/box/headset,
		/obj/item/clothing/gloves/foundation_service,
		/obj/item/material/clipboard,
		/obj/item/folder/blue,
		/obj/item/storage/box/encryptionkeys/sci,
		/obj/item/storage/box/encryptionkeys/med,
		/obj/item/storage/box/encryptionkeys/cargo,
		/obj/item/storage/box/encryptionkeys/service,
		/obj/item/storage/box/encryptionkeys/eng,
		/obj/item/storage/box/encryptionkeys/sec,
		/obj/item/clothing/shoes/dutyboots,
		///obj/item/device/radio/headset/heads/commsofficer
		/obj/item/paper/monitorkey,
	)

/obj/structure/closet/secure_closet/administration/commstech
	name = "communications operator's locker"
	req_access = list(access_adminlvl1)
	icon_state = "commlocked"
	icon_state = "commlocked"
	icon_closed = "communlocked"
	icon_locked = "commlocked"
	icon_opened = "commopen"
	icon_off = "commoff"

/obj/structure/closet/secure_closet/administration/commstech/WillContain()
	return list(
		/obj/item/device/radio,
		/obj/item/clothing/gloves/foundation_service,
		/obj/item/material/clipboard,
		/obj/item/folder/blue,
		/obj/item/clothing/shoes/dutyboots,
//		/obj/item/device/radio/headset/commsdispatcher,
		/obj/item/storage/belt/utility/full
	)
