//checks if a file exists and contains text
//returns text as a string if these conditions are met
/proc/return_file_text(filename)
	if(fexists(filename) == 0)
		error("File not found ([filename])")
		return

	var/text = file2text(filename)
	if(!text)
		error("File empty ([filename])")
		return

	return text

/proc/safefile2list(filename)
	if(!fexists(filename))
		log_error("Tried to read '[filename]', but it didn't exist!")
	var/list/L = file2list(filename)
	return LAZYLEN(L) ? L : list()

/// Returns the md5 of a file at a given path.
/proc/md5filepath(path)
	. = md5(file(path))

/// Save file as an external file then md5 it.
/// Used because md5ing files stored in the rsc sometimes gives incorrect md5 results.
/proc/md5asfile(file)
	var/static/notch = 0
	// its importaint this code can handle md5filepath sleeping instead of hard blocking, if it's converted to use rust_g.
	var/filename = "tmp/md5asfile.[world.realtime].[world.timeofday].[world.time].[world.tick_usage].[notch]"
	notch = WRAP(notch+1, 0, 2**15)
	fcopy(file, filename)
	. = md5filepath(filename)
	fdel(filename)

//Sends resource files to client cache
/client/proc/getFiles()
	for(var/file in args)
		send_rsc(src, file, null)

/client/proc/browse_files(root="data/logs/", max_iterations=10, list/valid_extensions=list(".txt",".log",".htm"))
	var/path = root

	for(var/i=0, i<max_iterations, i++)
		var/list/choices = sortList(flist(path))
		if(path != root)
			choices.Insert(1,"/")

		var/choice = input(src,"Choose a file to access:","Download",null) as null|anything in choices
		switch(choice)
			if(null)
				return
			if("/")
				path = root
				continue
		path += choice

		if(copytext(path,-1,0) != "/")		//didn't choose a directory, no need to iterate again
			break

	var/extension = copytext(path,-4,0)
	if( !fexists(path) || !(extension in valid_extensions) )
		to_chat(src, FONT_COLORED("red","Error: browse_files(): File not found/Invalid file([path])."))
		return

	return path

#define FTPDELAY 200	//200 tick delay to discourage spam
/*	This proc is a failsafe to prevent spamming of file requests.
	It is just a timer that only permits a download every [FTPDELAY] ticks.
	This can be changed by modifying FTPDELAY's value above.

	PLEASE USE RESPONSIBLY, Some log files can reach sizes of 4MB!	*/
/client/proc/file_spam_check()
	var/time_to_wait = fileaccess_timer - world.time
	if(time_to_wait > 0)
		to_chat(src, FONT_COLORED("red","Error: file_spam_check(): Spam. Please wait [round(time_to_wait/10)] seconds."))
		return 1
	fileaccess_timer = world.time + FTPDELAY
	return 0
#undef FTPDELAY

/*   Returns a list of all files (as file objects) in the directory path provided, as well as all files in any subdirectories, recursively!
	The list returned is flat, so all items can be accessed with a simple loop.
	This is designed to work with browse_rsc(), which doesn't currently support subdirectories in the browser cache.*/
/proc/getallfiles(path, remove_folders = TRUE, recursion = TRUE)
	set background = 1
	. = list()
	for(var/f in flist(path))
		if(copytext("[f]", -1) == "/")
			if(recursion)
				. += .("[path][f]")
		else
			. += file("[path][f]")

	if(remove_folders)
		for(var/file in .)
			if(copytext("[file]", -1) == "/")
				. -= file

/**
 * Sanitizes the name of each node in the path.
 *
 * Im case you are wondering when to use this proc and when to use SANITIZE_FILENAME,
 *
 * You use SANITIZE_FILENAME to sanitize the name of a file [e.g. example.txt]
 *
 * You use sanitize_filepath sanitize the path of a file [e.g. root/node/example.txt]
 *
 * If you use SANITIZE_FILENAME to sanitize a file path things will break.
 */
/proc/sanitize_filepath(path)
	. = ""
	var/delimiter = "/" //Very much intentionally hardcoded
	var/list/all_nodes = splittext(path, delimiter)
	for(var/node in all_nodes)
		if(.)
			. += delimiter // Add the delimiter before each successive node.
		. += SANITIZE_FILENAME(node)
