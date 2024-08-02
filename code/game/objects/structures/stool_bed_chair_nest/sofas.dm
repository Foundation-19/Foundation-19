#define COLORED_SOFA(path, color_name, sofa_color) \
path/middle/color_name {\
	color = sofa_color; \
} \
path/right/color_name {\
	color = sofa_color; \
} \
path/left/color_name {\
	color = sofa_color; \
} \
path/corner/color_name {\
	color = sofa_color; \
}

/obj/structure/chair/sofa
	name = "old ratty sofa"
	icon_state = "error"
	icon = 'icons/obj/chairs_wide.dmi'

/obj/structure/chair/sofa/middle
	icon_state = "sofamiddle"

/obj/structure/chair/sofa/left
	icon_state = "sofaend_left"

/obj/structure/chair/sofa/right
	icon_state = "sofaend_right"

/obj/structure/chair/sofa/corner
	icon_state = "sofacorner"

// Original icon ported from Eris(?) and updated to work here.
/obj/structure/chair/sofa/corp
	name = "sofa"
	desc = "Soft and cushy."
	icon_state = "corp_sofamiddle"

/obj/structure/chair/sofa/corp/left
	icon_state = "corp_sofaend_left"

/obj/structure/chair/sofa/corp/right
	icon_state = "corp_sofaend_right"

/obj/structure/chair/sofa/corp/corner
	icon_state = "corp_sofacorner"
