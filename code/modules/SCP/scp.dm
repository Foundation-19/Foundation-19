#define SAFE 1
#define EUCLID 2
#define KETER 3
#define THAUMIEL 4
#define NEUTRALIZED 5

/datum/scp
	var/name = "SCP-NULL"
	var/designation = "0"
	var/classification = SAFE
	var/datum/component/scp/component //You don't have to use this, but it's really nice for smaller SCP's so you can make them SCP whenever you want
	var/atom/owner

/datum/scp/New(atom/creation)
	creation.makeSCP()

/datum/scp/Destroy()
	. = ..()
	if(GLOB.SCP_list.len)
		GLOB.SCP_list -= src

/datum/scp/proc/SCPinit(atom/A)
	if(!isatom(A))
		return
	owner = A

	if(component)
		component = A.AddComponent(component,src,owner)

/datum/scp/proc/isCompatible(atom/A)
	return 1

/datum/scp/proc/Remove()
	if(owner)
		onLose()
		owner.TakeComponent(component)
		owner.SCP = null
		qdel(src)

	else
		qdel(src)

/datum/scp/proc/onGain()

/datum/scp/proc/onLose()

/atom/proc/makeSCP()
	GLOB.SCP_list += src
//	if(ispath(c))
//		SCP = new SCP()
	SCP.SCPinit(src)
	SCP.onGain()
	return 1

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
