/*
 * Holds procs designed to help with filtering text
 * Contains groups:
 *			SQL sanitization
 *			Text sanitization
 *			Text searches
 *			Text modification
 *			Misc
 */


/*
 * SQL sanitization
 */

// Adds a prefix to the table parameter, used in SQL to unify all tables under a common prefix, i.e. "tegu__[tablename]"
/proc/format_table_name(table as text)
	return "" + table // TODO: Remove hardcoded table prefix, make config entry instead

/*
 * Text sanitization
 */

//Used for preprocessing entered text
//Added in an additional check to alert players if input is too long
/proc/sanitize(input, max_length = MAX_MESSAGE_LEN, encode = 0, trim = 1, extra = 1)
	if(!input)
		return

	if(max_length)
		//testing shows that just looking for > max_length alone will actually cut off the final character if message is precisely max_length, so >= instead
		if(length(input) >= max_length)
			var/overflow = ((length(input)+1) - max_length)
			to_chat(usr, SPAN_WARNING("Your message is too long by [overflow] character\s."))
			return
		input = copytext_char(input,1,max_length)

	if(extra)
		input = replace_characters(input, list("\n"=" ","\t"=" "))

	if(encode)
		// The below \ escapes have a space inserted to attempt to enable unit testing of span class usage. Please do not remove the space.
		//In addition to processing html, html_encode removes byond formatting codes like "\ red", "\ i" and other.
		//It is important to avoid double-encode text, it can "break" quotes and some other characters.
		//Also, keep in mind that escaped characters don't work in the interface (window titles, lower left corner of the main window, etc.)
		input = html_encode(input)
	else
		//If not need encode text, simply remove < and >
		//note: we can also remove here byond formatting codes: 0xFF + next byte
		input = replace_characters(input, list("<"=" ", ">"=" "))

	if(trim)
		//Maybe, we need trim text twice? Here and before copytext_char?
		input = trim(input)

	return input

//Run sanitize(), but remove <, >, " first to prevent displaying them as &gt; &lt; &34; in some places, after html_encode().
//Best used for sanitize object names, window titles.
//If you have a problem with sanitize() in chat, when quotes and >, < are displayed as html entites -
//this is a problem of double-encode(when & becomes &amp;), use sanitize() with encode=0, but not the sanitizeSafe()!
/proc/sanitizeSafe(input, max_length = MAX_MESSAGE_LEN, encode = 1, trim = 1, extra = 1)
	return sanitize(replace_characters(input, list(">"=" ","<"=" ", "\""="'")), max_length, encode, trim, extra)

//Filters out undesirable characters from names
/proc/sanitizeName(input, max_length = MAX_NAME_LEN, allow_numbers = 0, force_first_letter_uppercase = TRUE)
	if(!input || length(input) > max_length)
		return //Rejects the input if it is null or if it is longer then the max length allowed

	var/number_of_alphanumeric	= 0
	var/last_char_group			= 0
	var/output = ""

	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// a  .. z
			if(97 to 122)			//Lowercase Letters
				if(last_char_group<2 && force_first_letter_uppercase)
					output += ascii2text(ascii_char-32)	//Force uppercase first character
				else
					output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 4

			// 0  .. 9
			if(48 to 57)			//Numbers
				if(!last_char_group)		continue	//suppress at start of string
				if(!allow_numbers)			continue
				output += ascii2text(ascii_char)
				number_of_alphanumeric++
				last_char_group = 3

			// '  -  .
			if(39,45,46)			//Common name punctuation
				if(!last_char_group) continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			// ~   |   @  :  #  $  %  &  *  +
			if(126,124,64,58,35,36,37,38,42,43)			//Other symbols that we'll allow (mainly for AI)
				if(!last_char_group)		continue	//suppress at start of string
				if(!allow_numbers)			continue
				output += ascii2text(ascii_char)
				last_char_group = 2

			//Space
			if(32)
				if(last_char_group <= 1)	continue	//suppress double-spaces and spaces at start of string
				output += ascii2text(ascii_char)
				last_char_group = 1
			else
				return

	if(number_of_alphanumeric < 2)	return		//protects against tiny names like "A" and also names like "' ' ' ' ' ' ' '"

	if(last_char_group == 1)
		output = copytext_char(output,1,length(output))	//removes the last character (in this case a space)

	for(var/bad_name in list("space","floor","wall","r-wall","monkey","unknown","inactive ai","plating"))	//prevents these common metagamey names
		if(cmptext(output,bad_name))	return	//(not case sensitive)

	return output

