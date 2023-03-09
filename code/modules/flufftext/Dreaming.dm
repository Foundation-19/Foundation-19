
var/list/dreams = list(
	"an ID card","a strange smiling white mask","the devil","a researcher","a grim fate","a bizzare object","a man set ablaze","a gunfight","the gods","the spirits","a doctor with an red stoned amulet","the foundation", "a happy family", "a P90 closed bolt automatic rifle", "a Dying Friend", "Germany", "Cheese", "a Camera", "many red eyes in the dark", "hell", "a holiday", "a mother", "a bottle", "a forsaken child", "the seven offspring", "a cultist", "a man without a face", "The Middle East", "Texas", "a lonesome road", "Paris", "Dresden", "the catacombs", "Tokyo city",
	"the Harak","a pile of flesh","a long hallway","a dark and infinite stairway","a rotting elderly man approaching","filth","a pale man crying","a bananna","a monkey","the Global Occult Coalition","the world wars", "an angry boss", "a broken limb", "a holstered M1911", "a Dead Friend", "a ruined facility", "a darting light in the middle of the night", "heaven", "the afterlife", "a father", "a senator", "an acid pool", "a black substance on the floor", "a little girl with mismatched eyes", "a vacant building", "the backrooms", "Berlin", "Munich", "New York", "the government",
	"the disease", "a dead man walking", "god himself", "a strange statue wanting a hug", "a security guard", "a joyful angry lizard", "a man in arizona", "the flesh that hates", "termination", "the end of the world", "the ocean", "a useless doctor", "an uncooperative prisoner", "the president", "a needle", "a glowing entity with a blazing blade", "a woman", "an outbreak", "a riot", "voices from the dark", "an odd looking person", "a rainy day", "a jade ring", "a broken hand", "a warm numbness", "a forest of eyes", "a stalker", "Germany", "Austria", "London", "a video game",
	"Site 19", "a plague doctor", "the sickness", "a teddy bear", "a lost friend", "a mutilated Ronald Reagan speaking", "a pill bottle", "the 05 Council", "Hatred", "a sunrise","a sunset", "a corruptive ray of sunlight", "a cup of coffee", "a great outfit", "a friendly D-Class Personnel", "a hallway full of corpses", "a blade", "a loved one", "a hat", "a distant horizon", "a crimson red liquid", "a cigarette", "a brother", "an entity behind a windowed door", "Japan", "the himalayas", "a soviet gas mask", "a good song", "a porcelain doll", "a fat aristocrat", "a cannibal",
	"D-Class Personnel", "a nurse", "The United Nations", "home", "a peaceful meadow", "a haunting forest", "an angry man", "a dead D-Class", "an imposter", "a Nobody", "a Friend", "a Stranger", "an enemy", "the gas prices", "a cat without an back half", "the moon", "the sun", "a strange floating object", "an engineer", "the janitor", "a firearm", "England", "an orange blob", "a demon", "a seven winged creature", "a red haired man in a tophat and red suit trying to sell you a product", "an artifical person", "a mass of flesh with eyes", "France", "Burgundy", "UnLondon",
)


/mob/living/carbon/proc/dream()
	dreaming = 1

	spawn(0)
		for(var/i = rand(1,4),i > 0, i--)
			to_chat(src, SPAN_NOTICE("<i>... [pick(dreams)] ...</i>"))
			sleep(rand(40,70))
			if(paralysis <= 0)
				dreaming = 0
				return 0
		dreaming = 0
		return 1

/mob/living/carbon/proc/handle_dreams()
	if(client && !dreaming && prob(5))
		dream()

/mob/living/carbon/var/dreaming = 0
