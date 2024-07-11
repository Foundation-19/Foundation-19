//Datum used to init Auxtools debugging as early as possible
//Datum gets created in master.dm because for whatever reason global code in there gets runs first
//In case we ever figure out how to manipulate global init order please move the datum creation into this file
/datum/debugger

/datum/debugger/New()
#ifdef USE_BYOND_TRACY
#warn USE_BYOND_TRACY is enabled
	init_byond_tracy()
#endif
	enable_debugger()

/datum/debugger/proc/enable_debugger()
	var/dll = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if(dll)
		call_ext(dll, "auxtools_init")()
		enable_debugging()

/proc/init_byond_tracy()
	var/library

	switch (world.system_type)
		if (MS_WINDOWS)
			library = "prof.dll"
		if (UNIX)
			library = "libprof.so"
		else
			CRASH("Unsupported platform: [world.system_type]")

	var/init_result = call_ext(library, "init")("block")
	if (init_result != "0")
		CRASH("Error initializing byond-tracy: [init_result]")

/proc/auxtools_stack_trace(msg)
	CRASH(msg)

/proc/auxtools_expr_stub()
	CRASH("auxtools not loaded")

/proc/enable_debugging(mode, port)
	CRASH("auxtools not loaded")
