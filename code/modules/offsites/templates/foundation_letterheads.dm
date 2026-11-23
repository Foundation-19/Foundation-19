// SCP Foundation + GOI letterhead templates for Foundation-19 faxes.
// Ported from daedalusdock scp_offsites_templates.dm into F19's
// /decl/offsite_template system.
// NOTE: normal DM strings with [tag] interpolate — so plain strings ESCAPE
// tags as \[tag\], while @{} raw strings keep tags bare.

/decl/offsite_template/foundation
	name = "Foundation Command"
	default_custom_header = "\[scplogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/foundation/generate_header(origin, custom)
	var/header = @{"[center][b]SCP FOUNDATION - [origin][/b][/center][hr][small][i]Radio Uplink Signed Message[br]"}
	if(custom)
		header += "\[custom\]\[br\]"
	header += @{"[/i][/small][hr]"}
	return convert(header)

/decl/offsite_template/foundation/generate_footer(origin, custom)
	return convert(@{"[hr][small]This message is the property of the SCP Foundation. Unauthorized disclosure of its contents constitutes a security violation. Report any suspected breach to your site's Internal Security Department representative.[/small]"})

/decl/offsite_template/ethics
	name = "Ethics Committee"
	default_custom_header = "\[ethicslogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/ethics/generate_header(origin, custom)
	var/header = @{"[center][b]ETHICS COMMITTEE CENTRAL OFFICE[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/ethics/generate_footer(origin, custom)
	return convert(@{"[hr][small]The Ethics Committee reminds all personnel that moral and ethical considerations are not optional. They are the Foundation.[/small]"})

/decl/offsite_template/uiu
	name = "UIU Command"
	default_custom_header = "\[uiulogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/uiu/generate_header(origin, custom)
	var/header = @{"[center][b]FEDERAL BUREAU OF INVESTIGATION[br]Unusual Incidents Unit[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/uiu/generate_footer(origin, custom)
	return convert(@{"[hr][small]FBI-UIU Internal Communication - Do Not Distribute[/small]"})

/decl/offsite_template/mcd
	name = "MC&D"
	default_custom_header = "\[mcdlogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/mcd/generate_header(origin, custom)
	var/header = @{"[center][b]MARSHALL, CARTER AND DARK, LTD.[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/mcd/generate_footer(origin, custom)
	return convert(@{"[hr][small]This correspondence is the exclusive property of Marshall, Carter and Dark, Ltd. and is intended solely for the named recipient.[/small]"})

/decl/offsite_template/ci
	name = "Chaos Insurgency"
	default_custom_header = "\[cilogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/ci/generate_header(origin, custom)
	var/header = @{"[center][b]CHAOS INSURGENCY - DELTA COMMAND[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/ci/generate_footer(origin, custom)
	return convert(@{"[hr][small]OPERATOR INFORMATION: This transmission is classified under CI Protocol 7. Unauthorized interception will be met with extreme prejudice.[/small]"})

/decl/offsite_template/o5
	name = "O5 Council"
	default_custom_header = "\[o5logo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/o5/generate_header(origin, custom)
	var/header = @{"[center][b]THE O5 COUNCIL[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/o5/generate_footer(origin, custom)
	return convert(@{"[hr][small]O5 EYES ONLY — This transmission terminates at the eyes of the addressed O5 member. Breach of this channel is a capital offense under Foundation Charter Section 1.[/small]"})

/decl/offsite_template/raisa
	name = "Records and Information Security Administration"
	default_custom_header = "\[raisalogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/raisa/generate_header(origin, custom)
	var/header = @{"[center][b]RAISA — RECORDS AND INFORMATION SECURITY ADMINISTRATION[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/raisa/generate_footer(origin, custom)
	return convert(@{"[hr][small]RAISA records transmission — tampering with records protocols is a Class-B infraction.[/small]"})

/decl/offsite_template/isd
	name = "Internal Security Department"
	default_custom_header = "\[isdlogo\]"
	takes_custom_footer = FALSE

/decl/offsite_template/isd/generate_header(origin, custom)
	var/header = @{"[center][b]INTERNAL SECURITY DEPARTMENT[/b][/center][hr]"}
	if(custom)
		header += "\[small\]\[i\]\[custom\]\[br\]\[/i\]\[/small\]\[hr\]"
	return convert(header)

/decl/offsite_template/isd/generate_footer(origin, custom)
	return convert(@{"[hr][small]ISD COMMUNICATION — We are watching. We are always watching.[/small]"})
