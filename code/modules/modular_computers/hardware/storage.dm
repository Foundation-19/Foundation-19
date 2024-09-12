/**
 * STORAGE
 *
 * Abstract computer component subtype for any part that stores files.
 */
/obj/item/stock_parts/computer/storage
	abstract_type = /obj/item/stock_parts/computer/storage
	var/max_capacity = 128
	var/used_capacity = 0
	var/list/stored_files = list()		// List of stored files on this drive. DO NOT MODIFY DIRECTLY!

/obj/item/stock_parts/computer/storage/diagnostics()
	. = ..()
	// 999 is a byond limit that is in place. It's unlikely someone will reach that many files anyway, since you would sooner run out of space.
	. += "SCPOS File Table Status: [stored_files.len]/999"
	. += "Storage capacity: [used_capacity]/[max_capacity]GQ"

// Use this proc to add file to the drive. Returns 1 on success and 0 on failure. Contains necessary sanity checks.
/obj/item/stock_parts/computer/storage/proc/store_file(datum/computer_file/F)
	if(!try_store_file(F))
		return FALSE
	F.holder = src
	stored_files.Add(F)
	recalculate_size()
	return TRUE

// Checks whether we can store the file. We can only store unique files, so this checks whether we wouldn't get a duplicity by adding a file.
/obj/item/stock_parts/computer/storage/proc/try_store_file(datum/computer_file/F)
	if(!F || !istype(F))
		return FALSE
	if(!can_store_file(F.size))
		return FALSE
	if(!check_functionality())
		return FALSE
	if(!stored_files)
		return FALSE

	var/list/badchars = list("/","\\",":","*","?","\"","<",">","|","#", ".")
	for(var/char in badchars)
		if(findtext(F.filename, char))
			return FALSE

	// This file is already stored. Don't store it again.
	if(F in stored_files)
		return FALSE

	var/name = F.filename + "." + F.filetype
	for(var/datum/computer_file/file in stored_files)
		if((file.filename + "." + file.filetype) == name)
			return FALSE
	return TRUE

// Checks whether file can be stored on the hard drive.
/obj/item/stock_parts/computer/storage/proc/can_store_file(size = 1)
	// In the unlikely event someone manages to create that many files.
	// BYOND is acting weird with numbers above 999 in loops (infinite loop prevention)
	if(stored_files.len >= 999)
		return FALSE
	if(used_capacity + size > max_capacity)
		return FALSE
	else
		return TRUE

// Use this proc to remove file from the drive. Returns TRUE on success and FALSE on failure. Contains necessary sanity checks.
/obj/item/stock_parts/computer/storage/proc/remove_file(datum/computer_file/F)
	if(!F || !istype(F))
		return FALSE

	if(!stored_files)
		return FALSE

	if(!check_functionality())
		return FALSE

	if(F in stored_files)
		stored_files -= F
		F.holder = null
		recalculate_size()
		return TRUE
	else
		return FALSE

// Loops through all stored files and recalculates used_capacity of this drive
/obj/item/stock_parts/computer/storage/proc/recalculate_size()
	var/total_size = 0
	for(var/datum/computer_file/F in stored_files)
		total_size += F.size

	used_capacity = total_size

// Tries to find the file by filename. Returns null on failure
/obj/item/stock_parts/computer/storage/proc/find_file_by_name(filename)
	if(!check_functionality())
		return null

	if(!filename)
		return null

	if(!stored_files)
		return null

	for(var/datum/computer_file/F in stored_files)
		if(F.filename == filename)
			return F
	return null

/obj/item/stock_parts/computer/storage/Destroy()
	stored_files = null
	return ..()

/**
 * HARD DRIVES
 *
 * Hard drives go inside the computer and are usually the "primary" method of storage.
 */
/obj/item/stock_parts/computer/storage/hard_drive
	name = "basic hard drive"
	desc = "A small power efficient solid state drive, with 128GQ of storage capacity for use in basic computers where power efficiency is desired."
	origin_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	max_capacity = 128
	power_usage = 25					// SSD or something with low power usage
	icon_state = "hdd_normal"
	hardware_size = 1

