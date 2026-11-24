
//////////////////////////
//   ORION TRAIL HERE   //
//////////////////////////

//Orion Trail Events
#define ORION_TRAIL_RAIDERS				"Vox Raiders"
#define ORION_TRAIL_FLUX				"Interstellar Flux"
#define ORION_TRAIL_ILLNESS				"Illness"
#define ORION_TRAIL_BREAKDOWN			"Breakdown"
#define ORION_TRAIL_MUTINY				"Mutiny?"
#define ORION_TRAIL_MUTINY_ATTACK 		"Mutinous Ambush"
#define ORION_TRAIL_MALFUNCTION			"Malfunction"
#define ORION_TRAIL_COLLISION			"Collision"
#define ORION_TRAIL_SPACEPORT			"Spaceport"
#define ORION_TRAIL_DISASTER			"Disaster"
#define ORION_TRAIL_SPACEPORT_RAIDED	"Raided Spaceport"
#define ORION_TRAIL_DERELICT			"Derelict Spacecraft"
#define ORION_TRAIL_CARP				"Carp Migration"
#define ORION_TRAIL_STUCK				"Stuck!"
#define ORION_TRAIL_START				"Start"
#define ORION_TRAIL_GAMEOVER			"Gameover!"


#define ORION_VIEW_MAIN			0
#define ORION_VIEW_SUPPLIES		1
#define ORION_VIEW_CREW			2


/obj/machinery/computer/arcade/orion_trail
	name = "orion trail"
	desc = "Imported straight from Outpost-T71!"
	icon_state = "arcade"
	random = FALSE
	machine_name = "orion trail arcade machine"
	var/list/supplies = list("1" = 0, "2" = 0, "3" = 0, "4" = 0, "5" = 0, "6" = 0) //engine,hull,electronics,food,fuel
	var/list/supply_cost = list("1" = 1000, "2" = 950, "3" = 1100, "4" = 75, "5" = 100)
	var/list/supply_name = list("1" = "engine parts", "2" = "hull parts", "3" = "electronic parts", "4" = "food", "5" = "fuel", "6" = "thalers")
	var/list/settlers = list()
	var/num_traitors = 0
	var/list/events = list(ORION_TRAIL_RAIDERS		= 3,
						   ORION_TRAIL_FLUX			= 1,
						   ORION_TRAIL_ILLNESS		= 3,
						   ORION_TRAIL_BREAKDOWN	= 2,
						   ORION_TRAIL_MUTINY		= 3,
						   ORION_TRAIL_MALFUNCTION	= 2,
						   ORION_TRAIL_COLLISION	= 1,
						   ORION_TRAIL_CARP			= 3
						   )
	var/list/stops = list("Pluto","Asteroid Belt","Proxima Centauri","Dead Space","Rigel Prime","Tau Ceti Beta","Black Hole","Space Outpost Beta-9","Orion Prime")
	var/list/stopblurbs = list(
		"Pluto, long since occupied with long-range sensors and scanners, stands ready to, and indeed continues to probe the far reaches of the galaxy.",
		"At the edge of the Sol system lies a treacherous asteroid belt. Many have been crushed by stray asteroids and misguided judgement.",
		"The nearest star system to Sol, in ages past it stood as a reminder of the boundaries of sub-light travel, now a low-population sanctuary for adventurers and traders.",
		"This region of space is particularly devoid of matter. Such low-density pockets are known to exist, but the vastness of it is astounding.",
		"Rigel Prime, the center of the Rigel system, burns hot, basking its planetary bodies in warmth and radiation.",
		"Tau Ceti Beta has recently become a waypoint for colonists headed towards Orion. There are many ships and makeshift stations in the vicinity.",
		"Sensors indicate that a black hole's gravitational field is affecting the region of space we were headed through. We could stay of course, but risk of being overcome by its gravity, or we could change course to go around, which will take longer.",
		"You have come into range of the first man-made structure in this region of space. It has been constructed not by travellers from Sol, but by colonists from Orion. It stands as a monument to the colonists' success.",
		"You have made it to Orion! Congratulations! Your crew is one of the few to start a new foothold for mankind!"
		)
	var/list/stop_distance = list(10000,7000,25000,9000,5000,30000,25000,10000,0)
	var/event = null
	var/event_title = ""
	var/event_desc = ""
	var/event_actions = ""
	var/event_info = ""
	var/distance = 0
	var/port = 0
	var/view = 0

