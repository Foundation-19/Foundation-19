/obj/item/implanter/codex
	name = "implanter (codex)"
	imp = /obj/item/implant/codex

/obj/item/implant/codex
	name = "codex implant"
	desc = "It has 'DON'T PANIC' embossed on the casing in friendly letters."

/obj/item/implant/codex/implanted(mob/source)
	. = ..(source)
	to_chat(usr, SPAN_NOTICE("You feel the brief sensation of having an entire encyclopedia at the tip of your tongue as the codex implant meshes with your nervous system."))
