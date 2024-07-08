// Database connections. A connection is established along with /hook/startup/proc/load_databases().
// Ideally, the connection dies when the server restarts (After feedback logging.).
GLOBAL_DATUM(dbcon, /DBConnection)
GLOBAL_PROTECT(dbcon)

// Added for Xenoarchaeology, might be useful for other stuff.
GLOBAL_LIST_INIT(alphabet_uppercase, list("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"))