/obj/item/stock_parts/computer/storage/hard_drive/proc/install_default_programs()
	store_file(new/datum/computer_file/program/computerconfig(src)) 		// Computer configuration utility, allows hardware control and displays more info than status bar
	store_file(new/datum/computer_file/program/ntnetdownload(src))			// NTNet Downloader Utility, allows users to download more software from NTNet repository
	store_file(new/datum/computer_file/program/filemanager(src))			// File manager, allows text editor functions and basic file manipulation.

/obj/item/stock_parts/computer/storage/hard_drive/New()
	install_default_programs()
	..()

/obj/item/stock_parts/computer/storage/hard_drive/advanced
	name = "advanced hard drive"
	desc = "A small hybrid hard drive with 256GQ of storage capacity for use in higher grade computers where balance between power efficiency and capacity is desired."
	max_capacity = 256
	origin_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	power_usage = 50 					// Hybrid, medium capacity and medium power storage
	icon_state = "hdd_advanced"
	hardware_size = 2

/obj/item/stock_parts/computer/storage/hard_drive/super
	name = "super hard drive"
	desc = "A small hard drive with 512GQ of storage capacity for use in cluster storage solutions where capacity is more important than power efficiency."
	max_capacity = 512
	origin_tech = list(TECH_DATA = 3, TECH_ENGINEERING = 3)
	power_usage = 100					// High-capacity but uses lots of power, shortening battery life. Best used with APC link.
	icon_state = "hdd_super"
	hardware_size = 2

/obj/item/stock_parts/computer/storage/hard_drive/cluster
	name = "cluster hard drive"
	desc = "A large storage cluster consisting of multiple hard drives for usage in high capacity storage systems. Has capacity of 2048 GQ."
	power_usage = 500
	origin_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4)
	max_capacity = 2048
	icon_state = "hdd_cluster"
	hardware_size = 3

// For tablets, etc. - highly power efficient.
/obj/item/stock_parts/computer/storage/hard_drive/small
	name = "small hard drive"
	desc = "A small highly efficient solid state drive for portable devices."
	power_usage = 10
	origin_tech = list(TECH_DATA = 2, TECH_ENGINEERING = 2)
	max_capacity = 64
	icon_state = "hdd_small"
	hardware_size = 1

/obj/item/stock_parts/computer/storage/hard_drive/micro
	name = "micro hard drive"
	desc = "A small micro hard drive for portable devices."
	power_usage = 2
	origin_tech = list(TECH_DATA = 1, TECH_ENGINEERING = 1)
	max_capacity = 32
	icon_state = "hdd_micro"
	hardware_size = 1

/**
 * PORTABLE DRIVES
 *
 * Portable drives are, well, portable storage devices. Think of USB sticks.
 */
/obj/item/stock_parts/computer/storage/portable_drive
	name = "basic data drive"
	desc = "A small drive that can be used to store some data. Its capacity is 16 GQ."
	power_usage = 10
	icon_state = "flashdrive_basic"
	hardware_size = 1
	max_capacity = 16
	origin_tech = list(TECH_DATA = 1)

/obj/item/stock_parts/computer/storage/portable_drive/advanced
	name = "advanced data drive"
	desc = "A small drive that can be used to store a lot of data. Its capacity is 64 GQ."
	power_usage = 20
	icon_state = "flashdrive_advanced"
	hardware_size = 1
	max_capacity = 64
	origin_tech = list(TECH_DATA = 2)

/obj/item/stock_parts/computer/storage/portable_drive/super
	name = "super data drive"
	desc = "A small drive that can be used to store huge amounts of data. Its capacity is 256 GQ."
	power_usage = 40
	icon_state = "flashdrive_super"
	hardware_size = 1
	max_capacity = 256
	origin_tech = list(TECH_DATA = 4)

// For idiot merchants who wipe the program from their console.
/obj/item/stock_parts/computer/storage/portable_drive/merchant
	name = "merchant_list_1155_CRACKZ_1155_no_keygen_repack"
	desc = "An obviously pirated copy of well-known trading software."

/obj/item/stock_parts/computer/storage/portable_drive/merchant/New()
	store_file(new/datum/computer_file/program/merchant(src))
	. = ..()
