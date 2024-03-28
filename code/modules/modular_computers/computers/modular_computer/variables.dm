// This is the base type that handles everything. Subtypes can be easily created by tweaking variables in this file to your liking.

/obj/item/modular_computer
	abstract_type = /obj/item/modular_computer
	name = "Modular Computer"
	desc = "A modular computer. You shouldn't see this."
	icon = null
	icon_state = null
	center_of_mass = null	// No pixelshifting by placing on tables, etc.
	randpixel = 0			// And no random pixelshifting on-creation either.
	/// A flag that describes this device's type.
	var/hardware_flag = 0
	/// If true, the computer has been emagged.
	var/computer_emagged = FALSE
	/// Error screen displayed
	var/bsod = FALSE
	/// Power usage when the computer is open (screen is active) and can be interacted with. Remember: hardware can use power too.
	var/base_active_power_usage = 50
	/// Power usage when the computer is idle and screen is off (currently only applies to laptops).
	var/base_idle_power_usage = 5
	/// Last time sound was played.
	var/ambience_last_played

	/// Set automatically. Whether the computer used APC power last tick.
	var/apc_powered = FALSE
	/// Last tick power usage of this computer.
	var/last_power_usage = 0
	/// Last battery percentage of this computer.
	var/last_battery_percent = 0
	var/last_world_time = "00:00"
	var/list/last_header_icons

	/// Whether the computer is turned on.
	var/enabled = FALSE
	/// Whether the computer is active/opened/it's screen is on.
	var/screen_on = TRUE
	/// The program that's currently active and visible to the user. Null if nothing's open - then, the main menu is displayed.
	var/datum/computer_file/program/active_program = null
	/// Idle programs on background. They still receive process calls but can't be interacted with.
	var/list/idle_threads = list()

	// Modular computers can run on various devices. Each DEVICE (Laptop, Console, Tablet,..)
	// must have it's own DMI file. Icon states must be called exactly the same in all files, but may look differently
	// If you create a program which is limited to Laptops and Consoles you don't have to add it's icon_state overlay for Tablets too, for example.
	/// Icon state when the computer is turned off
	var/icon_state_unpowered = null
	/// Icon state overlay when the computer is turned on, but no program is loaded that would override the screen.
	var/icon_state_menu = "menu"
	var/icon_state_screensaver = "standby"
	/// Maximal hardware size. Currently, tablets have 1, laptops 2 and consoles 3. Limits what hardware types can be installed.
	var/max_hardware_size = 0
	/// Amount of steel sheets refunded when disassembling an empty frame of this computer.
	var/steel_sheet_cost = 5
	/// Intensity of light this computer emits. Comparable to numbers light fixtures use.
	var/light_strength = 0

	// Damage of the chassis. If the chassis takes too much damage it will break apart.
	/// Current damage level
	var/damage = 0
	/// Damage level at which the computer ceases to operate
	var/broken_damage = 50
	/// Damage level at which the computer breaks apart.
	var/max_damage = 100

	/// List of open terminal datums.
	var/list/terminals

	// Important hardware (must be installed for computer to work)
	/// CPU. Without it the computer won't run. Better CPUs can run more programs at once.
	var/obj/item/stock_parts/computer/processor_unit/processor_unit
	/// Hard Drive component of this computer. Stores programs and files.
	var/obj/item/stock_parts/computer/storage/hard_drive/hard_drive
	/// An internal power source for this computer. Can be recharged. Not required for consoles or telescreens.
	var/obj/item/stock_parts/computer/battery_module/battery_module

	// Optional hardware (improves functionality, but is not critical for computer to work in most cases)
	/// Network Card component of this computer. Allows connection to SCiPnet
	var/obj/item/stock_parts/computer/network_card/network_card
	/// ID Card slot component of this computer. Useful for HoP modification console, PDAs, and so on.
	var/obj/item/stock_parts/computer/card_slot/card_slot
	/// Nano Printer component of this computer, for your everyday paperwork needs.
	var/obj/item/stock_parts/computer/nano_printer/nano_printer
	/// Portable data storage		// TODO: support for several portable drive slots / perhaps a system for general peripheral slots?
	var/obj/item/stock_parts/computer/storage/portable_drive/portable_drive
	/// AI slot, an intellicard housing that allows modifications of AIs.
	var/obj/item/stock_parts/computer/ai_slot/ai_slot
	/// Tesla Link, Allows remote charging from nearest APC.
	var/obj/item/stock_parts/computer/tesla_link/tesla_link
	/// One of several optional scanner attachments.
	var/obj/item/stock_parts/computer/scanner/scanner

	/// If true, can't be modified or damaged.
	var/modifiable = TRUE

	// If true, a pen can be stored.
	var/stores_pen = FALSE
	var/obj/item/pen/stored_pen

	var/interact_sounds
	var/interact_sound_volume = 40

	/// Ghetto solution. List of 5295 instances that are watching this computer. We use a list in case several 5295s are watching at once. If you're adding more hacking functionality, it might be smart to move this over.
	var/list/watched_by_5295 = list()
