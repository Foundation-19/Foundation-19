

#define FORENSIC_TYPE_FINGERPRINT "fingerprint"
#define FORENSIC_TYPE_DNA "dna"
#define FORENSIC_TYPE_ANOMALY "anomaly"
#define FORENSIC_TYPE_TRACE "trace"

#define FORENSIC_SCAN_TIER_BASIC 1
#define FORENSIC_SCAN_TIER_ADVANCED 2
#define FORENSIC_SCAN_TIER_EXPERIMENTAL 3

/datum/forensic_holder
	var/list/fingerprints
	var/list/dna_samples
	var/list/anomaly_evidence
	var/list/trace_evidence
	var/atom/owner

/datum/forensic_holder/New(atom/owner)
	src.owner = owner

/datum/forensic_holder/Destroy()
	owner = null
	return ..()

/datum/forensic_holder/proc/add_fingerprint(mob/M)
	if(!isliving(M) || !M.ckey)
		return
	LAZYINITLIST(fingerprints)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		fingerprints[H.ckey] = H.real_name
	else if(iscarbon(M) && !ishuman(M))
		fingerprints["unknown_carbon_[M.ckey]"] = "unknown_carbon"

/datum/forensic_holder/proc/add_dna(mob/living/carbon/M)
	if(!istype(M) || !M.dna)
		return
	LAZYINITLIST(dna_samples)
	dna_samples[M.dna.unique_enzymes] = M.real_name

/datum/forensic_holder/proc/add_anomaly(evidence_type, strength, source_id)
	LAZYINITLIST(anomaly_evidence)
	anomaly_evidence += list(list("type" = evidence_type, "strength" = strength, "source_id" = source_id, "time" = world.time))

/datum/forensic_holder/proc/add_trace(evidence_type, details)
	LAZYINITLIST(trace_evidence)
	trace_evidence += list(list("type" = evidence_type, "details" = details, "time" = world.time))

/datum/forensic_holder/proc/clean()
	LAZYNULL(fingerprints)
	LAZYNULL(dna_samples)
	LAZYNULL(anomaly_evidence)
	LAZYNULL(trace_evidence)

// Atom-side convenience hooks. NOTE: the is_blind-style macro trap does
// not apply here (no function-like macro name collisions).
/atom/var/datum/forensic_holder/forensic_holder

/atom/proc/ensure_forensic_holder()
	if(!forensic_holder)
		forensic_holder = new(src)
	return forensic_holder

/atom/proc/add_forensic_fingerprint(mob/M)
	ensure_forensic_holder()
	forensic_holder.add_fingerprint(M)

/atom/proc/add_forensic_dna(mob/living/carbon/M)
	ensure_forensic_holder()
	forensic_holder.add_dna(M)

/atom/proc/add_forensic_anomaly(evidence_type, strength, source_id)
	ensure_forensic_holder()
	forensic_holder.add_anomaly(evidence_type, strength, source_id)

/atom/proc/add_forensic_trace(evidence_type, details)
	ensure_forensic_holder()
	forensic_holder.add_trace(evidence_type, details)

/atom/proc/clean_forensic()
	if(forensic_holder)
		forensic_holder.clean()

/datum/forensic_scan_result
	var/target_name
	var/scan_tier
	var/list/fingerprints_found
	var/list/dna_found
	var/list/anomalies_found
	var/list/traces_found

/datum/forensic_scan_result/New(atom/target, tier, datum/forensic_holder/holder)
	target_name = target.name
	scan_tier = tier
	if(holder)
		fingerprints_found = holder.fingerprints ? holder.fingerprints.Copy() : null
		dna_found = holder.dna_samples ? holder.dna_samples.Copy() : null
		anomalies_found = holder.anomaly_evidence ? holder.anomaly_evidence.Copy() : null
		traces_found = holder.trace_evidence ? holder.trace_evidence.Copy() : null

/datum/forensic_scan_result/proc/format_output()
	var/list/report = list()
	report += SPAN_NOTICE("<b>Forensic Scan Report — [target_name]</b>")
	switch(scan_tier)
		if(FORENSIC_SCAN_TIER_BASIC)
			if(LAZYLEN(fingerprints_found))
				report += SPAN_NOTICE("Trace evidence detected: Fingerprints present.")
			else if(LAZYLEN(dna_found))
				report += SPAN_NOTICE("Trace evidence detected: DNA present.")
			else if(LAZYLEN(anomalies_found))
				report += SPAN_NOTICE("Trace evidence detected: Anomalous residue present.")
			else if(LAZYLEN(traces_found))
				report += SPAN_NOTICE("Trace evidence detected: Material traces present.")
			else
				report += SPAN_NOTICE("No trace evidence detected.")
		if(FORENSIC_SCAN_TIER_ADVANCED)
			if(LAZYLEN(fingerprints_found))
				report += SPAN_NOTICE("Fingerprints: [length(fingerprints_found)] print(s) found.")
			else
				report += SPAN_NOTICE("Fingerprints: None detected.")
			if(LAZYLEN(dna_found))
				report += SPAN_NOTICE("DNA: [length(dna_found)] sample(s) found.")
			else
				report += SPAN_NOTICE("DNA: None detected.")
			if(LAZYLEN(anomalies_found))
				report += SPAN_WARNING("Anomalous residue: [length(anomalies_found)] source(s) detected.")
			else
				report += SPAN_NOTICE("Anomalous residue: None detected.")
			if(LAZYLEN(traces_found))
				report += SPAN_NOTICE("Trace evidence: [length(traces_found)] trace(s) found.")
			else
				report += SPAN_NOTICE("Trace evidence: None detected.")
		if(FORENSIC_SCAN_TIER_EXPERIMENTAL)
			if(LAZYLEN(fingerprints_found))
				report += SPAN_NOTICE("<b>Fingerprints:</b>")
				for(var/key in fingerprints_found)
					report += SPAN_NOTICE("  - [fingerprints_found[key]] ([key])")
			else
				report += SPAN_NOTICE("Fingerprints: None detected.")
			if(LAZYLEN(dna_found))
				report += SPAN_NOTICE("<b>DNA Samples:</b>")
				for(var/enzyme in dna_found)
					report += SPAN_NOTICE("  - [dna_found[enzyme]] ([enzyme])")
			else
				report += SPAN_NOTICE("DNA: None detected.")
			if(LAZYLEN(anomalies_found))
				report += SPAN_WARNING("<b>Anomalous Residue:</b>")
				for(var/list/anomaly in anomalies_found)
					report += SPAN_WARNING("  - Type: [anomaly["type"]] | Strength: [anomaly["strength"]] | Source: [anomaly["source_id"]]")
			else
				report += SPAN_NOTICE("Anomalous residue: None detected.")
			if(LAZYLEN(traces_found))
				report += SPAN_NOTICE("<b>Trace Evidence:</b>")
				for(var/list/trace in traces_found)
					report += SPAN_NOTICE("  - Type: [trace["type"]] | Details: [trace["details"]]")
			else
				report += SPAN_NOTICE("Trace evidence: None detected.")
	return jointext(report, "\n")
