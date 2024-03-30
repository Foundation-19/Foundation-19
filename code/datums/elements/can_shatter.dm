/**
 * When attached to something, will make that thing shatter into shards on throw impact (shards based on matter list)
 * Or even when used as a weapon if the 'shatters_as_weapon' arg is TRUE
 */
/datum/element/can_shatter
	element_flags = ELEMENT_BESPOKE
	id_arg_index = 2

	/// What sound plays when the thing we're attached to shatters
	var/shattering_sound

/datum/element/can_shatter/Attach(datum/target,
	shattering_sound = 'sounds/items/ceramic_break.ogg',
	shatters_as_weapon = FALSE,
	)
	. = ..()

	if(!ismovable(target))
		return ELEMENT_INCOMPATIBLE

	src.shattering_sound = shattering_sound

	RegisterSignal(target, COMSIG_MOVABLE_IMPACT, PROC_REF(shatter))
	// TODO: add shattering on z-level impact
	if(shatters_as_weapon)
		RegisterSignal(target, COMSIG_ITEM_POST_ATTACK_ATOM, PROC_REF(shatter))

/datum/element/can_shatter/Detach(datum/target)
	. = ..()

	UnregisterSignal(target, list(COMSIG_MOVABLE_IMPACT, COMSIG_ITEM_POST_ATTACK_ATOM))

/// Handles the actual shattering part, throwing shards of whatever is defined on the component everywhere
/datum/element/can_shatter/proc/shatter(atom/movable/source, atom/hit_atom)
	SIGNAL_HANDLER

	var/generator/scatter_gen = generator("circle", 0, 48, NORMAL_RAND)
	var/scatter_turf = get_turf(hit_atom)

	for(var/obj/item/scattered_item as anything in source.contents)
		scattered_item.forceMove(scatter_turf)
		var/list/scatter_vector = scatter_gen.Rand()
		scattered_item.pixel_x = scatter_vector[1]
		scattered_item.pixel_y = scatter_vector[2]

	if(LAZYLEN(source.reagents?.reagent_list))
		source.reagents.splash(hit_atom, source.reagents.total_volume)

	playsound(scatter_turf, shattering_sound, 60, TRUE)
	show_sound_effect(get_turf(source), soundicon = SFX_ICON_JAGGED)

	if(isobj(source))
		var/obj/obj_source = source
		for(var/m_name in obj_source.matter)
			// Yes, the ceil means this produces more shards than necessary, allowing players to dupe materials.
			// I want to guarantee that at least 1 shard is created, and as of right now there's no way to generate "partial" shards
			for(var/i in 1 to ceil(obj_source.matter[m_name] / SHEET_MATERIAL_AMOUNT))
				new /obj/item/material/shard(get_turf(source), m_name)
		obj_source.decons(FALSE)
		return
	else
		qdel(source)