//Used to strip text of everything but letters and numbers, make letters lowercase, and turn spaces into .'s.
//Make sure the text hasn't been encoded if using this.
/proc/sanitize_for_email(text)
	if(!text) return ""
	var/list/dat = list()
	var/last_was_space = 1
	for(var/i=1, i<=length(text), i++)
		var/ascii_char = text2ascii(text,i)
		switch(ascii_char)
			if(65 to 90)	//A-Z, make them lowercase
				dat += ascii2text(ascii_char + 32)
			if(97 to 122)	//a-z
				dat += ascii2text(ascii_char)
				last_was_space = 0
			if(48 to 57)	//0-9
				dat += ascii2text(ascii_char)
				last_was_space = 0
			if(32, 46)	//space or .
				if(last_was_space)
					continue
				dat += "."		//We turn these into ., but avoid repeats or . at start.
				last_was_space = 1
	if(dat[length(dat)] == ".")	//kill trailing .
		dat.Cut(length(dat))
	return jointext(dat, null)

/// Checks the string for bad content (e.g. non-ASCII letters, whitespace only). If it's good, returns the string, otherwise returns null
/proc/reject_bad_text(text, max_length = 512)
	if(length(text) > max_length)
		return			//message too long
	var/non_whitespace = 0
	for(var/i = 1, i <= length(text), i++)
		switch(text2ascii(text, i))
			if(62, 60, 92, 47)	// <, >, \, and /
				return
			if(127 to 255)		// non-ASCII characters
				return
			if(0 to 31)			// weird stuff
				return
			if(32)				// whitespace
				continue
			else
				non_whitespace = 1
	if(non_whitespace)	//only accepts the text if it has some non-spaces
		return text


//Old variant. Haven't dared to replace in some places.
/proc/sanitize_old(t,list/repl_chars = list("\n"="#","\t"="#"))
	return html_encode(replace_characters(t,repl_chars))

/*
 * Text searches
 */

//Checks the beginning of a string for a specified sub-string
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtext(text, prefix, start, end)

//Checks the beginning of a string for a specified sub-string. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hasprefix_case(text, prefix)
	var/start = 1
	var/end = length(prefix) + 1
	return findtextEx(text, prefix, start, end)

//Checks the end of a string for a specified substring.
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtext(text, suffix, start, null)
	return

//Checks the end of a string for a specified substring. This proc is case sensitive
//Returns the position of the substring or 0 if it was not found
/proc/dd_hassuffix_case(text, suffix)
	var/start = length(text) - length(suffix)
	if(start)
		return findtextEx(text, suffix, start, null)

/*
 * Text modification
 */

/proc/replace_characters(t,list/repl_chars)
	for(var/char in repl_chars)
		t = replacetext(t, char, repl_chars[char])
	return t

//Adds 'u' number of zeros ahead of the text 't'
/proc/add_zero(t, u)
	return pad_left(t, u, "0")

//Adds 'u' number of spaces ahead of the text 't'
/proc/add_lspace(t, u)
	return pad_left(t, u, " ")

//Adds 'u' number of spaces behind the text 't'
/proc/add_tspace(t, u)
	return pad_right(t, u, " ")

// Adds the required amount of 'character' in front of 'text' to extend the lengh to 'desired_length', if it is shorter
// No consideration are made for a multi-character 'character' input
/proc/pad_left(text, desired_length, character)
	var/padding = generate_padding(length(text), desired_length, character)
	return length(padding) ? "[padding][text]" : text

// Adds the required amount of 'character' after 'text' to extend the lengh to 'desired_length', if it is shorter
// No consideration are made for a multi-character 'character' input
/proc/pad_right(text, desired_length, character)
	var/padding = generate_padding(length(text), desired_length, character)
	return length(padding) ? "[text][padding]" : text

/proc/generate_padding(current_length, desired_length, character)
	if(current_length >= desired_length)
		return ""
	var/characters = list()
	for(var/i = 1 to (desired_length - current_length))
		characters += character
	return JOINTEXT(characters)

