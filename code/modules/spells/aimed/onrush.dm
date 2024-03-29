/datum/spell/aimed/onrush
	name = "Onrush"
	desc = "This spell allows its user to quickly teleport towards their target, perfoming an attack with \
			currently held item. If the target dies or gets destroyed after the attack - spell is cast again \
			freely, until there's no living creatures left."
	deactive_msg = "You discharge the onrush spell..."
	active_msg = "You charge the onrush spell!"

	charge_max = 20 SECONDS
	cooldown_reduc = 5 SECONDS

	invocation = "Irruere!"
	invocation_type = INVOKE_SHOUT
	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 2, UPGRADE_POWER = 4)

	range = 8
	hud_state = "wiz_onrush"
	cast_sound = 'sounds/magic/magic_spell.ogg'

	categories = list(SPELL_CATEGORY_MOBILITY)
	spell_cost = 2
	mana_cost = 10

	/// List of mobs that were already attacked in this cast
	var/list/already_attacked = list()
	/// How many times can this be cast for free, regardless of previous target death
	var/free_rushes = 0
	// Current counter of "free rushes"
	var/free_rushes_counter = 0

/datum/spell/aimed/onrush/TargetCastCheck(mob/living/user, mob/living/target)
	if(!istype(target))
		to_chat(user, SPAN_WARNING("The target must be a living creature!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	if(target.stat)
		to_chat(user, SPAN_WARNING("[target] is already dead or unconscious!"))
		return FALSE
	return ..()

/datum/spell/aimed/onrush/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	already_attacked = list()
	free_rushes_counter = free_rushes
	remove_ranged_ability()
	on_deactivation(user)
	RushTarget(user, target)

/datum/spell/aimed/onrush/proc/RushTarget(mob/living/user, mob/living/target)
	var/turf/target_turf = get_step(get_turf(target), pick(GLOB.alldirs))
	var/list/line_list = getline(user, target_turf)
	for(var/i = 1 to length(line_list))
		var/turf/T = line_list[i]
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(T, user.dir, user)
		D.alpha = min(150 + i*15, 255)
		animate(D, alpha = 0, time = 2 + i*2)
	user.forceMove(target_turf)
	playsound(get_turf(user), 'sounds/scp/abnormality/white_night/spear_dash.ogg', 50, TRUE)
	OnrushAttack(user, target)
	if(!QDELETED(target))
		already_attacked |= target
	addtimer(CALLBACK(src, PROC_REF(CheckAndRepeat), user, target), rand(3, 6))

/datum/spell/aimed/onrush/proc/OnrushAttack(mob/living/user, mob/living/target)
	user.next_move = 0
	user.next_click = 0
	user.a_intent_change(I_HURT)
	user.ClickOn(target)

// Looks for valid mobs in view and attacks one
/datum/spell/aimed/onrush/proc/CheckAndRepeat(mob/living/user, mob/living/target)
	if(!QDELETED(target) && target.stat != DEAD)
		if(!free_rushes_counter)
			already_attacked = list()
			return FALSE
		free_rushes_counter -= 1

	var/list/valid_mobs = list()
	for(var/mob/living/L in view(6, user))
		if(L == user)
			continue
		if(L in already_attacked)
			continue
		if(L.stat == DEAD)
			continue
		valid_mobs += L
	if(!LAZYLEN(valid_mobs))
		already_attacked = list()
		return
	var/mob/living/new_target = pick(valid_mobs)
	RushTarget(user, new_target)

/datum/spell/aimed/onrush/ImproveSpellPower()
	if(!..())
		return FALSE

	free_rushes += 2

	return "The [src] spell will now additionaly charge [free_rushes] times for free."
