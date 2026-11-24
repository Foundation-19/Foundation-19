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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>Department:</b> Security / Science / Medical / Engineering / Logistics / Other<br><hr>
<b>Incident Type:</b><br>
[ ] Containment Breach<br>
[ ] SCP Exposure / Contact<br>
[ ] Personnel Injury / Fatality<br>
[ ] Security Violation<br>
[ ] Equipment Failure<br>
[ ] Unexplained Phenomenon<br>
[ ] Other: [field]<br><hr>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>Department:</b> [field]<br><hr>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
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
Low / Medium / High / Extreme<br><hr>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br><hr>
<b>Subject Name:</b> [field]<br>
<b>Subject Type:</b> Civilian / Foundation Personnel / D-Class / Other<br>
<b>Reason for Administration:</b><br>
[ ] Unintended SCP Exposure<br>
[ ] Security Leak<br>
[ ] Information Compromise<br>
[ ] Standard Protocol<br>
[ ] Other: [field]<br><hr>
<b>Amnestic Class:</b> A / B / C / E<br>
<b>Dosage:</b> [field]<br>
<b>Method of Administration:</b> Oral / Intravenous / Inhalation / Topical<br><hr>
<b>Memories Targeted for Removal:</b><br>
[field]<br>
[field]<br><hr>
<b>Pre-Administration Assessment:</b><br>
[field]<br><hr>
<b>Post-Administration Assessment:</b><br>
[field]<br><hr>
<b>Complications:</b> None / Describe: [field]<br><hr>
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
<b>Object Class:</b> Safe / Euclid / Keter<br>
<b>Previous Containment Status:</b> Contained / Partial / Pending<br><hr>
<b>Breach Location:</b> [field]<br>
<b>Breach Severity:</b> Minor / Moderate / Major / Catastrophic<br><hr>
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
[ ] Equipment Malfunction<br>
[ ] Human Error<br>
[ ] Sabotage / External Action<br>
[ ] SCP-Initiated<br>
[ ] Structural Failure<br>
[ ] Unknown<br>
[ ] Other: [field]<br><hr>
<b>Recontainment Status:</b><br>
[ ] Recontained - Time: [field]<br>
[ ] In Progress<br>
[ ] Pending MTF Deployment<br>
[ ] Not Recontained<br><hr>
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
[ ] General Labor<br>
[ ] Medical Testing<br>
[ ] SCP Testing<br>
[ ] Maintenance<br>
[ ] Kitchen Duty<br>
[ ] Mining Operations<br><hr>
<b>Medical Clearance:</b> Cleared / Restricted - Notes: [field]<br>
<b>Behavioral Assessment:</b> Compliant / Unstable / Hostile<br><hr>
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
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon / Neutralized<br><hr>
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
<b>Department:</b> Command / Security / Science / Medical / Engineering / Logistics / Service<br>
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br><hr>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br><hr>
<b>Violation Severity:</b> Minor / Moderate / Major / Critical<br>
<b>Violation Type:</b><br>
(_) Unnecessary D-Class Suffering<br>
(_) Testing Without Approval<br>
(_) Cruel and Unusual Procedures<br>
(_) Withholding Medical Treatment<br>
(_) Unauthorized Amnestic Use<br>
(_) SCP Mistreatment<br>
(_) Other: [field]<br><hr>
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
<b>Evaluation Type:</b> Routine / Post-Incident / Pre-Employment / SCP Exposure Follow-up<br><hr>
<b>Current Sanity Assessment:</b> Stable / Mild Distress / Moderate Distress / Severe Distress / Critical<br>
<b>SCP Exposure Level:</b> None / Low / Moderate / Severe / Critical<br><hr>
<b>Behavioral Observations:</b><br>
[field]<br>
[field]<br><hr>
<b>Cognitive Function:</b> Intact / Mildly Impaired / Moderately Impaired / Severely Impaired<br>
<b>Emotional State:</b> Stable / Anxious / Depressed / Agitated / Unstable<br>
<b>Social Functioning:</b> Normal / Withdrawn / Hostile / Paranoid<br><hr>
<b>Diagnosis:</b><br>
[field]<br><hr>
<b>Recommendations:</b><br>
(_) No Action Required<br>
(_) Counseling Sessions Recommended<br>
(_) Amnestic Treatment Recommended (Class: [field])<br>
(_) Temporary Duty Restriction<br>
(_) Permanent Reassignment<br>
(_) Medical Leave<br><hr>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br><hr>
<b>Case Name:</b> [field]<br>
<b>Investigation Type:</b> Anomalous Evidence / SCP-Related / Personnel / Unknown Phenomenon<br><hr>
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
<b>Classification:</b> UNCLASSIFIED / CONFIDENTIAL / SECRET / TOP SECRET<br><hr>
<b>Analyst:</b> [field]<br>
<b>Report Type:</b> Surveillance / Threat Assessment / GOI Activity / Information Security / Personnel<br><hr>
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
<b>Classification:</b> CONFIDENTIAL / SECRET / TOP SECRET<br><hr>
<b>GOI Name:</b> [field]<br>
<b>Current Standing:</b> Hostile / Unfriendly / Neutral / Friendly / Allied<br><hr>
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
(_) No Change (_) Improved (_) Deteriorated<br><hr>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>Department:</b> [field]<br><hr>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b><br>
[ ] Observation<br>
[ ] Physical Interaction<br>
[ ] Stress Testing<br>
[ ] Audio / Visual Exposure<br>
[ ] Biological Sampling<br>
[ ] Cognitive / Memetic Exposure<br>
[ ] Chemical Analysis<br>
[ ] Other: [field]<br><hr>
<b>Risk Assessment:</b><br>
(_) Level 1 - Minimal Risk<br>
(_) Level 2 - Low Risk<br>
(_) Level 3 - Medium Risk (Ethics Review Required)<br>
(_) Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
(_) Level 5 - Extreme Risk (O5 Consultation Required)<br><hr>
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
<b>Ethics Review Required:</b> Yes / No (mandatory if Risk >= 3)<br>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>Department:</b> [project["research_field"] || "Research"]<br><hr>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b><br>
[ ] Observation<br>
[ ] Physical Interaction<br>
[ ] Stress Testing<br>
[ ] Audio / Visual Exposure<br>
[ ] Biological Sampling<br>
[ ] Cognitive / Memetic Exposure<br>
[ ] Chemical Analysis<br>
[ ] Other: [field]<br><hr>
<b>Risk Assessment:</b><br>
(_) Level 1 - Minimal Risk<br>
(_) Level 2 - Low Risk<br>
(_) Level 3 - Medium Risk (Ethics Review Required)<br>
(_) Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
(_) Level 5 - Extreme Risk (O5 Consultation Required)<br>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br><hr>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Current Containment Location:</b> [field]<br><hr>
<b>Test Type:</b> [test_type]<br>
<b>D-Class Subject Designation:</b> [subject_name]<br><hr>
<b>Risk Assessment:</b><br>
(_) Level 1 - Minimal Risk<br>
(_) Level 2 - Low Risk<br>
(_) Level 3 - Medium Risk (Ethics Review Required)<br>
(_) Level 4 - High Risk (Ethics Review + Director Approval Required)<br>
(_) Level 5 - Extreme Risk (O5 Consultation Required)<br>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> 1 (Low) / 2 / 3 / 4 / 5 (Extreme)<br>
<b>D-Class Subject:</b> D-[field]<br><hr>
<b>Test Outcome:</b><br>
[ ] Successful - Objectives Met<br>
[ ] Partial Success - Some Objectives Met<br>
[ ] Failure - Objectives Not Met<br>
[ ] Inconclusive - Insufficient Data<br>
[ ] Aborted - Safety Concern<br><hr>
<b>Summary of Results:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Danger Triggered:</b> Yes / No<br>
<b>Subject Status:</b><br>
(_) Intact - No injuries sustained<br>
(_) Injured - Minor / Moderate / Severe injuries<br>
(_) Deceased - Cause: [field]<br>
(_) Missing - Last seen: [field]<br><hr>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Observations / Anomalous Effects:</b><br>
[field]<br>
[field]<br><hr>
<b>Equipment Status:</b> Intact / Damaged / Destroyed<br>
<b>Containment Integrity Affected:</b> Yes / No<br><hr>
<b>Ethics Violation Filed:</b> Yes / No<br>
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
<b>Clearance Level:</b> 1 / 2 / 3 / 4 / 5<br>
<b>SCP Designation:</b> SCP-[scp_target]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [risk_level] ([risk_level >= 4 ? "Extreme" : risk_level >= 3 ? "High" : risk_level >= 2 ? "Moderate" : "Low"])<br>
<b>D-Class Subject:</b> D-[field]<br><hr>
<b>Test Outcome:</b><br>
[ ] Successful - Objectives Met<br>
[ ] Partial Success - Some Objectives Met<br>
[ ] Failure - Objectives Not Met<br>
[ ] Inconclusive - Insufficient Data<br>
[ ] Aborted - Safety Concern<br><hr>
<b>Summary of Results:</b><br>
[field]<br>
[field]<br>
[field]<br>
[field]<br><hr>
<b>Danger Triggered:</b> Yes / No<br>
<b>Subject Status:</b><br>
(_) Intact - No injuries sustained<br>
(_) Injured - Minor / Moderate / Severe injuries<br>
(_) Deceased - Cause: [field]<br>
(_) Missing - Last seen: [field]<br><hr>
<b>Research Points Earned:</b> [field]<br><hr>
<b>Notable Observations / Anomalous Effects:</b><br>
[field]<br>
[field]<br><hr>
<b>Equipment Status:</b> Intact / Damaged / Destroyed<br>
<b>Containment Integrity Affected:</b> Yes / No<br><hr>
<b>Ethics Violation Filed:</b> Yes / No<br>
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
<b>Clearance Level:</b> 2 / 3 / 4 / 5<br>
<b>Research Team:</b> [field]<br><hr>
<b>Interaction Type:</b><br>
[ ] Proximity Effect<br>
[ ] Active Cross-Contamination<br>
[ ] Mutual Enhancement<br>
[ ] Mutual Nullification<br>
[ ] Synergistic Anomaly<br>
[ ] Competitive Interaction<br>
[ ] Other: [field]<br><hr>
<b>Participating Anomalies:</b><br>
<b>SCP-[field]</b> (Class: [field]) → [field]<br>
<b>SCP-[field]</b> (Class: [field]) → [field]<br><hr>
<b>Interaction Range:</b> [field] meters<br>
<b>Duration:</b> [field] seconds/minutes/hours<br>
<b>Trigger Conditions:</b><br>
[field]<br><hr>
<b>Interaction Effects Observed:</b><br>
<b>On SCP-[field]:</b><br>
[ ] No Observable Effect<br>
[ ] Enhancement of Anomalous Properties<br>
[ ] Suppression of Anomalous Properties<br>
[ ] Behavioral Change<br>
[ ] Physical Transformation<br>
[ ] Memetic/Cognitive Influence<br>
[ ] Other: [field]<br>
<b>On SCP-[field]:</b><br>
[ ] No Observable Effect<br>
[ ] Enhancement of Anomalous Properties<br>
[ ] Suppression of Anomalous Properties<br>
[ ] Behavioral Change<br>
[ ] Physical Transformation<br>
[ ] Memetic/Cognitive Influence<br>
[ ] Other: [field]<br><hr>
<b>Environmental Effects:</b><br>
[ ] None<br>
[ ] Localized Reality Distortion<br>
[ ] Spatial/Temporal Anomalies<br>
[ ] Containment Integrity Compromised<br>
[ ] Personnel Safety Risk<br>
[ ] Other: [field]<br><hr>
<b>Research Data Collected:</b><br>
<b>Sensor Readings:</b> [field]<br>
<b>Anomalous Energy Signatures:</b> [field]<br>
<b>Cognitive Impact Assessment:</b> [field]<br>
<b>Containment Metrics:</b> [field]<br><hr>
<b>Risk Assessment:</b><br>
(_) Minimal Risk - Interaction poses no additional threat<br>
(_) Low Risk - Minor additional containment requirements<br>
(_) Medium Risk - Requires modified containment protocols<br>
(_) High Risk - Potential for cascade containment failure<br>
(_) Extreme Risk - Immediate threat to facility integrity<br><hr>
<b>Cross-Containment Recommendations:</b><br>
[ ] Maintain Current Separation<br>
[ ] Increase Minimum Distance to [field] meters<br>
[ ] Implement Shielding Between Containments<br>
[ ] Schedule Regular Interaction Monitoring<br>
[ ] Prohibit Proximity Under Any Conditions<br>
[ ] Other: [field]<br><hr>
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
<b>Clearance Level:</b> 2 / 3 / 4 / 5<br>
<b>Research Team:</b> [field]<br><hr>
<b>Interaction Type:</b> [interaction_type]<br>
[ ] Proximity Effect<br>
[ ] Active Cross-Contamination<br>
[ ] Mutual Enhancement<br>
[ ] Mutual Nullification<br>
[ ] Synergistic Anomaly<br>
[ ] Competitive Interaction<br>
[ ] Other: [field]<br><hr>
<b>Participating Anomalies:</b><br>
<b>SCP-[scp1]</b> (Class: [field]) → [field]<br>
<b>SCP-[scp2]</b> (Class: [field]) → [field]<br><hr>
<b>Interaction Range:</b> [field] meters<br>
<b>Duration:</b> [field] seconds/minutes/hours<br>
<b>Trigger Conditions:</b><br>
[field]<br><hr>
<b>Interaction Effects Observed:</b><br>
<b>On SCP-[scp1]:</b><br>
[ ] No Observable Effect<br>
[ ] Enhancement of Anomalous Properties<br>
[ ] Suppression of Anomalous Properties<br>
[ ] Behavioral Change<br>
[ ] Physical Transformation<br>
[ ] Memetic/Cognitive Influence<br>
[ ] Other: [field]<br>
<b>On SCP-[scp2]:</b><br>
[ ] No Observable Effect<br>
[ ] Enhancement of Anomalous Properties<br>
[ ] Suppression of Anomalous Properties<br>
[ ] Behavioral Change<br>
[ ] Physical Transformation<br>
[ ] Memetic/Cognitive Influence<br>
[ ] Other: [field]<br><hr>
<b>Environmental Effects:</b><br>
[ ] None<br>
[ ] Localized Reality Distortion<br>
[ ] Spatial/Temporal Anomalies<br>
[ ] Containment Integrity Compromised<br>
[ ] Personnel Safety Risk<br>
[ ] Other: [field]<br><hr>
<b>Research Data Collected:</b><br>
<b>Sensor Readings:</b> [field]<br>
<b>Anomalous Energy Signatures:</b> [field]<br>
<b>Cognitive Impact Assessment:</b> [field]<br>
<b>Containment Metrics:</b> [field]<br><hr>
<b>Risk Assessment:</b><br>
(_) Minimal Risk - Interaction poses no additional threat<br>
(_) Low Risk - Minor additional containment requirements<br>
(_) Medium Risk - Requires modified containment protocols<br>
(_) High Risk - Potential for cascade containment failure<br>
(_) Extreme Risk - Immediate threat to facility integrity<br>
<i>Assessed Risk Level: [risk_level]</i><br><hr>
<b>Cross-Containment Recommendations:</b><br>
[ ] Maintain Current Separation<br>
[ ] Increase Minimum Distance to [field] meters<br>
[ ] Implement Shielding Between Containments<br>
[ ] Schedule Regular Interaction Monitoring<br>
[ ] Prohibit Proximity Under Any Conditions<br>
[ ] Other: [field]<br><hr>
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
<b>Clearance Level:</b> 4 / 5<br>
<b>Committee Members Present:</b> [field]<br><hr>
<b>Test Proposal Details:</b><br>
<b>Test ID:</b> [field]<br>
<b>Researcher:</b> [field]<br>
<b>Department:</b> [field]<br>
<b>SCP Designation:</b> SCP-[field]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> 3 (Medium) / 4 (High) / 5 (Extreme)<br><hr>
<b>Ethical Considerations:</b><br>
<b>1. Subject Welfare:</b><br>
[ ] D-Class Subject(s) - [field]<br>
[ ] Non-Anomalous Human Subject(s)<br>
[ ] Animal Subject(s)<br>
[ ] No Direct Subjects<br>
<b>Consent Status:</b> Voluntary / Coerced / Non-Consensual<br>
<b>Risk/Benefit Analysis:</b> [field]<br><hr>
<b>2. Containment Integrity:</b><br>
[ ] Risk of Breach - Low / Medium / High<br>
[ ] Potential for Cross-Contamination<br>
[ ] Equipment Failure Risk<br>
[ ] Environmental Hazard<br>
<b>Contingency Plans Adequate:</b> Yes / No<br><hr>
<b>3. Research Justification:</b><br>
<b>Scientific Merit:</b> Low / Moderate / High / Critical<br>
<b>Alternative Methods Considered:</b> Yes / No<br>
<b>Expected Knowledge Gain:</b> [field]<br><hr>
<b>4. Researcher Qualifications:</b><br>
<b>Researcher Experience Level:</b> Novice / Intermediate / Experienced / Expert<br>
<b>Previous Ethics Record:</b> Clean / Minor Violations / Major Violations<br>
<b>Supervision Level:</b> Unsupervised / Supervised / Direct Supervision<br><hr>
<b>Committee Review:</b><br>
<b>Review Session Date:</b> [field]<br>
<b>Duration:</b> [field] minutes<br>
<b>Discussion Points:</b><br>
[field]<br>
[field]<br><hr>
<b>Expert Consultations:</b><br>
[ ] Medical Ethics Specialist<br>
[ ] Containment Engineering<br>
[ ] Cognitive Research Specialist<br>
[ ] Anomalous Biology Expert<br>
[ ] Legal Counsel<br>
[ ] Other: [field]<br><hr>
<b>Committee Decision:</b><br>
(_) APPROVED - Test may proceed as proposed<br>
(_) APPROVED WITH MODIFICATIONS - See modifications section<br>
(_) DEFERRED - Requires additional information<br>
(_) DENIED - Ethical concerns cannot be mitigated<br>
(_) REFERRED TO O5 COUNCIL - Exceeds committee authority<br><hr>
<b>Required Modifications (if applicable):</b><br>
[field]<br>
[field]<br><hr>
<b>Conditions of Approval:</b><br>
1. [field]<br>
2. [field]<br>
3. [field]<br><hr>
<b>Follow-up Requirements:</b><br>
<b>Post-Test Debrief:</b> Required / Optional<br>
<b>Subject Monitoring:</b> [field] hours/days<br>
<b>Incident Reporting:</b> Immediate / 24-hour / Weekly<br><hr>
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
<b>Clearance Level:</b> 4 / 5<br>
<b>Committee Members Present:</b> [field]<br><hr>
<b>Test Proposal Details:</b><br>
<b>Test ID:</b> [test_id]<br>
<b>Researcher:</b> [researcher]<br>
<b>Department:</b> [field]<br>
<b>SCP Designation:</b> SCP-[scp_name]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Test Type:</b> [field]<br>
<b>Risk Level:</b> [risk_level] ([risk_level >= 4 ? "High" : "Medium"])<br><hr>
<b>Ethical Considerations:</b><br>
<b>1. Subject Welfare:</b><br>
[ ] D-Class Subject(s) - [field]<br>
[ ] Non-Anomalous Human Subject(s)<br>
[ ] Animal Subject(s)<br>
[ ] No Direct Subjects<br>
<b>Consent Status:</b> Voluntary / Coerced / Non-Consensual<br>
<b>Risk/Benefit Analysis:</b> [field]<br><hr>
<b>2. Containment Integrity:</b><br>
[ ] Risk of Breach - Low / Medium / High<br>
[ ] Potential for Cross-Contamination<br>
[ ] Equipment Failure Risk<br>
[ ] Environmental Hazard<br>
<b>Contingency Plans Adequate:</b> Yes / No<br><hr>
<b>3. Research Justification:</b><br>
<b>Scientific Merit:</b> Low / Moderate / High / Critical<br>
<b>Alternative Methods Considered:</b> Yes / No<br>
<b>Expected Knowledge Gain:</b> [field]<br><hr>
<b>4. Researcher Qualifications:</b><br>
<b>Researcher Experience Level:</b> Novice / Intermediate / Experienced / Expert<br>
<b>Previous Ethics Record:</b> Clean / Minor Violations / Major Violations<br>
<b>Supervision Level:</b> Unsupervised / Supervised / Direct Supervision<br><hr>
<b>Committee Review:</b><br>
<b>Review Session Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Duration:</b> [field] minutes<br>
<b>Discussion Points:</b><br>
[field]<br>
[field]<br><hr>
<b>Expert Consultations:</b><br>
[ ] Medical Ethics Specialist<br>
[ ] Containment Engineering<br>
[ ] Cognitive Research Specialist<br>
[ ] Anomalous Biology Expert<br>
[ ] Legal Counsel<br>
[ ] Other: [field]<br><hr>
<b>Committee Decision:</b><br>
(_) APPROVED - Test may proceed as proposed<br>
(_) APPROVED WITH MODIFICATIONS - See modifications section<br>
(_) DEFERRED - Requires additional information<br>
(_) DENIED - Ethical concerns cannot be mitigated<br>
(_) REFERRED TO O5 COUNCIL - Exceeds committee authority<br>
<i>Decision: [decision]</i><br><hr>
<b>Required Modifications (if applicable):</b><br>
[field]<br>
[field]<br><hr>
<b>Conditions of Approval:</b><br>
1. [field]<br>
2. [field]<br>
3. [field]<br><hr>
<b>Follow-up Requirements:</b><br>
<b>Post-Test Debrief:</b> Required / Optional<br>
<b>Subject Monitoring:</b> [field] hours/days<br>
<b>Incident Reporting:</b> Immediate / 24-hour / Weekly<br><hr>
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
<b>Clearance Level:</b> 2 / 3 / 4 / 5<br><hr>
<b>SCP Information:</b><br>
<b>Designation:</b> SCP-[field]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Containment Status:</b> Contained / Breached / Neutralized / Uncontained<br>
<b>Containment Procedures:</b> [field]<br><hr>
<b>Research Period:</b><br>
<b>Start Date:</b> [field]<br>
<b>End Date:</b> [field]<br>
<b>Duration:</b> [field] days<br>
<b>Research Focus:</b> [field]<br><hr>
<b>Research Methodology:</b><br>
[ ] Observational Study<br>
[ ] Experimental Testing<br>
[ ] Containment Analysis<br>
[ ] Anomalous Property Study<br>
[ ] Cross-SCP Interaction Research<br>
[ ] Historical/Archival Research<br>
[ ] Other: [field]<br><hr>
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
[ ] None<br>
[ ] Minor Containment Breach<br>
[ ] Researcher Injury<br>
[ ] D-Class Casualty<br>
[ ] Equipment Damage<br>
[ ] Ethics Violation<br>
<b>Incident Details:</b> [field]<br><hr>
<b>Cross-SCP Interactions Observed:</b><br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br><hr>
<b>Research Conclusions:</b><br>
<b>Primary Hypothesis Confirmed:</b> Yes / Partially / No<br>
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
[ ] Maintain Current Classification<br>
[ ] Upgrade to [field] Class<br>
[ ] Downgrade to [field] Class<br>
[ ] Special Classification Consideration<br><hr>
<b>Attachments:</b><br>
[ ] Test Authorization Forms<br>
[ ] Test Result Reports<br>
[ ] Cross-SCP Interaction Reports<br>
[ ] Ethics Committee Oversight Forms<br>
[ ] Incident Reports<br>
[ ] Photographic Evidence<br>
[ ] Sensor Data Logs<br><hr>
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
<b>Clearance Level:</b> 2 / 3 / 4 / 5<br><hr>
<b>SCP Information:</b><br>
<b>Designation:</b> SCP-[scp_id]<br>
<b>Object Class:</b> Safe / Euclid / Keter / Thaumiel / Apollyon<br>
<b>Containment Status:</b> Contained / Breached / Neutralized / Uncontained<br>
<b>Containment Procedures:</b> [field]<br><hr>
<b>Research Period:</b><br>
<b>Start Date:</b> [field]<br>
<b>End Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Duration:</b> [field] days<br>
<b>Research Focus:</b> [field]<br><hr>
<b>Research Methodology:</b><br>
[ ] Observational Study<br>
[ ] Experimental Testing<br>
[ ] Containment Analysis<br>
[ ] Anomalous Property Study<br>
[ ] Cross-SCP Interaction Research<br>
[ ] Historical/Archival Research<br>
[ ] Other: [field]<br><hr>
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
[ ] None<br>
[ ] Minor Containment Breach<br>
[ ] Researcher Injury<br>
[ ] D-Class Casualty<br>
[ ] Equipment Damage<br>
[ ] Ethics Violation<br>
<b>Incident Details:</b> [field]<br><hr>
<b>Cross-SCP Interactions Observed:</b><br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br>
<b>With SCP-[field]:</b> [field]<br><hr>
<b>Research Conclusions:</b><br>
<b>Primary Hypothesis Confirmed:</b> Yes / Partially / No<br>
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
[ ] Maintain Current Classification<br>
[ ] Upgrade to [field] Class<br>
[ ] Downgrade to [field] Class<br>
[ ] Special Classification Consideration<br><hr>
<b>Attachments:</b><br>
[ ] Test Authorization Forms<br>
[ ] Test Result Reports<br>
[ ] Cross-SCP Interaction Reports<br>
[ ] Ethics Committee Oversight Forms<br>
[ ] Incident Reports<br>
[ ] Photographic Evidence<br>
[ ] Sensor Data Logs<br><hr>
<b>Researcher Signature:</b> [researcher_name] <b>Date:</b> [time2text(world.time, "MM/DD/YYYY")]<br>
<b>Research Director Review:</b> [field] <b>Date:</b> [field]<br>
<b>Containment Specialist Review:</b> [field] <b>Date:</b> [field]<br>
<b>Ethics Committee Review:</b> [field] <b>Date:</b> [field]<br>
<br><i>CLASSIFIED - RESEARCH DATA - CLEARANCE LEVEL 2+ REQUIRED</i><br>"}
	update_icon()
	update_space(info)
	updateinfolinks()
	
	name = "Research Summary - SCP-\[scp_id\]"