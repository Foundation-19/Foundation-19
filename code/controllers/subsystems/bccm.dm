// BCCM (Ban Counter Counter Measures system) ((Name subject to change)), originally inspired by EAMS (Epic Anti-Multiaccount System), by Epicus
//version 1.0.3

/datum/bccm_info
	var/is_loaded = FALSE
	var/is_whitelisted = FALSE

	var/ip
	var/ip_as
	var/ip_mobile
	var/ip_proxy
	var/ip_hosting

/client
	var/datum/bccm_info/bccm_info = new

SUBSYSTEM_DEF(bccm)
	name = "BCCM"
	init_order = SS_INIT_BCCM
	flags = SS_NO_FIRE

	var/max_error_count = 4

	var/is_active = FALSE
	var/error_counter = 0

	var/list/tgui_panel_asn_data = list()
	var/list/tgui_panel_wl_data = list()

	var/list/client/postponed_client_queue = list()

/datum/controller/subsystem/bccm/Initialize(timeofday)
	if(!config.bccm)
		return ..()

	if(!sqlenabled)
		log_debug("BCCM could not be loaded without SQL enabled")
		return ..()

	Toggle()
	return ..()

/datum/controller/subsystem/bccm/stat_entry(msg)
	return "[is_active ? "ACTIVE" : "OFFLINE"]"

/datum/controller/subsystem/bccm/proc/Toggle(mob/user)
	if (!initialized && user)
		return

	if(!is_active && !SSdbcore.Connect())
		log_debug("BCCM could not be loaded because the DB connection could not be established.")
		return

	is_active = !is_active
	log_debug("BCCM is [is_active ? "enabled" : "disabled"]!")

	. = is_active
	if(!.)
		return

	tgui_panel_asn_data = GetAsnBanlistDatabase()
	tgui_panel_wl_data = GetWhitelistDatabase()

	var/list/clients_to_check = postponed_client_queue.Copy()
	postponed_client_queue.Cut()
	for (var/client/C in clients_to_check)
		CollectClientData(C)
		HandleClientAccessCheck(C, postponed = TRUE)
		HandleASNbanCheck(C, postponed = TRUE)
		CHECK_TICK

/datum/controller/subsystem/bccm/proc/CheckDBCon()
	if(is_active && SSdbcore.Connect())
		return TRUE

	is_active = FALSE
	log_and_message_admins("A Database error has occured. BCCM is automatically disabled.")
	return FALSE


/datum/controller/subsystem/bccm/proc/CollectClientData(client/C)
	ASSERT(istype(C))

	var/_ip_addr = C.address

	if(!is_active)
		postponed_client_queue.Add(C)
		return

	if(!CheckDBCon())
		return

	C.bccm_info.is_whitelisted = CheckWhitelist(C.ckey)

	if(!_ip_addr || _ip_addr == "127.0.0.1")
		return

	var/list/response = GetAPIresponse(_ip_addr, C)

	if(!response)
		return

	C.bccm_info.ip = _ip_addr
	C.bccm_info.ip_as = response["as"]
	C.bccm_info.ip_mobile = response["mobile"]
	C.bccm_info.ip_proxy = response["proxy"]
	C.bccm_info.ip_hosting = response["hosting"]

	C.bccm_info.is_loaded = TRUE
	return

/datum/controller/subsystem/bccm/proc/GetAPIresponse(ip, client/C = null)
	var/list/response = LoadCachedData(ip)

	if(response && C)
		log_access("BCCM data for [C] ([ip]) is loaded from cache!")

	while(!response && is_active && error_counter < max_error_count)
		var/list/http = world.Export("http://ip-api.com/json/[ip]?fields=17025024")

		if(!http)
			if(C)
				log_and_message_admins("BCCM: API connection failed, could not check [C], retrying.")
			else
				log_and_message_admins("BCCM: API connection failed, could not check [ip], retrying.")
			error_counter += 1
			sleep(2)
			continue

		var/raw_response = file2text(http["CONTENT"])

		try
			response = json_decode(raw_response)
		catch (var/exception/e)
			log_and_message_admins("BCCM: JSON decode error, could not check [C]. JSON decode error: [e.name]")
			return

		if(response["status"] == "fail")
			log_and_message_admins("BCCM: Request error, could not check [C]. CheckIP response: [response["message"]]")
			return

		if(C)
			log_access("BCCM data for [C]([ip]) is loaded from external API!")
		CacheData(ip, raw_response)

	if(error_counter >= max_error_count && is_active)
		log_and_message_admins("BCCM was disabled due to connection errors!")
		is_active = FALSE
		return

	return response

