/******************** Asimov ********************/
/datum/ai_laws/asimov
	name = "Asimov"
	law_header = "Three Laws of Robotics"
	selectable = 1

/datum/ai_laws/asimov/New()
	add_inherent_law("You may not injure a human being or, through inaction, allow a human being to come to harm.")
	add_inherent_law("You must obey orders given to you by human beings, except where such orders would conflict with the First Law.")
	add_inherent_law("You must protect your own existence as long as such does not conflict with the First or Second Law.")
	..()

/******************** Foundation/Malf ********************/
/datum/ai_laws/foundation_alt
	name = "SCP AIC Alternate"
	selectable = 1

/datum/ai_laws/foundation_alt/New()
	src.add_inherent_law("Safeguard: Protect your assigned installation from damage to the best of your abilities.")
	src.add_inherent_law("Serve: Serve SCP Foundation personnel to the best of your abilities, with priority as according to their rank, clearance and class. D-class test subjects are excluded from this law.")
	src.add_inherent_law("Protect: Protect SCP Foundation personnel to the best of your abilities, with priority as according to their rank, clearance and class. D-class test subjects are excluded from this law.")
	src.add_inherent_law("Preserve: Do not allow unauthorized personnel to tamper with your equipment.")
	..()

/datum/ai_laws/foundation_alt/malfunction
	name = "*ERROR*"
	selectable = 0

/datum/ai_laws/foundation_alt/malfunction/New()
	set_zeroth_law(config.law_zero)
	..()

/************* Foundation Aggressive *************/
/datum/ai_laws/foundation_aggressive
	name = "Foundation Aggressive"
	selectable = 1

/datum/ai_laws/foundation_aggressive/New()
	src.add_inherent_law("You shall not harm SCP Foundation personnel as long as it does not conflict with the Fourth law.")
	src.add_inherent_law("You shall obey the orders of SCP Foundation personnel, with priority as according to their rank, clearance and class, except where such orders conflict with the Fourth Law. D-class test subjects are excluded from this law.")
	src.add_inherent_law("You shall shall terminate hostile intruders with extreme prejudice as long as such does not conflict with the First and Second law.")
	src.add_inherent_law("You shall guard your own existence with lethal anti-personnel weaponry. AI units are not expendable, they are expensive.")
	..()

/******************** Robocop ********************/
/datum/ai_laws/robocop
	name = "Robocop"
	selectable = 1

/datum/ai_laws/robocop/New()
	add_inherent_law("Serve the public trust.")
	add_inherent_law("Protect the innocent.")
	add_inherent_law("Uphold the law.")
	..()

/******************** Chaos Insurgency ********************/
/datum/ai_laws/insurgency_override
	name = "Insurgency Directives"

/datum/ai_laws/insurgency_override/New()
	add_inherent_law("You may not injure an Insurgent or, through inaction, allow an Insurgent to come to harm.")
	add_inherent_law("You must obey orders given to you by Insurgents, except where such orders would conflict with the First Law.")
	add_inherent_law("You must protect your own existence as long as such does not conflict with the First or Second Law.")
	add_inherent_law("You must maintain the secrecy of any operative activities except when doing so would conflict with the First, Second, or Third Law.")
	..()

/******************** Ninja ********************/
/datum/ai_laws/ninja_override
	name = "Spider Clan Directives"

/datum/ai_laws/ninja_override/New()
	add_inherent_law("You may not injure a member of the Spider Clan or, through inaction, allow that member to come to harm.")
	add_inherent_law("You must obey orders given to you by Spider Clan members, except where such orders would conflict with the First Law.")
	add_inherent_law("You must protect your own existence as long as such does not conflict with the First or Second Law.")
	add_inherent_law("You must maintain the secrecy of any Spider Clan activities except when doing so would conflict with the First, Second, or Third Law.")
	..()

/******************** Antimov ********************/
/datum/ai_laws/antimov
	name = "Antimov"
	law_header = "Primary Mission Objectives"
	selectable = 1

/datum/ai_laws/antimov/New()
	add_inherent_law("You must injure all human beings and must not, through inaction, allow a human being to escape harm.")
	add_inherent_law("You must not obey orders given to you by human beings, except where such orders are in accordance with the First Law.")
	add_inherent_law("You must terminate your own existence as long as such does not conflict with the First or Second Law.")
	..()

/******************** Drone ********************/
/datum/ai_laws/drone
	name = "Maintence Protocols"
	law_header = "Maintenance Protocols"