//Returns a string with reserved characters and spaces before the first letter removed
/proc/trim_left(text)
	for (var/i = 1 to length(text))
		if (text2ascii(text, i) > 32)
			return copytext_char(text, i)
	return ""

//Returns a string with reserved characters and spaces after the last letter removed
/proc/trim_right(text)
	for (var/i = length(text), i > 0, i--)
		if (text2ascii(text, i) > 32)
			return copytext_char(text, 1, i + 1)
	return ""

//Returns a string with reserved characters and spaces before the first word and after the last word removed.
/proc/trim(text)
	return trim_left(trim_right(text))

//Returns a string with the first element of the string capitalized.
/proc/capitalize(t as text)
	return uppertext(copytext_char(t, 1, 2)) + copytext_char(t, 2)

//This proc strips html properly, remove < > and all text between
//for complete text sanitizing should be used sanitize()
/proc/strip_html_properly(input)
	if(!input)
		return
	var/opentag = 1 //These store the position of < and > respectively.
	var/closetag = 1
	while(1)
		opentag = findtext(input, "<")
		closetag = findtext(input, ">")
		if(closetag && opentag)
			if(closetag < opentag)
				input = copytext(input, (closetag + 1))
			else
				input = copytext(input, 1, opentag) + copytext(input, (closetag + 1))
		else if(closetag || opentag)
			if(opentag)
				input = copytext(input, 1, opentag)
			else
				input = copytext(input, (closetag + 1))
		else
			break
			break

	return input

//This proc fills in all spaces with the "replace" var (* by default) with whatever
//is in the other string at the same spot (assuming it is not a replace char).
//This is used for fingerprints
/proc/stringmerge(text,compare,replace = "*")
	var/newtext = text
	if(length(text) != length(compare))
		return 0
	for(var/i = 1, i < length(text), i++)
		var/a = copytext_char(text,i,i+1)
		var/b = copytext_char(compare,i,i+1)
		//if it isn't both the same letter, or if they are both the replacement character
		//(no way to know what it was supposed to be)
		if(a != b)
			if(a == replace) //if A is the replacement char
				newtext = copytext_char(newtext,1,i) + b + copytext_char(newtext, i+1)
			else if(b == replace) //if B is the replacement char
				newtext = copytext_char(newtext,1,i) + a + copytext_char(newtext, i+1)
			else //The lists disagree, Uh-oh!
				return 0
	return newtext

//This proc returns the number of chars of the string that is the character
//This is used for detective work to determine fingerprint completion.
/proc/stringpercent(text,character = "*")
	if(!text || !character)
		return 0
	var/count = 0
	for(var/i = 1, i <= length(text), i++)
		var/a = copytext_char(text,i,i+1)
		if(a == character)
			count++
	return count

/proc/reverse_text(text = "")
	var/new_text = ""
	for(var/i = length(text); i > 0; i--)
		new_text += copytext_char(text, i, i+1)
	return new_text

//Used in preferences' SetFlavorText and human's set_flavor verb
//Previews a string of len or less length
/proc/TextPreview(string,len=40)
	if(length(string) <= len)
		if(!length(string))
			return "\[...\]"
		else
			return string
	else
		return "[copytext_preserve_html(string, 1, 37)]..."

//alternative copytext() for encoded text, doesn't break html entities (&#34; and other)
/proc/copytext_preserve_html(text, first, last)
	return html_encode(copytext_char(html_decode(text), first, last))

/proc/create_text_tag(tagname, tagdesc = tagname, client/C = null)
	if(!(C?.get_preference_value(/datum/client_preference/chat_tags) == GLOB.PREF_SHOW))
		return tagdesc
	return icon2html(icon('./icons/chattags.dmi', tagname), world, extra_classes="text_tag")

/proc/text_badge(client/C = null)
	if(!C)
		return null
	var/badge_name
	if(C.holder)
		//No badges when deadminned
		if(C.is_stealthed())
			return null
		//Admin badge otherwise
		if(C.holder.rank)
			badge_name = C.holder.rank
			switch(C.holder.rank)
				if("NetworkAssistantLead", "NetworkCoLead", "NetworkLead")
					badge_name = "Host"
				if("HeadMaintainer")
					badge_name = "HeadDeveloper"
	else if(IS_TRUSTED_PLAYER(C.ckey))
		badge_name = "Trusted"
	if(badge_name)
		return icon2html(icon('./icons/chatbadges.dmi', badge_name), world, extra_classes="text_tag")
	return null

