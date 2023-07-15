/datum/scp

	///SCP name
	var/name
	///SCP Designation (i.e 173 or 096)
	var/designation
	///SCP Class (SAFE, EUCLID, ETC.)
	var/classification

	///Meta Flags for the SCP
	var/metaFlags

	///Flags that determine how a memetic scp is detected
	var/memeticFlags

	///Datum Parent
	var/atom/parent

	///Components
	var/datum/component/memetic/meme_comp

	///Proc called as an effect from memetic scps
	var/memetic_proc

/datum/scp/New(atom/creation, vName, vClass = SAFE, vDesg = trimSCP(vName), vMetaFlags)
	GLOB.SCP_list += creation

	name = vName
	designation = vDesg
	classification = vClass
	metaFlags = vMetaFlags

	parent = creation
	to_world_log("[creation] is now parent of [src]")

	parent.SetName(name)
	onGain()

/datum/scp/Destroy()
	. = ..()
	if(LAZYLEN(GLOB.SCP_list))
		GLOB.SCP_list -= src
	parent = null

///Run only after adding appropriate flags for components.
/datum/scp/proc/compInit() //if more comps are added for SCPs, they can be put here
	if(metaFlags & MEMETIC)
		meme_comp = parent.AddComponent(/datum/component/memetic, parent, memeticFlags, memetic_proc)

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

/atom/proc/isSCP(A)
	if(A)
		if(SCP.designation == A)
			return 1
	else
		if(SCP)
			return 1

/atom/proc/removeSCP(A)
	if(!SCP)
		return 0
	if(A)
		if(ispath(A) && (SCP.type == A))
			SCP.Remove()
			return 1
		if(ispath(GLOB.SCP_list[A] && (SCP.type == GLOB.SCP_list[A])))
			SCP.Remove()
			return 1
	else
		SCP.Remove()
		return 1
