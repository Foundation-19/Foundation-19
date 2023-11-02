// All signals. Format:
// When the signal is called: (signal arguments)
// All signals send the source datum of the signal as the first argument

// global signals
// These are signals which can be listened to by any component on any parent

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
/// Called on `/mob/living/proc/revive` (mob/living)
#define COMSIG_LIVING_POST_REVIVE "living_post_revive"

/// fired when a goal is succeeded
#define COMSIG_GOAL_SUCCEEDED "goal_succeeded"
/// fired when a goal is failed
#define COMSIG_GOAL_FAILED "goal_failed"

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

/// Called on `/mob/login` (/mob)
#define COMSIG_MOB_LOGIN "mob_login"
/// Called on `mob/logout` (/mob)
#define COMSIG_MOB_LOGOUT "mob_logout"

/// Called on `/mob/living/carbon/ingest` (/mob/living/carbon/, type)
#define COMSIG_REAGENT_INGESTED "reagent_ingested"
/// Called on `/obj/item/clothing/mask/smokable/smoke` (/datum, /obj/item/clothing/mask/smokable, number)
#define COMSIG_SMOKED_SMOKABLE "smoked_smokable"

///from base of mob/living/death(): (gibbed)
#define COMSIG_LIVING_DEATH "living_death"
/// mob died somewhere : (mob/living, gibbed)
#define COMSIG_GLOB_MOB_DEATH "!mob_death"

/// Called on `/datum/money_account/deposit` (/datum/money_account)
#define COMSIG_MONEY_DEPOSITED "money_deposited"

/// Called on `/mob/living/say` (/mob/living, message)
#define COMSIG_LIVING_TREAT_MESSAGE "living_treat_message"

/// Called on `/proc/do_after` (/user)
#define COMSIG_DO_AFTER_BEGAN "do_after_began"
/// Called on `/proc/do_after` (/user)
#define COMSIG_DO_AFTER_ENDED "do_after_ended"

/*
* Atom
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

// Called on `/mob/proc/update_movespeed` (/mob)
#define COMSIG_MOB_MOVESPEED_UPDATED "mob_movespeed_updated"
