/datum/codex_entry/wrench
	associated_paths = list(/obj/item/wrench)
	mechanics_text = "This versatile tool is used for dismantling machine frames, anchoring or unanchoring heavy objects like vending machines and <span codexlink='emitter'>emitters</span>, and much more.<br>\
	In general, if you want something to move or stop moving, you ought to use a wrench on it."
	lore_text = "The classic open-end wrench (or spanner, if you prefer) is still commonly used by Foundation personnel, \
	especially after anomalous science perfected a design for automatic bolt-matching."

/datum/codex_entry/screwdriver
	associated_paths = list(/obj/item/screwdriver)
	mechanics_text = "This tool is used to expose or safely hide away cabling.<br>\
	It can open and shut the maintenance panels on vending machines, airlocks, and much more!<br>\
	You can also use it, in combination with a <l>crowbar</l>, to install or remove windows.<br>\
	A screwdriver can also be used for <l>hacking wires</l><br>\
	They're also great for gouging eyes out! Simply target the eyes and stab your victim with one."
	lore_text = "Screws have not changed significantly in the paranormal world, and neither have the drivers used to install and remove them."

/datum/codex_entry/wirecutters
	associated_paths = list(/obj/item/wirecutters)
	mechanics_text = "This tool will cut wiring anywhere you see it - make sure to wear <l>insulated gloves</l>!<br>\
	When used on more complicated machines or airlocks, it can not only cut cables, but repair them, as well.<br>\
	Wirecutters are also useful for <l>hacking wires</l>."
	lore_text = "With anomalous alloys, today's wirecutters can snap through cables of astonishing thickness."

/datum/codex_entry/welder
	associated_paths = list(/obj/item/weldingtool)
	mechanics_text = "Use in your hand to toggle the welder on and off. Hold in one hand and click with an empty hand to remove its internal tank.<br>\
	Click on an object to try to weld it. You can seal airlocks, attach heavy-duty machines like <span codexlink='emitter'>emitters</span> and disposal chutes, and repair damaged <span codexlink='wall'>walls</span>.<br>\
	Each use of the welder will consume a unit of fuel. Be sure to wear protective equipment such as goggles, a mask, or certain voidsuit helmets to prevent eye damage.<br>\
	You can refill the welder at a welder tank by clicking on it, but be sure to turn it off first!<br>\
	Modify it with a <l>screwdriver</l> and stick some metal rods on it, and you've got the beginnings of a flamethrower."
	lore_text = "Commonly used by factories and homebrewed repair shops, welding tools are vital to Foundation's engineering staff. \
	While arc welding is still prefered by public manufactory companies, anomalous innovations in fuel storage have outpaced wireless technologies, \
	which firmly cemented gas welding as the #1 Foundation handheld welding tool."

/datum/codex_entry/crowbar
	associated_paths = list(/obj/item/crowbar)
	mechanics_text = "Aside from their use as a blunt weapon, crowbars are effective at prying things out, or open.<br>\
	Click on floor tiles to pry them loose. Use alongside a <l>screwdriver</l> to install or remove windows. Force open emergency shutters. Open the panel of an unlocked APC. Pry a computer's circuit board free.<br>\
	Crowbars can be used to bypass doors, even bolted ones, if the power's off. First, if the door is bolted, <span codexlink='welder'>weld</span> it and pry out the electronics. Then, just pry the door open!"
	lore_text = "As is the case with most standard-issue tools, crowbars are a simple and timeless design, the only difference being that advanced materials like plasteel have made them uncommonly tough."

/datum/codex_entry/toolbelt
	associated_paths = list(/obj/item/storage/belt/utility)
	mechanics_text = "The toolbelt has enough slots to carry around a full toolset: <l>screwdriver</l>, <l>crowbar</l>, <l>wrench</l>, <l>welder</l>, cable coil, and <l>multitool</l>.<br>\
	Simply click the belt to move a tool to one of its slots."
	lore_text = "Good hide is hard to come by in third-world countries. When they can't come across it, the Logistics department will outfit the staff with toolbelts made of synthetic leather."

/datum/codex_entry/toolbelt/crystal
	associated_paths = list(/obj/item/storage/belt/utility/crystal)
	lore_text = "While some Vigil units have tools integrated directly into their bodies, less specialized units simply use toolbelts."

/datum/codex_entry/toolbox/crystal
	associated_paths = list(/obj/item/storage/toolbox/crystal)
	lore_text = "The most basic of Vigil units may sometimes use toolboxes like these, which are surprisingly similar in design to ones of human origin. \
	On occasion, some units have been known to harbor a slight preference for these archaic designs over something more streamlined, for whatever reason."

