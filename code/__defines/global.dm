// Database connections. A connection is established along with /hook/startup/proc/load_databases().
// Ideally, the connection dies when the server restarts (After feedback logging.).
GLOBAL_DATUM(dbcon, /DBConnection)
GLOBAL_PROTECT(dbcon)
