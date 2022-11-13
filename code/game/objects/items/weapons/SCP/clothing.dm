/obj/item/clothing/under/scp/donor
	name = "grey uniform"
	desc = "A grey uniform."
	icon_state = "donor_sec"

/obj/item/clothing/under/scp/donor2
	name = "blue uniform"
	desc = "A blue engineer's uniform."
	icon_state = "donor_eng"

/obj/item/clothing/under/scp/donor3
	name = "green uniform"
	desc = "A green uniform."
	icon_state = "donate_sec"

/obj/item/clothing/under/scp/greyuniform
	name = "grey uniform"
	desc = "A dull grey uniform."
	icon_state = "grey"

/obj/item/clothing/under/scp/suittie
	name = "suit and tie"
	desc = "A rather sterile looking suit and tie."
	icon_state = "suit"
	worn_state = "suit_s"
	accessories = list(/obj/item/clothing/accessory/red)

/obj/item/clothing/under/scp/dclass
	name = "D-Class uniform"
	desc = "A bright orange jumpsuit, indicative of Class D personnel."
	icon_state = "d"

/obj/item/clothing/under/scp/chaos
	name = "tactical sweatshirt"
	desc = "A white tactical shirt for tactical operations."
	icon_state = "tac"
	has_sensor = 0
	item_flags = ITEM_FLAG_THICKMATERIAL
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 0, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.9

/obj/item/clothing/under/scp/alpha
	name = "Alpha-1 uniform"
	desc = "A modified uniform made specificly for the MTF unit 'Red Right Handp'."
	icon_state = "alpha-uniform"
	armor = list(melee = 30, bullet = 30, laser = 10, energy = 0, bomb = 5, bio = 0, rad = 0)
	siemens_coefficient = 0.9
	item_flags = ITEM_FLAG_THICKMATERIAL
