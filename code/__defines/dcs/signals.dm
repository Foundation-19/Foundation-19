// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent

/// Called after an explosion happened : (epicenter, devastation_range, heavy_impact_range, light_impact_range, flash_range)
#define COMSIG_GLOB_EXPLOSION "!explosion"
/// Mob was created somewhere : (mob)
#define COMSIG_GLOB_MOB_CREATED "!mob_created"
/// Mob died somewhere : (mob/living, gibbed)
#define COMSIG_GLOB_MOB_DEATH "!mob_death"
/// A magic orb was picked up by a mob: (orb, mob/living)
#define COMSIG_GLOB_ORB_PICKUP "!orb_picked"
/// When spell is cast; (user, spell, targets)
#define COMSIG_GLOB_SPELL_CAST "!spell_cast"
/// When hand type spell cast_hand is called; (user, spell, target)
#define COMSIG_GLOB_SPELL_CAST_HAND "!spell_cast_hand"

//////////////////////////////////////////////////////////////////

#define SIGNAL_HANDLER SHOULD_NOT_SLEEP(TRUE)

// /datum signals
/// when a component is added to a datum: (/datum/component)
#define COMSIG_COMPONENT_ADDED "component_added"
/// before a component is removed from a datum because of RemoveComponent: (/datum/component)
#define COMSIG_COMPONENT_REMOVING "component_removing"
/// before a datum's Destroy() is called: (force), returning a nonzero value will cancel the qdel operation
#define COMSIG_PARENT_PREQDELETED "parent_preqdeleted"
/// just before a datum's Destroy() is called: (force), at this point none of the other components chose to interrupt qdel and Destroy will be called
#define COMSIG_PARENT_QDELETING "parent_qdeleting"

/// fires on the target datum when an element is attached to it (/datum/element)
#define COMSIG_ELEMENT_ATTACH "element_attach"
/// fires on the target datum when an element is attached to it  (/datum/element)
#define COMSIG_ELEMENT_DETACH "element_detach"
/// fires when the game starts
#define COMSIG_TICKER_STARTED "game_started"
/// fires when the round ends
#define COMSIG_ROUND_ENDED "round_ended"

/// sent every carbon Life()
#define COMSIG_CARBON_LIFE "carbon_life"
/// sent every time the security level changes
#define COMSIG_SECURITY_LEVEL_CHANGED "security_level_change"
/// fire by minds to do post-initialization behaviour
#define COMSIG_MIND_POST_INIT "mind_post_init"
/// Called on `/mob/living/proc/rejuvenate` (mob/living)
#define COMSIG_LIVING_REJUVENATE "living_rejuvenate"

/// fired when a goal is succeeded
#define COMSIG_GOAL_SUCCEEDED "goal_succeeded"
/// fired when a goal is failed
#define COMSIG_GOAL_FAILED "goal_failed"

// /atom/movable signals
/// When an atom's Dispell() proc is called; Passes dispell strength as argument.
#define COMSIG_ATOM_MOVABLE_DISPELL "atom_dispell"
// Return value of a signal handler if dispell should be blocked
#define COMPONENT_DISPELL_BLOCKED (1 << 0)

/// When spell is cast; (user, spell, targets)
#define COMSIG_SPELL_CAST "spell_cast"
/// When hand type spell cast_hand is called; (user, spell, target)
#define COMSIG_SPELL_CAST_HAND "spell_cast_hand"

/// Called on `/obj/structure/fitness/weightlifter/attack_hand` (/mob/living/carbon/human)
#define COMSIG_HUMAN_LIFT_WEIGHT "human_lift_weight"
/// Called on `/datum/tgui_module/email_client/tgui_act` (/mob/living)
#define COMSIG_SENT_EMAIL "sent_email"
/// Called on `/datum/species/hug` (/mob/living/carbon/human, /mob/living)
#define COMSIG_GAVE_HUG "gave_hug"
/// Called on `/datum/species/hug` (/mob/living, /mob/living/carbon/human)
#define COMSIG_RECEIVED_HUG "received_hug"
/// Called on `/mob/living/carbon/human/check_pulse` (/mob/living/carbon/human)
#define COMSIG_CHECKED_PULSE "checked_pulse"
/// Called on `/datum/wires/tgui_act` (/mob, text)
#define COMSIG_CUT_WIRE "cut_wire"
/// Called on `/obj/machinery/reagentgrinder/grind` (/mob, /obj/machinery/reagentgrinder)
#define COMSIG_GRINDING "grinding"
/// Called on `/obj/item/stack/produce_recipe` (/mob, /datum/stack_recipe, /atom)
#define COMSIG_PRODUCED_RECIPE "produced_recipe"
/// Called on `/obj/item/evidencebag/MouseDrop` (/mob/living/carbon/human, /obj/item/evidencebag, /obj/item)
#define COMSIG_BAGGED_EVIDENCE "bagged_evidence"
/// Called on `/mob/living/simple_animal/attackby` (/mob, /mob/living/simple_animal, /obj/item/material/knife/kitchen/cleaver)
#define COMSIG_BUTCHERED "butchered"

