//////////////////////////////////////////////////////////////////////////
//This is the file where all the stats and skills procs are kept.		//
//The system is kinda barebones now but I hope to rewrite it to  		//
//be betting in the near future. 								 		//
//																 		//
//Stats are pretty generic, skills are kind of specific. 				//
//You should just be able to plop in the proc call wherever you want.   //
//I tried to make it versitile.											//
// - Matt 																//
//////////////////////////////////////////////////////////////////////////

//defines
#define CRIT_SUCCESS_NORM 5
#define CRIT_FAILURE_NORM 5
#define CRIT_SUCCESS 2
#define CRIT_FAILURE 3


//I am aware this is probably the worst possible way of doing it but I'm using this method till I get a better one. - Matt
/mob
	var/str = 10	//strength - used for hitting and lifting.
	var/dex = 10	//dexterity - used for dodging and parrying.
	var/int = 10
	var/mod = 0.1 //hidden modifier for later use

	//skills
	// When you see the add_skills code in jobs.dm, the random variables are in this order. - Lion
	var/melee_skill = 50
	var/ranged_skill = 50
	var/medical_skill = 20
	var/engineering_skill = 50

	//crit shit
	var/crit_success_chance = CRIT_SUCCESS_NORM
	var/crit_failure_chance = CRIT_FAILURE_NORM
	var/crit_success_modifier = 0
	var/crit_failure_modifier = 0
	var/crit_mood_modifier = 0


/mob/proc/get_success_chance()
	return crit_success_chance + crit_success_modifier + crit_mood_modifier

/mob/proc/get_failure_chance()
	return crit_failure_chance + crit_failure_modifier + crit_mood_modifier




/mob/proc/skillcheck(var/skill, var/requirement, var/show_message, var/message = "I have failed to do this.")//1 - 100
	if(skill >= requirement)//If we already surpass the skill requirements no need to roll.
		if(prob(get_success_chance()))//Only thing we roll for is a crit success.
			return CRIT_SUCCESS
		return 1
	else
		if(prob(skill))//Otherwise we roll to see if we pass.
			if(prob(get_success_chance()))//And again to see if we get a crit scucess.
				return CRIT_SUCCESS
			return 1
		else
		//	if(show_message)//If we don't pass then we return failure
	//			to_chat(src, "<span class = 'warning'>[message]</span>")
			if(prob(get_failure_chance()))//And roll for a crit failure.
				return CRIT_FAILURE
			return 0


/mob/proc/statscheck(var/stat, var/requirement, var/show_message, var/message = "I have failed to do this.")//Requirement needs to be 1 through 20
	if(stat < requirement)
		var/H = rand(1,20)// our "dice"
	//	H += mood_affect(1)// our skill modifier
		if(stat >= H)//Rolling that d20
			//world << "Rolled and passed."
			return 1
		else
		//	if(show_message)//If we fail then print this message and return 0.
	//			to_chat(src, "<span class = 'warning'>[message]</span>")
			return 0
	else
		//world << "Didn't roll and passed."
		return 1
/* sorry matt, mood isn't happening. leaving this intact for a sanity system down the road
//having a bad mood fucks your shit up fam.
/mob/proc/mood_affect(var/stat = null, var/skill = null)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		if(C.happiness <= MOOD_LEVEL_SAD3)
			if(stat)
				return 5
			if(skill)
				return -15
*/

/proc/strToDamageModifier(var/strength, var/modifier)
	return strength * modifier

/proc/strToSpeedModifier(var/strength, var/w_class)//Looks messy. Is messy. Is also only used once. But I don't give a fuuuuuuuuck.
	switch(strength)
		if(1 to 5)
			if(w_class > ITEM_SIZE_NORMAL)
				return 20

		if(6 to 11)
			if(w_class > ITEM_SIZE_NORMAL)
				return 15

		if(12 to 15)
			if(w_class > ITEM_SIZE_NORMAL)
				return 10

		if(16 to INFINITY)
			if(w_class > ITEM_SIZE_NORMAL)
				return 5

/proc/dexToAccuracy(var/dexterity) // i can do this better but lets take this for now
	switch(dexterity)
		if(1 to 3)
			return -8

		if(4 to 6)
			return -4

		if(7 to 10)
			return 0

		if(11 to 13)
			return 1

		if(14 to 16)
			return 2

		if(17 to 20)
			return 3

		if(21 to INFINITY)
			return 4

//Stats helpers.
// When you look at add_stats, they will be in this order as displayed. -Lion
/mob/proc/add_stats(var/stre, var/dexe, var/inti)//To make adding stats quicker.
	if(stre)
		str = stre
	if(dexe)
		dex = dexe
	if(inti)
		int = inti


/mob/proc/adjustStrength(var/num)
	str += num

/mob/proc/adjustDexterity(var/num)
	dex += num

/mob/proc/adjustInteligence(var/num)
	int += num



//Skill helpers.
/mob/proc/skillnumtodesc(var/skill)
	switch(skill)
		if(0 to 25)
			return "<small><i>pathetic</i></small>"
		if(25 to 45)
			return "unskilled"
		if(45 to 60)
			return pick("alright", "ok", "not bad")
		if(60 to 80)
			return "skilled"
		if(80 to INFINITY)
			return "<b>GOD LIKE</b>"

/mob/proc/add_skills(var/melee, var/ranged, var/medical, var/engineering)//To make adding skills quicker.
	if(melee)
		melee_skill = melee
	if(ranged)
		ranged_skill = ranged
	if(medical)
		medical_skill = medical
	if(engineering)
		engineering_skill = engineering
