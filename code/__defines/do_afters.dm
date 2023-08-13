// timed_action_flags parameter for `/proc/do_after`
/// Can do the action even if the user moves
#define DO_USER_CAN_MOVE     (1<<0)
/// Can do the action even if the user changes direction
#define DO_USER_CAN_TURN     (1<<1)
/// User can change the item they're currently holding
#define DO_USER_IGNORE_ITEM  (1<<2)
/// User must not switch hands during the do_after
#define DO_USER_SAME_HAND    (1<<3)
/// User must not switch targetting zones during the do_after
#define DO_USER_SAME_ZONE    (1<<4)
/// Can do the action even if the target moves
#define DO_TARGET_CAN_MOVE   (1<<5)
/// Can do the action even if the target changes direction
#define DO_TARGET_CAN_TURN   (1<<6)
/// Other do_afters targetting the same target will be blocked
#define DO_TARGET_UNIQUE_ACT (1<<7)
/// The user will see a bar representing do_after progress
#define DO_SHOW_USER         (1<<8)
/// The target will see a bar representing do_after progress
#define DO_SHOW_TARGET       (1<<9)
/// Used to prevent important slowdowns from being reducible
#define IGNORE_SLOWDOWNS     (1<<10)

#define DO_BOTH_CAN_MOVE     (DO_USER_CAN_MOVE | DO_TARGET_CAN_MOVE)
#define DO_BOTH_CAN_TURN     (DO_USER_CAN_TURN | DO_TARGET_CAN_TURN)
#define DO_DEFAULT           (DO_SHOW_USER | DO_USER_SAME_HAND | DO_BOTH_CAN_TURN)

#define DOING_INTERACTION(user, interaction_key) (LAZYACCESS(user.do_afters, interaction_key))
#define DOING_INTERACTION_LIMIT(user, interaction_key, max_interaction_count) ((LAZYACCESS(user.do_afters, interaction_key) || 0) >= max_interaction_count)
#define DOING_INTERACTION_WITH_TARGET(user, target) (LAZYACCESS(user.do_afters, target))
#define DOING_INTERACTION_WITH_TARGET_LIMIT(user, target, max_interaction_count) ((LAZYACCESS(user.do_afters, target) || 0) >= max_interaction_count)
