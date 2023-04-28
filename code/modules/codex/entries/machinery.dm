/datum/codex_entry/replicator
	associated_paths = list(/obj/machinery/fabricator/replicator)
	mechanics_text = "The food replicator is operated through voice commands. To inquire available dishes on the menu, say 'menu'. \
	To dispense a dish, say the name of the dish listed in its menu.<br>\
	Dishes can only be produced as long as the replicator has biomass. To check on the biomass level of the replicator, say 'status'. \
	Various food items or plants may be inserted to refill biomass."

/datum/codex_entry/emitter
	associated_paths = list(/obj/machinery/power/emitter)
	mechanics_text = "You must secure this in place with a <l>wrench</l> and weld it to the floor before using it. \
	The emitter will only fire if it is installed above a cable endpoint.<br>\
	Clicking will toggle it on and off, at which point, so long as it remains powered, it will fire in a single direction in bursts of four."
	lore_text = "A recent innovation by the Research team, this device has applications such as mining, cutting, and is often used to power advanced, bulky machinery."
	antag_text = "This baby is capable of slicing through <span codexlink='wall'>walls</span>, sealed lockers, and people."

/datum/codex_entry/diffuser_machine
	associated_paths = list(/obj/machinery/shield_diffuser)
	mechanics_text = "This device disrupts shields on directly adjacent tiles (in a + shaped pattern). \
	They are commonly installed around exterior airlocks to prevent shields from blocking EVA access.<br>\
	There is also a <span codexlink='portable shield diffuser'>portable version</span>."

/datum/codex_entry/conveyor_construct
	associated_paths = list(/obj/machinery/conveyor, /obj/item/construct/conveyor)
	mechanics_text = "This device must be connected to a <span codexlink='conveyor switch'>switch assembly</span> before placement by clicking the switch on the conveyor belt assembly \
	When active it will move objects on top of it to the adjacent space based on its direction and if it is running in forward or reverse mode.<br>\
	Can be removed with a <l>crowbar</l>."

/datum/codex_entry/conveyor_switch_construct
	associated_paths = list(/obj/machinery/conveyor_switch,/obj/machinery/conveyor_switch/oneway,/obj/item/construct/conveyor_switch)
	mechanics_text = "This device can connect to a number of <span codexlink='conveyor belt'>conveyor belts</span> and control their movement. \
	A two-way switch will allow you to make the conveyors run in forward and reverse mode, the one-way switch will only allow one direction.<br>\
	Can be removed with a <l>crowbar</l>."

/datum/codex_entry/tele_beacon
	associated_paths = list(/obj/machinery/tele_beacon)
	mechanics_text = "The teleporter beacon can be targeted by teleporter control consoles to allow teleporter pads to send mobs and objects to its location.<br>\
		It can only be targeted and used while the beacon is powered and anchored to the floor.<br>\
		While the panel is closed, you can:<br>\
		<ul><li>Use a <l>wrench</l> to anchor/unanchor the beacon, allowing it to be moved. The beacon is not functional unless anchored.</li>\
		<li>Use a <l>multitool</l> to rename the beacon. The name will be displayed in teleport control consoles.</li></ul>"
	antag_text = "If EMP'd, the beacon will lose all established teleporter locks and will be disabled for up to 30 seconds."

/datum/codex_entry/faxmachine
	associated_paths = list(/obj/machinery/photocopier/faxmachine)
	mechanics_text = "The fax machine can be used to transmit paper faxes to other fax machines on the map, or to off-site organizations handled by server administration. \
	To use the fax machine, you'll need to insert both a paper and your ID card, authenticate, select a destination, the transmit the fax. \
	You can also fax paper bundles, including photos, using this machine.<br>\
	You can check the machine's department origin tag using a <l>multitool</l>."
	antag_text = "If emagged with a <l>cryptographic sequencer</l>, the fax machine can then have its origin department tag changed using a multitool. \
	This allows you to send faxes pretending to be from somewhere else on the site, or even an off-site origin like the Foundation Central Office.<br>\
	<strong>NOTE</strong>: Any new department tags created in this way that do not already exist in the list of targets cannot receive faxes, \
	as this does not add new departments to the list of valid fax targets."