/obj/machinery/computer/arcade/orion_trail/proc/newgame(emag = 0)
	SetName("orion trail[emag ? ": Realism Edition" : ""]")
	supplies = list("1" = 1, "2" = 1, "3" = 1, "4" = 60, "5" = 20, "6" = 5000)
	emagged = emag
	distance = 0
	settlers = list("[usr]")
	for(var/i=0; i<3; i++)
		if(prob(50))
			settlers += pick(GLOB.first_names_male)
		else
			settlers += pick(GLOB.first_names_female)
	num_traitors = 0
	event = ORION_TRAIL_START
	port = 0
	view = ORION_VIEW_MAIN

/obj/machinery/computer/arcade/orion_trail/tgui_interact(mob/user, datum/tgui/ui)
	if(event == null)
		newgame()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OrionTrail", "Arcade")
		ui.open()

/obj/machinery/computer/arcade/orion_trail/tgui_data(mob/user)
	var/list/data = list()
	var/list/actions = list()
	var/title = event
	var/desc = event_desc
	var/info = event_info
	switch(view)
		if(ORION_VIEW_MAIN)
			if(event == ORION_TRAIL_START) //new game? New game.
				data["start"] = TRUE
				data["title"] = "Orion Trail[emagged ? ": Realism Edition" : ""]"
				data["desc"] = "Learn how our ancestors got to Orion, and have fun in the process!"
				data["actions"] = list(list("action" = "continue", "label" = "Start New Game"))
				data["view"] = view
				return data
			actions = list(list("action" = "continue", "label" = "Continue your journey"))
			switch(event)
				if(ORION_TRAIL_GAMEOVER)
					info = ""
					actions = list(list("action" = "continue", "label" = "Start New Game"))
				if(ORION_TRAIL_SPACEPORT)
					title += ": [stops[port]]"
					desc = "[stopblurbs[port]]"
					info = ""
					if(port == 9)
						actions = list(list("action" = "continue", "label" = "Return to the title screen!"))
					else
						actions = list(
							list("action" = "continue", "label" = "Shove off"),
							list("action" = "attack", "label" = "Raid Spaceport"),
						)
				if(ORION_TRAIL_SPACEPORT_RAIDED)
					title += ": [stops[port]]"
					actions = list(list("action" = "continue", "label" = "Shove off"))
				if(ORION_TRAIL_RAIDERS)
					desc = "You arm yourselves as you prepare to fight off the vox menace!"
				if(ORION_TRAIL_DERELICT)
					desc = "You come across an unpowered ship drifting slowly in the vastness of space. Sensors indicate there are no lifeforms aboard."
				if(ORION_TRAIL_ILLNESS)
					desc = "A disease has spread amoungst your crew!"
				if(ORION_TRAIL_FLUX)
					desc = "You've entered a turbulent region. Slowing down would be better for your ship but would cost more fuel."
					actions = list(
						list("action" = "continue", "label" = "Continue as normal", "risky" = 25),
						list("action" = "continue", "label" = "Take it slow", "slow" = 1),
					)
				if(ORION_TRAIL_MALFUNCTION)
					info = ""
					desc = "The ship's computers are malfunctioning! You can choose to fix it with a part or risk something going awry."
					actions = list(list("action" = "continue", "label" = "Continue as normal", "risky" = 25))
					if(supplies["3"] != 0)
						actions += list(list("action" = "continue", "label" = "Fix using a part.", "fix" = "3"))
				if(ORION_TRAIL_COLLISION)
					info = ""
					desc = "Something has hit your ship and breached the hull! You can choose to fix it with a part or risk something going awry."
					actions = list(list("action" = "continue", "label" = "Continue as normal", "risky" = 25))
					if(supplies["2"] != 0)
						actions += list(list("action" = "continue", "label" = "Fix using a part.", "fix" = "2"))
				if(ORION_TRAIL_BREAKDOWN)
					info = ""
					desc = "The ship's engines broke down! You can choose to fix it with a part or risk something going awry."
					actions = list(list("action" = "continue", "label" = "Continue as normal", "risky" = 25))
					if(supplies["1"] != 0)
						actions += list(list("action" = "continue", "label" = "Fix using a part.", "fix" = "1"))
				if(ORION_TRAIL_STUCK)
					desc = "You've ran out of fuel. Your only hope to survive is to get refueled by a passing ship, if there are any."
					if(supplies["5"] == 0)
						actions = list(list("action" = "continue", "label" = "Wait", "food" = 1))
				if(ORION_TRAIL_CARP)
					desc = "You've chanced upon a large carp migration! Known both for their delicious meat as well as their bite, you and your crew arm yourselves for a small hunting trip."
				if(ORION_TRAIL_MUTINY)
					desc = "You've been hearing rumors of dissenting opinions and missing items from the armory..."
				if(ORION_TRAIL_MUTINY_ATTACK)
					desc = "Oh no, some of your crew are attempting to mutiny!!"
			data["title"] = title
			data["desc"] = desc
			data["info"] = info
			data["distance"] = distance
			data["actions"] = actions
		if(ORION_VIEW_SUPPLIES)
			data["title"] = "Supplies"
			data["desc"] = "View your supplies or buy more when at a spaceport."
			data["currency"] = supplies["6"]
			data["currency_name"] = GLOB.using_map.local_currency_name
			var/list/supply_list = list()
			for(var/i=1; i<6; i++)
				var/amm = (i>3?10:1)
				supply_list += list(list(
					"index" = "[i]",
					"amount" = supplies["[i]"],
					"name" = supply_name["[i]"],
					"can_buy" = (event == ORION_TRAIL_SPACEPORT) ? TRUE : FALSE,
					"buy_cost" = supply_cost["[i]"],
					"can_sell" = (supplies["[i]"] >= amm && event == ORION_TRAIL_SPACEPORT) ? TRUE : FALSE,
					"amount_step" = amm,
				))
			data["supplies"] = supply_list
		if(ORION_VIEW_CREW)
			data["title"] = "Crew"
			data["desc"] = "View the status of your crew."
			var/list/crew = list()
			for(var/i=1;i<=settlers.len;i++)
				crew += list(list("index" = "[i]", "name" = settlers[i]))
			data["crew"] = crew
	var/list/nav = list()
	nav += list(list("action" = "continue", "label" = "Main", "active" = (view == ORION_VIEW_MAIN)))
	nav += list(list("action" = "supplies", "label" = "Supplies", "active" = (view == ORION_VIEW_SUPPLIES)))
	nav += list(list("action" = "crew", "label" = "Crew", "active" = (view == ORION_VIEW_CREW)))
	data["nav"] = nav
	data["view"] = view
	data["emagged"] = emagged
	return data