/// Called on `/obj/machinery/cryopod/despawn_occupant` (/mob)
#define COMSIG_HUMAN_DESPAWNED "human_despawned"

/// Called on `/mob/living/carbon/ingest` (/mob/living/carbon/, type)
#define COMSIG_REAGENT_INGESTED "reagent_ingested"
/// Called on `/obj/item/clothing/mask/smokable/smoke` (/datum, /obj/item/clothing/mask/smokable, number)
#define COMSIG_SMOKED_SMOKABLE "smoked_smokable"

///from base of mob/living/death(): (gibbed)
#define COMSIG_LIVING_DEATH "living_death"

/// Called on `/datum/money_account/deposit` (/datum/money_account)
#define COMSIG_MONEY_DEPOSITED "money_deposited"

/// Called on `/mob/living/say` (/mob/living, message, /datum/language)
#define COMSIG_LIVING_TREAT_MESSAGE "living_treat_message"
	#define SPEECH_ARG_MESSAGE 1
	#define SPEECH_ARG_LANGUAGE 2
	#define SPEECH_ARG_VERB 3
	#define SPEECH_ARG_ALT_NAME 4
	#define SPEECH_ARG_WHISPERING 5

/// Called on `/obj/item/proc/dropped` (/mob, /obj)
#define COMSIG_MOB_DROPPED_ITEM "mob_dropped_item"
/// Called on `/obj/item/proc/dropped` (/obj, /mob)
#define COMSIG_DROPPED_ITEM "dropped_item"

/// Called on `/atom/set_opacity` (/atom, old_opacity, new_opacity)
#define COMSIG_SET_OPACITY "set_opacity"

/// Called on `/obj/screen/zone_sel/set_selected_zone` (/obj/screen/zone_sel, selecting, old_selecting)
#define COMSIG_SET_SELECTED_ZONE "set_selected_zone"

/// Called on `/mob/set_stat` (/mob, stat)
#define COMSIG_SET_STAT "set_stat"
/// Called on `/mob/set_see_in_dark` (/mob, old value, new value)
#define COMSIG_SET_SEE_IN_DARK "set_see_in_dark"
/// Called on `/mob/set_see_invisible` (/mob, old value, new value)
#define COMSIG_SET_SEE_INVISIBLE "set_see_invisible"
/// Called on `/mob/set_sight` (/mob, old value, new value)
#define COMSIG_SET_SIGHT "set_sight"
/// Called on `/mob/set_invisibility` (/mob, old value, new value)
#define COMSIG_SET_INVISIBILITY "set_invisibility"
/// Called on `/mob/living/add_to_dead_mob_list` (/mob)
#define COMSIG_ADD_TO_DEAD_MOB_LIST "add_to_dead_mob_list"

/// Called on `/mob/swap_hand` (/mob)
#define COMSIG_SWAPPED_HANDS "swapped_hands"

/// Called on `/datum/shuttle/attempt_move` before moving (/datum/shuttle, destination, old_location)
#define COMSIG_SHUTTLE_PRE_MOVE "shuttle_pre_move"
/// Called on `/datum/shuttle/attempt_move` after moving (/datum/shuttle, destination, old_location)
#define COMSIG_SHUTTLE_MOVED "shuttle_moved"

/// Called on `/mob/living/silicon/robot/deselect_module` (/mob/living/silicon/robot, /obj/item)
#define COMSIG_ROBOT_DESELECTING_MODULE "robot_deselecting_module"
/// Called on `/mob/living/silicon/robot/uneq_active` and `/mob/living/silicon/robot/uneq_all` (/mob/living/silicon/robot, /obj/item)
#define COMSIG_ROBOT_DEACTIVATING_MODULE "robot_deactivating_module"


/// Called on `/obj/item/organ/removed` (/mob/living/carbon/human, /obj/item/organ)
#define COMSIG_ORGAN_DISMEMBERED "organ_dismembered"

/// Called on `/proc/do_after` (/user)
#define COMSIG_DO_AFTER_BEGAN "do_after_began"
/// Called on `/proc/do_after` (/user)
#define COMSIG_DO_AFTER_ENDED "do_after_ended"

/// Called on `/datum/chatserver_channel/add_message` (/datum/computer_file/program/chatserver, /datum/chatserver_channel, fullmessage)
#define COMSIG_SCIPRC_MESSAGE_SENT "sciprc_message_sent"
/// Called when a server program stops hosting (hosting program)
#define COMSIG_SERVER_PROGRAM_OFFLINE "server_program_offline"

/// From base of atom/movable/Moved(): (/atom)
#define COMSIG_MOVABLE_PRE_MOVE "movable_pre_move"
	/// Return this in a COMSIG_MOVABLE_PRE_MOVE signal proc to block movement.
	#define COMPONENT_MOVABLE_BLOCK_PRE_MOVE (1<<0)

