/datum/modpack/example
	/// A string name for the modpack. Used for looking up other modpacks in init.
	name = "Name"
	/// A string desc for the modpack. Can be used for modpack verb list as description.
	desc = "Description"
	/// A string with authors of this modpack.
	author = "Voiko"

/datum/modpack/example/pre_initialize()
	. = ..()

/datum/modpack/example/initialize()
	. = ..()

/datum/modpack/example/post_initialize()
	. = ..()