/obj/machinery/computer/arcade/orion_trail/tgui_act(action, list/params, datum/tgui/ui, datum/tgui_state/state)
	if(..())
		return TRUE
	switch(action)
		if("continue")
			if(view == ORION_VIEW_MAIN)
				var/next_event = null
				if(event == ORION_TRAIL_START)
					event = ORION_TRAIL_SPACEPORT
				if(event == ORION_TRAIL_GAMEOVER)
					event = null
					newgame()
					return TRUE
				if(!settlers.len)
					event_desc = "You and your crew were killed on the way to Orion, your ship left abandoned for scavengers to find."
					next_event = ORION_TRAIL_GAMEOVER
				if(port == 9)
					win()
					return TRUE
				var/travel = min(rand(1000,10000),distance)
				if(params["fix"])
					var/item = params["fix"]
					supplies[item] = max(0, --supplies[item])
				if(params["risky"])
					var/risk = text2num(params["risky"])
					if(prob(risk))
						next_event = ORION_TRAIL_DISASTER


				if(!params["food"])
					var/temp = supplies["5"] - travel/1000 * (params["slow"] ? 2 : 1)
					if(temp < 0 && (distance-travel != 0) && next_event == null) //uh oh. Better start a fuel event.
						next_event = ORION_TRAIL_STUCK
						travel -= (temp*-1)*1000/(params["slow"] ? 2 : 1)
						temp = 0
					supplies["5"] = temp

					supplies["4"] = round(supplies["4"] - travel/1000 * settlers.len * (params["slow"] ? 2 : 1))
					distance = max(0,distance-travel)
				else
					supplies["4"] -= settlers.len * 5
					event_info = "You have [supplies["4"]] food left.<BR>"
					next_event = ORION_TRAIL_STUCK

				if(supplies["4"] <= 0)
					next_event = ORION_TRAIL_GAMEOVER
					event_desc = "You and your crew starved to death, never to reach Orion."
					supplies["4"] = 0

				if(distance == 0 && next_event == null) //POOORT!
					port++
					event = ORION_TRAIL_SPACEPORT
					distance = stop_distance[port]
					//gotta set supply costs. The further out the more expensive it'll generally be
					supply_cost = list("1" = rand(500+100*port,1200+100*port), "2" = rand(700+100*port,1000+100*port), "3" = rand(900+50*port,1500+75*port), "4" =  rand(10+50*port,125+50*port), "5" =  rand(75+25*port,200+100*port))
				else //Event? Event.
					generate_event(next_event)
			else
				view = ORION_VIEW_MAIN
			return TRUE

		if("supplies")
			view = ORION_VIEW_SUPPLIES
			return TRUE

		if("crew")
			view = ORION_VIEW_CREW
			return TRUE

		if("buy")
			var/item = params["buy"]
			if(supply_cost["[item]"] <= supplies["6"])
				supplies["[item]"] += (text2num(item) > 3 ? 10 : 1)
				supplies["6"] -= supply_cost["[item]"]
			return TRUE

		if("sell")
			var/item = params["sell"]
			if(supplies["[item]"] >= (text2num(item) > 3 ? 10 : 1))
				supplies["6"] += supply_cost["[item]"]
				supplies["[item]"] -= (text2num(item) > 3 ? 10 : 1)
			return TRUE

		if("kill")
			var/item = text2num(params["kill"])
			remove_settler(item)
			return TRUE

		if("attack")
			supply_cost = list()
			if(prob(17*settlers.len))
				event_desc = "An empty husk of a station now, all its resources stripped for use in your travels."
				event_info = "You've successfully raided the spaceport!<br>"
				change_resource(null)
				change_resource(null)
			else
				event_desc = "The local police mobilized too quickly, sirens blare as you barely make it away with your ship intact."
				change_resource(null,-1)
				change_resource(null,-1)
				if(prob(50))
					remove_settler(null, "died while you were escaping!")
					if(prob(10))
						remove_settler(null, "died while you were escaping!")
			event = ORION_TRAIL_SPACEPORT_RAIDED
			return TRUE
	return FALSE

