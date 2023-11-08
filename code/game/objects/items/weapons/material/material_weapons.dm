// SEE code/modules/materials/materials.dm FOR DETAILS ON INHERITED DATUM.
// This class of weapons takes force and appearance data from a material datum.
// They are also fragile based on material data and many can break/smash apart.
/obj/item/material
	hitsound = 'sounds/weapons/bladeslice.ogg'
	gender = NEUTER
	throw_speed = 3
	throw_range = 7
	w_class = ITEM_SIZE_NORMAL
	health_max = 10

	var/default_material = MATERIAL_STEEL
	var/material/material

	var/applies_material_colour = 1
	var/applies_material_name = 1 //if false, does not rename item to 'material item.name'
	var/furniture_icon  //icon states for non-material colorable overlay, i.e. handles

	var/max_force = 40 //any damage above this is added to armor penetration value
	var/max_pen = 100 //any penetration above this value is ignored
	var/force_multiplier = 0.5 // multiplier to material's generic damage value for this specific type of weapon
	var/thrown_force_multiplier = 0.5

	var/attack_cooldown_modifier = 0
	var/unbreakable
	var/drops_debris = 1
	var/worth_multiplier = 1

/obj/item/material/New(newloc, material_key)
	if(!material_key)
		material_key = default_material
	set_material(material_key)
	..(newloc)
	queue_icon_update()
	if(!material)
		qdel(src)
		return

	matter = material.get_matter()
	if(matter.len)
		for(var/material_type in matter)
			if(!isnull(matter[material_type]))
				matter[material_type] *= force_multiplier // May require a new var instead.

/obj/item/material/get_material()
	return material

/obj/item/material/proc/update_force()
	var/new_force
	if(edge || sharp)
		new_force = material.get_edge_damage()
	else
		new_force = material.get_blunt_damage()
	new_force = round(new_force*force_multiplier)
	force = min(new_force, max_force)

	if(new_force > max_force)
		armor_penetration = initial(armor_penetration) + new_force - max_force
	armor_penetration += 2*max(0, material.brute_armor - 2)
	armor_penetration = min(max_pen, armor_penetration)

	throwforce = round(material.get_blunt_damage()*thrown_force_multiplier)
	attack_cooldown = material.get_attack_cooldown() + attack_cooldown_modifier

/obj/item/material/proc/set_material(new_material)
	material = SSmaterials.get_material_by_name(new_material)
	if(!material)
		qdel(src)
	else
		set_max_health(round(material.integrity / 5))
		restore_health(get_max_health())
		if(material.products_need_process())
			START_PROCESSING(SSobj, src)
		if(material.conductive)
			obj_flags |= OBJ_FLAG_CONDUCTIBLE
		else
			obj_flags &= (~OBJ_FLAG_CONDUCTIBLE)
		update_force()
		if(applies_material_name)
			set_name("[material.display_name] [initial(name)]")
		update_icon()

/obj/item/material/on_update_icon()
	cut_overlays()
	if(applies_material_colour && istype(material))
		color = material.icon_colour
		alpha = 100 + material.opacity * 255
	if(furniture_icon)
		var/image/I = image(icon, icon_state = furniture_icon)
		I.appearance_flags = RESET_COLOR
		add_overlay(I)

/obj/item/material/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/material/apply_hit_effect(mob/living/target, mob/living/user, hit_zone)
	. = ..()
	if(material.is_brittle() || target.get_blocked_ratio(hit_zone, BRUTE, damage_flags(), armor_penetration, force) * 100 >= material.hardness/5)
		check_shatter()

/obj/item/material/on_parry(damage_source)
	if(istype(damage_source, /obj/item/material))
		check_shatter()

/obj/item/material/proc/check_shatter()
	if(!unbreakable && prob(material.hardness))
		if(material.is_brittle())
			kill_health()
		else
			damage_health(1)

/obj/item/material/handle_death_change(new_death_state)
	. = ..()
	if(new_death_state)
		shatter()

/obj/item/material/proc/shatter()
	var/turf/T = get_turf(src)
	T.visible_message(SPAN_DANGER("\The [src] [material.destruction_desc]!"))
	playsound(src, SFX_SHATTER, 70, 1)
	show_sound_effect(src.loc, soundicon = SFX_ICON_JAGGED)
	if(drops_debris)
		material.place_shard(T)
	qdel(src)
