/client/verb/fix_layout()
	set name = "Исправить раскладку"
	set category = "OOC"

	set_macros()
	to_chat(src, SPAN_WARNING("Перерегистрация макросов выполнена. Если не сработало, убедитесь что раскладка переключена на английский язык."))

/datum/keybinding/admin/admin_pm
	hotkey_keys = list("F8")
	name = "build_mod"
	full_name = "Build Mod"
	description = "Change Build Mod"

/datum/keybinding/admin/admin_pm/down(client/user)
	user.togglebuildmodeself()
	return TRUE
