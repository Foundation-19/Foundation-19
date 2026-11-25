/obj/item/paper/foundation/incident_report
	name = "Incident Report Form"
	desc = "A standard Foundation incident report form."

/obj/item/paper/foundation/incident_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - INCIDENT REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Reporting Personnel:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Department:</b> [circle]Security [circle]Science [circle]Medical [circle]Engineering [circle]Logistics [circle]Other<br><hr>
<b>Incident Type:</b><br>
[check] Containment Breach<br>
[check] SCP Exposure / Contact<br>
[check] Personnel Injury / Fatality<br>
[check] Security Violation<br>
[check] Equipment Failure<br>
[check] Unexplained Phenomenon<br>
[check] Other: [field]<br><hr>
<b>SCP Designation (if applicable):</b> [field]<br>
<b>Location of Incident:</b> [field]<br>
<b>Time of Incident:</b> [field]<br><hr>
<b>Description of Incident:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Personnel Involved:</b><br>
1. [field] (Role: [field])<br>
2. [field] (Role: [field])<br>
3. [field] (Role: [field])<br><hr>
<b>Immediate Actions Taken:</b><br>
[field]<br>
[field]<br><hr>
<b>Recommendations:</b><br>
[field]<br>
[field]<br><hr>
<b>Reporting Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor Review:</b> [field] <b>Date:</b> [field]<br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/testing_request
	name = "SCP Testing Request Form"
	desc = "A Foundation form for requesting supervised SCP testing."

/obj/item/paper/foundation/testing_request/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - TESTING REQUEST</h2><hr>
<b>Request ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Requesting Researcher:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Department:</b> [field]<br><hr>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Objective:</b><br>
[field]<br>
[field]<br><hr>
<b>Test Procedure (detailed):</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Required Resources:</b><br>
[field]<br><hr>
<b>D-Class Personnel Required:</b> [field]<br>
<b>Equipment Required:</b> [field]<br>
<b>Estimated Duration:</b> [field]<br><hr>
<b>Risk Assessment:</b><br>
[circle]Low [circle]Medium [circle]High [circle]Extreme<br><hr>
<b>Safety Precautions:</b><br>
[field]<br>
[field]<br><hr>
<b>Researcher Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Senior Researcher Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Site Director Approval:</b> [field] <b>Date:</b> [field]<br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/amnestic_record
	name = "Amnestic Administration Record"
	desc = "A Foundation form for documenting amnestic use."

/obj/item/paper/foundation/amnestic_record/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - AMNESTIC ADMINISTRATION RECORD</h2><hr>
<b>Record ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Administering Personnel:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>Subject Name:</b> [field]<br>
<b>Subject Type:</b> [circle]Civilian [circle]Foundation Personnel [circle]D-Class [circle]Other<br>
<b>Reason for Administration:</b><br>
[check] Unintended SCP Exposure<br>
[check] Security Leak<br>
[check] Information Compromise<br>
[check] Standard Protocol<br>
[check] Other: [field]<br><hr>
<b>Amnestic Class:</b> [circle]A [circle]B [circle]C [circle]E<br>
<b>Dosage:</b> [field]<br>
<b>Method of Administration:</b> [circle]Oral [circle]Intravenous [circle]Inhalation [circle]Topical<br><hr>
<b>Memories Targeted for Removal:</b><br>
[field]<br>
[field]<br><hr>
<b>Pre-Administration Assessment:</b><br>
[field]<br><hr>
<b>Post-Administration Assessment:</b><br>
[field]<br><hr>
<b>Complications:</b> [circle]None [circle]Describe: [field]<br><hr>
<b>Administering Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor Approval:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - LEVEL 3 CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/breach_report
	name = "Containment Breach Report"
	desc = "A Foundation form for documenting containment breaches."

/obj/item/paper/foundation/breach_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - CONTAINMENT BREACH REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date of Breach:</b> [field]<br>
<b>Time of Breach:</b> [field]<br><hr>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter<br>
<b>Previous Containment Status:</b> [circle]Contained [circle]Partial [circle]Pending<br><hr>
<b>Breach Location:</b> [field]<br>
<b>Breach Severity:</b> [circle]Minor [circle]Moderate [circle]Major [circle]Catastrophic<br><hr>
<b>Sequence of Events:</b><br>
1. [field]<br>
2. [field]<br>
3. [field]<br>
4. [field]<br>
5. [field]<br><hr>
<b>Personnel Casualties:</b> [field]<br>
<b>D-Class Casualties:</b> [field]<br>
<b>Personnel Injured:</b> [field]<br><hr>
<b>Containment Failure Cause:</b><br>
[check] Equipment Malfunction<br>
[check] Human Error<br>
[check] Sabotage / External Action<br>
[check] SCP-Initiated<br>
[check] Structural Failure<br>
[check] Unknown<br>
[check] Other: [field]<br><hr>
<b>Recontainment Status:</b><br>
[check] Recontained - Time: [field]<br>
[check] In Progress<br>
[check] Pending MTF Deployment<br>
[check] Not Recontained<br><hr>
<b>Preventive Measures Recommended:</b><br>
[field]<br>
[field]<br><hr>
<b>Reporting Signature:</b> [field]<br>
<b>Security Director Review:</b> [field]<br>
<b>Site Director Review:</b> [field]<br>
<br><i>CLASSIFIED - LEVEL 3 CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/dclass_transfer
	name = "D-Class Transfer Form"
	desc = "A Foundation form for D-Class personnel transfers."

/obj/item/paper/foundation/dclass_transfer/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - D-CLASS TRANSFER FORM</h2><hr>
<b>Transfer ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>D-Class Designation:</b> D-[field]<br>
<b>Origin Facility:</b> [field]<br>
<b>Destination:</b> Site-53<br><hr>
<b>Assignment:</b><br>
[check] General Labor<br>
[check] Medical Testing<br>
[check] SCP Testing<br>
[check] Maintenance<br>
[check] Kitchen Duty<br>
[check] Mining Operations<br><hr>
<b>Medical Clearance:</b> [circle]Cleared [circle]Restricted - Notes: [field]<br>
<b>Behavioral Assessment:</b> [circle]Compliant [circle]Unstable [circle]Hostile<br><hr>
<b>Special Notes:</b><br>
[field]<br><hr>
<b>Authorizing Officer:</b> [field] <b>Date:</b> [field]<br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/scp_document
	name = "SCP Object Document"
	desc = "A classified SCP object documentation form."

/obj/item/paper/foundation/scp_document/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - CLASSIFIED OBJECT FILE</h2><hr>
<b>Item #:</b> SCP-[field]<br><hr>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon [circle]Neutralized<br><hr>
<b>Special Containment Procedures:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Description:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Addendum 1 - Discovery:</b><br>
[field]<br><hr>
<b>Addendum 2 - Incident Log:</b><br>
[field]<br><hr>
<b>Addendum 3 - Testing Log:</b><br>
[field]<br><hr>
<br><i>CLASSIFIED - CLEARANCE LEVEL VARIES BY SCP DESIGNATION</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/stamp/foundation
	name = "Foundation Stamp"
	desc = "A rubber stamp for stamping Foundation documents."
	icon_state = "stamp-cap"

