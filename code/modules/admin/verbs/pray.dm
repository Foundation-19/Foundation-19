/mob/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"

	sanitize_and_communicate(/decl/communication_channel/pray, src, msg)
	SSstatistics.add_field_details("admin_verb","PR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

// TODO: merge these two and move to different folder
/proc/Centcomm_announce(msg, mob/Sender)
	var/list/mob/living/silicon/ai/intercepters = check_for_interception()

	if(intercepters.len)
		for(var/thing in intercepters)
			var/mob/living/silicon/ai/ai = thing

			var/action = tgui_alert(ai, "Outgoing message from [sender]:\n", "Message Intercepted", list("Modify", "Block", "Allow"), timeout = 30 SECONDS)

			switch(action)
				if("Modify")
					msg = tgui_input_text(ai, "Set new message (from [sender]):", "Modify Message" default = msg)
				if("Block")
					return

	msg = SPAN_NOTICE("<b><font color=orange>[uppertext(GLOB.using_map.boss_short)]M:</font>[key_name(Sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) ([admin_jump_link(Sender)]) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder;CentcommReply=\ref[Sender]'>RPLY</A>):</b> [msg]")
	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, msg)
			sound_to(C, 'sounds/machines/signal.ogg')

/proc/Syndicate_announce(msg, mob/Sender)
	msg = SPAN_NOTICE("<b><font color=crimson>ILLEGAL:</font>[key_name(Sender, 1)] (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) (<A HREF='?_src_=holder;narrateto=\ref[Sender]'>DN</A>) ([admin_jump_link(Sender)]) (<A HREF='?_src_=holder;secretsadmin=check_antagonist'>CA</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder'>TAKE</a>) (<A HREF='?_src_=holder;SyndicateReply=\ref[Sender]'>RPLY</A>):</b> [msg]")
	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, msg)
			sound_to(C, 'sounds/machines/signal.ogg')
