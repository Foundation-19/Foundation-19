/datum/spell/aimed/spark_bolt
	name = "Spark Bolt"
	desc = "This spell fires a few weak spark bolts."
	charge_max = 16 SECONDS
	cooldown_reduc = 2 SECONDS
	spell_flags = 0
	invocation_type = INVOKE_NONE
	range = 20
	projectile_type = /obj/item/projectile/spark_bolt
	projectile_amount = 5
	ranged_clickcd = 4 // Pew-pew
	hud_state = "wiz_sparkbolt"
	cast_sound = 'sounds/magic/shot.ogg'
	active_msg = "You prepare to cast spark bolt!"
	deactive_msg = "You dissipate the spark bolt."

	level_max = list(UPGRADE_TOTAL = 4, UPGRADE_SPEED = 2, UPGRADE_POWER = 2)

	categories = list()
	spell_cost = 2
	mana_cost = 0.5 // Per projectile, mind you

/datum/spell/aimed/spark_bolt/ImproveSpellPower()
	if(!..())
		return FALSE

	projectile_amount += 3

	return "The spell [src] now has more projectiles stored per cast."

/datum/spell/aimed/spark_bolt/ImproveSpellSpeed()
	if(!..())
		return FALSE

	ranged_clickcd = max(0.5, ranged_clickcd - 1.5)

	return "The spell [src] now has lower cooldown and attack delay."

// Projectile
/obj/item/projectile/spark_bolt
	name = "spark bolt"
	icon_state = "sparkbolt"
	fire_sound = 'sounds/magic/shot.ogg'
	damage = 15
	damage_type = BURN
