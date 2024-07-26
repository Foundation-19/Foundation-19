// Define the SCP-458 object
/obj/item/pizzabox/scp458
    name = "The Never-Ending Pizza Box"
    desc = "A seemingly ordinary pizza box that is anomalously capable of producing an infinite amount of pizza."
    icon = 'icons/SCP/scp_items.dmi'  // Assuming the icon file exists
    icon_state = "pizzabox"

    // Variables to track interactions
    var/cooldown = 0  // Cooldown to prevent spamming
    var/cooldown_duration = 30 SECONDS

// Initialize SCP-458
/obj/item/pizzabox/scp458/Initialize()
    . = ..()
    START_PROCESSING(SSobj, src)

// Process method to handle cooldown
/obj/item/pizzabox/scp458/Process()
    if(cooldown > 0)
        cooldown -= 2 SECONDS
    if(cooldown < 0)
        cooldown = 0

// Interaction with SCP-458
/obj/item/pizzabox/scp458/attack_hand(mob/user as mob )
    if(cooldown > 0)
        to_chat(user, "<span class='warning'>The pizza box is still refilling.</span>")
        return

    // Generate a pizza slice
    var/obj/item/reagent_containers/food/snacks/slice = new /obj/item/reagent_containers/food/snacks/slice/margherita
    if(slice)
        user.put_in_hands(slice)
        to_chat(user, "<span class='notice'>You take a slice of pizza from [src]. It's delicious and exactly what you wanted!</span>")
        cooldown = cooldown_duration
    else
        to_chat(user, "<span class='warning'>Something went wrong. No pizza for you.</span>")

// Description when examined
/obj/item/pizzabox/scp458/examine(mob/user)
    . = ..()
    . += "<span class='info'>It seems to be an ordinary pizza box, but you can feel a faint warmth coming from inside, as if it's ready to serve pizza.</span>"
    if(cooldown > 0)
        . += "<span class='notice'>It looks like it's refilling. Please wait.</span>"
    else
        . += "<span class='notice'>It seems ready to dispense another pizza slice.</span>"

