#define STATE_OFF				(1<<0)
#define STATE_IDLE				(1<<1)
#define STATE_AWAITING_ANSWER	(1<<2)
#define STATE_ASH				(1<<3)
#define STATE_CASH				(1<<4)

/obj/scp263
	name = "old telivision"
	desc = "An old black and white television, but you can't quite tell which model it is. The logo THOMSOM appears at the bottom."
	icon = 'icons/scp/scp-263.dmi'

	icon_state = "off"

	health_current = 50
	health_max = 50

	// Config

	///Our Questions and answers list
	var/list/questions_and_answers = list(
		"What SCP has the consistency of peanut butter?" = list("999","Tickle Monster"),
		"What SCP can only move when not being looked at?" = list("173","Statue","Peanut"),
		"What SCP should you never look at?" = list("96","Shy Guy", "151", "painting"),
		"What SCP is the cure?" = list("49", "Plague Doctor", "500"),
		"What is the oldest SCP on site?" = list("173", "Statue", "Peanut"),
		"Where can you find SCP-151?" = list("LCZ", "Light Containment"),
		"Which SCP can phase through walls?" = list("343", "God", "106", "Old Man"),
		"What SCP is a fan of the dark?" = list("106", "Old Man", "280", "Eyes"),
		"What SCP can get really loud?" = list("66", "ball of yarn"),
		"What SCP can become your friend?" = list("131", "eyepod"),
		"Where can you find SCP-096?" = list("HCZ", "Heavy containment"),
		"What SCP can you climb into?" = list("216", "Safe", "1102", "briefcase"),
		"What SCP is a bat?" = list("2398")
	)
	///Possible rewards (weighted list)
	var/list/rewards = list(
		/obj/item/spacecash/bundle/c1 = 4,
		/obj/item/spacecash/bundle/c10 = 3,
		/obj/item/spacecash/bundle/c20 = 3,
		/obj/item/spacecash/bundle/c50 = 2,
		/obj/item/spacecash/bundle/c100 = 2,
		/obj/item/spacecash/bundle/c1000 = 1,
		/obj/item/stack/material/gold = 2,
		/obj/item/towel/fleece = 1
	)

	// Mechanics

	///Our current contestant
	var/mob/living/carbon/human/contestant
	///Our current state
	var/state = STATE_OFF
	///Our 263-1 Mob
	var/mob/living/carbon/scp263_1/current_scp263_1
	///Our copy of QnA list for use with pick n take
	var/list/questions_and_answers_copy = list()
	///What question we are on
	var/current_question
	///How many questions we have asked
	var/question_count
	///Ref to current question fail callback
	var/question_callback_fail
	///Have we cheated (this avoids message spam)
	var/has_cheated = FALSE

//This lets us talk out of the TV
/mob/living/carbon/scp263_1
	name = "strange man in the tv"
	desc = "A male human of Caucasian descent of approximately thirty-five years of age, dressed in a suit that matches a style commonly worn between the years 1959 and 1964."

	universal_speak = TRUE

/obj/scp263/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"old telivision", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"263", //Numerical Designation
	)

	current_scp263_1 = new /mob/living/carbon/scp263_1(src)
	questions_and_answers_copy = questions_and_answers.Copy()

/obj/scp263/Destroy()
	. = ..()
	contestant = null
	qdel(current_scp263_1)

/mob/living/carbon/scp263_1/Initialize()
	. = ..()
	if(!istype(loc, /obj/scp263))
		log_and_message_staff("Instance of SCP-263-1 spawned outside of SCP-263! Queing for deletion!", location = get_turf(src))
		qdel(src)
		return

	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"strange man in the tv", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_EUCLID, //Obj Class
		"263-1", //Numerical Designation
	)

// Mechanics

/obj/scp263/proc/cheated(datum/source, mob/speaker)
	if((speaker && ((speaker == current_scp263_1) || (speaker == contestant))) || has_cheated)
		return

	state = STATE_IDLE
	update_icon()
	has_cheated = TRUE

	current_scp263_1.say(pick("My my, cheating are we?", "Trying to get outside help?", "Couldent answer fair and square could you?"))
	contestant.fire_stacks++
	contestant?.IgniteMob()
	spawn(10 SECONDS)
		current_scp263_1.say(pick("Truly the ethics of the modern generation have gone downhill", "Guess [contestant.client.p_their()] ethics werent as good as we thought", "A shame they were so morally bankrupt."))
		contestant.dust()

		reset_target()
		spawn(5 SECONDS)
			reset_state()

/obj/scp263/proc/check_viewer(datum/source)
	if(!(contestant in viewers(world.view, src)))
		cheated()

/obj/scp263/proc/add_contestant(mob/living/carbon/human/new_contestant)
	if(contestant || !istype(new_contestant))
		return
	contestant = new_contestant
	RegisterSignal(contestant, COMSIG_MOB_HEARD_SPEECH, PROC_REF(cheated))
	RegisterSignal(contestant, COMSIG_MOB_HEARD_WHISPER, PROC_REF(cheated))
	RegisterSignal(contestant, COMSIG_MOVED, PROC_REF(check_viewer))

