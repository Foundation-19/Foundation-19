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
/// Prevents the user from harming others. If you introduce some way to damage others (even indirectly), think about checking this.
#define TRAIT_PACIFISM "pacifism"
/// The mob is clumsy and liable to mess things up in serious situations.
#define TRAIT_CLUMSY "clumsy"
/// The mob can't talk
#define TRAIT_MUTE "mute"
/// The mob can use complicated tools
#define TRAIT_ADVANCED_TOOL_USER "advanced_tool_user"
/// The mob can't use complicated tools, even if they have TRAIT_ADVANCED_TOOL_USER
#define TRAIT_DISCOORDINATED_TOOL_USER "discoordinated_tool_user"
/// Prevents usage of manipulation appendages (picking, holding or using items, manipulating storage). Check for this if you would reasonably need to use your hands to do something.
#define TRAIT_HANDS_BLOCKED "hands_blocked"
/// The mob can't hear anything. can_hear() always returns FALSE.
#define TRAIT_DEAF "deaf"
/// In some kind of critical condition. Is able to succumb.
#define TRAIT_CRITICAL_CONDITION "critical-condition"
/// Guarantees the user can hear their own heartbeat
#define TRAIT_HEAR_HEARTBEAT "hear_heartbeat"
/// If the user is nearsighted, having this trait stops it from affecting them (e.g. if they have glasses on).
#define TRAIT_NEARSIGHTED_CORRECTED "nearsighted_corrected"
/// Inability to access UI hud elements.
#define TRAIT_UI_BLOCKED "uiblocked"
/// Prevents the user from using guns
#define TRAIT_FATFINGERS "fatfingers"

/**
 * Trait sources
 */

/// A trait given by any status effect
#define STATUS_EFFECT_TRAIT "status-effect"
/// A trait given by a specific status effect
#define TRAIT_STATUS_EFFECT(effect_id) "[effect_id]-trait"

/// Trait associated to a stat value or range of
#define STAT_TRAIT "stat"
/// Cannot be removed without admin intervention.
#define ROUNDSTART_TRAIT "roundstart"
/// Gained by wearing certain clothing.
#define CLOTHING_TRAIT "clothing"
/// Gained by being statue-ified
#define STATUE_MUTE_TRAIT "statue_mute"
/// Gained by having electronic glasses EMPed
#define GLASSES_EMPED_TRAIT "glasses_emped"
/// Gained by taking damage from welding without protection
#define UNSAFE_WELDING_TRAIT "unsafe_welding"
/// Gained by being stung by a changeling
#define LING_STUNG_TRAIT "ling_stung"
/// For borers; gained by the host having this trait
#define BORER_HOST_TRAIT "borer_host"
/// Gained by missing a relevant organ
#define MISSING_ORGAN_TRAIT "missing_organ"
/// Gained by having enough damage
#define DAMAGED_TRAIT "damaged"
/// Gained by having a certain equipment_tint_total
#define EQUIPMENT_TINT_TOTAL_TRAIT "equipment_tint_total"
