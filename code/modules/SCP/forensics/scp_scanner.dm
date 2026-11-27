

#define SCANNER_TIER_BASIC 1
#define SCANNER_TIER_ADVANCED 2
#define SCANNER_TIER_EXPERIMENTAL 3

/obj/item/scp_scanner
	name = "SCP scanner"
	desc = "A handheld device capable of scanning for anomalous signatures, medical conditions, and forensic evidence."
	icon = 'icons/obj/device.dmi'
	icon_state = "health"
	item_state = "healthanalyzer"
	w_class = ITEM_SIZE_SMALL
	slot_flags = SLOT_BELT
	item_flags = ITEM_FLAG_NO_BLUDGEON
	var/scanner_tier = SCANNER_TIER_BASIC
	var/scan_cooldown = 0
	var/scan_cooldown_time = 3 SECONDS
	var/last_scan_result = ""
	var/scan_beam_color = "#ff0000"

/obj/item/scp_scanner/attack(mob/living/target, mob/living/user)
	if(scan_cooldown > world.time)
		to_chat(user, SPAN_WARNING("[src] is recharging. Please wait."))
		return
	scan_cooldown = world.time + scan_cooldown_time
	flick("[icon_state]-scan", src)
	set_light(2, 1, 0.5, 2.5, scan_beam_color, TRUE)
	addtimer(CALLBACK(src, PROC_REF(scan_beam_off)), 3)
	resolve_scan(target, user)

/obj/item/scp_scanner/proc/scan_beam_off()
	set_light(0, 0, 0, 2.5, scan_beam_color, FALSE)

/obj/item/scp_scanner/proc/resolve_scan(mob/living/target, mob/living/user)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		scan_medical(H, user)
		if(H.SCP)
			scan_anomaly(H, user)
		if(H.forensic_holder)
			scan_forensic(H, user)
		return
	if(target?.SCP)
		scan_anomaly(target, user)
		if(target.forensic_holder)
			scan_forensic(target, user)
		return
	if(target?.forensic_holder)
		scan_forensic(target, user)
		return
	last_scan_result = "No significant readings detected on [target]."
	to_chat(user, SPAN_NOTICE(last_scan_result))

/obj/item/scp_scanner/proc/scan_medical(mob/living/carbon/human/H, mob/living/user)
	var/list/output = list()
	output += SPAN_NOTICE("<b>Medical Scan — [H.name]</b>")
	switch(scanner_tier)
		if(SCANNER_TIER_BASIC)
			if(H.health < H.maxHealth)
				output += SPAN_WARNING("Elevated biomarkers detected. Subject may require medical attention.")
			else
				output += SPAN_NOTICE("Vital signs within normal parameters.")
		if(SCANNER_TIER_ADVANCED)
			var/brute_pct = round(H.getBruteLoss() / H.maxHealth * 100, 0.1)
			var/burn_pct = round(H.getFireLoss() / H.maxHealth * 100, 0.1)
			var/tox_pct = round(H.getToxLoss() / H.maxHealth * 100, 0.1)
			var/oxy_pct = round(H.getOxyLoss() / H.maxHealth * 100, 0.1)
			output += SPAN_NOTICE("Brute: [brute_pct]% | Burn: [burn_pct]% | Toxin: [tox_pct]% | Oxy: [oxy_pct]%")
		if(SCANNER_TIER_EXPERIMENTAL)
			output += SPAN_NOTICE("Brute Loss: [H.getBruteLoss()] | Burn Loss: [H.getFireLoss()] | Toxin Loss: [H.getToxLoss()] | Oxy Loss: [H.getOxyLoss()]")
			if(H.sanity)
				output += SPAN_WARNING("Mental stability: [round(H.sanity.sanity_level, 1)]%")
	last_scan_result = jointext(output, "\n")
	to_chat(user, last_scan_result)

/obj/item/scp_scanner/proc/scan_anomaly(atom/target, mob/living/user)
	if(!target.SCP)
		return
	var/list/output = list()
	switch(scanner_tier)
		if(SCANNER_TIER_BASIC)
			output += SPAN_WARNING("Anomalous readings detected on [target]. Recommend further analysis.")
		if(SCANNER_TIER_ADVANCED)
			output += SPAN_WARNING("Anomalous readings detected on [target].")
			output += SPAN_NOTICE("Designation: SCP-[target.SCP.designation]")
			output += SPAN_NOTICE("Classification: [target.SCP.classification]")
		if(SCANNER_TIER_EXPERIMENTAL)
			output += SPAN_WARNING("Anomalous readings detected on [target].")
			output += SPAN_NOTICE("Designation: SCP-[target.SCP.designation]")
			output += SPAN_NOTICE("Classification: [target.SCP.classification]")
			output += SPAN_NOTICE("Name: [target.SCP.name]")
			if(target.SCP.metaFlags & SCP_MEMETIC)
				output += SPAN_USERDANGER("WARNING: Cognitohazard risk detected. Maintain safe distance.")
			if(target.forensic_holder)
				var/datum/forensic_holder/fh = target.forensic_holder
				if(LAZYLEN(fh.anomaly_evidence))
					output += SPAN_NOTICE("Anomalous forensic signatures present. Full forensic analysis recommended.")
	last_scan_result = jointext(output, "\n")
	to_chat(user, last_scan_result)

/obj/item/scp_scanner/proc/scan_forensic(atom/target, mob/living/user)
	if(!target.forensic_holder)
		return
	var/datum/forensic_holder/fh = target.forensic_holder
	var/datum/forensic_scan_result/result = new(target, scanner_tier, fh)
	last_scan_result = result.format_output()
	to_chat(user, last_scan_result)

/obj/item/scp_scanner/advanced
	name = "advanced SCP scanner"
	desc = "An upgraded handheld scanner with improved resolution and faster processing."
	scanner_tier = SCANNER_TIER_ADVANCED
	scan_cooldown_time = 2 SECONDS
	scan_beam_color = "#ffaa00"

/obj/item/scp_scanner/experimental
	name = "experimental SCP scanner"
	desc = "A prototype scanner with maximum scan resolution and near-instant processing."
	scanner_tier = SCANNER_TIER_EXPERIMENTAL
	scan_cooldown_time = 1 SECOND
	scan_beam_color = "#00ffcc"

/obj/item/scp_scanner_upgrade
	name = "SCP scanner upgrade module"
	desc = "A firmware module that upgrades an SCP scanner to the next tier."
	icon = 'icons/obj/module.dmi'
	icon_state = "speed"
	w_class = ITEM_SIZE_TINY

/obj/item/scp_scanner_upgrade/attack(obj/item/scp_scanner/target, mob/living/user)
	if(!istype(target))
		to_chat(user, SPAN_WARNING("[src] can only be used on SCP scanners."))
		return ..()
	if(target.scanner_tier >= SCANNER_TIER_EXPERIMENTAL)
		to_chat(user, SPAN_WARNING("[target] is already at maximum tier."))
		return ..()
	target.scanner_tier++
	switch(target.scanner_tier)
		if(SCANNER_TIER_ADVANCED)
			target.name = "advanced SCP scanner"
			target.scan_cooldown_time = 2 SECONDS
			target.scan_beam_color = "#ffaa00"
		if(SCANNER_TIER_EXPERIMENTAL)
			target.name = "experimental SCP scanner"
			target.scan_cooldown_time = 1 SECOND
			target.scan_beam_color = "#00ffcc"
	to_chat(user, SPAN_NOTICE("You upgrade [target] to tier [target.scanner_tier]."))
	qdel(src)
