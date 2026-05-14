/// Standard maptext
/// Prepares a text to be used for maptext. Use this so it doesn't look hideous.
#define MAPTEXT(text) {"<span class='maptext'>[##text]</span>"}

/// Removes characters incompatible with file names.
#define SANITIZE_FILENAME(text) (GLOB.filename_forbidden_chars.Replace(text, ""))

/// Macro from Lummox used to get height from a MeasureText proc.
/// resolves the MeasureText() return value once, then resolves the height, then sets return_var to that.
#define WXH_TO_HEIGHT(measurement, return_var) \
	do { \
		var/_measurement = measurement; \
		return_var = text2num(copytext(_measurement, findtextEx(_measurement, "x") + 1)); \
	} while(FALSE);

/// Folder directory for strings
#define STRING_DIRECTORY "strings"

// JSON text files found in the /strings folder
/// File location for eigenstasium lines
#define EIGENSTASIUM_FILE "eigenstasium.json"

/// Max fields for sheets of paper
#define MAX_PAPER_FIELDS 50
