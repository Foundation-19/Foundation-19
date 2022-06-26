/datum/computer_file/report/recipient/scp/mtf
	logo = "\[mtf\]"
	form_name = "SCP-MTF-00"

/datum/computer_file/report/recipient/scp/mtf/New()
	..()
	set_access(access_mtf, access_mtf)

//By 	Gasmasked#4747
/datum/computer_file/report/recipient/scp/mtf/postmission
	form_name = "SCP-MTF-03"
	title = 	"MTF Team Post-Arrival Evaluation"
	available_on_ntnet = TRUE

/datum/computer_file/report/recipient/scp/mtf/postmission/generate_fields()
	..()
	add_field(/datum/report_field/simple_text, "Commanding MTF Officer", required = 1)

	add_field(/datum/report_field/simple_text, "MTF unit deployed", required = 1)
	add_field(/datum/report_field/pencode_text, "Reason for deployment", required = 1)
	add_field(/datum/report_field/date, "Date of Deployment", required = 1)
	add_field(/datum/report_field/time, "Time of Deployment", required = 1)
	add_field(/datum/report_field/number, "Total number of operatives deployed", required = 1)

	add_field(/datum/report_field/pencode_text, "\nSCP status", required = 1)
	add_field(/datum/report_field/text_label/instruction, "Write down every SCP stationed on-site as well as others involved, with a short status")
	add_field(/datum/report_field/number, "Total D-Class terminations", required = 1)
	add_field(/datum/report_field/number, "Total B/C-Class evacuated", required = 1)
	add_field(/datum/report_field/people/list_from_manifest, "A-Class evacuated", required = 1)

	add_field(/datum/report_field/pencode_text, "\nMTF Casualties", required = 1)
	add_field(/datum/report_field/pencode_text, "Hostile Casualties", required = 1)

	add_field(/datum/report_field/options/yes_no, "Mission Success?", required = 1)
	add_field(/datum/report_field/pencode_text, "MTF team state", required = 1)
	add_field(/datum/report_field/pencode_text, "Foundation personnel state", required = 1)
	add_field(/datum/report_field/pencode_text, "Site integrity state", required = 1)

	add_field(/datum/report_field/signature, "\nSignature", required = 1)
