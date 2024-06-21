/proc/add_utf_8_to_html(browser_content)
	if (isnull(browser_content) || isfile(browser_content))
		return browser_content
	else if(findtext(browser_content, "<html>"))
		return replacetext(browser_content, "<html>", "<html><meta charset='UTF-8'>")
	else
		return "<html><meta charset='UTF-8'><body>[browser_content]</body></html>"
