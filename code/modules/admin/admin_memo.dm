#define ADMIN_MEMO_FILE "data/admin_memo.sav"	//where the memos are saved

//switch verb so we don't spam up the verb lists with like, 3 verbs for this feature.
/client/proc/admin_memo(task in list("write","show","delete"))
	set name = "Admin Memo"
	set category = "Admin"

	if(config.enable_memos)
		if(!check_rights(R_ADMIN|R_MOD))
			return
		switch(task)
			if("write")		admin_memo_write()
			if("show")		admin_memo_show()
			if("delete")	admin_memo_delete()

/client/proc/admin_memo_write()
	var/savefile/F = new(ADMIN_MEMO_FILE)
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
		message_admins("[key] set an admin memo:<br>[memo]")

/client/proc/admin_memo_show()
	if(config.enable_memos)
		var/savefile/F = new(ADMIN_MEMO_FILE)
		if(F)
			if(!F.dir.len)
				to_chat(src, SPAN_NOTICE("No memos found."))
				return
			for(var/ckey in F.dir)
				to_chat(src, "<center><span class='motd'><b>Admin Memo</b><i> by [F[ckey]]</i></span></center>")
		else
			to_chat(src, SPAN_NOTICE("No memos found."))

/client/proc/admin_memo_delete()
	var/savefile/F = new(ADMIN_MEMO_FILE)
	if(F)
		var/ckey
		if(check_rights(R_SERVER,0))	//high ranking admins can delete other admin's memos
			ckey = input(src,"Whose memo shall we remove?","Remove Memo",null) as null|anything in F.dir
		else
			ckey = src.ckey
		if(ckey)
			F.dir.Remove(ckey)
			to_chat(src, "<b>Removed memo created by [ckey].</b>")
			message_admins("[src] removed an admin memo created by [ckey].")

#undef ADMIN_MEMO_FILE
