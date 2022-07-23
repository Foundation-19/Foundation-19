/*!!!!!!!!!!!!!!!!!!!!!
!Put your signals here!
!!!!!!!!!!!!!!!!!!!!!*/

/// Signifies that this proc is used to handle signals.
/// Every proc you pass to RegisterSignal must have this.
#define SIGNAL_HANDLER SHOULD_NOT_SLEEP(TRUE)

#define COMSIG_COMPONENT_ADDED "component_added"        //! when a component is added to a datum: (/datum/component)
#define COMSIG_COMPONENT_REMOVING "component_removing"  //! before a component is removed from a datum because of RemoveComponent: (/datum/component)
#define COMSIG_PARENT_PREQDELETED "parent_preqdeleted"			//! before a datum's Destroy() is called: (force), returning a nonzero value will cancel the qdel operation
#define COMSIG_PARENT_QDELETING "parent_qdeleting"				//! just before a datum's Destroy() is called: (force), at this point none of the other components chose to interrupt qdel and Destroy will be called


#define COMSIG_ELEMENT_ATTACH "element_attach" //! fires on the target datum when an element is attached to it (/datum/element)
#define COMSIG_ELEMENT_DETACH "element_detach" //! fires on the target datum when an element is attached to it  (/datum/element)
