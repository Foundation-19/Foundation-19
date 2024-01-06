/*
//////////////////////////////////////

Alien Hand Syndrome

	Quite noticeable.
	Resistant.
	Increases stage speed.
	Reduces transmittablity.
	Medium Level.

//////////////////////////////////////
*/

/datum/symptom/alien_hand
	name = "Alien Hand Syndrome"
	desc = "The virus causes its host's hands to act on their own, without conscious control over actions."
	stealth = -2
	resistance = 3
	stage_speed = 1
	transmittable = -2
	level = 5
	severity = 2
	symptom_delay_min = 5
	symptom_delay_max = 25
	threshold_descs = list(
		"Stage Speed 9" = "Increases frequency of actions.",
	)

/datum/symptom/alien_hand/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stage_rate"] >= 9)
		symptom_delay_min = 4
		symptom_delay_max = 16

/datum/symptom/alien_hand/Activate(datum/disease/advance/A)
	if(!..())
		return
	if(A.stage < 4)
		return
	var/mob/living/carbon/human/H = A.affected_mob
	var/list/random_atoms = list()
	var/view_range = 1
	// Shoot some people >:)
	if(istype(H.get_active_hand(), /obj/item/gun))
		view_range = 5
	for(var/atom/movable/AA in view(view_range, H))
		var/act_prob = 1
		// There's generally way too many random things lying around compared to rare humans
		if(isliving(A))
			act_prob = 10
		random_atoms[AA] = act_prob
	if(!LAZYLEN(random_atoms))
		return
	var/atom/movable/AA = pickweight(random_atoms)
	if(isliving(AA))
		admin_attack_log(H, AA, "Alien Hand Syndrome activated", "Has been targeted by alien hand syndrome")
	H.ClickOn(AA)
