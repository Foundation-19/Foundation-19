/datum/modpack/human_examine
	/// A string name for the modpack. Used for looking up other modpacks in init.
	name = "human_examine"
	/// A string desc for the modpack. Can be used for modpack verb list as description.
	desc = "добавлена работа и класс в строку карты при экзамайне"
	/// A string with authors of this modpack.
	author = "XAH"

/datum/modpack/human_examine/pre_initialize()
	. = ..()

/datum/modpack/human_examine/initialize()
	. = ..()

/datum/modpack/human_examine/post_initialize()
	. = ..()
