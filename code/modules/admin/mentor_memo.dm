#define MENTOR_MEMO_FILE "data/mentor_memo.sav"	//where the memos are saved

/client/proc/mentor_memo()
	set name = "Mentor Memo"
	set category = "Admin"

	if(config.enable_memos)
		if(!check_rights(0))
			return

		if(holder.rights == R_MENTOR) //If we are only a mentor, we cannot change the memo
			mentor_memo_show()
			return
		switch(input(usr) in list("write", "show", "delete"))
			if("write")		mentor_memo_write()
			if("show")		mentor_memo_show()
			if("delete")	mentor_memo_delete()

/client/proc/mentor_memo_write()
	var/savefile/F = new(MENTOR_MEMO_FILE)
	if(F)
		var/memo = sanitize(input(src,"Type your memo\n(Leaving it blank will delete your current memo):","Write Memo",null) as null|message, extra = 0)
		switch(memo)
			if(null)
				return
			if("")
				F.dir.Remove(ckey)
				to_chat(src, SPAN_BOLD("Memo removed."))
				return
		if(findtext(memo,"<script",1,0) )
			return
		to_save(F[ckey], "[key] on [time2text(world.realtime,"(DDD) DD MMM hh:mm")]<br>[memo]")
		message_admins("[key] set a mentor memo:<br>[memo]")

/client/proc/mentor_memo_show()
	if(config.enable_memos)
		var/savefile/F = new(MENTOR_MEMO_FILE)
		if(F)
			if(!F.dir.len)
				to_chat(src, SPAN_NOTICE("No memos found."))
				return
			for(var/ckey in F.dir)
				to_chat(src, "<center><span class='motd'><b>Mentor Memo</b><i> by [F[ckey]]</i></span></center>")
		else
			to_chat(src, SPAN_NOTICE("No memos found."))

/client/proc/mentor_memo_delete()
	var/savefile/F = new(MENTOR_MEMO_FILE)
	if(F)
		var/ckey
		if(check_rights(R_SERVER,0))	//high ranking admins can delete other admin's memos
			ckey = input(src,"Whose memo shall we remove?","Remove Memo",null) as null|anything in F.dir
		else
			ckey = src.ckey
		if(ckey)
			F.dir.Remove(ckey)
			to_chat(src, "<b>Removed memo created by [ckey].</b>")
			message_admins("[src] removed a mentor memo created by [ckey].")

#undef MENTOR_MEMO_FILE