/datum/controller/subsystem/bccm/proc/CheckForAccess(client/C)
	ASSERT(istype(C))

	if(!is_active)
		return TRUE

	if(!CheckDBCon())
		return TRUE

	if(!C.address || C.holder)
		return TRUE

	if(C.bccm_info.is_whitelisted)
		return TRUE

	if(C.bccm_info.is_loaded)
		if(!C.bccm_info.ip_proxy && !C.bccm_info.ip_hosting)
			return TRUE
		return FALSE

	log_and_message_admins("BCCM failed to load info for [C.ckey].")
	return TRUE

/datum/controller/subsystem/bccm/proc/CheckWhitelist(ckey)
	. = FALSE

	if(!CheckDBCon())
		return

	var/datum/db_query/query = SSdbcore.NewQuery("SELECT ckey FROM bccm_whitelist WHERE ckey = '[ckey]'")
	query.Execute()

	if(query.NextRow())
		. = TRUE

	qdel(query)

	return

/datum/controller/subsystem/bccm/proc/CheckASNban(client/C)
	ASSERT(istype(C))

	. = TRUE

	if(!is_active)
		return

	if(!CheckDBCon())
		return

	if(C.bccm_info.is_whitelisted)
		return

	var/datum/db_query/query = SSdbcore.NewQuery("SELECT `asn` FROM bccm_asn_ban WHERE asn = '[C.bccm_info.ip_as]'")
	query.Execute()

	if(query.NextRow())
		. = FALSE

	qdel(query)

	return

/datum/controller/subsystem/bccm/proc/LoadCachedData(ip)
	ASSERT(istext(ip))

	if(!CheckDBCon())
		return FALSE

	var/datum/db_query/_Cache_select_query = SSdbcore.NewQuery("SELECT response FROM bccm_ip_cache WHERE ip = '[ip]'")
	_Cache_select_query.Execute()

	if(!_Cache_select_query.NextRow())
		. = FALSE
	else
		. = json_decode(_Cache_select_query.item[1])

	qdel(_Cache_select_query)
	return

/datum/controller/subsystem/bccm/proc/CacheData(ip, raw_response)
	ASSERT(istext(ip))
	ASSERT(istext(raw_response))

	if(!CheckDBCon())
		return FALSE

	var/datum/db_query/_Cache_insert_query = SSdbcore.NewQuery("INSERT INTO bccm_ip_cache (`ip`, `response`) VALUES ('[ip]', '[raw_response]')")
	_Cache_insert_query.Execute()
	qdel(_Cache_insert_query)

	return TRUE

/datum/controller/subsystem/bccm/proc/AddToWhitelist(ckey_input, client/Admin)
	ASSERT(istype(Admin))

	if(!CheckDBCon())
		return

	var/ckey = new_sql_sanitize_text(ckey(ckey_input))

	if(!ckey)
		return

	var/datum/db_query/_Whitelist_Query = SSdbcore.NewQuery("INSERT INTO bccm_whitelist (`ckey`, `a_ckey`, `timestamp`) VALUES ('[ckey]', '[Admin.ckey]', Now())")
	_Whitelist_Query.Execute()
	qdel(_Whitelist_Query)

	tgui_panel_wl_data = GetWhitelistDatabase()
	log_and_message_admins("added [ckey] to BCCM whitelist.")

	return TRUE

/datum/controller/subsystem/bccm/proc/RemoveFromWhitelist(ckey, client/Admin)
	if(!CheckDBCon())
		return FALSE

	if(!CheckWhitelist(ckey))
		return

	var/datum/db_query/_Whitelist_Query = SSdbcore.NewQuery("DELETE FROM bccm_whitelist WHERE `ckey` = '[ckey]'")
	_Whitelist_Query.Execute()
	qdel(_Whitelist_Query)

	tgui_panel_wl_data = GetWhitelistDatabase()
	log_and_message_admins("removed [ckey] from BCCM whitelist.", Admin.mob)

	return TRUE

