/datum/spell/aimed/mana_burn
	name = "Mana Burn"
	desc = "This spell burns the mana out of the target, dealing damage proprotional to the amount of mana burnt."
	deactive_msg = "You discharge the mana burst spell..."
	active_msg = "You charge the mana burst spell!"

	charge_max = 25 SECONDS
	cooldown_reduc = 5 SECONDS

	invocation = "Ruptis!"
	invocation_type = INVOKE_SHOUT

	level_max = list(UPGRADE_TOTAL = 2, UPGRADE_SPEED = 2, UPGRADE_POWER = 0)

	range = 4

	hud_state = "wiz_mana_burn"

	cast_sound = 'sounds/magic/blind.ogg'

	spell_cost = 3
	mana_cost = 15
	categories = list(SPELL_CATEGORY_ANTIMAGIC)

	/// If the target has less or equal amount of mana, nothing will be done
	var/min_mana_burnt = 5
	var/max_mana_burnt = 100

/datum/spell/aimed/mana_burn/TargetCastCheck(mob/living/user, mob/living/target)
	if(!GetManaDatum(target))
		to_chat(user, SPAN_WARNING("The target must be capable of holding mana!"))
		return FALSE
	if(get_dist(user, target) > range)
		to_chat(user, SPAN_WARNING("The target is too far away!"))
		return FALSE
	return ..()

/datum/spell/aimed/mana_burn/fire_projectile(mob/living/user, mob/living/target)
	. = ..()
	var/datum/mana/M = GetManaDatum(target)
	if(!istype(M) || M.mana_level <= min_mana_burnt)
		to_chat(user, SPAN_WARNING("\The [target] did not possess enough mana to experience the burn."))
		return

	to_chat(target, SPAN_USERDANGER("You feel burning sensation as the energy leaves your body!"))
	playsound(target, 'sounds/magic/blind.ogg', 50, TRUE)
	target.adjustFireLoss(min(M.mana_level, max_mana_burnt))
	M.UseMana(target, min(M.mana_level, max_mana_burnt))
	for(var/i = 1 to 12)
		var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(get_turf(target), target.dir, target)
		D.alpha = 125
		D.color = COLOR_MANA
		animate(D, pixel_x = target.pixel_x + pick(rand(-32, -14), rand(14, 32)), pixel_y = target.pixel_y + pick(rand(-32, -14), rand(14, 32)), alpha = 55, color = COLOR_RED, time = rand(2, 6))
		animate(alpha = 0, time = 2)
