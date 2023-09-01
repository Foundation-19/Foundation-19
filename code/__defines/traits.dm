#define SIGNAL_ADDTRAIT(trait_ref) "addtrait [trait_ref]"
#define SIGNAL_REMOVETRAIT(trait_ref) "removetrait [trait_ref]"

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target._status_traits) { \
			target._status_traits = list(); \
			_L = target._status_traits; \
			_L[trait] = list(source); \
			SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
		} else { \
			_L = target._status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
				SEND_SIGNAL(target, SIGNAL_ADDTRAIT(trait), trait); \
			} \
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target._status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L?[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_L)) { \
				target._status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAIT_NOT_FROM(target, trait, sources) \
	do { \
		var/list/_traits_list = target._status_traits; \
		var/list/_sources_list; \
		if (sources && !islist(sources)) { \
			_sources_list = list(sources); \
		} else { \
			_sources_list = sources\
		}; \
		if (_traits_list?[trait]) { \
			for (var/_trait_source in _traits_list[trait]) { \
				if (!(_trait_source in _sources_list)) { \
					_traits_list[trait] -= _trait_source \
				} \
			};\
			if (!length(_traits_list[trait])) { \
				_traits_list -= trait; \
				SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(trait), trait); \
			}; \
			if (!length(_traits_list)) { \
				target._status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target._status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T), _T); \
					}; \
				};\
			if (!length(_L)) { \
				target._status_traits = null\
			};\
		}\
	} while (0)

#define REMOVE_TRAITS_IN(target, sources) \
	do { \
		var/list/_L = target._status_traits; \
		var/list/_S = sources; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] -= _S;\
				if (!length(_L[_T])) { \
					_L -= _T; \
					SEND_SIGNAL(target, SIGNAL_REMOVETRAIT(_T)); \
					}; \
				};\
			if (!length(_L)) { \
				target._status_traits = null\
			};\
		}\
	} while (0)

#define HAS_TRAIT(target, trait) (target._status_traits?[trait] ? TRUE : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (HAS_TRAIT(target, trait) && (source in target._status_traits[trait]))
#define HAS_TRAIT_FROM_ONLY(target, trait, source) (HAS_TRAIT(target, trait) && (source in target._status_traits[trait]) && (length(target._status_traits[trait]) == 1))
#define HAS_TRAIT_NOT_FROM(target, trait, source) (HAS_TRAIT(target, trait) && (length(target._status_traits[trait] - source) > 0))
/// Returns a list of trait sources for this trait. Only useful for wacko cases and internal futzing
/// You should not be using this
#define GET_TRAIT_SOURCES(target, trait) target._status_traits?[trait] || list()
/// A simple helper for checking traits in a mob's mind
#define HAS_MIND_TRAIT(target, trait) (HAS_TRAIT(target, trait) || (target.mind ? HAS_TRAIT(target.mind, trait) : FALSE))

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
/// Forces the user to stay unconscious. TODO
#define TRAIT_KNOCKEDOUT "knockedout"
/// TODO: make this work
#define TRAIT_PACIFISM "pacifism"
/// Cannot be removed without admin intervention. TODO
#define ROUNDSTART_TRAIT "roundstart"
/// Lets the user succumb even if they've got NODEATH. TODO
#define TRAIT_SUCCUMB_OVERRIDE "succumb_override"
/// Prevents voluntary standing or staying up on its own. TODO
#define TRAIT_FLOORED "floored"
/// TODO: make this work
#define TRAIT_INCAPACITATED "incapacitated"
/// Prevents voluntary movement. TODO
#define TRAIT_IMMOBILIZED "immobilized"
/// TODO: implement
#define TRAIT_CLUMSY "clumsy"
/// TODO: implement
#define TRAIT_MUTE "mute"
/// TODO: implement
#define TRAIT_DISCOORDINATED_TOOL_USER "discoordinated_tool_user"
/// TODO: implement
#define TRAIT_NOFIRE "nofire"
/// TODO: implement
#define TRAIT_HANDS_BLOCKED "hands_blocked"
/// TODO: implement
#define TRAIT_SLEEPIMMUNE "sleepimmune"
/// TODO: implement
#define TRAIT_DEAF "deaf"
/// TODO: implement
#define TRAIT_NODEATH "nodeath"
/// In some kind of critical condition. Is able to succumb. TODO: implement
#define TRAIT_CRITICAL_CONDITION "critical-condition"
/// Guarantees the user can hear their own heartbeat
#define TRAIT_HEAR_HEARTBEAT "hear_heartbeat"

/// A trait given by any status effect
#define STATUS_EFFECT_TRAIT "status-effect"
/// A trait given by a specific status effect
#define TRAIT_STATUS_EFFECT(effect_id) "[effect_id]-trait"