/obj/scp263/proc/reset_target()
	if(!contestant)
		return

	UnregisterSignal(contestant, COMSIG_MOB_HEARD_SPEECH)
	UnregisterSignal(contestant, COMSIG_MOB_HEARD_WHISPER)
	UnregisterSignal(contestant, COMSIG_MOVED)
	contestant = null

/obj/scp263/proc/reset_state()
	current_question = null
	question_count = 0

	deltimer(question_callback_fail)
	question_callback_fail = null

	questions_and_answers_copy = questions_and_answers.Copy()

	has_cheated = FALSE

	state = STATE_OFF
	update_icon()

/obj/scp263/proc/ask_question()
	question_count++

	current_question = pick_n_take(questions_and_answers_copy)
	current_scp263_1.say("[current_question] You have 45 seconds.")

	state = STATE_AWAITING_ANSWER
	update_icon()

	question_callback_fail = addtimer(CALLBACK(src, PROC_REF(question_fail), TRUE), 45 SECONDS, TIMER_STOPPABLE)

/obj/scp263/proc/question_succeed()
	state = STATE_IDLE
	update_icon()
	if(question_callback_fail)
		deltimer(question_callback_fail)

	if(question_count < 3)
		current_scp263_1.say(pick("Correct!", "Yes, thats right!", "Well done!", "Nicely done!", "I knew you could do it!", "These questions are no match for you!"))
		spawn(5 SECONDS)
			current_scp263_1.say(pick("Now, onto the next one.", "Question number [question_count + 1] is...", "Next question is..."))
			spawn(5 SECONDS)
				ask_question()
	else
		state = STATE_CASH
		update_icon()
		current_scp263_1.say("Congratulations! You have won the cash! Here is your prize!")
		var/reward_path = pickweight(rewards)
		var/obj/reward = new reward_path(get_turf(contestant))
		contestant.put_in_active_hand(reward) ? reward.visible_message(SPAN_NOTICE("[reward] materializes right into your hand!")) : reward.visible_message(SPAN_NOTICE("[reward] materializes under you!"))

		reset_target()
		spawn(5 SECONDS)
			reset_state()

/obj/scp263/proc/question_fail(is_timeout = FALSE)
	state = STATE_ASH
	update_icon()
	deltimer(question_callback_fail)
	var/list/message_list = is_timeout ? list("It appears you are out of time!", "Clocks run out!", "No more time remaining!", "Too little too late!") : list("Oooh so close!", "Incorrect!", "Thats wrong!", "Nope!", "Nice try!")
	current_scp263_1.say(pick(message_list))
	contestant.fire_stacks++
	contestant?.IgniteMob()
	spawn(10 SECONDS)
		state = STATE_IDLE
		update_icon()
		current_scp263_1.say("[pick("Thats a true pity, I really liked that one.", "A shame, I thought they would fare better.", "Their failure is a real pity.")] Lets hope the next contestant can avoid the ash... and get away with the cash!")
		contestant.dust()

		reset_target()
		spawn(8 SECONDS)
			reset_state()

//Overrides

/obj/scp263/hear_talk(mob/M, text, verb, datum/language/speaking)
	if((state != STATE_AWAITING_ANSWER) || (M != contestant))
		return
	for(var/answer in questions_and_answers[current_question])
		if(findtext(text, answer, 1, length(text) + 1))
			question_succeed()
			return
	question_fail()

/obj/scp263/attack_hand(mob/living/carbon/human/M)
	if(!istype(M) || M.a_intent != I_HELP || !is_alive())
		return ..()
	state = STATE_IDLE
	update_icon()

	current_scp263_1.say("Welcome to Cash...or...Ash!")
	spawn(5 SECONDS)
		current_scp263_1.say("Congratulations [M] for becoming our latest contestant on Cash or Ash!")
	spawn(10 SECONDS)
		current_scp263_1.say("You must answer three fiendish questions! I wish you luck in getting cash, and not ash!")
	spawn(15 SECOND)
		current_scp263_1.say("Question number one!")
	spawn(20 SECOND)
		add_contestant(M)
		ask_question()

/obj/scp263/update_icon()
	switch(state)
		if(STATE_OFF)
			icon_state = "off"
		if(STATE_IDLE)
			icon_state = "on"
		if(STATE_AWAITING_ANSWER)
			icon_state = "animation"
		if(STATE_ASH)
			icon_state = "ash"
		if(STATE_CASH)
			icon_state = "cash"
	return ..()

/obj/scp263/handle_death_change(new_death_state)
	if(new_death_state)
		playsound(src, SFX_SHATTER, 70, 1)
		show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
		visible_message(SPAN_WARNING("\The [src]'s screen shatters!"))

		for(var/i = 1 to rand(1,2))
			new /obj/item/material/shard(get_turf(src))
		icon_state = "broken"
	else
		icon_state = "off"

#undef STATE_OFF
#undef STATE_IDLE
#undef STATE_AWAITING_ANSWER
#undef STATE_ASH
#undef STATE_CASH
