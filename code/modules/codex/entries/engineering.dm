/datum/codex_entry/apc
	associated_paths = list(/obj/machinery/power/apc)
	entry_text = "An APC (Area Power Controller) regulates and supplies backup power for the area they are in.<br>\
	Their power channels are divided out into 'environmental' (Items that manipulate airflow and temperature), 'lighting' (Lights), and 'equipment' (Everything else that consumes power).<br>\
	Power consumption and backup power cell charge can be seen from the interface, further controls (turning a specific channel on, off or automatic, toggling the APC's ability to charge the backup cell, or toggling power for the entire area via master breaker) first requires the interface to be unlocked with an ID with Engineering access or by one of the station's robots or the artificial intelligence.<br>\
	APCs, if <span codexlink='cryptographic sequencer'>emagged</span>, will be permanently unlocked, with a visible blue error screen.<br>\
	<span codexlink='Hacking wires'>Wire hacking</span> can be useful when dealing with APCs.<br>\
	A powersink will also drain any APCs connected to the same wire the powersink is on."

/datum/codex_entry/inflatable_item
	associated_paths = list(/obj/item/inflatable)
	entry_text = "Inflate by using it in your hand.  The inflatable barrier will inflate on your tile.  To deflate it, use the 'deflate' verb."

/datum/codex_entry/inflatable_deployed
	associated_paths = list(/obj/structure/inflatable)
	entry_text = "To remove these safely, use the 'deflate' verb.  Hitting these with any objects will probably puncture and break it forever."

/datum/codex_entry/inflatable_door
	associated_paths = list(/obj/structure/inflatable/door)
	entry_text = "Click the door to open or close it.  It only stops air while closed.<br>\
	To remove these safely, use the 'deflate' verb.  Hitting these with any objects will probably puncture and break it forever."

/datum/codex_entry/welding_pack
	associated_paths = list(/obj/item/weldpack)
	entry_text = "This pack acts as a portable source of welding fuel. Use a <l>welder</l> on it to refill its tank - but make sure it's not lit!<br>\
	You can use this kit on a fuel tank or appropriate reagent dispenser to replenish its reserves."

/datum/codex_entry/gripper
	associated_paths = list(/obj/item/gripper)
	entry_text = "Click an item to pick it up with your gripper. Use it as you would normally use anything in your hand. The Drop Item verb will allow you to release the item."

/datum/codex_entry/diffuser_item
	associated_paths = list(/obj/item/shield_diffuser)
	entry_text = "This device disrupts shields on directly adjacent tiles (in a + shaped pattern), in a similar way the <span codexlink='shield diffuser'>floor mounted variant</span> does. \
	It is, however, portable and run by an internal battery. Can be recharged with a regular recharger."
