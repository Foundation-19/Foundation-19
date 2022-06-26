/datum/computer_file/report/recipient/scp/sci
	logo = "\[sci\]"
	form_name = "SCP-SCI-00"

/datum/computer_file/report/recipient/scp/sci/New()
	..()
	set_access(access_sciencelvl1)
	set_access(access_adminlvl2, override = 0)


//By 	Tiberius#4168
/datum/computer_file/report/recipient/scp/sci/test/standard
	form_name = "SCP-SCI-01"
	title = 	"Foundation Standard Test"
	available_on_ntnet = TRUE

/datum/computer_file/report/recipient/scp/sci/test/standard/generate_fields()
	add_field(/datum/report_field/text_label/header, "PRE-TEST")
	add_field(/datum/report_field/date, "Date", required = 1)
	add_field(/datum/report_field/time, "Time", required = 1)
	add_field(/datum/report_field/people/from_manifest, "Lead Researcher, Security Clearance and Personnel Classification", required = 1)
	add_field(/datum/report_field/people/list_from_manifest, "Supporting Researchers")
	add_field(/datum/report_field/simple_text, "SCP object(s) in experiment", required = 1)
	add_field(/datum/report_field/pencode_text, "Planned experiment", required = 1)
	add_field(/datum/report_field/number, "Requested security agent amount", required = 1)

	add_field(/datum/report_field/text_label/header, "\n\nPOST-TEST")
	add_field(/datum/report_field/options/yes_no, "\nTest successful?", required = 1)
	add_field(/datum/report_field/pencode_text, "Results", required = 1)
	add_field(/datum/report_field/pencode_text, "Casualties", required = 1)
	set_access(access_edit = access_sciencelvl2)

/datum/computer_file/report/recipient/scp/sci/test/termination
	form_name = "SCP-SCI-13"
	title = 	"Foundation Termination Attempt"
	available_on_ntnet = TRUE

/datum/computer_file/report/recipient/scp/sci/test/termination/generate_fields()
	..()
	var/datum/report_field/tempfield
	add_field(/datum/report_field/text_label/header, "PRE-ATTEMPT")
	add_field(/datum/report_field/date, "Date", required = 1)
	add_field(/datum/report_field/time, "Time", required = 1)
	add_field(/datum/report_field/people/from_manifest, "Lead Researcher")
	tempfield =	add_field(/datum/report_field/signature, "Site Director's signature", required = 1)
	tempfield.set_access(access_edit = list(access_adminlvl5))
	add_field(/datum/report_field/people/list_from_manifest, "Supporting Researchers")

	add_field(/datum/report_field/pencode_text, "\nSCP(s)", required = 1)
	add_field(/datum/report_field/pencode_text, "Planned Termination", required = 1)
	add_field(/datum/report_field/number, "Planned number of Guards", required = 1)

	add_field(/datum/report_field/text_label/header, "\nPOST-ATTEMPT")
	add_field(/datum/report_field/options/yes_no, "Success?", required = 1)
	add_field(/datum/report_field/pencode_text, "Results", required = 1)
	add_field(/datum/report_field/pencode_text, "Casualties", required = 1)
	add_field(/datum/report_field/pencode_text, "Notes")
	add_field(/datum/report_field/number, "Post Termination Attempt times", required = 1)
	set_access(access_edit = access_sciencelvl2)
