/datum/event/email_spam
	endWhen = 1 HOUR
	var/next_spam_time = 0

/datum/event/email_spam/setup()
	next_spam_time = world.time

/datum/event/email_spam/tick()
	if(world.time > (next_spam_time + 5 MINUTES))
		//if there's no spam managed to get to receiver for five minutes, give up
		kill()
		return

	if(prob(5))

		var/datum/computer_file/data/email_message/message = new()
		message.spam = TRUE

		switch(rand(1,7))
			if(1)
				message.source = "[rand(11111,99999)]@maxbet.com"
				message.title = "There is no better time to register!"
				message.stored_data = "Triple deposits are waiting for you at MaxBet Online!\
					\nYou can qualify for a 200% Welcome Bonus when you sign up today.\
					\nOnce you are a player with MaxBet, you will also receive lucrative weekly and monthly promotions.\
					\nYou will be able to enjoy over 450 top-flight casino games at MaxBet. Join today!"
			if(2)
				message.source = "[rand(11111,99999)]@quickdating.com"
				var/rand_descriptors = pick("Blonde", "Redheaded", "Russian", "Asian")
				message.title = pick("Find your [rand_descriptors] bride today!","[rand_descriptors] beauties are waiting!","Find your secret [rand_descriptors] crush!")
				message.stored_data = "Your profile caught my attention and I wanted to write and say hello (QuickDating).\
					\nIf you will write to me on my email [pick(GLOB.first_names_female)]@[pick(GLOB.last_names)].[pick("ru","ck","tj","ur","nt")] I shall necessarily send you a photo (QuickDating).\
					\nI want that we write each other and I hope, that you will like my profile and you will answer me (QuickDating).\
					\nYou have ([rand(1,3)]) new messages! You have ([rand(2,5)]) new profile views!"
			if(3)
				message.source = "[rand(11111,99999)]@wetskrell.com"
				message.title = "Bored? Feeling Lonely?"
				message.stored_data = "WetSkrell.com is a xenophillic website for paid use.\
					\nWetskrell.com only provides the higest quality of male entertaiment to customers.\
					\nSimply enter your bank account system number and pin. With three easy steps this service could be yours!"
			if(4)
				message.source = "[rand(11111,99999)]@ekfo.com.co"
				message.title = "Having dysfuctional troubles?"
				message.stored_data = "DR MAXMAN: REAL Doctors, REAL Science, REAL Results!\
					\nDr. Maxman was created by George Acuilar, M.D, a Certified Urologist who has treated over 70,000 patients worldwide with 'male problems'.\
					\nAfter seven years of research, Dr Acuilar and his team came up with this simple breakthrough male enhancement formula.\
					\nSimply deposit 500 dollars for AMAZING increases in length, width and stamina!"
			if(5)
				message.source = "[rand(11111,99999)]@ekfo.com.co"
				message.title = "[pick("Dr","Crown prince","King Regent","Professor","Captain")] \
					[pick("Robert","Alfred","Josephat","Kingsley","Sehi","Zbahi")] \
					[pick("Mugawe","Nkem","Gbatokwia","Nchekwube","Ndim","Ndubisi")]"
				message.stored_data = "Greetings sir, I regretfully to inform you that as I lay dying here due to my lack ofheirs I have chosen you to recieve the full sum of my lifetime savings of 1.5 billion dollars.\
					\nDue to my lack of agents I require immediate financial transaction to immediately deposit the sum of 1 POINT FIVE MILLION dollars.\
					\nPlease transfer 500 dollars within 30 days. DO NOT TELL or sum may be stolen!!"
			if(6)
				message.source = "[rand(11111,99999)]@ekfo.com.co"
				message.title = pick("National Payments Association","Better Business Bureau","Nyx E-Payments")
				message.stored_data = pick("Luxury watches for Blowout sale prices!\
					\nWatches, Jewelry & Accessories, Bags & Wallets !",\
					"Deposit $100 and get $300 totally free!",\
					"We have been filed with a complaint from one of your customers in respect of their business relations with you.\
					\nWe kindly ask you to open the COMPLAINT REPORT (attached) to reply on this complaint..")
			if(7)
				message.source = "[rand(11111,99999)]@ekfo.com.co"
				message.title = pick("You have won free tickets!","Click here to claim your prize!","You are the 1000th vistor!","You are our lucky grand prize winner!")
				message.stored_data = "[pick("You have won tickets to the newest ACTION JAXSON MOVIE!",\
					"You have won tickets to the newest crime drama DETECTIVE MYSTERY IN THE CLAMITY CAPER!",\
					"You have won tickets to the newest romantic comedy 16 RULES OF LOVE!",\
					"You have won tickets to the newest thriller THE CULT OF THE SLEEPING ONE!")]\
					\nDownload digital tickets NOW before they expire!"

		var/datum/computer_file/data/email_account/recipient = pick(ntnet_global.email_accounts)
		recipient.receive_mail(message, 0)

		// more players divides additional time (which means more spam more often). scaled logarithmically
		next_spam_time = world.time + (rand(5 MINUTES, 7 MINUTES) / ((GLOB.player_list.len > 5) ? (log(GLOB.player_list.len)): 1))
