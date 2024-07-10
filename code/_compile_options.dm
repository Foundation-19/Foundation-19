#define BACKGROUND_ENABLED 0    // The default value for all uses of set background. Set background can cause gradual lag and is recommended you only turn this on if necessary.
								// 1 will enable set background. 0 will disable set background.

#ifdef TGS
// TGS performs its own build of dm.exe, but includes a prepended TGS define.
#define CBT
#endif

#if !defined(CBT) && !defined(SPACEMAN_DMM)
#warn Building with Dream Maker is no longer supported and will result in errors.
#warn In order to build, run BUILD.bat in the root directory.
#warn Consider switching to VSCode editor instead, where you can press Ctrl+Shift+B to build.
#endif

// If this is uncommented, will attempt to load and initialize prof.dll/libprof.so.
// We do not ship byond-tracy. Build it yourself here: https://github.com/mafemergency/byond-tracy/
//#define USE_BYOND_TRACY

///Used to find the sources of harddels, quite laggy, don't be surpised if it freezes your client for a good while
//#define REFERENCE_TRACKING
#ifdef REFERENCE_TRACKING

///Should we be logging our findings or not
#define REFERENCE_TRACKING_LOG

///Used for doing dry runs of the reference finder, to test for feature completeness
//#define REFERENCE_TRACKING_DEBUG

///Run a lookup on things hard deleting by default.
//#define GC_FAILURE_HARD_LOOKUP
#ifdef GC_FAILURE_HARD_LOOKUP
#define FIND_REF_NO_CHECK_TICK
#endif //ifdef GC_FAILURE_HARD_LOOKUP
#endif //ifdef REFERENCE_TRACKING

/// If this is uncommented, we set up the ref tracker to be used in a live environment
/// And to log events to [log_dir]/harddels.log
//#define REFERENCE_DOING_IT_LIVE
#ifdef REFERENCE_DOING_IT_LIVE
// compile the backend
#define REFERENCE_TRACKING
// actually look for refs
#define GC_FAILURE_HARD_LOOKUP
// Log references in their own file
#define REFERENCE_TRACKING_LOG_APART
#endif // REFERENCE_DOING_IT_LIVE

/// Sets up the reftracker to be used locally, to hunt for hard deletions
/// Errors are logged to [log_dir]/harddels.log
//#define REFERENCE_TRACKING_STANDARD
#ifdef REFERENCE_TRACKING_STANDARD
// compile the backend
#define REFERENCE_TRACKING
// actually look for refs
#define GC_FAILURE_HARD_LOOKUP
// spend ALL our time searching, not just part of it
#define FIND_REF_NO_CHECK_TICK
// Log references in their own file
#define REFERENCE_TRACKING_LOG_APART
#endif // REFERENCE_TRACKING_STANDARD