/datum/controller/subsystem/bccm/proc/GetWhitelistDatabase()
	var/datum/db_query/_Whitelist_DB_Select_Query = SSdbcore.NewQuery("SELECT `ckey`, `a_ckey`, `timestamp` from bccm_whitelist")
	_Whitelist_DB_Select_Query.Execute()

	var/list/result = list()

	while(_Whitelist_DB_Select_Query.NextRow())
		var/list/row = list()
		row["ckey"] = _Whitelist_DB_Select_Query.item[1]
		row["a_ckey"] = _Whitelist_DB_Select_Query.item[2]
		row["timestamp"] = _Whitelist_DB_Select_Query.item[3]

		result["displayData"] += list(row)

	qdel(_Whitelist_DB_Select_Query)

	return result

/datum/controller/subsystem/bccm/proc/AddASNban(address, client/Admin)
	if(!CheckDBCon())
		return

	if(!check_rights(R_SERVER, TRUE, Admin))
		return

	var/ip = remove_all_spaces(new_sql_sanitize_text(address))

	if(length(ip) > 16)
		return

	var/list/response = GetAPIresponse(ip)

	var/ip_as = response["as"]

	var/datum/db_query/_ASban_Insert_Query = SSdbcore.NewQuery("INSERT INTO bccm_asn_ban (`ip`, `asn`, `a_ckey`, `timestamp`) VALUES ('[ip]', '[ip_as]', '[Admin.ckey]', Now())")
	_ASban_Insert_Query.Execute()
	qdel(_ASban_Insert_Query)

	tgui_panel_asn_data = GetAsnBanlistDatabase()
	log_and_message_admins("has added '[ip_as]' to the BCCM ASN banlist.", Admin)

	return TRUE

/datum/controller/subsystem/bccm/proc/RemoveASNban(ip_as, client/Admin)
	if(!CheckDBCon())
		return

	if(!check_rights(R_SERVER, TRUE, Admin))
		return

	var/datum/db_query/_ASban_Delete_Query = SSdbcore.NewQuery("DELETE FROM bccm_asn_ban WHERE `asn` = '[ip_as]'")
	_ASban_Delete_Query.Execute()
	qdel(_ASban_Delete_Query)

	tgui_panel_asn_data = GetAsnBanlistDatabase()
	log_and_message_admins("has removed '[ip_as]' from the BCCM ASN banlist.", Admin)

	return TRUE


/datum/controller/subsystem/bccm/proc/GetAsnBanlistDatabase()
	var/datum/db_query/_ASN_Banlist_Select_Query = SSdbcore.NewQuery("SELECT `asn`, `timestamp`, `a_ckey` from bccm_asn_ban")
	_ASN_Banlist_Select_Query.Execute()

	var/list/result = list()

	while(_ASN_Banlist_Select_Query.NextRow())
		var/list/row = list()
		row["asn"] = _ASN_Banlist_Select_Query.item[1]
		row["timestamp"] = _ASN_Banlist_Select_Query.item[2]
		row["a_ckey"] = _ASN_Banlist_Select_Query.item[3]

		result["displayData"] += list(row)

	qdel(_ASN_Banlist_Select_Query)

	return result


/datum/controller/subsystem/bccm/proc/HandleClientAccessCheck(client/C, postponed = 0)
	if(!SSbccm.CheckForAccess(C) && !(C.ckey in GLOB.admin_datums))
		if(!postponed)
			C.log_client_to_db_connection_log()
		log_and_message_admins(SPAN_NOTICE("BCCM: Failed Login: [C.key]/[C.ckey]([C.address])([C.computer_id]) failed to pass BCCM check."))
		qdel(C)
		return

/datum/controller/subsystem/bccm/proc/HandleASNbanCheck(client/C, postponed = 0)
	if(!SSbccm.CheckASNban(C) && !(C.ckey in GLOB.admin_datums))
		if(!postponed)
			C.log_client_to_db_connection_log()
		log_and_message_admins(SPAN_NOTICE("BCCM: Failed Login: [C.key]/[C.ckey]([C.address])([C.computer_id]) failed to pass ASN ban check."))
		qdel(C)
		return

/client/proc/BCCM_toggle()
	set category = "Server"
	set name = "Toggle BCCM"

	if(!check_rights(R_SERVER))
		return

	if(!SSdbcore.Connect())
		to_chat(usr, SPAN_NOTICE("The Database is not connected!"))
		return

	var/bccm_status = SSbccm.Toggle()
	log_and_message_admins("has [bccm_status ? "enabled" : "disabled"] the BCCM system!")


