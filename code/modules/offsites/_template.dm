// This represents a fax template (header, footer) for administrators to use when writing offsite faxes.
// These are singletons, so /decl/ is used.

/decl/offsite_template
	abstract_type = /decl/offsite_template

	var/name = "Unset - contact a coder!"

	/// Whether the template can take custom text when generating a header.
	var/takes_custom_header = TRUE
	/// Whether the template can take custom text when generating a footer.
	var/takes_custom_footer = FALSE

	/// The template's default custom text for its header.
	var/default_custom_header = null
	/// The template's default custom text for its footer.
	var/default_custom_footer = null

/// Generates a header from the template. Requires origin, custom text optional.
/decl/offsite_template/proc/generate_header(origin, custom)
	return name

/// Generates a footer from the template. Requires origin, custom text optional.
/decl/offsite_template/proc/generate_footer(origin, custom)
	return name

/// Converts template text to HTML.
/decl/offsite_template/proc/convert(text)
	return pencode2html(text)
