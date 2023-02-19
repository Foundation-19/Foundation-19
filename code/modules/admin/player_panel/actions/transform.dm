GLOBAL_LIST_INIT(pp_transformables, list(
	"Humanoid" = list(
		list(
			name = "Human",
			key = /mob/living/carbon/human,
			color = "green"
		),
		list(
			name = "Monkey",
			key = /mob/living/carbon/human/monkey,
			color = "green"
		),
		list(
			name = "Skrell",
			key = /mob/living/carbon/human/skrell,
			color = "green"
		),
		list(
			name = "Unathi",
			key = /mob/living/carbon/human/unathi,
			color = "green"
		),
		list(
			name = "Vox",
			key = /mob/living/carbon/human/vox,
			color = "green"
		),
		list(
			name = "IPC",
			key = /mob/living/carbon/human/machine,
			color = "green"
		),
		list(
			name = "Nabber",
			key = /mob/living/carbon/human/nabber,
			color = "green"
		),
		list(
			name = "Adherent",
			key = /mob/living/carbon/human/adherent,
			color = "green"
		)
	),
	"Miscellaneous" = list(
		list(
			name = "Cat",
			key = /mob/living/simple_animal/friendly/cat,
			color = "orange"
		),
		list(
			name = "Crab",
			key = /mob/living/simple_animal/friendly/crab,
			color = "orange"
		),
		list(
			name = "Corgi",
			key = /mob/living/simple_animal/friendly/corgi,
			color = "orange"
		)
	)
))

/datum/player_action/transform
	action_tag = "mob_transform"
	name = "Transform"
	permissions_required = R_SPAWN

/datum/player_action/transform/act(client/user, mob/target, list/params)
	if(isnewplayer(target))
		tgui_alert(user, "You can't transform players in lobby.")
		return
	var/type = text2path(params["key"])

	if(!ispath(type))
		return

	var/mob/M = new type(target.loc)

	if(!target.mind)
		target.mind_initialize()

	target.mind.transfer_to(M, TRUE)

	QDEL_IN(target, 0.3 SECONDS)
	spawn(1)
		M.mob_panel.tgui_interact(user.mob)

	message_staff("[key_name_admin(user)] has transformed [key_name_admin(target)] into mob type [type]")
	return TRUE
