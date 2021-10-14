/proc/qdel_after(D, time) 
	set waitfor = FALSE 
	sleep(time)
	if (D)
		qdel(D)