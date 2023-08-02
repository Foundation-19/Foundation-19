/obj/structure/sign/double/barsign/scp_078
	name = "Strange Barsign"

/obj/structure/sign/double/barsign/scp078/set_sign(datum/barsign/sign)
	sign = /datum/barsign/scp078
	return ..()

/obj/structure/sign/double/barsign/scp078/Initialize()
	. = ..()
	SCP = new /datum/scp(
		src, // Ref to actual SCP atom
		"Strange Barsign", //Name (Should not be the scp desg, more like what it can be described as to viewers)
		EUCLID, //Obj Class
		"078", //Numerical Designation
		SCP_PLACEHOLDER
	)
