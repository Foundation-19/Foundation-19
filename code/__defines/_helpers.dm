// Stuff that is relatively "core" and is used in other defines/helpers

/// Stringifies whatever you put into it.
#define STRINGIFY(argument) #argument

/// Until a condition is true, sleep
#define UNTIL(X) while(!(X)) stoplag()

/// Sleep if we haven't been deleted
/// Otherwise, return
#define SLEEP_NOT_DEL(time) \
	if(QDELETED(src)) { \
		return; \
	} \
	sleep(time);
