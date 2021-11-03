SUBSYSTEM_DEF(setup)
	name = "Setup"
	init_order = SS_INIT_SETUP
	priority = SS_PRIORITY_SETUP
	flags = SS_NO_FIRE

	var/controller_iteration = 0
	var/last_tick_duration = 0

	var/air_processing_killed = 0
	var/pipe_processing_killed = 0

/datum/controller/subsystem/setup/Initialize()

	if(!job_master)
		job_master = new /datum/controller/occupations()
		job_master.SetupOccupations(setup_titles=1)
		job_master.LoadJobs("config/jobs.txt")
		admin_notice("<span class='danger'>Job setup complete</span>", R_DEBUG)

	if(!syndicate_code_phrase)		syndicate_code_phrase	= generate_code_phrase()
	if(!syndicate_code_response)	syndicate_code_response	= generate_code_phrase()

	spawn(20)
		createRandomZlevel()

	setup_objects()
	setupgenetics()
	setupSCPs()

	transfer_controller = new

	return ..()

/datum/controller/subsystem/setup/proc/setup_objects()
	if(GLOB.using_map.use_overmap)
		report_progress("Initializing overmap events")
		overmap_event_handler.create_events(GLOB.using_map.overmap_z, GLOB.using_map.overmap_size, GLOB.using_map.overmap_event_areas)

	report_progress("Initializing lathe recipes")
	populate_lathe_recipes()

/////////////////////////
// (mostly) DNA2 SETUP
/////////////////////////

// Randomize block, assign a reference name, and optionally define difficulty (by making activation zone smaller or bigger)
// The name is used on /vg/ for species with predefined genetic traits,
//  and for the DNA panel in the player panel.
/datum/controller/subsystem/setup/proc/getAssignedBlock(var/name,var/list/blocksLeft, var/activity_bounds=DNA_DEFAULT_BOUNDS)
	if(blocksLeft.len==0)
		warning("[name]: No more blocks left to assign!")
		return 0
	var/assigned = pick(blocksLeft)
	blocksLeft.Remove(assigned)
	assigned_blocks[assigned]=name
	dna_activity_bounds[assigned]=activity_bounds
	//testing("[name] assigned to block #[assigned].")
	return assigned

/datum/controller/subsystem/setup/proc/setupgenetics()

	if (prob(50))
		// Currently unused.  Will revisit. - N3X
		GLOB.BLOCKADD = rand(-300,300)
	if (prob(75))
		GLOB.DIFFMUT = rand(0,20)

	var/list/numsToAssign=new()
	for(var/i=1;i<DNA_SE_LENGTH;i++)
		numsToAssign += i

	//testing("Assigning DNA blocks:")

	// Standard muts, imported from older code above.
	GLOB.BLINDBLOCK         = getAssignedBlock("BLIND",         numsToAssign)
	GLOB.DEAFBLOCK          = getAssignedBlock("DEAF",          numsToAssign)
	GLOB.HULKBLOCK          = getAssignedBlock("HULK",          numsToAssign, DNA_HARD_BOUNDS)
	GLOB.TELEBLOCK          = getAssignedBlock("TELE",          numsToAssign, DNA_HARD_BOUNDS)
	GLOB.FIREBLOCK          = getAssignedBlock("FIRE",          numsToAssign, DNA_HARDER_BOUNDS)
	GLOB.XRAYBLOCK          = getAssignedBlock("XRAY",          numsToAssign, DNA_HARDER_BOUNDS)
	GLOB.CLUMSYBLOCK        = getAssignedBlock("CLUMSY",        numsToAssign)
	GLOB.FAKEBLOCK          = getAssignedBlock("FAKE",          numsToAssign)

	// UNUSED!
	//GLOB.COUGHBLOCK         = getAssignedBlock("COUGH",         numsToAssign)
	//GLOB.GLASSESBLOCK       = getAssignedBlock("GLASSES",       numsToAssign)
	//GLOB.EPILEPSYBLOCK      = getAssignedBlock("EPILEPSY",      numsToAssign)
	//GLOB.TWITCHBLOCK        = getAssignedBlock("TWITCH",        numsToAssign)
	//GLOB.NERVOUSBLOCK       = getAssignedBlock("NERVOUS",       numsToAssign)

	// Bay muts (UNUSED)
	//GLOB.HEADACHEBLOCK      = getAssignedBlock("HEADACHE",      numsToAssign)
	//GLOB.NOBREATHBLOCK      = getAssignedBlock("NOBREATH",      numsToAssign, DNA_HARD_BOUNDS)
	//GLOB.REMOTEVIEWBLOCK    = getAssignedBlock("REMOTEVIEW",    numsToAssign, DNA_HARDER_BOUNDS)
	//GLOB.REGENERATEBLOCK    = getAssignedBlock("REGENERATE",    numsToAssign, DNA_HARDER_BOUNDS)
	//GLOB.INCREASERUNBLOCK   = getAssignedBlock("INCREASERUN",   numsToAssign, DNA_HARDER_BOUNDS)
	GLOB.REMOTETALKBLOCK    = getAssignedBlock("REMOTETALK",    numsToAssign, DNA_HARDER_BOUNDS)
	//GLOB.MORPHBLOCK         = getAssignedBlock("MORPH",         numsToAssign, DNA_HARDER_BOUNDS)
	//GLOB.COLDBLOCK          = getAssignedBlock("COLD",          numsToAssign)
	//GLOB.HALLUCINATIONBLOCK = getAssignedBlock("HALLUCINATION", numsToAssign)
	//GLOB.NOPRINTSBLOCK      = getAssignedBlock("NOPRINTS",      numsToAssign, DNA_HARD_BOUNDS)
	//GLOB.SHOCKIMMUNITYBLOCK = getAssignedBlock("SHOCKIMMUNITY", numsToAssign)
	//GLOB.SMALLSIZEBLOCK     = getAssignedBlock("SMALLSIZE",     numsToAssign, DNA_HARD_BOUNDS)

	//
	// Static Blocks
	/////////////////////////////////////////////.

	// Monkeyblock is always last.
	GLOB.MONKEYBLOCK = DNA_SE_LENGTH

	// And the genes that actually do the work. (domutcheck improvements)
	var/list/blocks_assigned[DNA_SE_LENGTH]
	for(var/gene_type in typesof(/datum/dna/gene))
		var/datum/dna/gene/G = new gene_type
		if(G.block)
			if(G.block in blocks_assigned)
				warning("DNA2: Gene [G.name] trying to use already-assigned block [G.block] (used by [english_list(blocks_assigned[G.block])])")
			dna_genes.Add(G)
			var/list/assignedToBlock[0]
			if(blocks_assigned[G.block])
				assignedToBlock=blocks_assigned[G.block]
			assignedToBlock.Add(G.name)
			blocks_assigned[G.block]=assignedToBlock

/datum/controller/subsystem/setup/proc/setupSCPs()
	var/list/SCPs = subtypesof(/datum/scp)
	for(var/i in 1 to SCPs.len)
		var/path = SCPs[i]   //They don't like it if you put it in one line
		var/datum/scp/SCP = new path()
		GLOB.SCP_list += list(SCP.designation = subtypesof(SCP))
/*	for(var/i in 1 to GLOB.SCP_list.len)
		world << "<span class='notice'><b>&#91;DEBUG&#93;</b>SCP-[GLOB.SCP_list[i]] sucesfully initialized as [GLOB.SCP_list[GLOB.SCP_list[i]]].</span>"
*/
