var/list/combatlog = list()
var/list/IClog     = list()
var/list/OOClog    = list()
var/list/adminlog  = list()

var/datum/configuration/config      = null
var/list/jobMax        = list()

var/diary               = null

GLOBAL_VAR(log_directory)
GLOBAL_PROTECT(log_directory)
GLOBAL_VAR(world_qdel_log)
GLOBAL_PROTECT(world_qdel_log)
GLOBAL_VAR(query_debug_log)
GLOBAL_PROTECT(query_debug_log)
