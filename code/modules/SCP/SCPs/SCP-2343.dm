/mob/living/carbon/human/scp343/scp2343
	name = "strange american man"
	desc = "A brusk and wiley man of american decent."
	icon = 'icons/SCP/scp_2343.dmi'
	icon_state = "americangod"
	status_flags = NO_ANTAG

	roundstart_traits = list(TRAIT_ADVANCED_TOOL_USER)

	var/charm_cooldown = 300 // Cooldown for charm ability in seconds
	var/last_charm_use = 0 // Timestamp of last charm use

/mob/living/carbon/human/scp343/scp2343/Initialize(mapload, new_species = "SCP-2343")
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"strange american man", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		SCP_SAFE, //Obj Class
		"2343", //Numerical Designation
		SCP_PLAYABLE|SCP_ROLEPLAY
	)

// Ability to charm nearby players, making them temporarily unable to act against SCP-2343
/mob/living/carbon/human/scp343/scp2343/proc/charm()
    if(world.time < last_charm_use + charm_cooldown * 10)
        to_chat(src, "<span class='warning'>You need to wait before you can use this ability again.</span>")
        return

    last_charm_use = world.time
    var/list/nearby_players = view(5, src) // Affects players within 5 tiles
    for(var/mob/living/carbon/human/H in nearby_players)
        if(H == src) continue
        to_chat(H, "<span class='notice'>You feel an overwhelming charm from [src], making you hesitate to act against them.</span>")
        H.Stun(5) // Stuns the player for 5 seconds

    to_chat(src, "<span class='notice'>You use your charm to pacify nearby individuals.</span>")

// Enhanced interaction: SCP-2343 can manipulate objects in unique ways
/mob/living/carbon/human/scp343/scp2343/verb/manipulate_object(obj/O in oview(1))
    set category = "Abilities"
    set name = "Manipulate Object"
    set desc = "Manipulate an object in a peculiar way."

    if(!O)
        to_chat(src, "<span class='warning'>There is nothing nearby to manipulate.</span>")
        return

    if(istype(O, /obj/machinery/door))
        var/obj/machinery/door/D = O
        D.operating = !D.operating
        to_chat(src, "<span class='notice'>You [D.operating ? "lock" : "unlock"] the door.</span>")
