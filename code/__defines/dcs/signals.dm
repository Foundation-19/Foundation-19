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

#define COMSIG_TICKER_STARTED "game_started"

/// sent every carbon Life()
#define COMSIG_CARBON_LIFE "carbon_life"

/// Called on `/mob/set_stat` (/mob, stat)
#define COMSIG_SET_STAT "set_stat"

/// Called on `/obj/item/proc/dropped` (/mob, /obj)
#define COMSIG_MOB_DROPPED_ITEM "mob_dropped_item"
/// Called on `/obj/item/proc/dropped` (/obj, /mob)
#define COMSIG_DROPPED_ITEM "dropped_item"

/// Called on `/atom/set_opacity` (/atom, old_opacity, new_opacity)
#define COMSIG_SET_OPACITY "set_opacity"

/*
* Atom
*/

/// Called in `/atom/movable/Move` and `/atom/movable/proc/forceMove` (/atom/movable, /atom, /atom)
#define COMSIG_MOVED "moved"

/// Called on `/atom/Entered` (/atom, enterer, old_loc)
#define COMSIG_ENTERED "entered"

/// Called on `/atom/Exited` (/atom, exitee, new_loc)
#define COMSIG_EXITED "exited"
