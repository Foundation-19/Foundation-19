/datum/modpack/objects
	/// A string name for the modpack. Used for looking up other modpacks in init.
	name = "Objects"
	/// A string desc for the modpack. Can be used for modpack verb list as description.
	desc = "Различное снаряжение и дополнительные предметы."
	/// A string with authors of this modpack.
	author = "Voiko"

/datum/modpack/objects/pre_initialize()
	. = ..()

/datum/modpack/objects/initialize()
	. = ..()

/datum/modpack/objects/post_initialize()
	. = ..()
