/datum/scp
	///SCP name
	var/name
	///SCP Designation (i.e 173 or 096)
	var/designation
	///SCP Class (SAFE, EUCLID, ETC.)
	var/classification

	///Meta Flags for the SCP
	var/metaFlags

	///Datum Parent
	var/atom/parent

	//Playable SCP vars

	///How many players do we need on for this SCP to be playable
	var/min_playercount = 0
	///How much time has to have passed for this SCP to become playable
	var/min_time = 0

	//Components

	///Memetic Component
	var/datum/component/memetic/meme_comp

	//Memetic Comp Vars

	///Proc called as an effect from memetic scps
	var/memetic_proc
	///Flags that determine how a memetic scp is detected
	var/memeticFlags
	///Sounds that are considered memetic
	var/list/memetic_sounds

	/// If this SCP can still be examined as normal
	var/regular_examine = FALSE

/datum/scp/New(atom/creation, vName, vClass = SCP_SAFE, vDesg, vMetaFlags)
	GLOB.SCP_list += creation

	name = vName //names are now usually captalized improper descriptors to fit the theme of SCP since people dont just know the scp desg off the bat. As such we need to improper it. TODO: add mental mechanic for foundation workers to see desg instead of name.
	designation = vDesg
	classification = vClass
	metaFlags = vMetaFlags

	parent = creation

	if(LAZYLEN(name))
		parent.SetName(name)

	if(classification == SCP_SAFE)
		set_faction(parent, MOB_FACTION_NEUTRAL)
	else
		set_faction(parent, FACTION_SCPS)

	if(ismob(parent))
		var/mob/pMob = parent
		if(LAZYLEN(name))
			pMob.fully_replace_character_name(name)
		pMob.status_flags += NO_ANTAG

	if(metaFlags & SCP_DISABLED)
		log_and_message_staff("Disabled SCP-[designation] spawned and subsequently deleted! Do not spawn disabled SCPs!", location = get_turf(parent))
		qdel(parent)
		return

	RegisterSignal(parent, COMSIG_ATOM_EXAMINED, PROC_REF(OnExamine))
	onGain()

/datum/scp/Destroy()
	. = ..()
	GLOB.SCP_list -= src
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINED)
	parent = null

///Run only after adding appropriate flags for components.
/datum/scp/proc/compInit() //if more comps are added for SCPs, they can be put here
	if(metaFlags & SCP_DISABLED)
		return
	if(metaFlags & SCP_MEMETIC)
		meme_comp = parent.AddComponent(/datum/component/memetic, memeticFlags, memetic_proc, memetic_sounds)

/datum/scp/proc/isCompatible(atom/A)
	return 1

/datum/scp/proc/Remove()
	if(parent)
		onLose()
		parent.TakeComponent(meme_comp)
		parent.SCP = null
		qdel(src)

	else
		qdel(src)

///For when an SCP object is examined, we send the examinee a message about the SCP's designation if they should know what SCP it is.
/datum/scp/proc/OnExamine(datum/source, mob/examinee)
	SIGNAL_HANDLER
	if(!ishuman(examinee))
		return
	var/mob/living/carbon/human/H = examinee
	var/datum/job/job = SSjobs.get_by_title(H.job)
	if(job && (job.department_flag & (COM|SCI|SEC)))
		to_chat(examinee, SPAN_CLASS("scp", "You know this is SCP-[designation]!"))

/datum/scp/proc/has_minimum_players()
	return length(GLOB.clients) >= min_playercount

/datum/scp/proc/onGain()

/datum/scp/proc/onLose()

/atom/proc/canBeSCP(datum/scp/SCP_)
	return SCP_.isCompatible(src)

// Chat for SCP
/client/verb/scp_say(message as text)
	set category = "OOC"
	set name = "SCP say"
	if(src.mob in GLOB.SCP_list)
		for(var/mob/A in GLOB.SCP_list)
			if(A.client)
				to_chat(A, SPAN_DANGER("<B><strong>[src.mob]:</strong></B> <span class='message linkify'>[message]</span>"))
	else
		to_chat(src, SPAN_WARNING("You must be SCP!"))
		return