/obj/item/stamp/foundation/director
	name = "Site Director Stamp"
	desc = "A rubber stamp marked 'Site Director - Site-53'."
	icon_state = "stamp-cap"

/obj/item/stamp/foundation/security
	name = "Security Director Stamp"
	desc = "A rubber stamp marked 'Security Director'."
	icon_state = "stamp-hos"

/obj/item/stamp/foundation/research
	name = "Research Director Stamp"
	desc = "A rubber stamp marked 'Research Director'."
	icon_state = "stamp-rd"

/obj/item/stamp/foundation/medical
	name = "Medical Director Stamp"
	desc = "A rubber stamp marked 'Medical Director'."
	icon_state = "stamp-cmo"

/obj/item/stamp/foundation/classified
	name = "CLASSIFIED Stamp"
	desc = "A red stamp for marking documents as classified."
	icon_state = "stamp-deny"

/obj/item/stamp/foundation/approved
	name = "APPROVED Stamp"
	desc = "A green stamp for approving documents."
	icon_state = "stamp-ok"

/obj/item/folder/foundation
	name = "Foundation Folder"
	desc = "A Foundation-branded manila folder."
	icon_state = "folder_manila"

/obj/item/folder/foundation/classified
	name = "Classified Folder"
	desc = "A red folder marked 'CLASSIFIED'. Handle with appropriate clearance."
	icon_state = "folder_red"

/obj/item/folder/foundation/top_secret
	name = "Top Secret Folder"
	desc = "A black folder marked 'TOP SECRET - O5 EYES ONLY'."
	icon_state = "folder_black"

/obj/item/paper/foundation/budget_request
	name = "Budget Funding Request"
	desc = "A Foundation form for requesting departmental budget allocation."

/obj/item/paper/foundation/budget_request/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - BUDGET FUNDING REQUEST</h2><hr>
<b>Request ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Requesting Personnel:</b> [field]<br>
<b>Department:</b> [circle]Command [circle]Security [circle]Science [circle]Medical [circle]Engineering [circle]Logistics [circle]Service<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>Amount Requested (credits):</b> [field]<br>
<b>Purpose:</b><br>
[field]<br>
[field]<br><hr>
<b>Justification:</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Expected Outcome:</b><br>
[field]<br><hr>
<b>Alternative Funding Sources Considered:</b><br>
[field]<br><hr>
<b>Requesting Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Department Head Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Bureaucrat Review:</b> [field] <b>Date:</b> [field]<br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/ethics_violation
	name = "Ethics Committee Violation Report"
	desc = "A Foundation form for reporting ethics violations in SCP testing or personnel treatment."

/obj/item/paper/foundation/ethics_violation/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - ETHICS COMMITTEE VIOLATION REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Reporting Personnel:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>Violation Severity:</b> [circle]Minor [circle]Moderate [circle]Major [circle]Critical<br>
<b>Violation Type:</b><br>
[check] Unnecessary D-Class Suffering<br>
[check] Testing Without Approval<br>
[check] Cruel and Unusual Procedures<br>
[check] Withholding Medical Treatment<br>
[check] Unauthorized Amnestic Use<br>
[check] SCP Mistreatment<br>
[check] Other: [field]<br><hr>
<b>SCP Designation (if applicable):</b> SCP-[field]<br>
<b>Personnel Involved in Violation:</b><br>
1. [field] (Role: [field])<br>
2. [field] (Role: [field])<br><hr>
<b>Description of Violation:</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Witnesses:</b><br>
[field]<br><hr>
<b>Recommended Action:</b><br>
[field]<br><hr>
<b>Reporting Signature:</b> [field] <b>Date:</b> [field]<br>
<b>ECL Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - ETHICS COMMITTEE EYES ONLY</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/psych_evaluation
	name = "Psychological Evaluation Form"
	desc = "A Foundation form for documenting psychological evaluations of personnel."

/obj/item/paper/foundation/psych_evaluation/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - PSYCHOLOGICAL EVALUATION</h2><hr>
<b>Evaluation ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Subject Name:</b> [field]<br>
<b>Subject Role:</b> [field]<br>
<b>Evaluating Psychologist:</b> [field]<br><hr>
<b>Evaluation Type:</b> [circle]Routine [circle]Post-Incident [circle]Pre-Employment [circle]SCP Exposure Follow-up<br><hr>
<b>Current Sanity Assessment:</b> [circle]Stable [circle]Mild Distress [circle]Moderate Distress [circle]Severe Distress [circle]Critical<br>
<b>SCP Exposure Level:</b> [circle]None [circle]Low [circle]Moderate [circle]Severe [circle]Critical<br><hr>
<b>Behavioral Observations:</b><br>
[field]<br>
[field]<br><hr>
<b>Cognitive Function:</b> [circle]Intact [circle]Mildly Impaired [circle]Moderately Impaired [circle]Severely Impaired<br>
<b>Emotional State:</b> [circle]Stable [circle]Anxious [circle]Depressed [circle]Agitated [circle]Unstable<br>
<b>Social Functioning:</b> [circle]Normal [circle]Withdrawn [circle]Hostile [circle]Paranoid<br><hr>
<b>Diagnosis:</b><br>
[field]<br><hr>
<b>Recommendations:</b><br>
[check] No Action Required<br>
[check] Counseling Sessions Recommended<br>
[check] Amnestic Treatment Recommended (Class: [field])<br>
[check] Temporary Duty Restriction<br>
[check] Permanent Reassignment<br>
[check] Medical Leave<br><hr>
<b>Amnestic Recommendation Justification (if applicable):</b><br>
[field]<br><hr>
<b>Evaluating Psychologist Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Medical Director Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CONFIDENTIAL - MEDICAL CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/investigation_report
	name = "Anomalous Investigation Report"
	desc = "A Foundation form for reporting findings from anomalous investigations."

/obj/item/paper/foundation/investigation_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - ANOMALOUS INVESTIGATION REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date:</b> [field]<br><hr>
<b>Investigating Agent:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>Case Name:</b> [field]<br>
<b>Investigation Type:</b> [circle]Anomalous Evidence [circle]SCP-Related [circle]Personnel [circle]Unknown Phenomenon<br><hr>
<b>Location of Investigation:</b> [field]<br>
<b>SCP Designation (if applicable):</b> SCP-[field]<br><hr>
<b>Evidence Collected:</b><br>
1. [field] (Type: [field] ID: [field])<br>
2. [field] (Type: [field] ID: [field])<br>
3. [field] (Type: [field] ID: [field])<br><hr>
<b>Findings:</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Analysis Summary:</b><br>
[field]<br>
[field]<br><hr>
<b>Recommended Actions:</b><br>
[field]<br><hr>
<b>Investigating Agent Signature:</b> [field] <b>Date:</b> [field]<br>
<b>RAISA Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - RAISA CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/intel_report
	name = "Intelligence Report"
	desc = "A Foundation form for RAISA intelligence reports."

