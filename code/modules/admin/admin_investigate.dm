//By Carnwennan

//This system was made as an alternative to all the in-game lists and variables used to log stuff in-game.
//lists and variables are great. However, they have several major flaws:
//Firstly, they use memory. TGstation has one of the highest memory usage of all the ss13 branches.
//Secondly, they are usually stored in an object. This means that they aren't centralised. It also means that
//the data is lost when the object is deleted! This is especially annoying for things like the singulo engine!
#define INVESTIGATE_DIR "data/investigate/"

//SYSTEM
/proc/investigate_subject2file(subject)
	return file("[INVESTIGATE_DIR][subject].html")

/hook/startup/proc/resetInvestigate()
	investigate_reset()
	return 1

/proc/investigate_reset()
	if(fdel(INVESTIGATE_DIR))	return 1
	return 0

/atom/proc/investigate_log(message, subject)
	if(!message)	return
	var/F = investigate_subject2file(subject)
	if(!F)	return
	to_file(F, "<small>[time_stamp()] \ref[src] ([x],[y],[z])</small> || [src] [message]<br>")

//ADMINVERBS
/client/proc/investigate_show( subject in list("hrefs","wires","singulo") )
	set name = "Investigate"
	set category = "Admin"
	if(!holder)	return
	switch(subject)
		if("singulo", "wires")			//general one-round-only stuff
			var/F = investigate_subject2file(subject)
			if(!F)
				to_chat(src, SPAN_WARNING("Error: admin_investigate: [INVESTIGATE_DIR][subject] is an invalid path or cannot be accessed."))
				return
			show_browser(src, F,"window=investigate[subject];size=800x300")

		if("hrefs")				//persistant logs and stuff
			if (GLOB.href_logfile)
				show_browser(src, GLOB.href_logfile, "window=investigate[subject];size=800x300")
			else
				to_chat(src, SPAN_WARNING("Error: admin_investigate: Href Logging [config.log_hrefs ? "failed to start" : "is disabled"]."))
