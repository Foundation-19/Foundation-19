/datum/status_effect/fake_virus
	id = "fake_virus"
	duration = 1800//3 minutes
	status_type = STATUS_EFFECT_REPLACE
	tick_interval = 1
	alert_type = null
	var/msg_stage = 0//so you dont get the most intense messages immediately

/datum/status_effect/fake_virus/tick()
	var/fake_msg = ""
	var/fake_emote = ""
	switch(msg_stage)
		if(0 to 300)
			if(prob(1))
				fake_msg = pick(
				SPAN_WARNING(pick("Your head hurts.", "Your head pounds.")),
				SPAN_WARNING(pick("You're having difficulty breathing.", "Your breathing becomes heavy.")),
				SPAN_WARNING(pick("You feel dizzy.", "Your head spins.")),
				SPAN_WARNING(pick("You swallow excess mucus.", "You lightly cough.")),
				SPAN_WARNING(pick("Your head hurts.", "Your mind blanks for a moment.")),
				SPAN_WARNING(pick("Your throat hurts.", "You clear your throat.")))
		if(301 to 600)
			if(prob(2))
				fake_msg = pick(
				SPAN_WARNING(pick("Your head hurts a lot.", "Your head pounds incessantly.")),
				SPAN_WARNING(pick("Your windpipe feels like a straw.", "Your breathing becomes tremendously difficult.")),
				SPAN_WARNING("You feel very [pick("dizzy","woozy","faint")]."),
				SPAN_WARNING(pick("You hear a ringing in your ear.", "Your ears pop.")),
				SPAN_WARNING("You nod off for a moment."))
		else
			if(prob(3))
				if(prob(50))// coin flip to throw a message or an emote
					fake_msg = pick(
					SPAN_USERDANGER(pick("Your head hurts!", "You feel a burning knife inside your brain!", "A wave of pain fills your head!")),
					SPAN_USERDANGER(pick("Your lungs hurt!", "It hurts to breathe!")),
					SPAN_WARNING(pick("You feel nauseated.", "You feel like you're going to throw up!")))
				else
					fake_emote = pick("cough", "sniff", "sneeze")

	if(fake_emote)
		owner.emote(fake_emote)
	else if(fake_msg)
		to_chat(owner, fake_msg)

	msg_stage++
