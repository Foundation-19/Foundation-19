/client/verb/fix_layout()
	set name = "Исправить раскладку"
	set category = "OOC"

	set_macros()
	to_chat(src, SPAN_WARNING("Перерегистрация макросов выполнена. Если не сработало, убедитесь что раскладка переключена на английский язык."))