/obj/machinery/computer/arcade/orion_trail/proc/change_resource(specific = null, add = 1)
	if(!specific)
		specific = rand(1,6)
	var/cost = (specific < 4 ? rand(1,5) : rand(5,100)) * add
	cost = round(cost)
	if(cost < 0)
		cost = max(cost,supplies["[specific]"] * -1)
	else
		cost = max(cost,1)
	supplies["[specific]"] += cost
	event_info += "You've [add > 0 ? "gained" : "lost"] [abs(cost)] [supply_name["[specific]"]]<BR>"

/obj/machinery/computer/arcade/orion_trail/proc/remove_settler(specific = null, desc = null)
	if(!settlers.len)
		return
	if(!specific)
		specific = rand(1,settlers.len)

	event_info += "The crewmember, [settlers[specific]] [desc == null ? "has died!":"[desc]"]<BR>"
	settlers -= settlers[specific]
	if(num_traitors > 0 && prob(100/max(1,settlers.len-1)))
		num_traitors--

/obj/machinery/computer/arcade/orion_trail/proc/generate_event(specific = null)
	if(!specific)
		if(prob(20*num_traitors))
			specific = ORION_TRAIL_MUTINY_ATTACK
		else
			specific = pickweight(events)

	switch(specific)
		if(ORION_TRAIL_RAIDERS)
			if(prob(17 * settlers.len))
				event_info = "You managed to fight them off!<br>"
				if(prob(5))
					remove_settler(null,"died in the firefight!")
				change_resource(rand(4,5))
				change_resource(rand(1,3))
				if(prob(50))
					change_resource(6,1.1)
			else
				event_info = "You couldn't fight them off!<br>"
				if(prob(10*settlers.len))
					remove_settler(null, "was kidnapped by the Vox!")
				change_resource(null,-1)
				change_resource(null,-0.5)
		if(ORION_TRAIL_DERELICT)
			if(prob(60))
				event_info = "You find resources onboard!"
				change_resource(rand(1,3))
				change_resource(rand(4,5))
			else
				event_info = "You don't find anything onboard..."
		if(ORION_TRAIL_COLLISION)
			event_info = ""
			event_desc = "You've collided with a passing meteor, breaching your hull!"
			if(prob(10))
				event_info = "Your cargo hold was breached!<BR>"
				change_resource(rand(4,5),-1)
			if(prob(5*settlers.len))
				remove_settler(null,"was sucked out into the void!")
		if(ORION_TRAIL_ILLNESS)
			if(prob(15))
				event_info = ""
				var/num = 1
				if(prob(15))
					num++
				for(var/i=0;i<num;i++)
					remove_settler(null,"has succumbed to an illness.")
			else
				event_info = "Thankfully everybody was able to pull through."
		if(ORION_TRAIL_CARP)
			event_info = ""
			if(prob(100-25*settlers.len))
				remove_settler(null, "was swarmed by carp and eaten!")
			change_resource(4)

		if(ORION_TRAIL_MUTINY)
			event_info = ""
			if(num_traitors < settlers.len - 1 && prob(55)) //gotta have at LEAST one non-traitor.
				num_traitors++
		if(ORION_TRAIL_MUTINY_ATTACK)
			//check to see if they just jump ship
			if(prob(30+(settlers.len-num_traitors)*20))
				event_info = "The traitors decided to jump ship along with some of your supplies!<BR>"
				change_resource(4,-1 - (0.2 * num_traitors))
				change_resource(5,-1 - (0.1 * num_traitors))
				for(var/i=0;i<num_traitors;i++)
					remove_settler(rand(2,settlers.len),"decided to up and leave!")
				num_traitors = 0
			else //alright. They wanna fight for the ship.
				event_info = "The traitors are charging you! Prepare your weapons!<BR>"
				var/list/traitors = list()
				for(var/i=0;i<num_traitors;i++)
					traitors += pick((settlers-traitors)-settlers[1])
				var/list/nontraitors = settlers-traitors
				while(nontraitors.len && traitors.len)
					if(prob(50))
						var/t = rand(1,traitors.len)
						remove_settler(t,"was slain like the traitorous scum they were!")
						traitors -= traitors[t]
					else
						var/n = rand(1,nontraitors.len)
						remove_settler(n,"was slain in defense of the ship!")
						nontraitors -= nontraitors[n]
				settlers = nontraitors
				num_traitors = 0
		if(ORION_TRAIL_DISASTER)
			event_desc = "The [event] proved too difficult for you and your crew!"
			change_resource(4,-1)
			change_resource(pick(1,3),-1)
			change_resource(5,-1)
		if(ORION_TRAIL_STUCK)
			event_info = "You have [supplies["4"]] food left.<BR>"
			if(prob(10))
				event_info += "A passing ship has kindly donated fuel to you and wishes you luck on your journey.<BR>"
				change_resource(5,0.3)
	if(emagged)
		emag_effect(specific)
	event = specific