/datum/codex_entry/cable_painter
	associated_paths = list(/obj/item/device/cable_painter)
	mechanics_text = "Use this device to select a preferred cable color. Apply it to a bundle of cables on your person, \
	or use it on installed cabling on the floor to paint it in your chosen color."
	lore_text = "A device often used by large-scale engineers to color-code their electrical systems. \
	An experienced technician can identify traditional installations by color alone."

/datum/codex_entry/paint_sprayer
	associated_paths = list(/obj/item/device/paint_sprayer)
	mechanics_text = "Used to paint floors, <span codexlink='wall'>walls</span>, windows, pipes, mech parts and airlocks.<br>\
	While holding the paint sprayer in the active hand, Ctrl+Click on a target will pick its color and Shift+Click will remove paint from it.<br>\
	Using the paint sprayer in hand will allow you to choose a decal for painting floors.<br>\
	You can quickly select a color/preset by ctrl-clicking or alt-clicking the paint sprayer, respectively."
	lore_text = "This ubiquitous maintenance-grade paint sprayer isn't as fancy or convenient as modern consumer models, \
	but with an internal synthesizer it never runs out of pigment!"

/datum/codex_entry/geiger_counter
	associated_paths = list(/obj/item/device/geiger)
	mechanics_text = "By using this item, you may toggle its scanning mode on and off. Examine it while it's on to check for ambient radiation."
	lore_text = "For decades geiger counters have been saving the lives of unsuspecting laborers and technicians. You can never be too careful around radiation."

/datum/codex_entry/light_replacer
	associated_paths = list(/obj/item/device/lightreplacer)
	mechanics_text = "Examine or use this item to see how many lights are remaining. You can feed it lightbulbs or sheets of glass to refill it.<br>\
	Using a <l>cryptographic sequencer</l> on this device will cause it to overload each light it replaces; when turned on, the new lights will explode!"
	lore_text = "Thanks to the Research division, you don't have to screw lightbulbs in by hand! The design of light replacers are only accessible by Level 4 staff or above."

/datum/codex_entry/multitool
	associated_paths = list(/obj/item/device/multitool)
	mechanics_text = "Multitools are an incredibly versatile tool that can be used on a wide variety of machines.<br>\
	The most common use for this is to trip a device's wires without having to cut them. Simply click on an object with exposed wiring to use it.<br>\
	Configuring and linking machinery usually requires a multitool as well.<br>\
	Multitools are also useful in <l>hacking wires</l>."
	lore_text = "The common, every day multitool is descended from certain electrical tools from the mundane world. \
	Though none too cheap, they are incredibly handy, and can be found in any self-respecting technician's toolbox."

/datum/codex_entry/t_scanner
	associated_paths = list(/obj/item/device/t_scanner)
	mechanics_text = "Use this to toggle its scanning capabilities on and off. While on, it will expose the layout of cabling and pipework in a 7x7 area around you."
	lore_text = "The T-ray scanner is a modern spectroscopy solution and labor-saving device. \
	Why work yourself to the bone removing floor panels when you can simply look through them with submillimeter radiation?"

/datum/codex_entry/rcd
	associated_paths = list(/obj/item/rcd)
	mechanics_text = "On use, this device will toggle between various types of structures (or their removal). You can examine it to see its current mode.<br>\
	It must be loaded with compressed matter cartridges, which can be obtained from an autolathe. Click an adjacent tile to use the device."
	lore_text = "Advents in material printing and synthesis technology have produced everyday miracles, such as the RCD, \
	which in certain industries has single-handedly put entire construction crews out of a job."

/datum/codex_entry/toolbox
	mechanics_text = "The toolbox is a general-purpose storage item with lots of space. With an item in your hand, click on it to store it inside."
	lore_text = "No one remembers which company designed this particular toolbox. It's been mass-produced, retired, brought out of retirement, and counterfeited for decades."

/datum/codex_entry/toolbox/New()
	associated_paths += typesof(/obj/item/storage/toolbox)
	. = ..()

/datum/codex_entry/insulated_gloves
	mechanics_text = "Insulated gloves are a vital safety precaution for high-voltage electrical work. They're usually worn while using <l>wirecutters</l> or laying cables.<br>\
	Insulated gloves are also a useful commodity for <l>hacking wires</l>."

/datum/codex_entry/insulated_gloves/New()
	associated_paths += typesof(/obj/item/clothing/gloves/insulated)
