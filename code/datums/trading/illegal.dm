/datum/trader/ship/illegal
	name = "Unknown"
	origin = "Unregistered Vessel"
	typical_duration = 10
	margin = 2

/datum/trader/ship/illegal/gunshop
	speech = list(TRADER_HAIL_GENERIC    = "Welcome, have a look at our armaments, just be quick.",
				TRADER_HAIL_DENY         = "Our ship doesn't sell anything, you might've mistaken us for someone else.",

				TRADER_TRADE_COMPLETE    = "Nice having business with you.",
				TRADER_NO_BLACKLISTED   = "Not interested in that one.",
				TRADER_NO_GOODS    = "Cash for guns, thats the deal.",
				TRADER_NOT_ENOUGH  = "Looks you need money, more of it.",
				TRADER_HOW_MUCH          = "That'd cost you VALUE CURRENCY.",

				TRADER_COMPLEMENT_SUCCESS = "So, gonna buy anything?",
				TRADER_COMPLEMENT_FAILURE   = "I don't think you understand how business works.",
				TRADER_INSULT_GOOD       = "That's not how you do business, pal.",
				TRADER_INSULT_BAD        = "Hope you aren't planning to travel anywhere any time soon."
				)

	possible_trading_items = list(/obj/item/gun/projectile/pistol/throwback			= TRADER_THIS_TYPE,
								/obj/item/gun/projectile/pistol/military			= TRADER_THIS_TYPE,
								/obj/item/gun/projectile/automatic/machine_pistol	= TRADER_THIS_TYPE,
								/obj/item/grenade/frag								= TRADER_THIS_TYPE,
								/obj/item/ammo_magazine/pistol/throwback			= TRADER_THIS_TYPE,
								/obj/item/ammo_magazine/pistol/double				= TRADER_THIS_TYPE,
								/obj/item/ammo_magazine/machine_pistol				= TRADER_THIS_TYPE,
								)

/datum/trader/ship/illegal/egunshop
	speech = list(TRADER_HAIL_GENERIC    = "Welcome to our installation, we've got the best laser guns in whole universe! Just be quiet about it...",
				TRADER_HAIL_DENY         = "Our ship isn't expecting any visitors at this moment.",

				TRADER_TRADE_COMPLETE    = "Great choice!",
				TRADER_NO_BLACKLISTED   = "Nuh-uh, don't need any.",
				TRADER_NO_GOODS    = "Payment is accepted in CURRENCY only.",
				TRADER_NOT_ENOUGH  = "Don't have enough money? Get some elsewhere.",
				TRADER_HOW_MUCH          = "I'll get you that for VALUE CURRENCY.",

				TRADER_COMPLEMENT_SUCCESS = "Well of course this shop is the best, I am glad you asked.",
				TRADER_COMPLEMENT_FAILURE   = "You might've misunderstood something.",
				TRADER_INSULT_GOOD       = "Don't like our shop? Well, that's bad news for you.",
				TRADER_INSULT_BAD        = "We'll meet again, MOB, under different circumstances..."
				)

	possible_trading_items = list(/obj/item/gun/energy/ionrifle				= TRADER_ALL,
								/obj/item/gun/energy/toxgun					= TRADER_THIS_TYPE,
								/obj/item/gun/energy/laser/assault			= TRADER_THIS_TYPE,
								/obj/item/gun/energy/incendiary_laser		= TRADER_THIS_TYPE,
								)