/obj/machinery/computer/arcade/orion_trail/proc/emag_effect(event)
	switch(event)
		if(ORION_TRAIL_RAIDERS)
			if(istype(usr,/mob/living/carbon))
				var/mob/living/carbon/M = usr
				if(prob(50))
					to_chat(usr, SPAN_WARNING("You hear battle shouts. The tramping of boots on cold metal. Screams of agony. The rush of venting air. Are you going insane?"))
					M.hallucination(50, 50)
				else
					to_chat(usr, SPAN_DANGER("Something strikes you from behind! It hurts like hell and feel like a blunt weapon, but nothing is there..."))
					M.take_organ_damage(10, 0)
			else
				to_chat(usr, SPAN_WARNING("The sounds of battle fill your ears..."))
		if(ORION_TRAIL_ILLNESS)
			if(istype(usr,/mob/living/carbon/human))
				var/mob/living/carbon/human/M = usr
				to_chat(M, SPAN_WARNING("An overpowering wave of nausea consumes over you. You hunch over, your stomach's contents preparing for a spectacular exit."))
				M.vomit()
			else
				to_chat(usr, SPAN_WARNING("You feel ill."))
		if(ORION_TRAIL_CARP)
			to_chat(usr, SPAN_DANGER(" Something bit you!"))
			var/mob/living/M = usr
			M.adjustBruteLoss(10)
		if(ORION_TRAIL_FLUX)
			if(istype(usr,/mob/living/carbon) && prob(75))
				var/mob/living/carbon/M = usr
				M.Weaken(3)
				src.visible_message("A sudden gust of powerful wind slams \the [M] into the floor!", "You hear a large fwooshing sound, followed by a bang.")
				M.take_organ_damage(10, 0)
			else
				to_chat(usr, SPAN_WARNING("A violent gale blows past you, and you barely manage to stay standing!"))
		if(ORION_TRAIL_MALFUNCTION)
			if(supplies["3"])
				return
			src.visible_message("\The [src]'s screen glitches out and smoke comes out of the back.")
			for(var/i=1;i<7;i++)
				supplies["[i]"] = max(0,supplies["[i]"] + rand(-10,10))
		if(ORION_TRAIL_COLLISION)
			if(prob(90) && !supplies["2"])
				var/turf/simulated/floor/F = src.loc
				F.ChangeTurf(/turf/space)
				src.visible_message(SPAN_DANGER("Something slams into the floor around \the [src], exposing it to space!"), "You hear something crack and break.")
			else
				src.visible_message("Something slams into the floor around \the [src] - luckily, it didn't get through!", "You hear something crack.")
		if(ORION_TRAIL_GAMEOVER)
			to_chat(usr, SPAN_DANGER("<font size=3>You're never going to make it to Orion...</font>"))
			var/mob/living/M = usr
			M.visible_message("\The [M] starts rapidly deteriorating.")
			SStgui.close_user_uis(M, src)
			for(var/i=0;i<10;i++)
				sleep(10)
				M.Stun(5)
				M.adjustBruteLoss(10)
				M.adjustFireLoss(10)
			usr.gib() //So that people can't cheese it and inject a lot of kelo/bicard before losing



