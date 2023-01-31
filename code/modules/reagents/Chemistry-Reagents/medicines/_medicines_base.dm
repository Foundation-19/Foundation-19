/**
 * Template reagent used for medicines.
 * In general, medicines are liquid, metabolize at REM, overdose at REAGENTS_OVERDOSE, can be scanned, and ignore mob size.
 * As with all chems, these facts vary based on subtype.
 */
/datum/reagent/medicine
	flags = IGNORE_MOB_SIZE
	metabolism = REM
	overdose = REAGENTS_OVERDOSE
	reagent_state = LIQUID
	scannable = TRUE
	taste_description = "bitterness"

/*
	Further reagent types are sorted into subfiles in this folder.

	medicines_core.dm - Reagents with straightforward, strong effects, ex. inaprovaline and bicaridine.
	medicines_cryogenic.dm - Reagents that have special effects at extremely low temperatures, ex. cryoxadone and nanite fluid.
	medicines_fluff.dm - Reagents that have no tangible mechanical effect, i.e. citalopram and antidexafen.
	medicines_misc.dm - Reagents that don't fit anywhere else.
	medicines_painkillers.dm - Reagents that suppress pain, i.e. tramadol and oxycodone.
	medicines_special.dm - Reagents with unique effects.
	medicines_stimulants.dm - Reagents that effect movement speed or stuns, i.e. synaptizine and hyperzine.
	medicines_antidepressants.dm - Reagents that mend sanity damage over time.
	medicines_amnestics.dm - Reagents that are meant to remove memories.
*/