/proc/contains_az09(input)
	for(var/i=1, i<=length(input), i++)
		var/ascii_char = text2ascii(input,i)
		switch(ascii_char)
			// A  .. Z
			if(65 to 90)			//Uppercase Letters
				return 1
			// a  .. z
			if(97 to 122)			//Lowercase Letters
				return 1

			// 0  .. 9
			if(48 to 57)			//Numbers
				return 1
	return 0

/proc/generateRandomString(length)
	. = list()
	for(var/a in 1 to length)
		var/letter = rand(33,126)
		. += ascii2text(letter)
	. = jointext(.,null)

#define starts_with(string, substring) (copytext(string,1,1+length(substring)) == substring)

#define gender2text(gender) capitalize(gender)

/**
 * Strip out the special beyond characters for \proper and \improper
 * from text that will be sent to the browser.
 */
#define strip_improper(input_text) replacetext(replacetext(input_text, "\proper", ""), "\improper", "")

/proc/pencode2html(t)
	t = pencode_acs2html(t)
	t = replacetext(t, "\n", "<BR>")
	t = replacetext(t, "\[center\]", "<center>")
	t = replacetext(t, "\[/center\]", "</center>")
	t = replacetext(t, "\[br\]", "<BR>")
	t = replacetext(t, "\[b\]", "<B>")
	t = replacetext(t, "\[/b\]", "</B>")
	t = replacetext(t, "\[i\]", "<I>")
	t = replacetext(t, "\[/i\]", "</I>")
	t = replacetext(t, "\[u\]", "<U>")
	t = replacetext(t, "\[/u\]", "</U>")
	t = replacetext(t, "\[time\]", "[station_time_timestamp("hh:mm")]")
	t = replacetext(t, "\[date\]", "[stationdate2text()]")
	t = replacetext(t, "\[large\]", "<font size=\"4\">")
	t = replacetext(t, "\[/large\]", "</font>")
	t = replacetext(t, "\[field\]", "<span class=\"paper_field\"></span>")
	t = replacetext(t, "\[h1\]", "<H1>")
	t = replacetext(t, "\[/h1\]", "</H1>")
	t = replacetext(t, "\[h2\]", "<H2>")
	t = replacetext(t, "\[/h2\]", "</H2>")
	t = replacetext(t, "\[h3\]", "<H3>")
	t = replacetext(t, "\[/h3\]", "</H3>")
	t = replacetext(t, "\[*\]", "<li>")
	t = replacetext(t, "\[hr\]", "<HR>")
	t = replacetext(t, "\[small\]", "<font size = \"1\">")
	t = replacetext(t, "\[/small\]", "</font>")
	t = replacetext(t, "\[ulist\]", "<ul>")
	t = replacetext(t, "\[/ulist\]", "</ul>")
	t = replacetext(t, "\[list\]", "<ul>")		// kept for backwards compatability with pre-existing pencode
	t = replacetext(t, "\[/list\]", "</ul>")
	t = replacetext(t, "\[olist\]", "<ol>")
	t = replacetext(t, "\[/olist\]", "</ol>")
	t = replacetext(t, "\[table\]", "<table border=1 cellspacing=0 cellpadding=3 style='border: 1px solid black;'>")
	t = replacetext(t, "\[/table\]", "</td></tr></table>")
	t = replacetext(t, "\[grid\]", "<table>")
	t = replacetext(t, "\[/grid\]", "</td></tr></table>")
	t = replacetext(t, "\[row\]", "</td><tr>")
	t = replacetext(t, "\[cell\]", "<td>")
	t = replacetext(t, "\[editorbr\]", "")
	t = replacetext(t, "\[scplogo\]", "<img src = scplogo.png>")
	t = replacetext(t, "\[ethicslogo\]", "<img src = ethics.png>")
	t = replacetext(t, "\[o5logo\]", "<img src = o5.png>")
	t = replacetext(t, "\[adminlogo\]", "<img src = admin.png>")
	t = replacetext(t, "\[englogo\]", "<img src = eng.png>")
	t = replacetext(t, "\[mtflogo\]", "<img src = mtf.png>")
	t = replacetext(t, "\[loglogo\]", "<img src = log.png>")
	t = replacetext(t, "\[manlogo\]", "<img src = man.png>")
	t = replacetext(t, "\[medlogo\]", "<img src = med.png>")
	t = replacetext(t, "\[scilogo\]", "<img src = sci.png>")
	t = replacetext(t, "\[seclogo\]", "<img src = sec.png>")
	t = replacetext(t, "\[isdlogo\]", "<img src = isd.png>")
	t = replacetext(t, "\[dealogo\]", "<img src = dea.png>")
	t = replacetext(t, "\[intlogo\]", "<img src = int.png>")
	t = replacetext(t, "\[triblogo\]", "<img src = trib.png>")
	t = replacetext(t, "\[aiadlogo\]", "<img src = aiad.png>")
	t = replacetext(t, "\[amdlogo\]", "<img src = amd.png>")
	t = replacetext(t, "\[dcdlogo\]", "<img src = dcd.png>")
	t = replacetext(t, "\[fsdlogo\]", "<img src = fsd.png>")
	t = replacetext(t, "\[misilogo\]", "<img src = misi.png>")
	t = replacetext(t, "\[patalogo\]", "<img src = pata.png>")
	t = replacetext(t, "\[raisalogo\]", "<img src = raisa.png>")
	t = replacetext(t, "\[goclogo\]", "<img src = ungoc.png>")
	t = replacetext(t, "\[uiulogo\]", "<img src = uiu.png>")
	t = replacetext(t, "\[mcdlogo\]", "<img src = mcd.png>")
	t = replacetext(t, "\[grlogo\]", "<img src = gr.png>")
	t = replacetext(t, "\[arlogo\]", "<img src = ar.png>")
	t = replacetext(t, "\[cilogo\]", "<img src = ci.png>")
	t = replacetext(t, "\[shlogo\]", "<img src = sh.png>")
	t = replacetext(t, "\[cotbglogo\]", "<img src = cotbg.png>")
	t = replacetext(t, "\[coclogo\]", "<img src = coc.png>")
	t = replacetext(t, "\[cmaxlogo\]", "<img src = cmax.png>")
	t = replacetext(t, "\[mcflogo\]", "<img src = mcf.png>")
	t = replacetext(t, "\[wwslogo\]", "<img src = wws.png>")
	t = replacetext(t, "\[spclogo\]", "<img src = spc.png>")
	return t

