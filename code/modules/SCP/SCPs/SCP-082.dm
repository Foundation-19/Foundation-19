/mob/living/carbon/human/scp082
	name = "morbidly obese frenchman"
	desc = "A most massive mound of meat and muscle, with a french accent to boot."
	icon = 'icons/SCP/scp-082.dmi'

	status_flags = NO_ANTAG | SPECIES_FLAG_NO_EMBED | SPECIES_FLAG_NEED_DIRECT_ABSORB
	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)
	handcuffs_breakout_modifier = 0.2
	pixel_x = -16
	pixel_y = -16
	usefov = FALSE
	health = 2000
	maxHealth = 2000
	floating_message_pixel_x_offset = 16
	floating_message_pixel_y_offset = 32
	speech_bubble_pixel_x_offset = 16
	speech_bubble_pixel_y_offset = 32
	layer = SCP_082_LAYER
	stamina = 25
	max_stamina = 25

	/// Door force open cooldown
	var/door_cooldown = 10 SECONDS
	/// Last speech heard up close
	var/last_interaction_time = 0
	/// How much time should pass without interactions to be able to get up and leave
	var/patience_limit = 15 MINUTES
	/// The area we spawned in
	var/area/home_area = null
	/// If TRUE, we are in the hunger state (seperate from regular hunger)
	var/hungering = FALSE
	/// Multiplier for time to open doors when hungering
	var/hungering_door_open_mult = 0.75
	/// The currently selected clothing set. If "", then no clothing
	var/clothing_set = "tuxedo"
	/// Head mutable appearance
	var/mutable_appearance/head_appearance
	/// Clothing mutable appearance
	var/mutable_appearance/clothing_appearance
	/// How long to go on cooldown for after stopping hunger
	var/hunger_cooldown_time = 10 MINUTES
	/// Current probability to go into hunger this Life() tick
	var/hunger_prob = 0
	/// How many Life() ticks since the hunger cooldown has ended have occurred
	var/non_hunger_ticks = 0
	/// How much to heal from eating a leg/arm, split between brute and burn
	var/limb_heal_amount = 200
	/// How much to heal from eating a head, split between brute and burn
	var/head_heal_amount = 400
	/// How much to heal from eating a torso, split between brute and burn
	var/torso_heal_amount = 500
	/// Multiplier for how much blood to regen when eating a bodypart
	var/eat_blood_regen_mult = 1.4
	/// What number to consider 082's "max health" when it comes to hunger timer/cooldown
	var/practical_max_health = 300

	/// Door cooldown tracker
	COOLDOWN_DECLARE(door_cooldown_track)
	/// Cooldown for patience message
	COOLDOWN_DECLARE(patience_cooldown_track)
	/// Cooldown for going into hunger. It will take longer than the cooldown, but this is the minimum time
	COOLDOWN_DECLARE(hunger_cooldown_track)

/mob/living/carbon/human/scp082/Initialize(mapload, new_species = "SCP-082")
	. = ..()
	SCP = new /datum/scp(
		src,
		"morbidly obese frenchman",
		SCP_EUCLID,
		"082",
		SCP_PLAYABLE|SCP_ROLEPLAY,
	)

	SCP.min_time = 10 MINUTES
	SCP.min_playercount = 16
	SCP.regular_examine = TRUE

	ADD_TRAIT(src, TRAIT_FATFINGERS, ROUNDSTART_TRAIT)
	init_skills()
	add_language(LANGUAGE_ENGLISH)
	add_language(LANGUAGE_HUMAN_FRENCH)

	home_area = get_area(src)
	head_appearance = mutable_appearance(icon, hungering ? "hungry" : "static", layer + 0.02)
	clothing_appearance = mutable_appearance(icon, "[clothing_set]", layer + 0.01)

/mob/living/carbon/human/scp082/Destroy()
	home_area = null
	return ..()

// This code makes me want to drink
/mob/living/carbon/human/scp082/update_icons()
	lying_prev = lying
	update_hud()
	overlays.Cut()

	if (icon_update)
		icon_state = null
		switch(stat)
			if(CONSCIOUS)
				icon_state = "082_headless"
			if(UNCONSCIOUS)
				icon_state = "082-asleep"
			if(DEAD)
				icon_state = "082-dead"

	if(stat == CONSCIOUS)
		head_appearance.icon_state = hungering ? "hungry" : "static"
		overlays += head_appearance

	if(clothing_set)
		switch(stat)
			if(CONSCIOUS)
				clothing_appearance.icon_state = clothing_set
			if(UNCONSCIOUS)
				clothing_appearance.icon_state = "[clothing_set]-asleep"
			if(DEAD)
				clothing_appearance.icon_state = "[clothing_set]-dead"
		overlays += clothing_appearance

