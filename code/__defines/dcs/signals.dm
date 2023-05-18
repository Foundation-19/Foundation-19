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
/// fired by a human to access goal panel
#define COMSIG_OPENING_GOAL_TGUI "opening_goal_tgui"

/// fired by a human when it lifts a weight
#define COMSIG_HUMAN_LIFT_WEIGHT "human_lift_weight"
/// fired by an atom/movable when it moves
#define COMSIG_ATOM_MOVABLE_MOVED "atom_movable_moved"
/// fired by a mob/living when it sends an email via the email client
#define COMSIG_SENT_EMAIL "sent_email"
/// fired by a human when it gives someone a hug
#define COMSIG_GAVE_HUG "gave_hug"

/// fired by a human when it despawns (e.g. by a cryopod)
#define COMSIG_HUMAN_DESPAWNED "human_despawned"

/// fired by a mob/living/carbon when it ingests a reagent. IS DYNAMICALLY CONSTRUCTED: append reagent type onto the string
#define COMSIG_REAGENT_INGESTED_ "reagent_ingested_"