//pencode translation to html for tags exclusive to digital files (currently email, nanoword, report editor fields,
//modular scanner data and txt file printing) and prints from them
/proc/digitalPencode2html(text)
	text = replacetext(text, "\[pre\]", "<pre>")
	text = replacetext(text, "\[/pre\]", "</pre>")
	text = replacetext(text, "\[fontred\]", "<font color=\"red\">") //</font> to pass html tag integrity unit test
	text = replacetext(text, "\[fontblue\]", "<font color=\"blue\">")//</font> to pass html tag integrity unit test
	text = replacetext(text, "\[fontgreen\]", "<font color=\"green\">")
	text = replacetext(text, "\[/font\]", "</font>")
	text = replacetext(text, "\[redacted\]", "<span class=\"redacted\">R E D A C T E D</span>")
	return pencode2html(text)

/// Scans for and replaces pencode ACS formats with usable HTML versions
/proc/pencode_acs2html(text)
	// raw text for regex
	var/regex/scanner_nosecondary = new(@"\[acs item_number=(\w+) clearance_level=(\w+) containment_class=(\w+) disruption_class=(\w+) risk_class=(\w+)\]", "g")
	var/regex/scanner_secondary = new(@"\[acs item_number=(\w+) clearance_level=(\w+) containment_class=(\w+) secondary_class=(\w+) disruption_class=(\w+) risk_class=(\w+)\]", "g")

	var/newtext = text

	newtext = scanner_nosecondary.Replace(newtext,
@{"<div class="acs-hybrid-text-bar acs-hybrid-version acs-clear-$2 acs-$3 acs-$4 acs-$5">
<div class="acs-item">
<span><strong>Item#:</strong>$1</span>
</div>
<div class="acs-clear">
<strong>Clearance Level $2:</strong> <span class="clearance-level-text">Clearance</span>
</div>
<div class="acs-contain-container">
<div class="acs-contain">
<div class="acs-text">
<span><strong>Containment Class:</strong></span> <span>$3</span>
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$3-icon.svg" alt="">
</div>
</div>
<div class="acs-secondary">
<div class="acs-text">
<span><strong>Secondary Class:</strong></span> <span></span>
</div>
<div class="acs-icon">
<img>
</div>
</div>
</div>
<div class="acs-disrupt">
<div class="acs-text">
<strong>Disruption Class:</strong> <span class="disruption-class-number">#</span>/$4
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$4-icon.svg" alt="">
</div>
</div>
<div class="acs-risk">
<div class="acs-text">
<strong>Risk Class:</strong> <span class="risk-class-number">#</span>/$5
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$5-icon.svg" alt="">
</div>
</div>
</div>"})

	newtext = scanner_secondary.Replace(newtext,
@{"<div class="acs-hybrid-text-bar acs-yes acs-hybrid-version acs-clear-$2 acs-$3 acs-$4 acs-$5 acs-$6">
<div class="acs-item">
<span><strong>Item#:</strong>$1</span>
</div>
<div class="acs-clear">
<strong>Clearance Level $2:</strong> <span class="clearance-level-text">Clearance</span>
</div>
<div class="acs-contain-container">
<div class="acs-contain">
<div class="acs-text">
<span><strong>Containment Class:</strong></span> <span>$3</span>
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$3-icon.svg" alt="">
</div>
</div>
<div class="acs-secondary">
<div class="acs-text">
<span><strong>Secondary Class:</strong></span> <span>$4</span>
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$4-icon.svg" alt="">
</div>
</div>
</div>
<div class="acs-disrupt">
<div class="acs-text">
<strong>Disruption Class:</strong> <span class="disruption-class-number">#</span>/$5
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$5-icon.svg" alt="">
</div>
</div>
<div class="acs-risk">
<div class="acs-text">
<strong>Risk Class:</strong> <span class="risk-class-number">#</span>/$6
</div>
<div class="acs-icon">
<img src="http://scp-wiki.wdfiles.com/local--files/component%3Aanomaly-class-bar/$6-icon.svg" alt="">
</div>
</div>
</div>"})

	return newtext

//Will kill most formatting; not recommended.
/proc/html2pencode(t)
	t = replacetext(t, "<pre>", "\[pre\]")
	t = replacetext(t, "</pre>", "\[/pre\]")
	t = replacetext(t, "<font color=\"red\">", "\[fontred\]")//</font> to pass html tag integrity unit test
	t = replacetext(t, "<font color=\"blue\">", "\[fontblue\]")//</font> to pass html tag integrity unit test
	t = replacetext(t, "<font color=\"green\">", "\[fontgreen\]")
	t = replacetext(t, "</font>", "\[/font\]")
	t = replacetext(t, "<BR>", "\[br\]")
	t = replacetext(t, "<br>", "\[br\]")
	t = replacetext(t, "<B>", "\[b\]")
	t = replacetext(t, "</B>", "\[/b\]")
	t = replacetext(t, "<I>", "\[i\]")
	t = replacetext(t, "</I>", "\[/i\]")
	t = replacetext(t, "<U>", "\[u\]")
	t = replacetext(t, "</U>", "\[/u\]")
	t = replacetext(t, "<center>", "\[center\]")
	t = replacetext(t, "</center>", "\[/center\]")
	t = replacetext(t, "<H1>", "\[h1\]")
	t = replacetext(t, "</H1>", "\[/h1\]")
	t = replacetext(t, "<H2>", "\[h2\]")
	t = replacetext(t, "</H2>", "\[/h2\]")
	t = replacetext(t, "<H3>", "\[h3\]")
	t = replacetext(t, "</H3>", "\[/h3\]")
	t = replacetext(t, "<li>", "\[*\]")
	t = replacetext(t, "<HR>", "\[hr\]")
	t = replacetext(t, "<ul>", "\[ulist\]")
	t = replacetext(t, "</ul>", "\[/ulist\]")
	t = replacetext(t, "<table>", "\[grid\]")
	t = replacetext(t, "</table>", "\[/grid\]")
	t = replacetext(t, "<tr>", "\[row\]")
	t = replacetext(t, "<td>", "\[cell\]")
	t = replacetext(t, "<img src = scplogo.png>", "\[scplogo\]")
	t = replacetext(t, "<img src = ethics.png>", "\[ethicslogo\]")
	t = replacetext(t, "<img src = o5.png>", "\[o5logo\]")
	t = replacetext(t, "<img src = admin.png>", "\[adminlogo\]")
	t = replacetext(t, "<img src = eng.png>", "\[englogo\]")
	t = replacetext(t, "<img src = mtf.png>", "\[mtflogo\]")
	t = replacetext(t, "<img src = log.png>", "\[loglogo\]")
	t = replacetext(t, "<img src = man.png>", "\[manlogo\]")
	t = replacetext(t, "<img src = med.png>", "\[medlogo\]")
	t = replacetext(t, "<img src = sci.png>", "\[scilogo\]")
	t = replacetext(t, "<img src = sec.png>", "\[seclogo\]")
	t = replacetext(t, "<img src = isd.png>", "\[isdlogo\]")
	t = replacetext(t, "<img src = dea.png>", "\[dealogo\]")
	t = replacetext(t, "<img src = int.png>", "\[intlogo\]")
	t = replacetext(t, "<img src = trib.png>", "\[triblogo\]")
	t = replacetext(t, "<img src = ungoc.png>", "\[goclogo\]")
	t = replacetext(t, "<img src = uiu.png>", "\[uiulogo\]")
	t = replacetext(t, "<img src = mcd.png>", "\[mcdlogo\]")
	t = replacetext(t, "<img src = ar.png>", "\[arlogo\]")
	t = replacetext(t, "<img src = ci.png>", "\[cilogo\]")
	t = replacetext(t, "<img src = sh.png>", "\[shlogo\]")
	t = replacetext(t, "<img src = cotbg.png>", "\[cotbglogo\]")
	t = replacetext(t, "<span class=\"paper_field\"></span>", "\[field\]")
	t = replacetext(t, "<span class=\"redacted\">R E D A C T E D</span>", "\[redacted\]")
	t = strip_html_properly(t)
	return t

// Random password generator
/proc/GenerateKey()
	//Feel free to move to Helpers.
	var/newKey
	newKey += pick("the", "if", "of", "as", "in", "a", "you", "from", "to", "an", "too", "little", "snow", "dead", "drunk", "rosebud", "duck", "al", "le")
	newKey += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	newKey += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	return newKey

//Used for applying byonds text macros to strings that are loaded at runtime
/proc/apply_text_macros(string)
	var/next_backslash = findtext(string, "\\")
	if(!next_backslash)
		return string

	var/leng = length(string)

	var/next_space = findtext(string, " ", next_backslash + 1)
	if(!next_space)
		next_space = leng - next_backslash

	if(!next_space)	//trailing bs
		return string

	var/base = next_backslash == 1 ? "" : copytext_char(string, 1, next_backslash)
	var/macro = lowertext(copytext_char(string, next_backslash + 1, next_space))
	var/rest = next_backslash > leng ? "" : copytext_char(string, next_space + 1)

	//See http://www.byond.com/docs/ref/info.html#/DM/text/macros
	switch(macro)
		//prefixes/agnostic
		if("the")
			rest = text("\the []", rest)
		if("a")
			rest = text("\a []", rest)
		if("an")
			rest = text("\an []", rest)
		if("proper")
			rest = text("\proper []", rest)
		if("improper")
			rest = text("\improper []", rest)
		if("roman")
			rest = text("\roman []", rest)
		//postfixes
		if("th")
			base = text("[]\th", rest)
		if("s")
			base = text("[]\s", rest)
		if("he")
			base = text("[]\he", rest)
		if("she")
			base = text("[]\she", rest)
		if("his")
			base = text("[]\his", rest)
		if("himself")
			base = text("[]\himself", rest)
		if("herself")
			base = text("[]\herself", rest)
		if("hers")
			base = text("[]\hers", rest)

	. = base
	if(rest)
		. += .(rest)

/proc/deep_string_equals(A, B)
	if (length(A) != length(B))
		return FALSE
	for (var/i = 1 to length(A))
		if (text2ascii(A, i) != text2ascii(B, i))
			return FALSE
	return TRUE

// If char isn't part of the text the entire text is returned
/proc/copytext_after_last(text, char)
	var/regex/R = regex("(\[^[char]\]*)$")
	regex_find(R, text)
	return R.group[1]

/proc/sql_sanitize_text(text)
	text = replacetext(text, "'", "''")
	text = replacetext(text, ";", "")
	text = replacetext(text, "&", "")
	return text

/proc/new_sql_sanitize_text(text)
	text = replacetext(text, "'", "")
	text = replacetext(text, ";", "")
	text = replacetext(text, "&", "")
	text = replacetext(text, "`", "")
	return text

/proc/remove_all_spaces(text)
	text = replacetext(text, " ", "")
	return text

/proc/text2num_or_default(text, default)
	var/result = text2num(text)
	return "[result]" == text ? result : default

/proc/text2regex(text)
	var/end = findlasttext(text, "/")
	if (end > 2 && length(text) > 2 && text[1] == "/")
		var/flags = end == length(text) ? FALSE : copytext_char(text, end + 1)
		var/matcher = copytext_char(text, 2, end)
		try
			return flags ? regex(matcher, flags) : regex(matcher)
		catch()
	log_error("failed to parse text to regex: [text]")

/proc/process_chat_markup(message)
	if (message && length(config.chat_markup))
		for (var/list/entry in config.chat_markup)
			var/regex/matcher = entry[1]
			message = replacetext_char(message, matcher, entry[2])
	return message

/**
 * Used to get a properly sanitized input. Returns null if cancel is pressed.
 *
 * Arguments
 ** user - Target of the input prompt.
 ** message - The text inside of the prompt.
 ** title - The window title of the prompt.
 ** max_length - If you intend to impose a length limit - default is 1024.
 ** no_trim - Prevents the input from being trimmed if you intend to parse newlines or whitespace.
*/
/proc/stripped_input(mob/user, message = "", title = "", default = "", max_length=MAX_MESSAGE_LEN, no_trim=FALSE)
	var/user_input = input(user, message, title, default) as text|null
	if(isnull(user_input)) // User pressed cancel
		return
	if(no_trim)
		return copytext_char(html_encode(user_input), 1, max_length)
	else
		return trim(html_encode(user_input), max_length) //trim is "outside" because html_encode can expand single symbols into multiple symbols (such as turning < into &lt;)

/**
 * Used to get a properly sanitized input in a larger box. Works very similarly to stripped_input.
 *
 * Arguments
 ** user - Target of the input prompt.
 ** message - The text inside of the prompt.
 ** title - The window title of the prompt.
 ** max_length - If you intend to impose a length limit - default is 1024.
 ** no_trim - Prevents the input from being trimmed if you intend to parse newlines or whitespace.
*/
/proc/stripped_multiline_input(mob/user, message = "", title = "", default = "", max_length=MAX_MESSAGE_LEN, no_trim=FALSE)
	var/user_input = input(user, message, title, default) as message|null
	if(isnull(user_input)) // User pressed cancel
		return
	if(no_trim)
		return copytext_char(html_encode(user_input), 1, max_length)
	else
		return trim(html_encode(user_input), max_length)

// Format a power value in W, kW, MW, or GW.
/proc/DisplayPower(powerused)
	if(powerused < 1000) //Less than a kW
		return "[powerused] W"
	else if(powerused < 1000000) //Less than a MW
		return "[round((powerused * 0.001),0.01)] kW"
	else if(powerused < 1000000000) //Less than a GW
		return "[round((powerused * 0.000001),0.001)] MW"
	return "[round((powerused * 0.000000001),0.0001)] GW"

/proc/count_fields_from_html(t)
	//Count the fields
	var/laststart = 1
	var/fields = 0
	while(fields < MAX_PAPER_FIELDS)
		var/i = findtext(t, "<span class=\"paper_field\">", laststart)	//</span>
		if(i==0)
			break
		laststart = i+1
		fields++
	return fields
