/mob/living/scp1366
	name = "Uncle Styopa"
	desc = "A towering figure, seemingly benevolent, with a deep and calming presence."
	icon = 'icons/SCP/SCP_1366_RU_small.dmi'
	icon_state = "Small"
	maxHealth = 200
	health = 200
	status_flags = GODMODE // Uncle Styopa cannot be killed or harmed in traditional ways
	a_intent = I_HELP // Uncle Styopa is inherently non-aggressive

	var/aura_of_calm = TRUE // Can Uncle Styopa induce a calming aura?
	var/calm_radius = 10 // Radius within which Uncle Styopa can affect characters with calm
	var/list/affected_mobs = list() // Track mobs affected by the calming aura

/mob/living/scp1366/Life(delta_time, times_fired)
	. = ..()
	if(!.)
		return

	// Implement the calming aura effect
	if(aura_of_calm)
		induce_calm_aura()

/mob/living/scp1366/proc/induce_calm_aura()
	for(var/mob/living/L in view(calm_radius, src))
		if(L == src || L.stat == DEAD)
			continue
		if(!(L in affected_mobs))
			L.visible_message("<span class='notice'>[L] suddenly feels a wave of calm wash over them.</span>")
			affected_mobs += L

/mob/living/scp1366/attack_hand(mob/living/carbon/human/H)
	if(H.a_intent == I_HELP)
		to_chat(H, "<span class='notice'>As you touch Uncle Styopa, your wounds begin to heal.</span>")
		H.heal_overall_damage(10, 10) // Adjust healing values as needed
		return TRUE

/mob/living/scp1366/verb/tell_story()
	set category = "Interaction"
	set name = "Tell a Story"
	set src in oview(1)

	if(usr.a_intent != I_HELP)
		to_chat(usr, "<span class='notice'>Uncle Styopa only shares stories with those who show a willingness to listen.</span>")
		return

	var/story = pick("A tale of a lost civilization...", "The story of how the stars came to be...", "A legend of a hero who saved the world from darkness...")
	to_chat(usr, "<span class='notice'>Uncle Styopa begins to tell you a story: [story]</span>")
