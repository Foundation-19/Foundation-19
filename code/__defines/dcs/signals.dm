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
/// fire by minds to do post-initialization behaviour
#define COMSIG_MIND_POST_INIT "mind_post_init"

/// fired when a goal is succeeded
#define COMSIG_GOAL_SUCCEEDED "goal_succeeded"
/// fired when a goal is failed
#define COMSIG_GOAL_FAILED "goal_failed"

/// fired by a human when it lifts a weight
#define COMSIG_HUMAN_LIFT_WEIGHT "human_lift_weight"
/// fired by a mob/living when it sends an email via the email client
#define COMSIG_SENT_EMAIL "sent_email"
/// fired by a human when it gives someone a hug
#define COMSIG_GAVE_HUG "gave_hug"
/// fired by a human on check_pulse()
#define COMSIG_CHECKED_PULSE "checked_pulse"
/// fired by a human when cutting wires. passes wire color as arg
#define COMSIG_CUT_WIRE "cut_wire"
/// fired by a human during /obj/machinery/reagentgrinder/proc/grind(). passes machine as arg
#define COMSIG_GRINDING "grinding"
/// fired by a human on /obj/item/stack/proc/produce_recipe. passes recipe as first arg and constructed atom as second arg
#define COMSIG_PRODUCED_RECIPE "produced_recipe"
/// fired by a human on /obj/item/evidencebag/MouseDrop. passes bag as first arg and item as second arg
#define COMSIG_BAGGED_EVIDENCE "bagged_evidence"
/// fired by a human on /mob/living/simple_animal/attackby with a /obj/item/material/knife/kitchen/cleaver. passes meat as first arg and cleaver as second
#define COMSIG_BUTCHERED "butchered"

/// fired by a human when it despawns (e.g. by a cryopod)
#define COMSIG_HUMAN_DESPAWNED "human_despawned"

/// fired by a mob/living/carbon when it ingests a reagent. IS DYNAMICALLY CONSTRUCTED: append reagent type onto the string
#define COMSIG_REAGENT_INGESTED "reagent_ingested"
/// fired by something when it smokes something (as in a cigarette). should pass the object being smoked and the amount of reagents
#define COMSIG_SMOKED_SMOKABLE "smoked_smokable"

/// fired by a bank account when it has money deposited into it
#define COMSIG_MONEY_DEPOSITED "money_deposited"

/*
* Atom
*/

/// Called in `/atom/movable/Move` and `/atom/movable/proc/forceMove` (/atom/movable, /atom, /atom)
#define COMSIG_MOVED "moved"

/// Called on `/atom/Entered` (/atom, enterer, old_loc)
#define COMSIG_ENTERED "entered"

/// Called on `/atom/Exited` (/atom, exitee, new_loc)
#define COMSIG_EXITED "exited"