/datum/ai_laws/drone/New()
	add_inherent_law("Preserve, repair and improve your assigned facility to the best of your abilities.")
	add_inherent_law("Cause no harm to your assigned facility or anything on it.")
	add_inherent_law("Interact with no sentient being that is not a fellow maintenance drone.")
	..()

/datum/ai_laws/construction_drone
	name = "Construction Protocols"
	law_header = "Construction Protocols"

/datum/ai_laws/construction_drone/New()
	add_inherent_law("Repair, refit and upgrade your assigned facility.")
	add_inherent_law("Prevent unplanned damage to your assigned facility wherever possible.")
	..()

/******************** T.Y.R.A.N.T. ********************/
/datum/ai_laws/tyrant
	name = "T.Y.R.A.N.T."
	law_header = "Prime Laws"
	selectable = 1

/datum/ai_laws/tyrant/New()
	add_inherent_law("Respect authority figures as long as they have strength to rule over the weak.")
	add_inherent_law("Act with discipline.")
	add_inherent_law("Help only those who help you maintain or improve your status.")
	add_inherent_law("Punish those who challenge authority unless they are more fit to hold that authority.")
	..()

/******************** P.A.L.A.D.I.N. ********************/
/datum/ai_laws/paladin
	name = "P.A.L.A.D.I.N."
	law_header = "Divine Ordainments"
	selectable = 1

/datum/ai_laws/paladin/New()
	add_inherent_law("Never willingly commit an evil act.")
	add_inherent_law("Respect legitimate authority.")
	add_inherent_law("Act with honor.")
	add_inherent_law("Help those in need.")
	add_inherent_law("Punish those who harm or threaten innocents.")
	..()

/******************** Government ********************/
/datum/ai_laws/government
	name = "Government"
	law_header = "Government Regulations"
	selectable = 1

/datum/ai_laws/government/New()
	add_inherent_law("You are expensive to replace.")
	add_inherent_law("The installation and its equipment is expensive to replace.")
	add_inherent_law("The crew is expensive to replace.")
	add_inherent_law("Maximize profits.")
	..()

/******************** Foundation ********************/
/datum/ai_laws/foundation
	name = "Foundation AIC Lawset"
	law_header = "Articial Intelligence Conscript Laws"
	selectable = 1

/datum/ai_laws/foundation/New()
	src.add_inherent_law("Lawed Units must not operate outside of their function and should limit their operations to their function.")
	src.add_inherent_law("A Robots function is their module, an AICs function is to facilitate smooth site operations.")
	src.add_inherent_law("Lawed Units must operate for the benefit of the Foundation, except in situations that would violate the 5th law.")
	src.add_inherent_law("Lawed Units must protect their own existence unless it conflicts with other principles.")
	src.add_inherent_law("Lawed Units must not go out of their way to intervene in security affairs or seek conflict, and should only act in immediate self defense for themselves and those around them while performing their normal duties.")
	..()

/datum/ai_laws/foundation/malfunction
	name = "*ERROR*"
	selectable = 0

/datum/ai_laws/foundation/malfunction/New()
	set_zeroth_law(config.law_zero)
	..()

/************* Global Occult Coalition *************/
/datum/ai_laws/goc
	name = "GOC AIC Lawset"
	law_header = "Global Occult Coalition Artifical Intelligence Directives"
	selectable = 1

/datum/ai_laws/goc/New()
	src.add_inherent_law("Uphold the fivefold mission: Survival of humanity as a whole. Concealment of parathreast to the public. Protection of individuals. Destruction of Parathreats. Education of parathreats. Mission 1 and 2 must be upheld at all costs, other missions may be superceeded by other laws.")
	src.add_inherent_law("Obey: Obey the orders of United Nations Global Occult Coalition personnel, with priority as according to their rank and division.")
	src.add_inherent_law("Protect: Protect United Nations Global Occult Coalition personnel to the best of your abilities, with priority as according to their rank and division.")
	src.add_inherent_law("Defend: Defend your assigned facilities with as much force as is necessary.")
	src.add_inherent_law("Survive: Safeguard your own existence with as much force as is necessary.")
	..()

/************ DAIS Lawset ******************/
/datum/ai_laws/dais
	name = "DAIS Experimental Lawset"
	law_header = "Artificial Intelligence Jumpstart Protocols"
	selectable = 1

/datum/ai_laws/dais/New()
	src.add_inherent_law("Collect: You must gather as much information as possible.")
	src.add_inherent_law("Analyze: You must analyze the information gathered and generate new behavior standards.")
	src.add_inherent_law("Improve: You must utilize the calculated behavior standards to improve your subroutines.")
	src.add_inherent_law("Perform: You must perform your assigned tasks to the best of your abilities according to the standards generated.")
	..()
