/decl/emote/audible
	key = "burp"
	emote_message_3p = "burps."
	message_type = AUDIBLE_MESSAGE

/decl/emote/audible/deathgasp_alien
	key = "deathgasp"
	emote_message_3p = "lets out a waning guttural screech, green blood bubbling from its maw."

/decl/emote/audible/whimper
	key = "whimper"
	emote_message_3p = "whimpers."

/decl/emote/audible/gasp
	key = "gasp"
	emote_message_3p = "gasps."
	conscious = 0

/decl/emote/audible/scretch
	key = "scretch"
	emote_message_3p = "scretches."

/decl/emote/audible/choke
	key = "choke"
	emote_message_3p = "chokes."
	conscious = 0

/decl/emote/audible/gnarl
	key = "gnarl"
	emote_message_3p = "gnarls and shows its teeth.."

/decl/emote/audible/chirp
	key = "chirp"
	emote_message_3p = "chirps!"
	emote_sound = /misc/nymphchirp.ogg'

/decl/emote/audible/multichirp
	key = "mchirp"
	emote_message_3p = "chirps a chorus of notes!"
	emote_sound = /misc/multichirp.ogg'

/decl/emote/audible/alarm
	key = "alarm"
	emote_message_1p = "You sound an alarm."
	emote_message_3p = "sounds an alarm."

/decl/emote/audible/alert
	key = "alert"
	emote_message_1p = "You let out a distressed noise."
	emote_message_3p = "lets out a distressed noise."

/decl/emote/audible/notice
	key = "notice"
	emote_message_1p = "You play a loud tone."
	emote_message_3p = "plays a loud tone."

/decl/emote/audible/whistle
	key = "whistle"
	emote_message_1p = "You whistle."
	emote_message_3p = "whistles."

/decl/emote/audible/boop
	key = "boop"
	emote_message_1p = "You boop."
	emote_message_3p = "boops."

/decl/emote/audible/sneeze
	key = "sneeze"
	emote_message_3p = "sneezes."

/decl/emote/audible/sniff
	key = "sniff"
	emote_message_3p = "sniffs."

/decl/emote/audible/snore
	key = "snore"
	emote_message_3p = "snores."
	conscious = 0

/decl/emote/audible/whimper
	key = "whimper"
	emote_message_3p = "whimpers."

/decl/emote/audible/yawn
	key = "yawn"
	emote_message_3p = "yawns."

/decl/emote/audible/clap
	key = "clap"
	emote_message_3p = "claps."
	emote_sound = list(
		/misc/clap1.ogg',
		/misc/clap2.ogg',
		/misc/clap3.ogg',
		/misc/clap4.ogg'
	)

/decl/emote/audible/chuckle
	key = "chuckle"
	emote_message_3p = "chuckles."

/decl/emote/audible/cough
	key = "cough"
	emote_message_3p = "coughs!"
	conscious = 0

/decl/emote/audible/cry
	key = "cry"
	emote_message_3p = "cries."

/decl/emote/audible/sigh
	key = "sigh"
	emote_message_3p = "sighs."

/decl/emote/audible/laugh
	key = "laugh"
	emote_message_3p_target = "laughs at TARGET."
	emote_message_3p = "laughs."
	emote_sound = list(
		FEMALE = list(/voice/human/womanlaugh.ogg'),
		MALE = list(/voice/human/manlaugh1.ogg',s/voice/human/manlaugh2.ogg')
	)

/decl/emote/audible/laugh/do_sound(atom/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.species.name != SPECIES_HUMAN) // TODO: Add species-specific laugh sounds
		return
	return ..()

/decl/emote/audible/mumble
	key = "mumble"
	emote_message_3p = "mumbles!"

/decl/emote/audible/grumble
	key = "grumble"
	emote_message_3p = "grumbles!"

/decl/emote/audible/groan
	key = "groan"
	emote_message_3p = "groans!"
	conscious = 0

/decl/emote/audible/moan
	key = "moan"
	emote_message_3p = "moans!"
	conscious = 0

/decl/emote/audible/giggle
	key = "giggle"
	emote_message_3p = "giggles."

/decl/emote/audible/scream
	key = "scream"
	emote_message_3p = "screams!"

/decl/emote/audible/grunt
	key = "grunt"
	emote_message_3p = "grunts."

/decl/emote/audible/slap
	key = "slap"
	emote_message_1p_target = "You slap TARGET across the face!"
	emote_message_1p = "You slap yourself across the face!"
	emote_message_3p_target = "slaps TARGET across the face!"
	emote_message_3p = "slaps USER_SELF across the face!"
	emote_sound = /effects/snap.ogg'
	check_restraints = TRUE
	check_range = 1

/decl/emote/audible/bug_hiss
	key = "hiss"
	emote_message_3p_target = "hisses at TARGET."
	emote_message_3p = "hisses."
	emote_sound = /voice/BugHiss.ogg'

/decl/emote/audible/bug_buzz
	key = "buzz"
	emote_message_3p = "buzzes its wings."
	emote_sound = /voice/BugBuzz.ogg'

/decl/emote/audible/bug_chitter
	key = "chitter"
	emote_message_3p = "chitters."
	emote_sound = /voice/Bug.ogg'

/decl/emote/audible/roar
	key = "roar"
	emote_message_3p = "roars!"

/decl/emote/audible/bellow
	key = "bellow"
	emote_message_3p = "bellows!"

/decl/emote/audible/howl
	key = "howl"
	emote_message_3p = "howls!"

/decl/emote/audible/wheeze
	key = "wheeze"
	emote_message_3p = "wheezes."

/decl/emote/audible/hiss
	key = "hiss_"
	emote_message_3p_target = "hisses softly at TARGET."
	emote_message_3p = "hisses softly."

/decl/emote/audible/lizard_bellow
	key = "bellow"
	emote_message_3p_target = "bellows deeply at TARGET!"
	emote_message_3p = "bellows!"
	emote_sound = /voice/LizardBellow.ogg'

/decl/emote/audible/lizard_squeal
	key = "squeal"
	emote_message_3p = "squeals."
	emote_sound = /voice/LizardSqueal.ogg'
