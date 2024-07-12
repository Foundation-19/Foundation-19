// SCP-1025: The Encyclopedia of Diseases
/obj/item/book/scp1025
    name = "SCP-1025"
    desc = "A large encyclopedia that contains detailed information about various diseases."

/obj/item/book/scp1025/attack_self(mob/user)
    user.set_infected(random_disease())
    to_chat(user, "<span class='notice'>As you read SCP-1025, you feel unwell...</span>")

/proc/random_disease()
    var/diseases = list("Common Cold", "Flu", "Chickenpox", "Measles", "Malaria", "Tuberculosis")
    return pick(diseases)