/obj/machinery/computer/arcade/orion_trail/emag_act(mob/user)
	if(!emagged)
		newgame(1)
		SStgui.update_uis(src)

/obj/machinery/computer/arcade/orion_trail/proc/win()
	src.visible_message("\The [src] plays a triumpant tune, stating 'CONGRATULATIONS, YOU HAVE MADE IT TO ORION.'")
	if(emagged)
		new /obj/item/orion_ship(src.loc)
		log_and_message_staff("made it to Orion on an emagged machine and got an explosive toy ship.")
	else
		prizevend()
	event = null
	if(usr)
		newgame()
	SStgui.update_uis(src)

/obj/item/orion_ship
	name = "model settler ship"
	desc = "A model spaceship, it looks like those used back in the day when travelling to Orion! It even has a miniature FX-293 reactor, which was renowned for its instability and tendency to explode..."
	icon = 'icons/obj/toy.dmi'
	icon_state = "ship"
	w_class = ITEM_SIZE_SMALL
	var/active = 0 //if the ship is on
/obj/item/orion_ship/examine(mob/user)
	. = ..()
	if(!(in_range(user, src)))
		return
	if(!active)
		to_chat(user, SPAN_NOTICE("There's a little switch on the bottom. It's flipped down."))
	else
		to_chat(user, SPAN_NOTICE("There's a little switch on the bottom. It's flipped up."))
/obj/item/orion_ship/attack_self(mob/user)
	if(active)
		return
	log_and_message_staff("primed an explosive Orion ship for detonation.", user)
	to_chat(user, SPAN_WARNING("You flip the switch on the underside of [src]."))
	active = 1
	src.visible_message(SPAN_NOTICE("[src] softly beeps and whirs to life!"))
	src.audible_message("<b>\The [src]</b> says, 'This is ship ID #[rand(1,1000)] to Orion Port Authority. We're coming in for landing, over.'")
	sleep(20)
	src.visible_message(SPAN_WARNING("[src] begins to vibrate..."))
	src.audible_message("<b>\The [src]</b> says, 'Uh, Port? Having some issues with our reactor, could you check it out? Over.'")
	sleep(30)
	src.audible_message("<b>\The [src]</b> says, 'Oh, God! Code Eight! CODE EIGHT! IT'S GONNA BL-'")
	sleep(3.6)
	src.visible_message(SPAN_DANGER("[src] explodes!"))
	explosion(src.loc, 1,2,4)
	qdel(src)

#undef ORION_TRAIL_RAIDERS
#undef ORION_TRAIL_FLUX
#undef ORION_TRAIL_ILLNESS
#undef ORION_TRAIL_BREAKDOWN
#undef ORION_TRAIL_MUTINY
#undef ORION_TRAIL_MUTINY_ATTACK
#undef ORION_TRAIL_MALFUNCTION
#undef ORION_TRAIL_COLLISION
#undef ORION_TRAIL_SPACEPORT
#undef ORION_TRAIL_DISASTER
#undef ORION_TRAIL_CARP
#undef ORION_TRAIL_STUCK
#undef ORION_TRAIL_START
#undef ORION_TRAIL_GAMEOVER


#undef ORION_VIEW_MAIN
#undef ORION_VIEW_SUPPLIES
#undef ORION_VIEW_CREW
