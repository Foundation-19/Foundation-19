/decl/turf_initializer/proc/InitializeTurf(turf/T)
	return

/area
	var/turf_initializer = null

/area/Initialize()
	. = ..()
	if(turf_initializer)
		for(var/turf/T in src)
			var/decl/turf_initializer/ti = decls_repository.get_decl(turf_initializer)
			ti.InitializeTurf(T)