/// From base of /client/Move(): (new_loc, direction)
#define COMSIG_MOB_CLIENT_PRE_MOVE "mob_client_pre_move"
	/// Return this in a COMSIG_MOB_CLIENT_PRE_MOVE signal proc to block movement.
	#define COMSIG_MOB_CLIENT_BLOCK_PRE_MOVE COMPONENT_MOVABLE_BLOCK_PRE_MOVE
	/// The argument of move_args which corresponds to the loc we're moving to
	#define MOVE_ARG_NEW_LOC 1
	/// The argument of move_args which dictates our movement direction
	#define MOVE_ARG_DIRECTION 2

/// An item has just been equipped by a mob. Called on obj/item/equipped(): (obj/item/equipped_item, mob/equipper, slot)
#define COMSIG_ITEM_EQUIPPED "item_equipped"
/// A mob has just equipped an item. Called on [/mob] from base of [/obj/item/equipped()]: (mob/equipper, obj/item/equipped_item, slot)
#define COMSIG_MOB_EQUIPPED_ITEM "mob_equipped_item"

/// Called on `/client` after `/datum/preferences/setup` has completed with prefs datum as argument.
#define COMSIG_CLIENT_PREFS_LOADED "client_prefs_loaded"

/*
*	Atom
*/

/// Called on `/atom/movable/Move` and `/atom/movable/proc/forceMove` (/atom/movable, /atom, /atom)
#define COMSIG_MOVED "moved"

/// Called on `/atom/Entered` (/atom, enterer, old_loc)
#define COMSIG_ENTERED "entered"

/// Called on `/atom/Exited` (/atom, exitee, new_loc)
#define COMSIG_EXITED "exited"

/// From base of atom/setDir(): (old_dir, new_dir). Called before the direction changes
#define COMSIG_ATOM_PRE_DIR_CHANGE "atom_pre_face_atom"
	#define COMPONENT_ATOM_BLOCK_DIR_CHANGE (1<<0)
/// From base of atom/setDir(): (old_dir, new_dir). Called before the direction changes.
#define COMSIG_ATOM_DIR_CHANGE "atom_dir_change"
/// From base of atom/setDir(): (old_dir, new_dir). Called after the direction changes.
#define COMSIG_ATOM_POST_DIR_CHANGE "atom_dir_change"
/// From base of [/atom/proc/update_desc]: (updates)
#define COMSIG_ATOM_UPDATE_DESC "atom_update_desc"

/*
*	Global
*/

/// Called on `/datum/controller/subsystem/shuttle/proc/initialize_shuttle` (/datum/ssdcs)
#define COMSIG_GLOB_SHUTTLE_INITIALIZED "!shuttle_initialized"

/// Called on `/mob/login` (/mob)
#define COMSIG_GLOB_MOB_LOGIN "!mob_login"
/// Called on `mob/logout` (/mob)
#define COMSIG_GLOB_MOB_LOGOUT "!mob_logout"

/*
*	Mob
*/

/// Called in '/mob/verb/examinate' on examined atom (/mob/examinee)
#define COMSIG_ATOM_EXAMINED "atomExamined"

/// Called in '/mob/living/say' on the mob who heard speech (/mob/living/speaker, message)
#define COMSIG_MOB_HEARD_SPEECH "mobHeardSpeech"
/// Called in '/mob/living/say' on the mob who heard the whisper (/mob/living/speaker, list(message)). Message is passed in a list so that back-editing is possible.
#define COMSIG_MOB_HEARD_WHISPER "mobHeardWhisper"
/// Called in 'mob/on_hear_say' on the mob who heard whatever message (/mob/hearer, message)
#define COMSIG_MOB_HEAR "mob_hear"

/// Called on `/mob/proc/update_movespeed` (/mob)
#define COMSIG_MOB_MOVESPEED_UPDATED "mob_movespeed_updated"

/// Called on `/mob/login` (/mob)
#define COMSIG_MOB_LOGIN "mob_login"
/// Called on `mob/logout` (/mob)
#define COMSIG_MOB_LOGOUT "mob_logout"

/*
*	Photos
*/

/// Called in '/obj/item/device/camera/proc/captureimage' on the atom taken a picture of (/obj/item/device/camera, mob/living/user)
#define COMSIG_PHOTO_TAKEN_OF "photoTakenOf"
/// Called in '/obj/item/photo/proc/show' on the atom that the photo was shown of (/obj/item/photo, mob/user)
#define COMSIG_PHOTO_SHOWN_OF "photoShownOf"

/*
*	Sound
*/

/// Called in '/mob/proc/playsound_local' on the atom that the sound originated from (/mob/hearer, sound)
#define COMSIG_OBJECT_SOUND_HEARD "atomHeard"
/// Called in '/datum/sound_token/proc/PrivUpdateListener' on the atom that the sound originated from (/mob/hearer, sound)
#define COMSIG_OBJECT_SOUND_HEARD_LOOPING "atomHeardLooping"

/*
*	Eye
*/

/// Called in '/mob/proc/reset_view' on every atom in view of new eyeobj (/mob/viewer, /atom/new_view)
#define COMSIG_ATOM_VIEW_RESET "atomViewReset"
