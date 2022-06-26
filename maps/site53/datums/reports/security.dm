/datum/computer_file/report/recipient/scp/sec
	logo = "\[sec\]"
	form_name = "SCP-SEC-00"

/datum/computer_file/report/recipient/scp/sec/New()
	..()
	set_access(access_securitylvl2)
	set_access(access_adminlvl2, override = 0)

//By 	Herbert Falsevor#3037
/datum/computer_file/report/recipient/scp/sec/dclass/assignment
	form_name = "SCP-LCZ-11"
	title =		"D-Class Assignments"
	available_on_ntnet = TRUE

/datum/computer_file/report/recipient/scp/sec/dclass/assignment/generate_fields()
	..()
	add_field(/datum/report_field/text_label/header, )
	add_field(/datum/report_field/date, "Date")
	add_field(/datum/report_field/time, "Time")
	add_field(/datum/report_field/people/list_from_manifest, "Desk manned by")
	add_field(/datum/report_field/people/list_from_manifest, "Mining and Manual Labour")
	add_field(/datum/report_field/people/list_from_manifest, "Botany Duty")
	add_field(/datum/report_field/people/list_from_manifest, "Kitchen Duty")
	add_field(/datum/report_field/people/list_from_manifest, "Janitorial Duty")
	add_field(/datum/report_field/text_label, "\nGuidelines")
	add_field(/datum/report_field/text_label/instruction, "\n- Attempt to fill slots evenly.")
	add_field(/datum/report_field/text_label/instruction, "\n- If a D-Class is terminated, remove them from the list.")
	add_field(/datum/report_field/text_label/instruction, "\n- Never give a D-Class two assignments at once.")
	add_field(/datum/report_field/text_label/instruction, "\n- If a D-Class is reassigned, search them for equipment. If any is found, return it back to the work place.")
	set_access(access_edit = access_securitylvl2)

//By 	Herbert Falsevor#3037
/datum/computer_file/report/recipient/scp/sec/dclass/termination
	form_name = "SCP-LCZ-12"
	title =		"D-Class Termination Certificate"
	available_on_ntnet = TRUE

/datum/computer_file/report/recipient/scp/sec/dclass/termination/generate_fields()
	..()
	add_field(/datum/report_field/date, "Date")
	add_field(/datum/report_field/time, "Time")
	add_field(/datum/report_field/people/from_manifest, "Terminated Instance")
	add_field(/datum/report_field/people/list_from_manifest, "Arresting Officer(s)")
	add_field(/datum/report_field/people/list_from_manifest, "Termination Officer(s)")
	add_field(/datum/report_field/pencode_text, "Justification(s)")
	add_field(/datum/report_field/pencode_text, "Method of Termination")
	add_field(/datum/report_field/signature, "Signature")
	set_access(access_edit = access_securitylvl2)