/obj/item/paper/foundation/intel_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - INTELLIGENCE REPORT</h2><hr>
<b>Report ID:</b> RAISA-[field]<br>
<b>Date:</b> [field]<br>
<b>Classification:</b> [circle]UNCLASSIFIED [circle]CONFIDENTIAL [circle]SECRET [circle]TOP SECRET<br><hr>
<b>Analyst:</b> [field]<br>
<b>Report Type:</b> [circle]Surveillance [circle]Threat Assessment [circle]GOI Activity [circle]Information Security [circle]Personnel<br><hr>
<b>Target/Subject:</b> [field]<br>
<b>Threat Assessment (0-100):</b> [field]<br><hr>
<b>Summary:</b><br>
[field]<br>
[field]<br><hr>
<b>Detailed Findings:</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Recommendations:</b><br>
[field]<br><hr>
<b>Attachments:</b> [field]<br>
<b>Analyst Signature:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - RAISA CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/goi_communique
	name = "GOI Communique"
	desc = "A Foundation form for recording communications with Groups of Interest."

/obj/item/paper/foundation/goi_communique/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - GOI COMMUNIQUE</h2><hr>
<b>Communique ID:</b> [field]<br>
<b>Date:</b> [field]<br>
<b>Classification:</b> [circle]CONFIDENTIAL [circle]SECRET [circle]TOP SECRET<br><hr>
<b>GOI Name:</b> [field]<br>
<b>Current Standing:</b> [circle]Hostile [circle]Unfriendly [circle]Neutral [circle]Friendly [circle]Allied<br><hr>
<b>Foundation Representative:</b> [field]<br>
<b>GOI Representative:</b> [field]<br>
<b>Meeting Location:</b> [field]<br><hr>
<b>Purpose of Communication:</b><br>
[field]<br><hr>
<b>Summary of Discussion:</b><br>
[field]<br>
[field]<br><hr>
<b>Agreements Reached:</b><br>
[field]<br><hr>
<b>Standing Impact Assessment:</b><br>
[circle]No Change [circle]Improved [circle]Deteriorated<br><hr>
<b>Follow-up Actions Required:</b><br>
[field]<br><hr>
<b>Foundation Representative Signature:</b> [field] <b>Date:</b> [field]<br>
<b>GOI Relations Director Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - GOI RELATIONS CLEARANCE REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/test_authorization
	name = "SCP Test Authorization Form"
	desc = "A Foundation form for authorizing supervised SCP testing."

