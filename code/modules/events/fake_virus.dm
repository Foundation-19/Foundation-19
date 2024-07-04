/datum/event/fake_virus/start()
	var/list/fake_virus_victims = list()
	for(var/mob/living/carbon/human/victim in GLOB.player_list)
		if(victim.stat != CONSCIOUS)
			continue
		fake_virus_victims += victim

	//first we do hard status effect victims
	var/defacto_min = min(3, length(fake_virus_victims))
	if(defacto_min <= 0)// event will hit 1-3 people by default, but will do 1-2 or just 1 if only those many candidates are available
		return
	for(var/i in 1 to rand(1, defacto_min))
		var/mob/living/carbon/human/hypochondriac = pick_n_take(fake_virus_victims)
		hypochondriac.apply_status_effect(/datum/status_effect/fake_virus)

	//then we do light one-message victims who simply cough or whatever once (have to repeat the process since the last operation modified our candidates list)
	defacto_min = min(5, length(fake_virus_victims))
	if(defacto_min <= 0)
		return
	for(var/i in 1 to rand(1, defacto_min))
		var/mob/living/carbon/human/onecoughman = pick_n_take(fake_virus_victims)
		if(prob(25))//1/4 odds to get a spooky message instead of coughing out loud
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), onecoughman, SPAN_WARNING("[pick("Your head hurts.", "Your head pounds.")]")), rand(3 SECONDS, 15 SECONDS))
		else
			addtimer(CALLBACK(onecoughman, TYPE_PROC_REF(/mob, emote), pick("cough", "sniff", "sneeze")), rand(3 SECONDS, 15 SECONDS))//deliver the message with a slightly randomized time interval so there arent multiple people coughing at the exact same time