/mob/living/carbon/human/scp082/reset_layer()
	if(lying)
		layer = SCP_082_LYING_LAYER
	else
		..()

/mob/living/carbon/human/scp082/update_body(update_icons = TRUE)
	if(!stand_icon) // not going to change, realistically
		stand_icon = new(icon, "082_headless")

	if(update_icons)
		queue_icon_update()


/mob/living/carbon/human/scp082/proc/init_skills()
	skillset.skill_list = list()
	for(var/decl/hierarchy/skill/skill as anything in GLOB.skills)
		skillset.skill_list[skill.type] = SKILL_UNTRAINED
	skillset.skill_list[SKILL_COOKING] = SKILL_MASTER
	skillset.skill_list[SKILL_HAULING] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_COMBAT] = SKILL_EXPERIENCED
	skillset.skill_list[SKILL_ANATOMY] = SKILL_EXPERIENCED
	skillset.on_levels_change()

/mob/living/carbon/human/scp082/do_possession(mob/observer/ghost/possessor)
	. = ..()
	if(!.)
		return
	priority_announcement.Announce("Motion sensors triggered in the containment chamber of SCP-082, on-site security personnel are to investigate the issue.", "Motion Sensors")
	last_interaction_time = world.time + 5 MINUTES

/mob/living/carbon/human/scp082/proc/open_door(obj/machinery/door/door) // this should probably be a component honestly
	if(!COOLDOWN_FINISHED(src, door_cooldown_track))
		to_chat(src, SPAN_WARNING("You can't open another door just yet!"))
		return

	if(!istype(door))
		return

	if(!door.density)
		return

	if(!door.Adjacent(src))
		to_chat(src, SPAN_WARNING("[door] is too far away."))
		return

	var/open_time = 6 SECONDS
	if(istype(door, /obj/machinery/door/blast))
		if(get_area(src) == home_area && world.time <= last_interaction_time + patience_limit)
			to_chat(src, SPAN_WARNING("You don't feel like leaving just yet."))
			return
		open_time += 10 SECONDS

	if(istype(door, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = door
		if(airlock.locked)
			open_time += 3 SECONDS
		if(airlock.welded)
			open_time += 3 SECONDS
		if(airlock.secured_wires)
			open_time += 3 SECONDS

	if(istype(door, /obj/machinery/door/airlock/highsecurity))
		open_time += 6 SECONDS

	if(hungering)
		open_time *= hungering_door_open_mult

	door.visible_message(SPAN_WARNING("[src] begins to pry open [door]!"))
	playsound(get_turf(door), 'sounds/machines/airlock_creaking.ogg', 35, 1)
	COOLDOWN_START(src, door_cooldown_track, door_cooldown)

	if(!do_after(src, open_time, door) || !door.Adjacent(src))
		COOLDOWN_RESET(src, door_cooldown_track)
		return

	if(istype(door, /obj/machinery/door/blast))
		var/obj/machinery/door/blast/blastdoor = door
		blastdoor.visible_message(SPAN_DANGER("[src] forcefully opens [blastdoor]!"))
		blastdoor.force_open()
		return

	if(istype(door, /obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/airlock = door
		airlock.unlock(TRUE) // No more bolting in the SCPs and calling it a day
		airlock.welded = FALSE

	door.set_broken(TRUE)
	door.do_animate("spark")
	visible_message("[src] slices [door]'s controls, [door.open(TRUE) ? "ripping it open!" : "breaking it!"]")

/mob/living/carbon/human/scp082/proc/start_hunger()
	set waitfor = FALSE

	non_hunger_ticks = 0
	hunger_prob = 0
	stamina = max_stamina
	to_chat(src, SPAN_WARNING("You feel like you're getting <b>very</b> hungry..."))
	var/total_damage_taken = 0
	for(var/obj/item/organ/external/external in organs)
		if(BP_IS_ROBOTIC(external) && !external.vital)
			continue
		total_damage_taken += min(external.brute_dam + external.burn_dam, external.max_damage)
	sleep(max(2 SECONDS, 10 SECONDS * (1 - (total_damage_taken / practical_max_health))))
	to_chat(src, SPAN_WARNING("A proper hunger. You feel the need to <b>feast</b>."))
	hungering = TRUE
	queue_icon_update()
	addtimer(CALLBACK(src, PROC_REF(stop_hunger), TRUE), 2 MINUTES)

/mob/living/carbon/human/scp082/proc/stop_hunger(time = FALSE)
	if(time)
		to_chat(src, SPAN_WARNING("Your hunger passes."))
	else
		to_chat(src, SPAN_WARNING("You feel sated. Your hunger recedes."))
	hungering = FALSE
	var/total_damage_taken = 0
	for(var/obj/item/organ/external/external in organs)
		if(BP_IS_ROBOTIC(external) && !external.vital)
			continue
		total_damage_taken += min(external.brute_dam + external.burn_dam, external.max_damage)
	queue_icon_update()
	COOLDOWN_START(src, hunger_cooldown_track, hunger_cooldown_time * (1 - (total_damage_taken / (practical_max_health * 1.5))))

//Overrides

/mob/living/carbon/human/scp082/Life()
	. = ..()
	if(COOLDOWN_FINISHED(src, patience_cooldown_track) && world.time > last_interaction_time + patience_limit && get_area(src) == home_area)
		COOLDOWN_START(src, patience_cooldown_track, 5 MINUTES)
		to_chat(src, SPAN_DANGER("They really abandoned you in here..? Seems like it's time to take a walk."))

	if(COOLDOWN_FINISHED(src, hunger_cooldown_track) && !hungering)
		if(prob(hunger_prob))
			start_hunger()
		else
			var/total_damage_taken = 0
			for(var/obj/item/organ/external/external in organs)
				if(BP_IS_ROBOTIC(external) && !external.vital)
					continue
				total_damage_taken += min(external.brute_dam + external.burn_dam, external.max_damage)
			// At full HP: Reaches 0% at 300 ticks (600s), 50% at 539 (1078s), 100% at 700 (1400s)
			// The minimum time to go into hungering state decreases the more damage SCP-082 takes
			// https://www.desmos.com/calculator/fbxdrszswf
			hunger_prob = ((0.0005 * ((non_hunger_ticks + (300 * (total_damage_taken / practical_max_health))) ** 2)) - 45) * 0.5
			non_hunger_ticks++

/mob/living/carbon/human/scp082/UnarmedAttack(atom/target as obj|mob)
	if(!istype(target))
		return

	if(istype(target, /obj/machinery/door))
		setClickCooldown(CLICK_CD_ATTACK)
		open_door(target)
		return

	if(!ishuman(target))
		return ..()

	setClickCooldown(CLICK_CD_ATTACK)
	return ..()

/mob/living/carbon/human/scp082/grab_attack(obj/item/grab/grab)
	if((grab.assailant != src) || !hungering || grab.affecting.SCP)
		return ..()

	var/limb_to_tear

	switch(zone_sel?.selecting)
		if(BP_L_FOOT, BP_L_LEG)
			limb_to_tear = BP_L_LEG
		if(BP_R_FOOT, BP_R_LEG)
			limb_to_tear = BP_R_LEG
		if(BP_L_ARM, BP_L_HAND)
			limb_to_tear = BP_L_ARM
		if(BP_R_ARM, BP_R_HAND)
			limb_to_tear = BP_R_ARM
		if(BP_HEAD)
			limb_to_tear = BP_HEAD
		if(BP_CHEST, BP_GROIN)
			limb_to_tear = BP_CHEST

	if(limb_to_tear == BP_CHEST)
		if(!istype(grab.affecting.organs_by_name[BP_L_ARM], /obj/item/organ/external/stump) || !istype(grab.affecting.organs_by_name[BP_R_ARM], /obj/item/organ/external/stump) || !istype(grab.affecting.organs_by_name[BP_L_LEG], /obj/item/organ/external/stump) || !istype(grab.affecting.organs_by_name[BP_R_LEG], /obj/item/organ/external/stump) || !istype(grab.affecting.organs_by_name[BP_HEAD], /obj/item/organ/external/stump))
			to_chat(src, SPAN_WARNING("You can't consume a torso unless it's had all its limbs removed!"))
			return

		var/mob/living/carbon/human/grabbed = grab.affecting
		visible_message(SPAN_WARNING("[src] consumes the rest of [grab.affecting], eating [grabbed.p_them()] whole!"), SPAN_WARNING("You consume the rest of [grabbed]!"))
		playsound(src, pick('sounds/weapons/alien_bite1.ogg', 'sounds/weapons/alien_bite2.ogg'), 70, TRUE)
		grabbed.blood_squirt(1, get_turf(grabbed))
		stop_hunger()
		heal_overall_damage(torso_heal_amount / 2, torso_heal_amount / 2)
		vessel.add_reagent(/datum/reagent/blood, torso_heal_amount * eat_blood_regen_mult)
		adjust_nutrition(400)
		qdel(grabbed)
	else
		if(istype(grab.affecting.organs_by_name[limb_to_tear], /obj/item/organ/external/stump))
			to_chat(src, SPAN_WARNING("[grab.affecting] is already missing that limb!"))
			return
		var/mob/living/carbon/human/grabbed = grab.affecting
		visible_message(SPAN_WARNING("[src] messily bites off [grab.affecting]'s [grab.affecting.organs_by_name[limb_to_tear]], eating it whole!"), SPAN_WARNING("You bite off [grab.affecting]'s [grab.affecting.organs_by_name[limb_to_tear]], satiating your hunger."))
		grab.affecting.organs_by_name[limb_to_tear]:droplimb(FALSE, DROPLIMB_BLUNT) // It may not be actually blunt, but the gib effect is what we're after
		if(grabbed.stat != DEAD)
			grabbed.emote("scream", AUDIBLE_MESSAGE)
		grabbed.blood_squirt(2, get_turf(grabbed))
		stop_hunger()
		playsound(src, pick('sounds/weapons/alien_bite1.ogg', 'sounds/weapons/alien_bite2.ogg'), 70, TRUE)
		if(limb_to_tear == BP_HEAD)
			heal_overall_damage(head_heal_amount / 2, head_heal_amount / 2)
			vessel.add_reagent(/datum/reagent/blood, head_heal_amount * eat_blood_regen_mult)
		else
			heal_overall_damage(limb_heal_amount / 2, limb_heal_amount / 2)
			vessel.add_reagent(/datum/reagent/blood, limb_heal_amount * eat_blood_regen_mult)
		adjust_nutrition(200)

// Override for footstep volume
/mob/living/carbon/human/scp082/handle_footsteps()
	if(!has_footsteps())
		return

	 //every other turf makes a sound
	if((step_count % 2) && MOVING_QUICKLY(src))
		return

	// don't need to step as often when you hop around
	if((step_count % 3) && !has_gravity(src))
		return

	if(istype(move_intent, /decl/move_intent/creep)) //We don't make sounds if we're tiptoeing
		return

	var/turf/T = get_turf(src)
	if(istype(T))
		var/footsound = T.get_footstep_sound(src)
		if(footsound)
			var/range = -(world.view - 2)
			var/volume = 70
			if(MOVING_DELIBERATELY(src))
				volume -= 45
				range -= 0.333
			playsound(T, footsound, volume, 1, range)
			play_special_footstep_sound(T, volume, range)

	show_sound_effect(T, src)


/obj/structure/scp082_trunk
	name = "large trunk"
	desc = "A large, brown trunk. You can see some clothes sticking out of it."
	icon_state = "trunk"
	var/static/list/possible_outfits = list(
		"None" = "",
		"Mayor" = "mayor",
		"Business Casual" = "armstrong",
		"Clown" = "clown",
		"Mime" = "mime",
		"D-Class" = "d_class",
		"Revolutionary Outfit" = "french_revolution",
		"Tuxedo" = "tuxedo",
		"Dress" = "monroe",
		"Fighter" = "goro",
	)

/obj/structure/scp082_trunk/attack_hand(mob/user)
	. = ..()
	if(!istype(user, /mob/living/carbon/human/scp082))
		to_chat(user, SPAN_WARNING("[src]'s lid is far too heavy for you to open!"))
		return

	var/picked = tgui_input_list(user, "Select an outfit from your trunk.", "Select outfit", possible_outfits)
	if(!picked || !in_range(src, user) || QDELETED(src))
		return

	var/mob/living/carbon/human/scp082/user_scp = user
	user_scp.clothing_set = possible_outfits[picked]
	user_scp.queue_icon_update()


/obj/item/organ/internal/brain/scp082
	max_damage = 900
	min_broken_damage = 900


/obj/item/organ/external/head/scp082
	max_damage = 400
	min_broken_damage = 300
	arterial_bleed_severity = 0.4

/obj/item/organ/external/chest/scp082
	max_damage = 600
	min_broken_damage = 400
	arterial_bleed_severity = 0.4

/obj/item/organ/external/groin/scp082
	max_damage = 600
	min_broken_damage = 400
	arterial_bleed_severity = 0.4

/obj/item/organ/external/leg/scp082
	max_damage = 300
	min_broken_damage = 210
	arterial_bleed_severity = 0.4

/obj/item/organ/external/leg/right/scp082
	max_damage = 300
	min_broken_damage = 210
	arterial_bleed_severity = 0.4

/obj/item/organ/external/arm/scp082
	max_damage = 300
	min_broken_damage = 210
	arterial_bleed_severity = 0.4

/obj/item/organ/external/arm/right/scp082
	max_damage = 300
	min_broken_damage = 210
	arterial_bleed_severity = 0.4

/obj/item/organ/external/foot/scp082
	max_damage = 250
	min_broken_damage = 200
	arterial_bleed_severity = 0.4

/obj/item/organ/external/foot/right/scp082
	max_damage = 250
	min_broken_damage = 2100
	arterial_bleed_severity = 0.4

/obj/item/organ/external/hand/scp082
	max_damage = 250
	min_broken_damage = 200
	arterial_bleed_severity = 0.4

/obj/item/organ/external/hand/right/scp082
	max_damage = 250
	min_broken_damage = 2100
	arterial_bleed_severity = 0.4

/obj/item/paper/scp082_memoir
	name = "poetry"
	info = {"
In the dank, deep depths of the dark alleyway,
Where no man can see the light of day,
There stood a boy wearing tattered attire,
And, in the corner, a small campfire.
With rags as a sleeping mat, and a box for a house,
And laying there, quiet as a mouse,
The boy knew not to make any sound,
For he knew what would happen if he were to be found.

While sleeping in his cot, the boy slept well,
And felt, as a whole, rather swell.
The boy woke the next morning, hearing a shout,
And from his cot, he began to sprout.
Looking to the light, he saw a figure,
Though its full shape, he could not configure.
Two more entered sight, all were a blur.
Should the boy run? He was unsure.

The figures came charging at a rapid motion,
Nothing could be heard over the commotion.
They grabbed the boys limbs, and pulled him madly,
The boy had to flee, but he could not, sadly.
Trapped by the figures, he was unable to walk,
With a cloth over his mouth, he was unable to talk.
With a thump on the head, his world became dark,
And along with the men, they disembarked.

With a groggy grunt, the boy awoke with tears,
He was locked in a cage, the worst of his fears.
Draped in red, he could not see,
With bars of steel, he could not flee.
There was a rustle, then a light so bright,
The boy had almost lost his sight.
Then, a man, with a twinkle in his eye
Grabbed a cane and top hat, then began to outcry:

"Ladies and gentlemen, children of any age!
Allow me to show you what is in this cage.
Around the world, I've travelled, sea to sea,
And I have brought a gift for thee to see.
Be warned, you may run crying in fear,
And this gift may also cause you to tear.
But fret not, my dears, for it will cause no harm
For if he does, I'll cut off his arm!"

"This great, hefty beast has arms so strong,
That he could cut down trees all year long.
Yes, it's true, this beast has some muscle,
He could certainly proclaim victory in any tussle.
But folks, if you will have a look at this creature!
We must not neglect his most prominent feature.
With jaws of steel, and teeth so bright,
This creature's smile could light up the night!"

The man turned to the boy, scowl on his face,
He whispered, "Come on, beast, pick up the pace!
Your audience is waiting, give em' a show!"
The man took the cane, then delivered a blow.
The boy shook with fear, not knowing what to do,
The audience before him began to boo.
With one last breath that reeked of bile,
The boy stood tall, and then, he smiled.

Cheers, cheers! Cheers all around!
Not a single frown was able to be found.
The man stepped forward, and said, "How about that?"
The crowd before him threw coins in his hat.
The man was rich, all thanks to the boy.
"Perhaps," the man thought, "there is more use for this toy"
Then the man reached into a pocket in his back,
He pulled out a whip, and let out a crack.

Blood crept down the boy's back, as thick as molasses.
Brought to his knees, right before the masses.
The boy let out a roar, all could hear.
The crowd shrieked, then ran in fear.
The man chuckled, and looked at the boy,
Then said, "Oh come now, don't be so coy.
From here on out, I'll be your guide.
And, together, we shall travel far and wide!"

Days passed like months, and months like years.
Each day he was alive, he bathed in tears.
Was this his place, his final destination?
Is this life his only true application?
Whatever questions he asked, no one answered the boy.
For what was he if he not a toy?
It took many years, and much contemplation,
But at last, the boy received an explanation.

In the crypts of his mind, there came a voice.
This voice allowed the poor boy a choice.
Shall he remain in his cage, filled with dejection?
Or shall he get revenge with divine retaliation?
The boy stared at his thousands of scars,
Then brought his attention to the light of the stars.
In order to escape, the boy needed a plan,
But most of all, he must become a man.

It was the last day of the tour, the final show
What would happen? The boy did not know.
The man in the hat came out from the back.
He took out his whip, then gave another crack.
Still locked in his cage, the boy could not fight.
All he could do was shake with fright.
The man just chuckled, not giving a care.
He grabbed his cane, and gave one last declare:

"Now folks, hear me, as I tell you my feat!
I stand here, offering you all a treat.
After many years of teaching and rehabilitation,
I present this beast to the entire nation!
For he is no longer a beast, no longer so cruel,
And with my teachings, he is now my mule.
Don't believe me, you say? Need I show you?"
The man then unlocked the cage, and out the door flew.

Slowly, the boy inched from his crib,
To encourage him, the man jabbed him in the rib.
Picking up the pace, the boy made it out,
The audience before him let out a shout.
"Beast!" they called him. "Abomination!" they cried,
The boy could not smile, no matter how much he tried.
The man beside him, with eyes full of rage,
Shouted at the boy, while hitting the cage.

"Come on, my boy! What are you doing?
Can you not see that the audience is booing?
After all these years, and all of this time,
Now is when you decide to begrime?
Show them your power, show them your might!
For I know that you're human, just ever so slight.
Show them how a beast like you does no harm.
For if you don't, I will saw off your arm!"

The boy stood still, unable to move.
He could not find his internal groove.
The crypts of his mind internally froze,
Then suddenly, in front of him, a shadow arose.
The shadow engulfed the boy, entrapped his soul,
Then slowly and quietly, it began to cajole.
Finally, the boy knew what must be done,
And chuckled to himself, "Let's have some fun."

The boy grabbed his captor, and held him tight.
He stared into his eyes, and saw the fright.
As the boy lifted the man, the man screamed in fear.
From his left eye, the boy saw him tear.
The boy did not care, he had no remorse,
For he knew that this man was truly so coarse.
The boy opened his jaws, and placed the man inside.
And though it was muffled, the man still cried.

He squirmed in his mouth, as the boy began to munch,
Then he grew limp with one final CRUNCH.

Blood gushed in the boy's mouth, it was quite a sight.
Still, unrelenting, the boy held on tight.
For he was no longer a boy, much more vicious and malicious.
As he devoured the man's flesh, he whispered, "How delicious."
Still wanting more, he turned to the crowd,
Who had already started running and screaming aloud.
The beast chased after, grabbing a few.
He ripped off their arms, then began to chew.

After those few, he grabbed some more.
He ripped out their entrails, which leaked on the floor.
After those meals, he ran to the street.
He feasted on those with livers so sweet.
In the corner of his eye, he saw a young man,
With a pair of ripped trousers, and a gun in his hand.
Though he tried to take on the beast,
It was upon his corpse that the beast would feast.

But before the beast could go any more,
He took a look down, and stared at the gore,
For this boy was like him, alone and afraid,
With no one else who would give him aid.
The beast was now alone, blood creeping in his scars,
No one could see him except for the stars.
With much shame, the beast fled the scene,
For he did not know how he could be this obscene.

He took shelter in the woods, unable to cope
With the actions he made; he was out of hope.
He washed himself in a nearby river,
Scraping off the remnants of the young man's liver.
He grabbed some leaves, and then some sticks,
Then made a small cot, in which he affixed
A small drape for a door, and some leaves that were dead,
This was the only things the beast could call his bed.

(SCP-082 begins to tear, but continues to speak)

After the night passed, he awoke in a room,
With many bright lights, and a mood so gloom.
There were people above, staring at the aberration.
The creature then knew the reality of the situation.
His life flashed again, all of the pain,
All the creature could do was exclaim.
For he was again alone, with nothing to do.
Then, a voice from above said, "Hello, 082."
	"}