/obj/item/paper/foundation/test_authorization/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - TEST AUTHORIZATION FORM</h2><hr>
<b>Project ID:</b> [field]<br>
<b>Date:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Requesting Researcher:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Department:</b> [field]<br><hr>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b><br>
[check] Observation<br>
[check] Physical Interaction<br>
[check] Stress Testing<br>
[check] Audio / Visual Exposure<br>
[check] Biological Sampling<br>
[check] Cognitive / Memetic Exposure<br>
[check] Chemical Analysis<br>
[check] Other: [field]<br><hr>
<b>Risk Assessment:</b><br>
[check] Level 1 - Minimal Risk<br>
[check] Level 2 - Low Risk<br>
[check] Level 3 - Medium Risk (Ethics Review Required)<br>
[check] Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
[check] Level 5 - Extreme Risk (O5 Consultation Required)<br><hr>
<b>D-Class Subject Designation:</b> D-[field]<br>
<b>Number of Subjects Required:</b> [field]<br><hr>
<b>Test Objective:</b><br>
[field]<br>
[field]<br><hr>
<b>Test Procedure (detailed):</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Required Resources / Equipment:</b><br>
[field]<br><hr>
<b>Safety Precautions:</b><br>
[field]<br>
[field]<br><hr>
<b>Contingency Plan (if test deviates):</b><br>
[field]<br><hr>
<b>Ethics Review Required:</b> [circle]Yes [circle]No (mandatory if Risk >= 3)<br>
<b>Ethics Committee Case #:</b> [field]<br><hr>
<b>Researcher Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Senior Researcher Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor / Director Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Liaison Approval:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/test_authorization/proc/autofill_from_project(list/project, mob/user)
	var/researcher_name = "________"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		researcher_name = H.real_name
	var/scp_target = project["scp_target"] || "________"
	var/risk_level = project["risk_level"] || 1
	var/risk_text = "Level [risk_level] - "
	risk_text += risk_level >= 5 ? "Extreme Risk (O5 Consultation Required)" : risk_level >= 4 ? "High Risk (Ethics Review + Director Approval Required)" : risk_level >= 3 ? "Medium Risk (Ethics Review Required)" : risk_level >= 2 ? "Low Risk" : "Minimal Risk"
	var/ethics_required = risk_level >= 3 ? "Yes (mandatory at Risk Level [risk_level])" : "No"
	var/approved_by = project["approved_by"] || "________"
	var/approval_date = "________"
	if(project["approval_time"])
		approval_date = time2text(project["approval_time"], "MM/DD/YYYY")
	info = @{"<h2>SCP FOUNDATION - TEST AUTHORIZATION FORM</h2><hr>
<b>Project ID:</b> [project["id"] || project["name"] || "________"]<br>
<b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Requesting Researcher:</b> [researcher_name]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Department:</b> [project["research_field"] || "Research"]<br><hr>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b><br>
[check] Observation<br>
[check] Physical Interaction<br>
[check] Stress Testing<br>
[check] Audio / Visual Exposure<br>
[check] Biological Sampling<br>
[check] Cognitive / Memetic Exposure<br>
[check] Chemical Analysis<br>
[check] Other: [field]<br><hr>
<b>Risk Assessment:</b><br>
[check] Level 1 - Minimal Risk<br>
[check] Level 2 - Low Risk<br>
[check] Level 3 - Medium Risk (Ethics Review Required)<br>
[check] Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
[check] Level 5 - Extreme Risk (O5 Consultation Required)<br>
<i>Assessed Risk: [risk_text]</i><br><hr>
<b>D-Class Subject Designation:</b> D-[field]<br>
<b>Number of Subjects Required:</b> [field]<br><hr>
<b>Test Objective:</b><br>
[project["description"] || "________"]<br><hr>
<b>Test Procedure (detailed):</b><br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Required Resources / Equipment:</b><br>
[field]<br><hr>
<b>Safety Precautions:</b><br>
[field]<br>
[field]<br><hr>
<b>Contingency Plan (if test deviates):</b><br>
[field]<br><hr>
<b>Ethics Review Required:</b> [ethics_required]<br>
<b>Ethics Committee Case #:</b> [field]<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Senior Researcher Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor / Director Approval:</b> [approved_by] <b>Date:</b> [approval_date]<br>
<b>Ethics Liaison Approval:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	name = "SCP Test Authorization Form - [project["name"] || "SCP-[scp_target]"]"

/obj/item/paper/foundation/test_authorization/proc/autofill_from_proposal(list/proposal, mob/user)
	var/researcher_name = proposal["researcher"] || "________"
	var/scp_target = proposal["scp_id"] || "________"
	var/risk_level = proposal["risk_level"] || 1
	var/risk_text = "Level [risk_level] - "
	risk_text += risk_level >= 5 ? "Extreme Risk (O5 Consultation Required)" : risk_level >= 4 ? "High Risk (Ethics Review + Director Approval Required)" : risk_level >= 3 ? "Medium Risk (Ethics Review Required)" : risk_level >= 2 ? "Low Risk" : "Minimal Risk"
	var/ethics_required = risk_level >= 3 ? "Yes (mandatory at Risk Level [risk_level])" : "No"
	var/test_type = proposal["test_type"] || "________"
	var/subject_name = proposal["subject_name"] || "________"
	var/description = proposal["description"] || "________"
	var/proposal_id = proposal["proposal_id"] || "________"
	info = @{"<h2>SCP FOUNDATION - TEST AUTHORIZATION FORM</h2><hr>
<b>Proposal ID:</b> [proposal_id]<br>
<b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Requesting Researcher:</b> [researcher_name]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b> [test_type]<br>
<b>D-Class Subject Designation:</b> [subject_name]<br><hr>
<b>Risk Assessment:</b><br>
[check] Level 1 - Minimal Risk<br>
[check] Level 2 - Low Risk<br>
[check] Level 3 - Medium Risk (Ethics Review Required)<br>
[check] Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
[check] Level 5 - Extreme Risk (O5 Consultation Required)<br>
<i>Assessed Risk: [risk_text]</i><br><hr>
<b>Test Objective:</b><br>
[description]<br><hr>
<b>Test Procedure (detailed):</b><br>
[field]<br>
[field]<br><hr>
<b>Safety Precautions:</b><br>
[field]<br>
[field]<br><hr>
<b>Contingency Plan (if test deviates):</b><br>
[field]<br><hr>
<b>Ethics Review Required:</b> [ethics_required]<br>
<b>Ethics Committee Case #:</b> [field]<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Senior Researcher Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor / Director Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Liaison Approval:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	name = "SCP Test Authorization - \[proposal_id\]"

/obj/item/paper/foundation/test_result
	name = "SCP Test Result Report"
	desc = "A Foundation form for documenting SCP test outcomes."

/obj/item/paper/foundation/test_result/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - TEST RESULT REPORT</h2><hr>
<b>Test ID:</b> [field]<br>
<b>Date Completed:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Researcher:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [circle]1 (Low) [circle]2 [circle]3 [circle]4 [circle]5 (Extreme)<br>
<b>D-Class Subject:</b> D-[field]<br><hr>
<b>Test Outcome:</b><br>
[check] Successful - Objectives Met<br>
[check] Partial Success - Some Objectives Met<br>
[check] Failure - Objectives Not Met<br>
[check] Inconclusive - Insufficient Data<br>
[check] Aborted - Safety Concern<br><hr>
<b>Summary of Results:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Danger Triggered:</b> [circle]Yes [circle]No<br>
<b>Subject Status:</b><br>
[check] Intact - No injuries sustained<br>
[check] Injured - Minor / Moderate / Severe injuries<br>
[check] Deceased - Cause: [field]<br>
[check] Missing - Last seen: [field]<br><hr>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Observations / Anomalous Effects:</b><br>
[field]<br>
[field]<br><hr>
<b>Equipment Status:</b> [circle]Intact [circle]Damaged [circle]Destroyed<br>
<b>Containment Integrity Affected:</b> [circle]Yes [circle]No<br><hr>
<b>Ethics Violation Filed:</b> [circle]Yes [circle]No<br>
<b>Ethics Committee Case #:</b> [field]<br><hr>
<b>Follow-up Actions Required:</b><br>
[field]<br><hr>
<b>Researcher Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Senior Researcher Review:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/test_result/proc/autofill_from_project(list/project, mob/user)
	var/researcher_name = "________"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		researcher_name = H.real_name
	var/scp_target = project["scp_target"] || "________"
	var/risk_level = project["risk_level"] || 1
	var/approved_by = project["approved_by"] || "________"
	info = @{"<h2>SCP FOUNDATION - TEST RESULT REPORT</h2><hr>
<b>Test ID:</b> [project["id"] || project["name"] || "________"]<br>
<b>Date Completed:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Researcher:</b> [researcher_name]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [risk_level] ([risk_level >= 4 ? "Extreme" : risk_level >= 3 ? "High" : risk_level >= 2 ? "Moderate" : "Low"])<br>
<b>D-Class Subject:</b> D-[field]<br><hr>
<b>Test Outcome:</b><br>
[check] Successful - Objectives Met<br>
[check] Partial Success - Some Objectives Met<br>
[check] Failure - Objectives Not Met<br>
[check] Inconclusive - Insufficient Data<br>
[check] Aborted - Safety Concern<br><hr>
<b>Summary of Results:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Danger Triggered:</b> [circle]Yes [circle]No<br>
<b>Subject Status:</b><br>
[check] Intact - No injuries sustained<br>
[check] Injured - Minor / Moderate / Severe injuries<br>
[check] Deceased - Cause: [field]<br>
[check] Missing - Last seen: [field]<br><hr>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Observations / Anomalous Effects:</b><br>
[field]<br>
[field]<br><hr>
<b>Equipment Status:</b> [circle]Intact [circle]Damaged [circle]Destroyed<br>
<b>Containment Integrity Affected:</b> [circle]Yes [circle]No<br><hr>
<b>Ethics Violation Filed:</b> [circle]Yes [circle]No<br>
<b>Ethics Committee Case #:</b> [field]<br><hr>
<b>Follow-up Actions Required:</b><br>
[field]<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Senior Researcher Review:</b> [field] <b>Date:</b> [field]<br>
<b>Supervisor Review:</b> [approved_by] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	name = "SCP Test Result Report - [project["name"] || "SCP-[scp_target]"]"

// Cross-SCP Interaction Research Paperwork
/obj/item/paper/foundation/cross_scp_interaction_report
	name = "Cross-SCP Interaction Research Report"
	desc = "A Foundation form for documenting cross-anomalous entity interactions."

/obj/item/paper/foundation/cross_scp_interaction_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - CROSS-SCP INTERACTION RESEARCH REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Primary Researcher:</b> [field]<br>
<b>Clearance Level:</b> [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Research Team:</b> [field]<br><hr>
<b>Interaction Type:</b><br>
[check] Proximity Effect<br>
[check] Active Cross-Contamination<br>
[check] Mutual Enhancement<br>
[check] Mutual Nullification<br>
[check] Synergistic Anomaly<br>
[check] Competitive Interaction<br>
[check] Other: [field]<br><hr>
<b>Participating Anomalies:</b><br>
<b>SCP-[field]</b> (Class: [field]) → [field]<br>
<b>SCP-[field]</b> (Class: [field]) → [field]<br><hr>
<b>Interaction Range:</b> [field] meters<br>
<b>Duration:</b> [field] seconds/minutes/hours<br>
<b>Trigger Conditions:</b><br>
[field]<br><hr>
<b>Interaction Effects Observed:</b><br>
<b>On SCP-[field]:</b><br>
[check] No Observable Effect<br>
[check] Enhancement of Anomalous Properties<br>
[check] Suppression of Anomalous Properties<br>
[check] Behavioral Change<br>
[check] Physical Transformation<br>
[check] Memetic/Cognitive Influence<br>
[check] Other: [field]<br>
<b>On SCP-[field]:</b><br>
[check] No Observable Effect<br>
[check] Enhancement of Anomalous Properties<br>
[check] Suppression of Anomalous Properties<br>
[check] Behavioral Change<br>
[check] Physical Transformation<br>
[check] Memetic/Cognitive Influence<br>
[check] Other: [field]<br><hr>
<b>Environmental Effects:</b><br>
[check] None<br>
[check] Localized Reality Distortion<br>
[check] Spatial/Temporal Anomalies<br>
[check] Containment Integrity Compromised<br>
[check] Personnel Safety Risk<br>
[check] Other: [field]<br><hr>
<b>Research Data Collected:</b><br>
<b>Sensor Readings:</b> [field]<br>
<b>Anomalous Energy Signatures:</b> [field]<br>
<b>Cognitive Impact Assessment:</b> [field]<br>
<b>Containment Metrics:</b> [field]<br><hr>
<b>Risk Assessment:</b><br>
[check] Minimal Risk - Interaction poses no additional threat<br>
[check] Low Risk - Minor additional containment requirements<br>
[check] Medium Risk - Requires modified containment protocols<br>
[check] High Risk - Potential for cascade containment failure<br>
[check] Extreme Risk - Immediate threat to facility integrity<br><hr>
<b>Cross-Containment Recommendations:</b><br>
[check] Maintain Current Separation<br>
[check] Increase Minimum Distance to [field] meters<br>
[check] Implement Shielding Between Containments<br>
[check] Schedule Regular Interaction Monitoring<br>
[check] Prohibit Proximity Under Any Conditions<br>
[check] Other: [field]<br><hr>
<b>Follow-up Research Required:</b><br>
[field]<br><hr>
<b>Researcher Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Research Director Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Containment Specialist Review:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Committee Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 3+ REQUIRED - CROSS-ANOMALOUS INTERACTION DATA</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/cross_scp_interaction_report/proc/autofill_from_interaction(list/interaction_data, mob/user)
	var/researcher_name = "________"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		researcher_name = H.real_name
	
	var/scp1 = interaction_data["scp1_id"] || "________"
	var/scp2 = interaction_data["scp2_id"] || "________"
	var/interaction_type = interaction_data["interaction_type"] || "Unknown"
	var/risk_level = interaction_data["risk_level"] || 1
	
	info = @{"<h2>SCP FOUNDATION - CROSS-SCP INTERACTION RESEARCH REPORT</h2><hr>
<b>Report ID:</b> [interaction_data["id"] || "CROSS-[world.time]"]<br>
<b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Primary Researcher:</b> [researcher_name]<br>
<b>Clearance Level:</b> [circle]2 [circle]3 [circle]4 [circle]5<br>
<b>Research Team:</b> [field]<br><hr>
<b>Interaction Type:</b> [interaction_type]<br>
[check] Proximity Effect<br>
[check] Active Cross-Contamination<br>
[check] Mutual Enhancement<br>
[check] Mutual Nullification<br>
[check] Synergistic Anomaly<br>
[check] Competitive Interaction<br>
[check] Other: [field]<br><hr>
<b>Participating Anomalies:</b><br>
<b>SCP-[scp1]</b> (Class: [field]) → [field]<br>
<b>SCP-[scp2]</b> (Class: [field]) → [field]<br><hr>
<b>Interaction Range:</b> [field] meters<br>
<b>Duration:</b> [field] seconds/minutes/hours<br>
<b>Trigger Conditions:</b><br>
[field]<br><hr>
<b>Interaction Effects Observed:</b><br>
<b>On SCP-[scp1]:</b><br>
[check] No Observable Effect<br>
[check] Enhancement of Anomalous Properties<br>
[check] Suppression of Anomalous Properties<br>
[check] Behavioral Change<br>
[check] Physical Transformation<br>
[check] Memetic/Cognitive Influence<br>
[check] Other: [field]<br>
<b>On SCP-[scp2]:</b><br>
[check] No Observable Effect<br>
[check] Enhancement of Anomalous Properties<br>
[check] Suppression of Anomalous Properties<br>
[check] Behavioral Change<br>
[check] Physical Transformation<br>
[check] Memetic/Cognitive Influence<br>
[check] Other: [field]<br><hr>
<b>Environmental Effects:</b><br>
[check] None<br>
[check] Localized Reality Distortion<br>
[check] Spatial/Temporal Anomalies<br>
[check] Containment Integrity Compromised<br>
[check] Personnel Safety Risk<br>
[check] Other: [field]<br><hr>
<b>Research Data Collected:</b><br>
<b>Sensor Readings:</b> [field]<br>
<b>Anomalous Energy Signatures:</b> [field]<br>
<b>Cognitive Impact Assessment:</b> [field]<br>
<b>Containment Metrics:</b> [field]<br><hr>
<b>Risk Assessment:</b><br>
[check] Minimal Risk - Interaction poses no additional threat<br>
[check] Low Risk - Minor additional containment requirements<br>
[check] Medium Risk - Requires modified containment protocols<br>
[check] High Risk - Potential for cascade containment failure<br>
[check] Extreme Risk - Immediate threat to facility integrity<br>
<i>Assessed Risk Level: [risk_level]</i><br><hr>
<b>Cross-Containment Recommendations:</b><br>
[check] Maintain Current Separation<br>
[check] Increase Minimum Distance to [field] meters<br>
[check] Implement Shielding Between Containments<br>
[check] Schedule Regular Interaction Monitoring<br>
[check] Prohibit Proximity Under Any Conditions<br>
[check] Other: [field]<br><hr>
<b>Follow-up Research Required:</b><br>
[field]<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Research Director Approval:</b> [field] <b>Date:</b> [field]<br>
<b>Containment Specialist Review:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Committee Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - CLEARANCE LEVEL 3+ REQUIRED - CROSS-ANOMALOUS INTERACTION DATA</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	
	name = "Cross-SCP Interaction Report - SCP-\[scp1\] ↔ SCP-\[scp2\]"

// Ethics Committee Test Oversight Paperwork
/obj/item/paper/foundation/ethics_test_oversight
	name = "Ethics Committee Test Oversight Form"
	desc = "A Foundation form for ethics committee review of high-risk SCP testing."

/obj/item/paper/foundation/ethics_test_oversight/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - ETHICS COMMITTEE TEST OVERSIGHT FORM</h2><hr>
<b>Oversight Case #:</b> EC-[field]<br>
<b>Date Filed:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Ethics Liaison:</b> [field]<br>
<b>Clearance Level:</b> [circle]4 [circle]5<br>
<b>Committee Members Present:</b> [field]<br><hr>
<b>Test Proposal Details:</b><br>
<b>Test ID:</b> [field]<br>
<b>Researcher:</b> [field]<br>
<b>Department:</b> [field]<br>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [circle]3 (Medium) [circle]4 (High) [circle]5 (Extreme)<br><hr>
<b>Ethical Considerations:</b><br>
<b>1. Subject Welfare:</b><br>
[check] D-Class Subject(s) - [field]<br>
[check] Non-Anomalous Human Subject(s)<br>
[check] Animal Subject(s)<br>
[check] No Direct Subjects<br>
<b>Consent Status:</b> [circle]Voluntary [circle]Coerced [circle]Non-Consensual<br>
<b>Risk/Benefit Analysis:</b> [field]<br><hr>
<b>2. Containment Integrity:</b><br>
[check] Risk of Breach - Low / Medium / High<br>
[check] Potential for Cross-Contamination<br>
[check] Equipment Failure Risk<br>
[check] Environmental Hazard<br>
<b>Contingency Plans Adequate:</b> [circle]Yes [circle]No<br><hr>
<b>3. Research Justification:</b><br>
<b>Scientific Merit:</b> [circle]Low [circle]Moderate [circle]High [circle]Critical<br>
<b>Alternative Methods Considered:</b> [circle]Yes [circle]No<br>
<b>Expected Knowledge Gain:</b> [field]<br><hr>
<b>4. Researcher Qualifications:</b><br>
<b>Researcher Experience Level:</b> [circle]Novice [circle]Intermediate [circle]Experienced [circle]Expert<br>
<b>Previous Ethics Record:</b> [circle]Clean [circle]Minor Violations [circle]Major Violations<br>
<b>Supervision Level:</b> [circle]Unsupervised [circle]Supervised [circle]Direct Supervision<br><hr>
<b>Committee Review:</b><br>
<b>Review Session Date:</b> [field]<br>
<b>Duration:</b> [field] minutes<br>
<b>Discussion Points:</b><br>
[field]<br>
[field]<br><hr>
<b>Expert Consultations:</b><br>
[check] Medical Ethics Specialist<br>
[check] Containment Engineering<br>
[check] Cognitive Research Specialist<br>
[check] Anomalous Biology Expert<br>
[check] Legal Counsel<br>
[check] Other: [field]<br><hr>
<b>Committee Decision:</b><br>
[check] APPROVED - Test may proceed as proposed<br>
[check] APPROVED WITH MODIFICATIONS - See modifications section<br>
[check] DEFERRED - Requires additional information<br>
[check] DENIED - Ethical concerns cannot be mitigated<br>
[check] REFERRED TO O5 COUNCIL - Exceeds committee authority<br><hr>
<b>Required Modifications (if applicable):</b><br>
[field]<br>
[field]<br><hr>
<b>Conditions of Approval:</b><br>
1. [field]<br>
2. [field]<br>
3. [field]<br><hr>
<b>Follow-up Requirements:</b><br>
<b>Post-Test Debrief:</b> [circle]Required [circle]Optional<br>
<b>Subject Monitoring:</b> [field] hours/days<br>
<b>Incident Reporting:</b> [circle]Immediate [circle]24-hour [circle]Weekly<br><hr>
<b>Ethics Liaison Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Committee Chair Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Researcher Acknowledgment:</b> [field] <b>Date:</b> [field]<br>
<b>Research Director Acknowledgment:</b> [field] <b>Date:</b> [field]<br>
<br><i>CONFIDENTIAL - ETHICS COMMITTEE EYES ONLY - CLEARANCE LEVEL 4+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/ethics_test_oversight/proc/autofill_from_oversight(list/oversight_data, mob/user)
	var/ethics_liaison = "________"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		ethics_liaison = H.real_name
	
	var/test_id = oversight_data["test_id"] || "________"
	var/scp_name = oversight_data["scp_name"] || "________"
	var/researcher = oversight_data["researcher"] || "________"
	var/risk_level = oversight_data["risk_level"] || 3
	var/approved = oversight_data["approved"] || FALSE
	var/denied = oversight_data["denied"] || FALSE
	
	var/decision = "________"
	if(approved)
		decision = "APPROVED"
	else if(denied)
		decision = "DENIED"
	
	info = @{"<h2>SCP FOUNDATION - ETHICS COMMITTEE TEST OVERSIGHT FORM</h2><hr>
<b>Oversight Case #:</b> EC-[world.time]-[rand(100,999)]<br>
<b>Date Filed:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Ethics Liaison:</b> [ethics_liaison]<br>
<b>Clearance Level:</b> [circle]4 [circle]5<br>
<b>Committee Members Present:</b> [field]<br><hr>
<b>Test Proposal Details:</b><br>
<b>Test ID:</b> [test_id]<br>
<b>Researcher:</b> [researcher]<br>
<b>Department:</b> [field]<br>
<b>SCP Designation:</b> SCP-[scp_name]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [risk_level] ([risk_level >= 4 ? "High" : "Medium"])<br><hr>
<b>Ethical Considerations:</b><br>
<b>1. Subject Welfare:</b><br>
[check] D-Class Subject(s) - [field]<br>
[check] Non-Anomalous Human Subject(s)<br>
[check] Animal Subject(s)<br>
[check] No Direct Subjects<br>
<b>Consent Status:</b> [circle]Voluntary [circle]Coerced [circle]Non-Consensual<br>
<b>Risk/Benefit Analysis:</b> [field]<br><hr>
<b>2. Containment Integrity:</b><br>
[check] Risk of Breach - Low / Medium / High<br>
[check] Potential for Cross-Contamination<br>
[check] Equipment Failure Risk<br>
[check] Environmental Hazard<br>
<b>Contingency Plans Adequate:</b> [circle]Yes [circle]No<br><hr>
<b>3. Research Justification:</b><br>
<b>Scientific Merit:</b> [circle]Low [circle]Moderate [circle]High [circle]Critical<br>
<b>Alternative Methods Considered:</b> [circle]Yes [circle]No<br>
<b>Expected Knowledge Gain:</b> [field]<br><hr>
<b>4. Researcher Qualifications:</b><br>
<b>Researcher Experience Level:</b> [circle]Novice [circle]Intermediate [circle]Experienced [circle]Expert<br>
<b>Previous Ethics Record:</b> [circle]Clean [circle]Minor Violations [circle]Major Violations<br>
<b>Supervision Level:</b> [circle]Unsupervised [circle]Supervised [circle]Direct Supervision<br><hr>
<b>Committee Review:</b><br>
<b>Review Session Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Duration:</b> [field] minutes<br>
<b>Discussion Points:</b><br>
[field]<br>
[field]<br><hr>
<b>Expert Consultations:</b><br>
[check] Medical Ethics Specialist<br>
[check] Containment Engineering<br>
[check] Cognitive Research Specialist<br>
[check] Anomalous Biology Expert<br>
[check] Legal Counsel<br>
[check] Other: [field]<br><hr>
<b>Committee Decision:</b><br>
[check] APPROVED - Test may proceed as proposed<br>
[check] APPROVED WITH MODIFICATIONS - See modifications section<br>
[check] DEFERRED - Requires additional information<br>
[check] DENIED - Ethical concerns cannot be mitigated<br>
[check] REFERRED TO O5 COUNCIL - Exceeds committee authority<br>
<i>Decision: [decision]</i><br><hr>
<b>Required Modifications (if applicable):</b><br>
[field]<br>
[field]<br><hr>
<b>Conditions of Approval:</b><br>
1. [field]<br>
2. [field]<br>
3. [field]<br><hr>
<b>Follow-up Requirements:</b><br>
<b>Post-Test Debrief:</b> [circle]Required [circle]Optional<br>
<b>Subject Monitoring:</b> [field] hours/days<br>
<b>Incident Reporting:</b> [circle]Immediate [circle]24-hour [circle]Weekly<br><hr>
<b>Ethics Liaison Signature:</b> [ethics_liaison] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Committee Chair Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Researcher Acknowledgment:</b> [field] <b>Date:</b> [field]<br>
<b>Research Director Acknowledgment:</b> [field] <b>Date:</b> [field]<br>
<br><i>CONFIDENTIAL - ETHICS COMMITTEE EYES ONLY - CLEARANCE LEVEL 4+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	
	name = "Ethics Oversight Form - Test \[test_id\]"
// SCP Research Summary Paperwork
/obj/item/paper/foundation/research_summary
	name = "SCP Research Summary Report"
	desc = "A Foundation form summarizing research findings on an SCP."

/obj/item/paper/foundation/research_summary/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - RESEARCH SUMMARY REPORT</h2><hr>
<b>Report ID:</b> RS-[field]<br>
<b>Date:</b> [field]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Primary Researcher:</b> [field]<br>
<b>Research Team:</b> [field]<br>
<b>Clearance Level:</b> [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>SCP Information:</b><br>
<b>Designation:</b> SCP-[field]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Containment Status:</b> [circle]Contained [circle]Breached [circle]Neutralized [circle]Uncontained<br>
<b>Containment Procedures:</b> [field]<br><hr>
<b>Research Period:</b><br>
<b>Start Date:</b> [field]<br>
<b>End Date:</b> [field]<br>
<b>Duration:</b> [field] days<br>
<b>Research Focus:</b> [field]<br><hr>
<b>Research Methodology:</b><br>
[check] Observational Study<br>
[check] Experimental Testing<br>
[check] Containment Analysis<br>
[check] Anomalous Property Study<br>
[check] Cross-SCP Interaction Research<br>
[check] Historical/Archival Research<br>
[check] Other: [field]<br><hr>
<b>Key Findings:</b><br>
<b>1. Anomalous Properties:</b><br>
[field]<br>
[field]<br>
<b>2. Behavioral Patterns:</b><br>
[field]<br>
[field]<br>
<b>3. Containment Insights:</b><br>
[field]<br>
[field]<br>
<b>4. Safety Protocols:</b><br>
[field]<br>
[field]<br><hr>
<b>Data Collection Summary:</b><br>
<b>Observations Recorded:</b> [field]<br>
<b>Interactions Logged:</b> [field]<br>
<b>Cross-SCP Interactions:</b> [field]<br>
<b>Test Proposals:</b> [field]<br>
<b>Completed Tests:</b> [field]<br>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Incidents:</b><br>
[check] None<br>
[check] Minor Containment Breach<br>
[check] Researcher Injury<br>
[check] D-Class Casualty<br>
[check] Equipment Damage<br>
[check] Ethics Violation<br>
<b>Incident Details:</b> [field]<br><hr>
<b>Cross-SCP Interactions Observed:</b><br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br><hr>
<b>Research Conclusions:</b><br>
<b>Primary Hypothesis Confirmed:</b> [circle]Yes [circle]Partially [circle]No<br>
<b>New Hypotheses Generated:</b> [field]<br>
<b>Knowledge Gaps Identified:</b> [field]<br><hr>
<b>Recommendations:</b><br>
<b>1. Containment Improvements:</b><br>
[field]<br>
<b>2. Further Research:</b><br>
[field]<br>
<b>3. Safety Protocol Updates:</b><br>
[field]<br>
<b>4. Classification Review:</b><br>
[check] Maintain Current Classification<br>
[check] Upgrade to [field] Class<br>
[check] Downgrade to [field] Class<br>
[check] Special Classification Consideration<br><hr>
<b>Attachments:</b><br>
[check] Test Authorization Forms<br>
[check] Test Result Reports<br>
[check] Cross-SCP Interaction Reports<br>
[check] Ethics Committee Oversight Forms<br>
[check] Incident Reports<br>
[check] Photographic Evidence<br>
[check] Sensor Data Logs<br><hr>
<b>Researcher Signature:</b> [field] <b>Date:</b> [field]<br>
<b>Research Director Review:</b> [field] <b>Date:</b> [field]<br>
<b>Containment Specialist Review:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Committee Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - RESEARCH DATA - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

/obj/item/paper/foundation/research_summary/proc/autofill_from_research(list/research_data, mob/user)
	var/researcher_name = "________"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		researcher_name = H.real_name
	
	var/scp_id = research_data["scp_id"] || "________"
	var/observations = research_data["observations"] || 0
	var/interactions = research_data["interactions"] || 0
	var/cross_interactions = research_data["cross_interactions"] || 0
	
	info = @{"<h2>SCP FOUNDATION - RESEARCH SUMMARY REPORT</h2><hr>
<b>Report ID:</b> RS-[world.time]-[rand(100,999)]<br>
<b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Facility:</b> Site-53<br><hr>
<b>Primary Researcher:</b> [researcher_name]<br>
<b>Research Team:</b> [field]<br>
<b>Clearance Level:</b> [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>SCP Information:</b><br>
<b>Designation:</b> SCP-[scp_id]<br>
<b>Object Class:</b> [circle]Safe [circle]Euclid [circle]Keter [circle]Thaumiel [circle]Apollyon<br>
<b>Containment Status:</b> [circle]Contained [circle]Breached [circle]Neutralized [circle]Uncontained<br>
<b>Containment Procedures:</b> [field]<br><hr>
<b>Research Period:</b><br>
<b>Start Date:</b> [field]<br>
<b>End Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Duration:</b> [field] days<br>
<b>Research Focus:</b> [field]<br><hr>
<b>Research Methodology:</b><br>
[check] Observational Study<br>
[check] Experimental Testing<br>
[check] Containment Analysis<br>
[check] Anomalous Property Study<br>
[check] Cross-SCP Interaction Research<br>
[check] Historical/Archival Research<br>
[check] Other: [field]<br><hr>
<b>Key Findings:</b><br>
<b>1. Anomalous Properties:</b><br>
[field]<br>
[field]<br>
<b>2. Behavioral Patterns:</b><br>
[field]<br>
[field]<br>
<b>3. Containment Insights:</b><br>
[field]<br>
[field]<br>
<b>4. Safety Protocols:</b><br>
[field]<br>
[field]<br><hr>
<b>Data Collection Summary:</b><br>
<b>Observations Recorded:</b> [observations]<br>
<b>Interactions Logged:</b> [interactions]<br>
<b>Cross-SCP Interactions:</b> [cross_interactions]<br>
<b>Test Proposals:</b> [field]<br>
<b>Completed Tests:</b> [field]<br>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Incidents:</b><br>
[check] None<br>
[check] Minor Containment Breach<br>
[check] Researcher Injury<br>
[check] D-Class Casualty<br>
[check] Equipment Damage<br>
[check] Ethics Violation<br>
<b>Incident Details:</b> [field]<br><hr>
<b>Cross-SCP Interactions Observed:</b><br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br><hr>
<b>Research Conclusions:</b><br>
<b>Primary Hypothesis Confirmed:</b> [circle]Yes [circle]Partially [circle]No<br>
<b>New Hypotheses Generated:</b> [field]<br>
<b>Knowledge Gaps Identified:</b> [field]<br><hr>
<b>Recommendations:</b><br>
<b>1. Containment Improvements:</b><br>
[field]<br>
<b>2. Further Research:</b><br>
[field]<br>
<b>3. Safety Protocol Updates:</b><br>
[field]<br>
<b>4. Classification Review:</b><br>
[check] Maintain Current Classification<br>
[check] Upgrade to [field] Class<br>
[check] Downgrade to [field] Class<br>
[check] Special Classification Consideration<br><hr>
<b>Attachments:</b><br>
[check] Test Authorization Forms<br>
[check] Test Result Reports<br>
[check] Cross-SCP Interaction Reports<br>
[check] Ethics Committee Oversight Forms<br>
[check] Incident Reports<br>
[check] Photographic Evidence<br>
[check] Sensor Data Logs<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Research Director Review:</b> [field] <b>Date:</b> [field]<br>
<b>Containment Specialist Review:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Committee Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - RESEARCH DATA - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

	name = "Research Summary - SCP-\[scp_id\]"

// ===== ZONE VISITATION REQUEST =====
// Printed by visitors or staff, approved (stamped) by the Site Director or
// a Zone/Guard Commander, then presented at a checkpoint for legal entry
// into a Containment Zone for observation purposes only.
/obj/item/paper/foundation/visitation_request
	name = "Zone Visitation Request"
	desc = "A Foundation form requesting permission to enter and observe a Containment Zone."

/obj/item/paper/foundation/visitation_request/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - ZONE VISITATION REQUEST</h2><hr>
<b>Request ID:</b> [field]<br>
<b>Date Filed:</b> [field]<br><hr>
<b>Requester Name:</b> [field]<br>
<b>Requester Role/Department:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>Requested Zone:</b> [circle]LCZ [circle]HCZ [circle]EZ [circle]Offsite<br>
<b>Specific SCP(s) to Observe:</b><br>
[field]<br><hr>
<b>Purpose of Visit:</b><br>
[field]<br><hr>
<b>Requested Visit Date:</b> [field]<br>
<b>Requested Visit Duration:</b> [field]<br>
<b>Escort Required:</b> [circle]Yes [circle]No [circle]Escort Provided (name: [field])<br><hr>
<b>REQUESTER ACKNOWLEDGEMENT:</b><br>
By signing below, I acknowledge that this visitation is FOR OBSERVATION ONLY. I will make NO CONTACT with, interfere with, or interact with any SCP, its containment unit, or assigned personnel beyond routine verbal greetings, unless explicitly authorized by the supervising escort. I understand that violating these conditions is a Level 3 security violation and may result in detainment, amnesticization, or termination of employment.<br><hr>
<b>Requester Signature:</b> [field] <b>Date:</b> [field]<br><hr>
<b>APPROVAL SECTION (Site Director or Zone/Guard Commander):</b><br>
[circle]Approved [circle]Denied [circle]Deferred<br>
<b>Approving Officer:</b> [field] <b>Title:</b> [field]<br>
<b>Conditions/Notes:</b><br>
[field]<br>
<b>Approving Officer Signature:</b> [field] <b>Date:</b> [field]<br>
<br><i>PRESENT THIS FORM AND PHOTO ID AT CHECKPOINT. NO CONTACT - OBSERVATION ONLY.</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

// ===== AREA ENTRY PERMIT =====
// Issued by checkpoint guards. Carried as temporary authorization to be in
// the Area; surrendered at the checkpoint when leaving.
/obj/item/paper/foundation/entry_permit
	name = "Area Entry Permit"
	desc = "A checkpoint-issued permit authorizing temporary presence in a restricted Area."

/obj/item/paper/foundation/entry_permit/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - AREA ENTRY PERMIT</h2><hr>
<b>Permit No:</b> [field]<br>
<b>Issued:</b> [field] <b>Valid Until:</b> [field]<br><hr>
<b>Permit Holder:</b> [field]<br>
<b>Role/Department:</b> [field]<br>
<b>Employee ID:</b> [field]<br><hr>
<b>Authorized Area(s):</b> [circle]LCZ [circle]HCZ [circle]EZ [circle]Office Wing [circle]Logistics<br>
<b>Purpose of Entry:</b><br>
[field]<br><hr>
<b>Restrictions:</b><br>
[check] Must remain escorted at all times<br>
[check] No entry to SCP containment chambers<br>
[check] No photography or recording<br>
[check] Must report to checkpoint upon departure<br>
[check] Other: [field]<br><hr>
<b>ISSUING GUARD:</b><br>
<b>Guard Name:</b> [field] <b>Badge No:</b> [field]<br>
<b>Guard Signature:</b> [field]<br><hr>
<b>PERMIT CONDITIONS:</b><br>
This permit is the holder's authorization to be present in the listed Area(s). It must be presented to any Guard on demand. This permit does NOT confer clearance to interact with SCPs or access restricted systems. Unauthorized distribution, forgery, or failure to surrender this permit upon departure are security violations.<br><hr>
<b>SURRENDER RECORD (checkpoint use only):</b><br>
<b>Returned:</b> [field] <b>Receiving Guard:</b> [field]<br>
<b>Holder Verified On Exit:</b> [circle]Yes [circle]No<br>
<br><i>HOLD ONTO THIS PERMIT. SURRENDER AT CHECKPOINT WHEN LEAVING THE AREA.</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()

// ===== ARREST / DETAINMENT REPORT =====
// Filed by the arresting officer(s); documents charges, evidence, and
// punishment, and is routed to the Guard Commander for review.
/obj/item/paper/foundation/arrest_report
	name = "Arrest and Detainment Report"
	desc = "A Foundation form documenting an arrest, the charges, and disciplinary action."

/obj/item/paper/foundation/arrest_report/Initialize(mapload)
	. = ..()
	info = @{"<h2>SCP FOUNDATION - ARREST AND DETAINMENT REPORT</h2><hr>
<b>Report ID:</b> [field]<br>
<b>Date/Time of Arrest:</b> [field]<br><hr>
<b>ARRESTEE:</b><br>
<b>Name:</b> [field]<br>
<b>Role/Department:</b> [field]<br>
<b>Employee ID:</b> [field]<br>
<b>Clearance Level:</b> [circle]1 [circle]2 [circle]3 [circle]4 [circle]5<br><hr>
<b>ARREST DETAILS:</b><br>
<b>Location of Arrest:</b> [field]<br>
<b>Arresting Officer(s):</b> [field]<br>
<b>Badge No(s):</b> [field]<br><hr>
<b>CHARGES:</b><br>
[check] Trespassing - Unauthorized entry into restricted Area<br>
[check] Failure to Display Entry Permit<br>
[check] Unauthorized Contact with SCP<br>
[check] Refusal to Comply with Security Orders<br>
[check] Assault on Personnel<br>
[check] Theft of Foundation Property<br>
[check] Information Leak / Security Breach<br>
[check] Possession of Unauthorized Equipment<br>
[check] Other: [field]<br><hr>
<b>INCIDENT SUMMARY:</b><br>
[field]<br>
[field]<br><hr>
<b>EVIDENCE COLLECTED:</b><br>
[check] Witness Statements (attached)<br>
[check] Camera Footage (archived, ref: [field])<br>
[check] Physical Evidence (logged, ref: [field])<br>
[check] None<br><hr>
<b>DETAINMENT:</b><br>
<b>Detainment Location:</b> [circle]LCZ Brig [circle]HCZ Brig [circle]Holding Cell [circle]Released Pending Review<br>
<b>Disposition:</b> [circle]Awaiting Disciplinary Review [circle]Counseling [circle]Demotion [circle]Termination [circle]Amnesticization [circle]Referred to Tribunal<br>
<b>Punishment/Discipline Imposed:</b><br>
[field]<br><hr>
<b>ARRESTING OFFICER SIGNATURE:</b> [field] <b>Date:</b> [field]<br>
<b>Guard Commander Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>SECURITY EYES ONLY - ROUTE TO GUARD COMMANDER</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()