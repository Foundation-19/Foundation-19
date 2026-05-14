// This represents a fax template (header, footer) for administrators to use when writing offsite faxes.
// These are singletons, so /decl/ is used.

/decl/offsite_template
	abstract_type = /decl/offsite_template

	var/name = "Unset - contact a coder!"

	/// Whether the template can take custom text when generating its header or footer.
	var/takes_custom_header = TRUE
	var/takes_custom_footer = FALSE

	/// The template's default custom text for its header and footer.
	var/default_custom_header = null
	var/default_custom_footer = null

	// Whether the template actually generates a header, footer, or body.
	var/uses_header = TRUE
	var/uses_body = FALSE
	var/uses_footer = TRUE

/// Generates a header from the template. Requires origin, custom text optional.
/decl/offsite_template/proc/generate_header(origin, custom)
	if(!uses_header)
		return ""

/// Generates a body from the template. Requires origin.
/decl/offsite_template/proc/generate_body(origin)
	if(!uses_body)
		return ""

/// Generates a footer from the template. Requires origin, custom text optional.
/decl/offsite_template/proc/generate_footer(origin, custom)
	if(!uses_footer)
		return ""

/// Converts template text to HTML.
/decl/offsite_template/proc/convert(text)
	return pencode2html(text)
