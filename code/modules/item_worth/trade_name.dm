// Name that will be shown when asking merchant about items they want to purchase.
/atom/proc/trade_name()
	return initial(src.name)

/mob/living/carbon/human/trade_name()
	return "[initial(src.species.name)] specimen"
