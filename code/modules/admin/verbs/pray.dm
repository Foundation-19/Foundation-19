/mob/verb/pray(msg as text)
	set category = "IC"
	set name = "Pray"

	sanitize_and_communicate(/decl/communication_channel/pray, src, msg)
	SSstatistics.add_field_details("admin_verb","PR") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/Centcomm_announce(msg, mob/Sender, iamessage)
	var/mob/intercepted = check_for_interception()
	msg = SPAN_NOTICE("<b><font color=orange>[uppertext(GLOB.using_map.boss_short)]M[iamessage ? " IA" : ""][intercepted ? "(Intercepted by [intercepted])" : null]</font>: [ADMIN_FULLMONTY(Sender)] [ADMIN_CENTCOM_REPLY(Sender)]:</b> [msg]")
	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, msg)
			sound_to(C, 'sounds/machines/signal.ogg')

/proc/Syndicate_announce(msg, mob/Sender)
	var/mob/intercepted = check_for_interception()
	msg = SPAN_NOTICE("<b><font color=crimson>ILLEGAL[intercepted ? "(Intercepted by [intercepted])" : null]</font>: [ADMIN_FULLMONTY(Sender)] [ADMIN_SYNDICATE_REPLY(Sender)]:</b> [msg]")
	for(var/client/C in GLOB.admins)
		if(R_MOD & C.holder.rights)
			to_chat(C, msg)
			sound_to(C, 'sounds/machines/signal.ogg')
