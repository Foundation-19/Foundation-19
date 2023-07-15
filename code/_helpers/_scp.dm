// SCP Helpers

/// Trims out the "SCP-" from scp names
proc/trimSCP(text)
    var/prefixLoc = dd_hasprefix(text, "SCP-")
    if(prefixLoc)
        return copytext(text,prefixLoc)
    return "0000"
