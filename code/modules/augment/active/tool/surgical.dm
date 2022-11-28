/obj/item/organ/internal/augment/active/polytool/surgical
	name = "surgical toolset"
	action_button_name = "Deploy Surgical Tool"
	desc = "Part of The Foundation's line of advanced bionic augmentations, this device contains a basic set of tools."
	icon_state = "multitool_medical"
	paths = list(
		/obj/item/bonesetter,
		/obj/item/cautery,
		/obj/item/circular_saw,
		/obj/item/hemostat,
		/obj/item/retractor,
		/obj/item/scalpel,
		/obj/item/surgicaldrill
	)
	
//toolset tools are dropped when left on the floor, these come from Eipharius IS12
	
/obj/item/bonesetter/toolset
/obj/item/bonesetter/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
		
/obj/item/cautery/toolset
/obj/item/cautery/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
/obj/item/circular_saw/toolset
/obj/item/circular_saw/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
/obj/item/hemostat/toolset
/obj/item/hemostat/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
/obj/item/retractor/toolset
/obj/item/retractor/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
/obj/item/scalpel/toolset
/obj/item/scalpel/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)		
		
/obj/item/surgicaldrill/toolset
/obj/item/surgicaldrill/toolset/dropped() //since nodrop is fucked this will deal with it for now.
	..()
	spawn(1) if(src) qdel(src)
