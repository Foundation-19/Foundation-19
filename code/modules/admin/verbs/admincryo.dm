/client/proc/cmd_admin_cryo(mob/living/M as mob in GLOB.living_mob_list_)
	set category = "Special Verbs"

	set name = "Admin Cryo"
	if(!check_rights(R_MOD))
		src << "Only moderators may use this command."
		return
	if(!istype(M))
		alert("Cannot cryo a ghost")
		return

	var/confirm = alert(src, "You will be removing [M] from the round, are you sure?", "Message", "Yes", "No")
	if(confirm != "Yes")
		return
	if (usr.client)
		if(usr.client.holder)

			for(var/obj/item/card/id/Z in M)
				qdel(Z)
			for(var/obj/item/device/pda/Y in M)
				qdel(Y)
			for(var/obj/item/clothing/under/X in M)
				qdel(X)
			for(var/obj/item/organ/V in M)
				qdel(V)

			// important
			M.forceMove(null)

			if(M.mind)
				if(M.mind.assigned_job)
					M.mind.assigned_job.clear_slot()

				if(M.mind.objectives.len)
					M.mind.objectives = null
					M.mind.special_role = null

			message_admins("\blue [key_name_admin(usr)] has admin cryoed [key_name(M)]")
			log_admin("[key_name(usr)] admin cryoed [key_name(M)]")

			// remove the mob from crew records
			var/sanitized_name = M.real_name
			sanitized_name = sanitize(sanitized_name)
			var/datum/computer_file/report/crew_record/R = get_crewmember_record(sanitized_name)
			if(R)
				qdel(R)


			// remove the mob from client2mob
			// Delete the mob.
			var/mob/observer/ghost/g = find_dead_player(M.last_ckey, TRUE)
			M.ckey = null
			if(!g) // Player didn't ghost. Ghost then delete.
				g = M.ghostize(FALSE)
			g?.skip_respawn_timer = TRUE
			// delete the mob
			qdel(M)
