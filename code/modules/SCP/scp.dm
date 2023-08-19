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

/datum/scp/New(atom/creation, vName, vClass = SAFE, vDesg, vMetaFlags)
	GLOB.SCP_list += creation

	name = "\improper [vName]" //names are now usually captalized improper descriptors to fit the theme of SCP since people dont just know the scp desg off the bat. As such we need to improper it. TODO: add mental mechanic for foundation workers to see desg instead of name.
	designation = vDesg
	classification = vClass
	metaFlags = vMetaFlags

	parent = creation

	parent.SetName(name)

	if(classification == SAFE)
		set_faction(parent, MOB_FACTION_NEUTRAL)
	else
		set_faction(parent, FACTION_SCPS)

	if(ismob(parent))
		var/mob/pMob = parent
		pMob.fully_replace_character_name(name)

		if(metaFlags & PLAYABLE)
			pMob.status_flags += NO_ANTAG

	if(metaFlags & SCP_PLACEHOLDER)
		log_and_message_staff("Placeholder SCP-[designation] spawned and subsequently deleted! Do not spawn placeholders!", location = get_turf(parent))
		qdel(parent)
		return

	onGain()

/datum/scp/Destroy()
	. = ..()
	if(LAZYLEN(GLOB.SCP_list))
		GLOB.SCP_list -= src
	parent = null

///Run only after adding appropriate flags for components.
/datum/scp/proc/compInit() //if more comps are added for SCPs, they can be put here
	if(metaFlags & SCP_PLACEHOLDER)
		return
	if(metaFlags & MEMETIC)
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

/datum/scp/proc/onGain()

/datum/scp/proc/onLose()

/atom/proc/canBeSCP(datum/scp/SCP_)
	return SCP_.isCompatible(src)
