/datum/codex_entry/modular_computer
	lore_text = "To prevent potential corporate, government, or terrorist spying, the SCP Foundation ensures all staff are equipped with only self-produced electronics."
	mechanics_text = "Modular computers are (as their name implies) assembled with different hardware items that, together, allow a modular computer to function.<br>\
	There are 5 types of modular computers: consoles, laptops, tablets, PDAs, and telescreens.<br>\
	Tablets and PDAs are quick and easy to use; just use them in-hand to turn them on! However, they can only use the smallest components.<br>\
	Laptops are a nice middle-ground option. They're moderately cumbersome and have to be placed on a table to be used, but can use larger electronics.<br>\
	Telescreens and consoles are larger, stationary computers. Thanks to their size, consoles can utilize even the largest hardware."

/datum/codex_entry/modular_computer/New()
	associated_paths = typesof(/obj/item/modular_computer)

/datum/codex_entry/processor_unit
	display_name = "processor unit"
	mechanics_text = "A critical component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	This is required to run programs and SCPOS. Stronger processor units allow for more programs to be run simultaneously."
	antag_text = "Processing speed is also important when hacking."

/datum/codex_entry/processor_unit/New()
	associated_paths = typesof(/obj/item/stock_parts/computer/processor_unit)

/datum/codex_entry/hard_drive
	display_name = "hard drive"
	mechanics_text = "A critical component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	This is important for storing digital files. Larger and more technologically-advanced hard drives can store more than weaker ones."

/datum/codex_entry/hard_drive/New()
	associated_paths = (typesof(/obj/item/stock_parts/computer/hard_drive) - typesof(/obj/item/stock_parts/computer/hard_drive/portable))

/datum/codex_entry/hard_drive_portable
	display_name = "portable hard drive"
	mechanics_text = "A form of <l>hard drive</l> that allows for physical transportation of files.<br>\
	Insert the flash drive into a <span codexlink='Modular Computer'>modular computer</span> to transfer files.<br>\
	Due to their small size, portable hard drives store less files than their respective built-in counterparts."

/datum/codex_entry/hard_drive_portable/New()
	associated_paths = typesof(/obj/item/stock_parts/computer/hard_drive/portable)

/datum/codex_entry/battery_module
	display_name = "battery module"
	mechanics_text = "A semi-critical component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	This stores battery power for mobile electronics, but can be skipped for consoles (which rely on direct power from cables).<br>\
	Larger batteries can store more power"

/datum/codex_entry/battery_module/New()
	associated_paths = typesof(/obj/item/stock_parts/computer/battery_module)

/datum/codex_entry/network_card
	display_name = "network card"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It's required for access to the internet, more technologically-advanced network cards can provide faster connections to the internet, and from longer ranges.<br>\
	Consoles can also use ethernet network cards, which provide an extremely strong connection."

/datum/codex_entry/network_card/New()
	associated_paths = typesof(/obj/item/stock_parts/computer/network_card)

/datum/codex_entry/card_slot
	associated_paths = list(/obj/item/stock_parts/computer/card_slot)
	display_name = "RFID card slot"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It has a slot to input a card for modification. Also see <l>RFID card broadcaster</l>"

/datum/codex_entry/card_slot_broadcaster
	associated_paths = list(/obj/item/stock_parts/computer/card_slot/broadcaster)
	display_name = "RFID card broadcaster"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It has a slot to input a card for use with scanners. Also see <l>RFID card slot</l>"

/datum/codex_entry/nano_printer
	associated_paths = list(/obj/item/stock_parts/computer/nano_printer)
	display_name = "nano printer"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It can be used to print forms and reports on paper (fed from an internal storage). Useful with a <span codexlink='scanner module'>paper scanner module</span>."

/datum/codex_entry/ai_slot
	associated_paths = list(/obj/item/stock_parts/computer/ai_slot)
	display_name = "inteliCard slot"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It can hold an internal AIC card."

/datum/codex_entry/tesla_link
	associated_paths = list(/obj/item/stock_parts/computer/tesla_link)
	display_name = "tesla link"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	It pulls power out of nearby <span codexlink='area power controller'>area power controllers</span> and charges <span codexlink='battery module'>internal batteries</span>."

/datum/codex_entry/scanner
	display_name = "scanner module"
	mechanics_text = "An optional component for <span codexlink='Modular Computer'>modular computers</span>.<br>\
	Scanners are varying forms of sensors used to provide information. The exact information provided is dependant on the type of scanner used.<br>\
	Atmospheric scanners report the types and amount of <span codexlink='Gases (category)'>gases</span> in the air.<br>\
	Medical scanners report the medical information of patients.<br>\
	Reagent scanners can identify various <span codexlink = 'Reagents (category)'>reagents</span>.<br>\
	Paper scanners can save physical reports as digital papers. Best paired with a <l>nano printer</l>."

/datum/codex_entry/scanner/New()
	associated_paths = typesof(/obj/item/stock_parts/computer/scanner)
