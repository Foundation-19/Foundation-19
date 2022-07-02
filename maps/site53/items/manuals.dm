/obj/item/book/manual/solgov_law
	name = "Sol Central Government Law"
	desc = "A brief overview of SolGov Law."
	icon_state = "bookSolGovLaw"
	author = "The Sol Central Government"
	title = "Sol Central Government Law"

/obj/item/book/manual/solgov_law/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="[config.wikiurl]Sol_Central_Government_Law&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}


/obj/item/book/manual/military_law
	name = "The Sol Code of Military Justice"
	desc = "A brief overview of military law."
	icon_state = "bookSolGovLaw"
	author = "The Sol Central Government"
	title = "The Sol Code of Military Justice"

/obj/item/book/manual/military_law/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="[config.wikiurl]Sol_Gov_Military_Justice&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/scp/fra
	name = "Foundation Regulations"
	desc = "A book that has a comprehensive list of Foundation Regulations."
	icon_state = "book1"
	author = "The Internal Security Department"
	title = "Foundation Regulations"

/obj/item/book/manual/scp/fra/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Foundation_Regulations&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/scp/secsop
	name = "Standard Operating Procedure - Security Department"
	desc = "THE book that tells you not to be shit at your job."
	icon_state = "book2"
	author = "The Internal Security Department"
	title = "Security SoP"

/obj/item/book/manual/scp/secsop/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Security_SOP&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/scp/scisop
	name = "Standard Operating Procedure - Science Department"
	desc = "THE book that tells you not to be shit at your job."
	icon_state = "book6"
	author = "The Administrative Department"
	title = "Science SoP"

/obj/item/book/manual/scp/scisop/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Research_SOP&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/scp/medsop
	name = "Standard Operating Procedure - Medical Department"
	desc = "THE book that tells you not to be shit at your job."
	icon_state = "book4"
	author = "The Administrative Department"
	title = "Medical SoP"

/obj/item/book/manual/scp/medsop/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Medical_SOP&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/scp/engsop
	name = "Standard Operating Procedure - Engineering Department"
	desc = "THE book that tells you not to be shit at your job."
	icon_state = "book3"
	author = "The Administrative Department"
	title = "Engineering SoP"

/obj/item/book/manual/scp/engsop/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Engineering_SOP&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/book/manual/mil_sop
	name = "Military Operating Procedure"
	desc = "SOP in Site DS90."
	icon_state = "booksolregs"
	author = "The Foundation"
	title = "Standard Operating Procedure"

/obj/item/book/manual/mil_sop/Initialize()
	. = ..()
	dat = {"

		<html><head>
		</head>

		<body>
		<iframe width='100%' height='97%' src="http://wiki.scp13.site/index.php?title=Security/Military&printable=yes&remove_links=1" frameborder="0" id="main_frame"></iframe>
		</body>

		</html>

		"}

/obj/item/folder/nt/rd

/obj/item/folder/envelope/blanks
	desc = "A thick envelope. The Nanotrasen logo is stamped in the corner, along with 'CONFIDENTIAL'."

/obj/item/folder/envelope/blanks/Initialize()
	. = ..()
	new/obj/item/paper/blanks(src)

/obj/item/paper/blanks
	name = "RE: Regarding testing supplies"
	info = {"
	<tt><center><b><font color='red'>CONFIDENTIAL: UPPER MANAGEMENT ONLY</font></b>
	<h3>NANOTRASEN RESEARCH DIVISION</h3>
	<img src = ntlogo.png>
	</center>
	<b>FROM:</b> Hieronimus Blackstone, Overseer of Torch Cooperation Project<br>
	<b>TO:</b> Research Director of SEV Torch branch<br>
	<b>CC:</b> Liason with SCG services aboard SEV Torch<br>
	<b>SUBJECT:</b> RE: Testing Materials<br>
	<hr>
	We have reviewed your request, and would like to make an addition to the list of needed materials.<br>
	As we hold very high hopes for this branch, it would be only right to provide our scientists with the most accurate testing environment. And by that we mean the living human subjects. Our Ethics Review Board suggested a workaround for that pesky 'consent' requierment.<br>
	In the Research Wing you should find a small section labeled 'Aux Custodial Supplies'. Inside we have provided several mind-blank vatgrown clones. Our Law Special Response Team so far had not found SCG legislation that explicitly forbids their use in research.<br>
	They come in self-contained life support bags, with additional measures to make them easier to use for, let's say, more sensitive personnel. As our preliminary study showed, 75% more subjects were more willing to harm a (consenting) intern if their face was fully hidden.<br>
	We are expecting great results from this program. Do not disappoint us.<br>
	<i>H.B.</i></tt>
	"}

/obj/item/folder/envelope/captain
	desc = "A thick envelope. The SCG crest is stamped in the corner, along with 'TOP SECRET - TORCH UMBRA'."

/obj/item/folder/envelope/captain/Initialize()
	. = ..()
/*	var/obj/effect/overmap/torch = map_sectors["[z]"]
	var/memo = {"
	<tt><center><b><font color='red'>SECRET - CODE WORDS: TORCH</font></b>
	<h3>SOL CENTRAL GOVERNMENT EXPEDITIONARY COMMAND</h3>
	<img src = sollogo.png>
	</center>
	<b>FROM:</b> ADM William Lau<br>
	<b>TO:</b> Commanding Officer of SEV Torch<br>
	<b>SUBJECT:</b> Standing Orders<br>
	<hr>
	Captain.<br>
	Your orders are to visit the following star systems. Keep in mind that your supplies are limited; ration exploration time accordingly.
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<li>[GLOB.using_map.system_name]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<li>[generate_system_name()]</li>
	<br>
	Priority targets are artifacts of uncontacted alien species and signal sources of unknown origin.<br>
	None of these systems are claimed by any entity recognized by the SCG, so you have full salvage rights on any derelicts discovered.<br>
	Investigate and mark any prospective colony worlds as per usual procedures.<br>
	There is no SCG presence in that area. In case of distress calls, you will be the only vessel available; do not ignore them. We cannot afford any more PR backlash.<br>
	The current docking code is: [torch.docking_codes]<br>
	Report all findings via bluespace comm buoys during inter-system jumps.<br>

	<i>ADM Lau.</i></tt>
	<i>This paper has been stamped with the stamp of SCG Expeditionary Command.</i>
	"}*/
//	new/obj/item/paper(src, memo, "Standing Orders")

	new/obj/item/paper/umbra(src)

/obj/item/folder/envelope/rep
	desc = "A thick envelope. The SCG crest is stamped in the corner, along with 'TOP SECRET - UMBRA'."

/obj/item/folder/envelope/rep/Initialize()
	. = ..()
	new/obj/item/paper/umbra(src)

/obj/item/paper/umbra
	name = "UMBRA Protocol"
	info = {"
	<tt><center><b><font color='red'>TOP SECRET - CODE WORDS: TORCH UMBRA</font></b>
	<h3>OFFICE OF THE SECRETARY GENERAL OF SOL CENTRAL GOVERNMENT</h3>
	<img src = sollogo.png>
	</center>
	<b>FROM:</b> Johnathan Smitherson, Special Aide of the Secretary General<br>
	<b>TO:</b> Commanding Officer of the SEV Torch<br>
	<b>CC:</b> Special Representative aboard the SEV Torch<br>
	<b>SUBJECT:</b> UMBRA protocol<br>
	<hr>
	This is a small addendum to the usual operating procedures. Unlike the rest of SOP, this is not left to the Commanding Officer's discretion and is mandatory. As unconventional as this is, we felt it is essential for smooth operation of this mission.<br>
	Procedure can be initiated only by transmission from SCG Expeditionary Command via secure channel. The sender may not introduce themselves, but you shouldn't have trouble confirming the transmission source, I believe.<br>
	The signal to initiate the procedure are codewords 'GOOD NIGHT WORLD' used in this order as one phrase. You do not need to send acknowledgement.
	<li>Information about this expedition's findings is to be treated as secret and vital to SCG's national security, and is protected under codeword UMBRA. Only SCG government employees, NT personnel and Skrell citizens aboard the SEV Torch are allowed access to this information on a need-to-know basis.</li>
	<li>The secrecy of this information is to be applied retroactively. Any non-cleared personnel who were exposed to such information are to be secured and transferred to DIA on arrival at home port.</li>
	<li>Any devices capable of transmitting data on interstellar range are to be confiscated from private possession.</li>
	<li>Disregard any systems remaining in your flight plan and set course for Sol, Neptune orbit. You will be contacted upon your arrival. Do not make stops in ports on the way unless absolutely necessary.</li>
	<br>
	While drastic, I assure you this is a simple precaution, lest any issues. Just keep the option open, and carry on with your normal duties.
	<i>Regards, John.</i></tt>
	<i>This paper has been stamped with the stamp of Office of the General Secretary of SCG.</i>
	"}

/////////////
//SCP BOOKS//
/////////////

// SAFE

/obj/item/paper/scp/safe/scp013
	name = "SCP-013"
	info = {"
	<tt><center><b><font color='green'>SAFE: SCP-013</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<br>
<b>Item #:</b> SCP-013<br>

<b>Object Class:</b> Safe<br>

<b>Special Containment Procedures:</b> SCP-013 are to be kept in a Secure Storage Vault at Site-66. Exposed subjects are to be monitored for differences between their symptoms. Exposed subjects are to be interviewed daily, and any changes in perception are to be logged.<br>

<b>Description:</b> SCP-013 is the collective designation of 242 cigarettes which display similar anomalies. The most common external detail between instances is the presence of the words “Blue Lady” hand-written on each cigarette in blue ink.
Subjects who consume the contents of SCP-013 through inhalation will begin to perceive themselves as a specific unidentified woman. Subjects have described the woman to be aged between 25 and 35 years old, standing approximately 1.6 metres tall with an estimated weight of between 50 and 55 kg. Additional recurring details include cropped dark hair, blue eyes, and bright blue lipstick.
Immediately after consuming an instance of SCP-013, subjects will gradually begin to perceive reflections of themselves as having the features of the woman, and will gradually perceive their bodies changing to reflect her appearance over the course of the following weeks. All changes are entirely mental; the subject’s body does not change outwardly, only their perception of themselves. These alterations are permanent, and cannot be reversed.
SCP-013 was discovered after the suicide of an Ian Miles, packed in a large cardboard crate in his apartment. A cursory search of the apartment uncovered several hundred sketches of a figure strongly resembling the one perceived while under 013's effect. Miles' body had been found sitting at a desk, dead of a massive overdose and draped over a handwritten note, transcribed below.
During the investigation of Miles' apartment, one civilian investigator became affected by 013's effect. An embedded Agent soon contacted the nearest Site; the subject, the artifact, and related evidence were extracted and contained.
Currently, two hundred seventeen instances of SCP-013 cigarettes are contained at Bio-Site 66; twenty-five SCP-013 cigarettes are contained at Research Sector-09, pending future research into similar anomalous effects.
"}


/obj/item/paper/scp/safe/scp113
	name = "SCP-113"
	info = {"
	<tt><center><b><font color='green'>SAFE: SCP-113</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<br>
<b>Item #:</b> SCP-113<br>

<b>Object Class:</b> Safe<br>

<b>Special Containment Procedures:</b> SCP-113 is to be kept in standard storage in Site-23. SCP-113 may be handled with laboratory gloves. No organism may be exposed to SCP-113 without prior approval. Personnel exposed to SCP-113 are to be kept under medical observation for 7 days. <br>

<b>Description:</b> SCP-113 resembles a small, polished piece of red jasper. Analysis shows that SCP-113 is not composed of jasper, but -REDACTED- composition similar to that of other recovered objects.
<br>
When SCP-113 comes in direct contact with the flesh of an organism possessing sex chromosomes, the organism's physical characteristics associated with gender and biological sex are transformed (including genetics and secondary sexual characteristics), either reversed or altered.
<br>
This process occurs in four stages:
<br>
<b>Stage 1:</b> Lasts approximately 0.2 seconds. SCP-113 bonds with the cells that it touches and induces an unidentified chemical change. This process causes tissue damage similar to mild burns, and SCP-113 cannot be removed from contact with the subject until all stages complete.
<br>
<b>Stage 2:</b> Lasts approximately 20 seconds. SCP-113 emits a low-intensity electromagnetic wave which travels through the subject's body. Subjects may experience nausea and vomiting, along with a stinging sensation throughout the body.
<br>
<b>Stage 3:</b> Lasts approximately 60 seconds. Throughout this stage, the subject's cellular makeup is temporarily transformed. Altered cell composition ranges widely from being unidentifiable as human, to a unique variation of partially-differentiated stem cells. The subject will experience intense stimulation of all sensory nerves during the final 20 seconds of this stage, and describe this part of the process as extremely painful. Subjects in poor health may die of shock in this stage.
<br>
At the end of this stage, the subject's biological sex is permanently altered. In standard cases, the subject's biological sex will be changed to the opposite biological sex. All primary and secondary sexual characteristics are altered accordingly.
<br>
<b>Stage 4:</b> SCP-113 disengages from the subject and becomes inert.
<br>
Subjects with sex chromosomes atypical for their species (such as intersex humans) are affected in unpredictable ways by SCP-113. In human intersex subjects, this appears to be influenced by gender identity; such subjects may be unaffected, or their bodies may change to match baseline male or female bodies (with sex chromosomes to match), or other results may occur. Usually, change seems to match or partially match subject's gender identity during initial use, if gender identity is nonstandard. Whether SCP-113 alters its effect based on the presence of a nonstandard gender identity is under investigation.
<br>
Gender identity of human subjects is not typically altered by SCP-113. In subjects with nonstandard gender identities (typically gender identities which do not match their pre-exposure biological sex), this usually results in positive psychological effects. In subjects with standard gender identities (male/female, matching pre-exposure biological sex), psychological effects are usually negative. These appear to be natural psychological reactions, and not an anomalous effect of SCP-113.
<br>
SCP-113 exposure results in unusual effects in certain species. In Varanus komodoensis (the komodo dragon), a number of ZW/ZZ individuals were transformed to possess WW chromosomes instead of ZZ or ZW, which was in every instance fatal. In Caenorhabditis elegans (a nematode), no males were produced despite C. elegans having two sexes (hermaphrodite and male). Male subjects became hermaphrodites, and hermaphrodite subjects were unaffected. (Note: In wild populations, male C. elegans are extremely rare.)
<br>
Subjects of single-sex, hermaphroditic species (such as earthworms) will not be transformed by SCP-113; the object's process will stop at the second stage and the object will become inert.
<br>
Previously exposed subjects may undergo SCP-113's effects again by re-initiating contact with SCP-113 after approximately 60 seconds have passed. However, in 25% of cases, immediate second exposure to SCP-113 fails to transform the subject correctly. Transformation failure varies in nature, but usually includes massive bone, organ, and tissue damage to the subject, as well as partial or complete obliteration of genitalia. This commonly results in death by organ trauma or internal bleeding.
<br>
Failure rate can be affected by subjects not coming into contact with SCP-113 for a lengthy period of time, which varies by subject; patterns are under research. Under normal circumstances, transformation failure rate increases exponentially upon multiple exposures. Subjects who survive rapid, repeated exposure are eventually transformed -DATA EXPUNGED- Further anomalous elements continue to appear as exposure count increases.


"}

/obj/item/paper/scp/safe/scp131
	name = "SCP-131"
	info = {"
	<tt><center><b><font color='green'>SAFE: SCP-131</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<br>
<b>Item #:</b> SCP-131<br>

<b>Object Class:</b> Safe<br>

<b>Special Containment Procedures:</b> No special safety procedures are to be taken with SCP-131-A and SCP-131-B. They are free to travel about Site-19 so long as they do not attempt to enter any restricted areas or attempt to leave the facility. Casual contact with the subjects is permitted, but it is recommended that such contact be kept to a minimum to prevent the creatures from forming an attachment to personnel. Hourly tabs are to be kept on subjects at all times; failure to account for their presence at these times constitutes a level one lock down situation. Any report of abuse or mistreatment of the subjects will result in harsh reprimand.<br>

<b>Description:</b> SCP-131-A and SCP-131-B (affectionately nicknamed the "Eye Pods" by personnel) are a pair of teardrop-shaped creatures roughly 30 cm (1 ft) in height, with a single blue eye in the middle of their bodies. SCP-131-A is burnt orange in color while SCP-131-B is mustard yellow. At the base of each creature is a wheel-like protrusion which allows for locomotion, suggesting that the creatures may be biomechanical in origin. The subjects can move surprisingly fast, covering over 60 m (200 ft) in a matter of seconds. The subjects, however, lack a braking system, which has led to some rather spectacular, if not overly amusing, mishaps involving the creatures. The subjects have also shown the ability to climb sheer surfaces, and have gotten lost in the air vents on more than one occasion.
The subjects seem to have the intelligence of common house cats and are insatiably curious. Most of the time they simply roll around the facility, observing personnel at work and catching peeks at other Safe class SCPs. The subjects seem to be able to communicate with each other via an untranslatable high-pitched babbling. The subjects have never been observed to blink, even in laboratories when the subjects have been videotaped for over 18 consecutive hours.
The subjects seem to respond well to any affection given to them and will quickly bond to the giver of said affection, much in the same way a puppy bonds with a human being. They will follow anyone or anything they've made a bond with anywhere, even into normally restricted areas. Although curious, the subjects can sense danger in their general vicinity, and if the object of their bond begins to approach something they register as dangerous (e.g., Euclid or Keter class objects) they will swarm around their bonded companion's feet (or appropriate extremities) while babbling in a panicked tone, as if to warn them. Because of the daily dangers faced by Site-19 staff in dealing with Euclid and Keter class objects, it is recommended that staff avoid making attempts to bond with the subjects, as it can pose a distraction during delicate operations and experiments and may pose a danger to the subjects themselves (see Addendum 131-1). If the subjects are ignored by their bonded target long enough, they will eventually lose interest and return to their normal activities.
It should be noted that the subjects require no real care or maintenance from the site staff. They do not eat, leave droppings, or even sleep. It would seem that the only sustenance they require is visual stimulation (although this requires further study to verify).
Subjects SCP-131-A and SCP-131-B were found in a cornfield outside ¦¦¦¦¦¦¦¦¦¦¦¦ in the year 19¦¦. They were promptly transported to Site-19 via -DATA EXPUNGED- and were then downgraded to Safe class and given free reign across the site once it became clear they were not broadcasting what they saw to any hostile foreign powers.

"}


/obj/item/paper/scp/safe/scp500
	name = "SCP-500"
	info = {"
	<tt><center><b><font color='green'>SAFE: SCP-500</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item #:</b> SCP-500

<b>Object Class:</b> Safe

<b>Special Containment Procedures:</b> SCP-500 must be stored in a cool and dry place away from bright light. SCP-500 is only allowed to be accessed by personnel with level 4 security clearance to prevent misapplication.

<b>Description:</b> SCP-500 is a small plastic can which at the time of writing contains forty-seven (47) red pills. One pill, when taken orally, effectively cures the subject of all diseases within two hours, exact time depending on the severity and amount of the subject's conditions. Despite extensive trials, all attempts at synthesizing more of what is thought to be the active ingredient of the pills have been unsuccessful.
"}

/obj/item/paper/scp/safe/scp999
	name = "SCP-999"
	info = {"
	<tt><center><b><font color='green'>SAFE: SCP-999</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item #:</b> SCP-999<br>

<b>Object Class:</b> Safe<br>

<b>Special Containment Procedures:</b> SCP-999 is allowed to freely roam the facility should it desire to, but otherwise must stay in its pen. Subject is not allowed out of its pen at night or off facility grounds at any time. Pen is to be kept clean and food replaced twice daily. All personnel are allowed inside SCP-999’s holding area, but only if they are not assigned to other tasks at the time, or if they are on break. Subject is to be played with when bored and spoken to in a calm, non-threatening tone. <br>

<b>Description:</b> SCP-999 appears to be a large, amorphous, gelatinous mass of translucent orange slime, weighing about 54 kg (120 lbs) with a consistency similar to that of peanut butter. Subject’s size and shape constantly change, though most of the time its form is the size of a large beanbag chair. Composition of SCP-999 is oil-based, but consists of a substance unknown to modern science. Other than a thin, transparent membrane surrounding the orange mass, subject appears to have no organs to speak of.<br>

Subject’s temperament is best described as playful and dog-like: when approached, SCP-999 will react with overwhelming elation, slithering over to the nearest person and leaping upon them, “hugging” them with a pair of pseudopods while nuzzling the person’s face with a third pseudopod, all the while emitting high-pitched gurgling and cooing noises. The surface of SCP-999 emits a pleasing odor that differs with whomever it is interacting with. Recorded scents include chocolate, fresh laundry, bacon, roses, and Play-Doh™.

Simply touching SCP-999’s surface causes an immediate euphoria, which intensifies the longer one is exposed to SCP-999, and lasts long after separation from the creature. Subject’s favorite activity is tickle-wrestling, often by completely enveloping a person from the neck down and tickling them until asked to stop (though it does not always comply with this request).

While the creature will interact with anyone, it seems to have a special interest in those who are unhappy or hurt in any way. Persons suffering from crippling depression, after interacting with SCP-999, have returned completely cured with a very positive outlook on life. The possibility of marketing SCP-999’s slime as an antidepressant has been discussed.

In addition to its playful behavior, SCP-999 seems to love all animals (especially humans), refusing to eat any meat and even risking its own life to save others, on one occasion leaping in front of a person to take a bullet fired at them (subject’s intellect is still up for debate: though its behavior is infantile, it seems to understand human speech and most modern technology, including guns). The creature’s diet consists entirely of candy and sweets, with M&M’s™ and Necco™ wafers being its favorites. Its eating methods are similar to those of an amoeba.
<br>
<b>Addendum SCP-999-A:</b> The following is a report from an experiment in which SCP-682 is exposed to SCP-999 in the hopes that it will curb the creature’s omnicidal rage.
<br><br>
<i>
SCP-999 is released into SCP-682’s containment area. SCP-999 immediately slithers towards SCP-682.
<br>
999: (elated gurgles)
<br>
682: (unintelligible groans, growling) What is that?
<br>
SCP-999 moves in front of SCP-682, jumping up and down in a dog-like manner while calling out in a high-pitched squealing noise.
<br>
682: (groans) Disgusting…
<br>
SCP-682 immediately steps on SCP-999, completely flattening SCP-999. Observers were about to abort the experiment when SCP-682 started talking again.
<br>
682: (grunts) Hmmm? (unintelligible) what is this… (low noise, similar to light chuckle) I feel all… tingly inside…
<br>
SCP-999 can be seen crawling up from between SCP-682’s toes, up along its side and around its neck, where it clings on and begins gently nuzzling with its pseudopod. A wide grin slowly spreads across SCP-682’s face.
<br>
682: (deep chuckling) I feel… so… happy. Happy… (laughs) happy… happy…
<br>
SCP-682 repeats the word “happy” for several minutes, laughing occasionally before escalating into nonstop laughter. As laughter continues, SCP-682 rolls around on its back, slamming its tail upon the floor with dangerous force.
<br>
682: (bellowing laughter) Stop! No tickling! (continues laughing)
<br>
SCP-682 and SCP-999 continue the “tickle fight” until SCP-682 finally wears down and appears to fall asleep with what would appear to be a smile on its face. After fifteen minutes with no activity, two D-Class personnel enter the room to retrieve SCP-999. When SCP-999 is removed, SCP-682 immediately wakes up and unleashes an unidentifiable wave of energy from its body, all the while laughing maniacally.
<br>
All persons within the wave’s range collapse into crippling fits of laughter, allowing SCP-682 to escape and slaughter all in its path. Meanwhile, SCP-999 quickly rescues as many persons as it can, taking them to a safe place to recover from SCP-682’s "laughter wave" while agents suppress and recontain SCP-682.
<br>
Despite the tragedy that SCP-682 had brought upon the facility, SCP-999 has not shown any fear towards the creature and in fact has made gestures suggesting it wants to “play” with SCP-682 again. SCP-682, however, has stated, “That feculent little snot wad can -DATA EXPUNGED- and die."</i>

"}

// EUCLID

/obj/item/paper/scp/euclid/scp012
	name = "SCP-012"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-012</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-012
<br>
<b>Object Class:</b> Euclid
<br>
<b>Special Containment Procedures:</b> SCP-012 is to be kept in a darkened room at all times. If the object is exposed to light or seen by personnel using a light frequency other than infrared, remove personnel for mental health screening and immediate physical. Object is to be encased in an iron-shielded box, suspended from the ceiling with a minimum clearance of 2.5 m (8 ft) from the floor, walls, and any openings.
<br>
<b>Description:</b> SCP-012 was retrieved by Archaeologist K.M. Sandoval during the excavation of a northern Italian tomb destroyed in a recent storm. The object, a piece of handwritten musical score entitled "On Mount Golgotha", part of a larger set of sheet music, appears to be incomplete. The red/black ink, first thought to be some form of berry or natural dye ink, was later found to be human blood from multiple subjects. The first personnel to locate the sheet (Site 19 Special Salvage) had two (2) members descend into insanity, attempting to use their own blood to finish the composition, ultimately resulting in massive blood loss and internal trauma.

Following initial investigations, multiple test subjects were allowed access to the score. In every case, the subjects mutilated themselves in order to use their own blood to finish the piece, resulting in subsequent symptoms of psychosis and massive trauma. Those subjects who managed to finish a section of the piece immediately committed suicide, declaring the piece to be "impossible to complete". Attempts to perform the music have resulted in a disagreeable cacophony, with each instrumental part having no correlation or harmony with the other instruments.
"}

/obj/item/paper/scp/euclid/scp049
	name = "SCP-049"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-049</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-049
<br>
<b>Object Class:</b> Euclid
<br>
<b>Special Containment Procedures:</b> SCP-049 is contained within a Standard Secure Humanoid Containment Cell in Research Sector-02 at Site-19. SCP-049 must be sedated before any attempts to transport it. During transport, SCP-049 must be secured within a Class III Humanoid Restriction Harness (including a locking collar and extension restraints) and monitored by no fewer than two armed guards.

While SCP-049 is generally cooperative with most Foundation personnel, outbursts or sudden changes in behaviour are to be met with elevated force. Under no circumstances should any personnel come into direct contact with SCP-049 during these outbursts. In the event SCP-049 becomes aggressive, the application of lavender (L. multifida) has been shown to produce a calming effect on the entity. Once calmed, SCP-049 generally becomes compliant, and will return to containment with little resistance.

In order to facilitate the ongoing containment of SCP-049, the entity is to be provided with the corpse of a recently deceased animal (typically a bovine or other large mammal) once every two weeks for study. Corpses that become instances of SCP-049-2 are to be removed from SCP-049's containment cell and incinerated. SCP-049 is no longer permitted to interact with human subjects, and requests for human subjects are to be denied.
<br>
<b>Description:</b> SCP-049 is a humanoid entity, roughly 1.9 meters in height, which bears the appearance of a medieval plague doctor. While SCP-049 appears to be wearing the thick robes and the ceramic mask indicative of that profession, the garments instead seem to have grown out of SCP-049's body over time1, and are now nearly indistinguishable from whatever form is beneath them. X-rays indicate that despite this, SCP-049 does have a humanoid skeletal structure beneath its outer layer.

SCP-049 is capable of speech in a variety of languages, though tends to prefer English or medieval French2. While SCP-049 is generally cordial and cooperative with Foundation staff, it can become especially irritated or at times outright aggressive if it feels that it is in the presence of what it calls the "Pestilence". Although the exact nature of this Pestilence is currently unknown to Foundation researchers, it does seem to be an issue of immense concern to SCP-049.

SCP-049 will become hostile with individuals it sees as being affected by the Pestilence, often having to be restrained should it encounter such. If left unchecked, SCP-049 will generally attempt to kill any such individual; SCP-049 is capable of causing all biological functions of an organism to cease through direct skin contact. How this occurs is currently unknown, and autopsies of SCP-049's victims have invariably been inconclusive. SCP-049 has expressed frustration or remorse after these killings, indicating that they have done little to kill "The Pestilence", though will usually seek to then perform a crude surgery on the corpse using the implements contained within a black doctor's bag it carries on its person at all times3. While these surgeries are not always "successful", they often result in the creation of instances of SCP-049-2.

SCP-049-2 instances are reanimated corpses that have been operated on by SCP-049. These instances do not seem to retain any of their prior memories or mental functions, having only basic motor skills and response mechanisms. While these instances are generally inactive, moving very little and in a generally ambulatory fashion, they can become extremely aggressive if provoked, or if directed to by SCP-049. SCP-049-2 instances express active biological functions, though these are vastly different from currently understood human physiology. Despite these alterations, SCP-049 often remarks that the subjects have been "cured".
"}

/obj/item/paper/scp/euclid/scp078
	name = "SCP-078"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-078</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-078
<br>
<b>Object Class:</b> Euclid
<br>
<b>Special Containment Procedures:</b> SCP-078 is to be left hanging on the wall of its containment cell and physically unplugged. The sole outlet in the room should be controlled by a switch, which must be left in the off position at all times unless SCP-078 is undergoing testing. Personnel who enter the containment room should familiarize themselves with the position of the switch so that they can locate it with their eyes closed in the event that SCP-078 is accidentally turned on.
<br>
<b>Description:</b> SCP-078 is a pink neon sign approximately one and a half meters long that displays the phrase "TOO LATE TO DIE YOUNG." It was initially recovered in the town of ¦¦¦¦¦¦¦¦, ¦¦¦¦¦¦¦¦, after standard Foundation data mining protocols recorded an abnormally high death rate due to starvation or other forms of self-neglect.
While powered off, SCP-078 has no abnormal properties and may be observed without effect. Viewing SCP-078 for less than ten seconds while it is powered on has no effect, nor does indirect observation. Subjects who cannot understand SCP-078 due to a lack of ability to comprehend written English are also unaffected. However, any subject that views SCP-078 for longer than ten seconds will, when viewing any handwritten piece of writing, occasionally perceive extra sentences. These sentences are not written in the subject's own style or in that of the surrounding text, but consist of a random style that differs from note to note (see Addendum 078-01), and always are phrased as if to assuage the subject's guilt on some matter or decision they feel guilty about. For example, a D-class personnel who was convicted of murdering his wife in a heated argument read the sentence "She deserved it for not doing what you said" in his handwritten journal, while Dr. ¦¦¦¦¦¦, who left his family to work for the Foundation and was accidentally exposed, found the sentence "Your work will save humanity." in his notes on SCP-¦¦¦.
At first, the effect is beneficial, with affected subjects reporting greater peace of mind after exposure to SCP-078. However, the sentences shift from emphasizing the positive consequences of actions to deemphasizing the negative ones on a timescale of one week; Dr. ¦¦¦¦¦¦, two days later, found the sentence "They never loved you anyway." in his personal journal. Moreover, the writing will start giving justifications for acts the subject has never felt guilt over, or which the subject has already rationalized. The subject will then start reconsidering his justifications for those actions, as well as attempting to justify any further actions that they take. The need for rationalization increases as time goes on, and they will start vocalizing their thought processes, and by the end of one week, any task the subject performs more trivial than the basics of survival will induce a bout of neurosis as the subject attempts to rationalize why they did not instead take some other action. By the end of two weeks, the subject is unable to eat food: after the first bite, they will spend the next hour justifying why they ate that specific part of the meal first. Death due to malnutrition follows unless the subject is fed intravenously. ¦ D-class personnel who have reached this stage, as well as ¦ researchers who were accidentally exposed, are kept alive for purposes of study and to see if a cure can be found.
The sole exception to SCP-078's effect is SCP-078 itself: any subject who views SCP-078 a second time will see it displaying increasingly more guilt-inducing messages as duration since their first exposure increases. All subjects who have viewed it a week after initial exposure have attempted suicide.
"}

/obj/item/paper/scp/euclid/scp096
	name = "SCP-096"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-096</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item $:</b> SCP-096<br>

<b>Object Class:</b> Euclid<br>

<b>Special Containment Procedures:</b> SCP-096 is to be contained in its cell, a 5 m x 5 m x 5 m airtight steel cube, at all times. Weekly checks for any cracks or holes are mandatory. There are to be absolutely no video surveillance or optical tools of any kind inside SCP-096's cell. Security personnel will use pre-installed pressure sensors and laser detectors to ensure SCP-096's presence inside the cell.

Any and all photos, video, or recordings of SCP-096's likeness are strictly forbidden without approval from Dr. ¦¦¦ and O5-¦.

<b>Description:</b> SCP-096 is a humanoid creature measuring approximately 2.38 meters in height. Subject shows very little muscle mass, with preliminary analysis of body mass suggesting mild malnutrition. Arms are grossly out of proportion with the rest of the subject's body, with an approximate length of 1.5 meters each. Skin is mostly devoid of pigmentation, with no sign of any body hair.

SCP-096's jaw can open to four (4) times the norm of an average human. Other facial features remain similar to an average human, with the exception of the eyes, which are also devoid of pigmentation. It is not yet known whether SCP-096 is blind or not. It shows no signs of any higher brain functions, and is not considered to be sapient.

SCP-096 is normally extremely docile, with pressure sensors inside its cell indicating it spends most of the day pacing by the eastern wall. However, when someone views SCP-096's face, whether it be directly, via video recording, or even a photograph, it will enter a stage of considerable emotional distress. SCP-096 will cover its face with its hands and begin screaming, crying, and babbling incoherently. Approximately one (1) to two (2) minutes after the first viewing, SCP-096 will begin running to the person who viewed its face (who will from this point on be referred to as SCP-096-1).

Documented speeds have varied from thirty-five (35) km/h to ¦¦¦ km/h, and seems to depend on distance from SCP-096-1. At this point, no known material or method can impede SCP-096's progress. The actual position of SCP-096-1 does not seem to affect SCP-096's response; it seems to have an innate sense of SCP-096-1's location. Note: This reaction does not occur when viewing artistic depictions (see Document 096-1).

Upon arriving at SCP-096-1's location, SCP-096 will proceed to kill and -DATA EXPUNGED- SCP-096-1. 100% of cases have left no traces of SCP-096-1. SCP-096 will then sit down for several minutes before regaining its composure and becoming docile once again. It will then attempt to make its way back to its natural habitat, -DATA REDACTED-

Due to the possibility of a mass chain reaction, including breach of Foundation secrecy and large civilian loss of life, retrieval of subject should be considered Alpha priority.

Dr. ¦¦¦ has also petitioned for immediate termination of SCP-096 (see Interview 096-1). <s>Order is awaiting approval.</s> Termination order has been approved, and is to be carried out by Dr. ¦¦¦ on -DATA REDACTED-. See Incident-096-1-A.
	"}

/obj/item/paper/scp/euclid/scp151
	name = "SCP-151"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-151</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center><br>
<b>Item #:</b> SCP-151
<br>
Object Class: Euclid
<br>
Special Containment Procedures: SCP-151 should be kept in a locked storage compartment, covered by an opaque cloth. The keys to the compartment should be kept in the custody of the site commander when SCP-151 is not being researched. When research is being conducted, SCP-151 may be kept in a locked laboratory, provided it is always covered when not being used.
<br>
<b>Description:</b> SCP-151 is a 1 m x 1.3 m (3 ft x 4 ft) oil painting, apparently from the perspective of someone underwater. A subject who views the painting exhibits no initial effects. However, over a period of 24 hours, the subject's breathing becomes increasingly labored, culminating in the death of the subject. Autopsies reveal that subjects' lungs have filled with seawater. Attempts to halt the drowning process by medical intervention have proven successful in prolonging the life of the subject, but have not stopped nor reversed the condition.

The painting is not signed, but several names are written on the back.

"}

/obj/item/paper/scp/euclid/scp153
	name = "SCP-153"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-153</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item #:</b> SCP-153<br>

<b>Object Class:</b> Euclid<br>

<b>Special Containment Procedures:</b> SCP-513 is to be suspended in a one cubic meter block of gelatin and contained within a soundproofed, climate-controlled cell. The gelatin must be inspected daily for any degradation or loss of integrity. An emergency inspection will be carried out immediately following any earthquake, explosion, or sonic event grade 2 or higher. Personnel performing the inspection are to wear earplugs and active noise-canceling earmuffs at all times while inside SCP-513’s cell.

If the gelatin cube shows any signs of degradation (such as rips, tears, splits, liquefaction, or mold), SCP-513 is to be immediately removed and suspended within a replacement cube by a team of surgically deafened Class-D personnel. No other personnel are to enter the cell during this procedure.

Any sentient beings exposed to SCP-513 are to be monitored by at least two security personnel at all times. Under absolutely no circumstances may exposure victims be administered sedatives or allowed to fall unconscious. Any victim who does fall unconscious is to be terminated immediately.

Class-D personnel are to be terminated at the first sign of mental degradation. All other exposure victims may be terminated at their request.

If possible, SCP-513-1 is to be apprehended on sight.<br>

<b>Description:</b> Physically, SCP-513 is an unremarkable, rusty cowbell. No marks or engravings are visible on its surface due to the large amount of corrosion. Attempts to remove the rust chemically or mechanically have had no success.

SCP-513 was recovered by Agent ¦¦¦¦¦¦ while carrying out Containment Reestablishment Procedure Mu at Site-¦¦. SCP-513’s clapper was firmly held in place by several strips of duct tape. A single scrap of paper was found along with SCP-513 (see Addendum).

Any noise produced by SCP-513 immediately induces strong anxiety in all sentient beings who hear it, regardless of their previous mental status. Exposure victims report feelings of being watched by an unseen entity and present elevated heart rates and blood pressure. Roughly one hour after exposure, exposure victims begin to catch glimpses of SCP-513-1 when opening doors, walking past mirrors, turning their heads, or performing any other actions that result in a sudden change in visual perception. Upon being sighted, SCP-513-1 reportedly turns away and runs out of view before disappearing without a trace. Questioning of bystanders indicates that SCP-513-1 is invisible to those who have not been exposed to SCP-513.

Sightings of SCP-513-1 reoccur every 14 to 237 minutes. This “stalking” behavior inevitably causes extreme sleep deprivation, as victims are frequently disturbed by SCP-513-1’s presence in their quarters. Victims able to fall asleep before SCP-513-1's appearance report being physically assaulted by it. Upon the victim's awakening, SCP-513-1 flees as usual (see Experiment Log 513). This sleep deprivation, along with the mental stress caused by SCP-513-1's behavior, invariably induces paranoia, aggression, hypervigilance, and depression. All test cases but one have ended with the test subject’s suicide.

Descriptions of SCP-513-1's appearance are largely unreliable. Test subjects are unable to provide complete accounts of sightings due to their exhaustion, degraded mental health, and disruptive hypervigilance. However, all interrogations thus far indicate that SCP-513-1 is a tall, emaciated humanoid with abnormally large hands.</tt>
	"}

/obj/item/paper/scp/euclid/scp173
	name = "SCP-173"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-173</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item #:</b> SCP-173<br>

<b>Object Class:</b> Euclid<br>

<b>Special Containment Procedures:</b> Item SCP-173 is to be kept in a locked container at all times. When personnel must enter SCP-173's container, no fewer than 3 may enter at any time and the door is to be relocked behind them. At all times, two persons must maintain direct eye contact with SCP-173 until all personnel have vacated and relocked the container.<br>

<b>Description:</b> Moved to Site-19 1993. Origin is as of yet unknown. It is constructed from concrete and rebar with traces of Krylon brand spray paint. SCP-173 is animate and extremely hostile. The object cannot move while within a direct line of sight. Line of sight must not be broken at any time with SCP-173. Personnel assigned to enter container are instructed to alert one another before blinking. Object is reported to attack by snapping the neck at the base of the skull, or by strangulation. In the event of an attack, personnel are to observe Class 4 hazardous object containment procedures.<br>

Personnel report sounds of scraping stone originating from within the container when no one is present inside. This is considered normal, and any change in this behaviour should be reported to the acting HMCL supervisor on duty.<br>

The reddish brown substance on the floor is a combination of feces and blood. Origin of these materials is unknown. The enclosure must be cleaned on a bi-weekly basis.</tt>
	"}

/obj/item/paper/scp/euclid/scp513
	name = "SCP-513"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-513</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-513
<br>
<b>Object Class:</b> Euclid
<br>
<b>Special Containment Procedures:</b> SCP-513 is to be suspended in a one cubic meter block of gelatin and contained within a soundproofed, climate-controlled cell. The gelatin must be inspected daily for any degradation or loss of integrity. An emergency inspection will be carried out immediately following any earthquake, explosion, or sonic event grade 2 or higher. Personnel performing the inspection are to wear earplugs and active noise-canceling earmuffs at all times while inside SCP-513’s cell.
<br>
If the gelatin cube shows any signs of degradation (such as rips, tears, splits, liquefaction, or mold), SCP-513 is to be immediately removed and suspended within a replacement cube by a team of surgically deafened Class-D personnel. No other personnel are to enter the cell during this procedure.

Any sentient beings exposed to SCP-513 are to be monitored by at least two security personnel at all times. Under absolutely no circumstances may exposure victims be administered sedatives or allowed to fall unconscious. Any victim who does fall unconscious is to be terminated immediately.

Class-D personnel are to be terminated at the first sign of mental degradation. All other exposure victims may be terminated at their request.

If possible, SCP-513-1 is to be apprehended on sight.
<br>
<b>Description:</b> Physically, SCP-513 is an unremarkable, rusty cowbell. No marks or engravings are visible on its surface due to the large amount of corrosion. Attempts to remove the rust chemically or mechanically have had no success.

SCP-513 was recovered by Agent ¦¦¦¦¦¦ while carrying out Containment Reestablishment Procedure Mu at Site-¦¦. SCP-513’s clapper was firmly held in place by several strips of duct tape. A single scrap of paper was found along with SCP-513 (see Addendum).

Any noise produced by SCP-513 immediately induces strong anxiety in all sentient beings who hear it, regardless of their previous mental status. Exposure victims report feelings of being watched by an unseen entity and present elevated heart rates and blood pressure. Roughly one hour after exposure, exposure victims begin to catch glimpses of SCP-513-1 when opening doors, walking past mirrors, turning their heads, or performing any other actions that result in a sudden change in visual perception. Upon being sighted, SCP-513-1 reportedly turns away and runs out of view before disappearing without a trace. Questioning of bystanders indicates that SCP-513-1 is invisible to those who have not been exposed to SCP-513.

Sightings of SCP-513-1 reoccur every 14 to 237 minutes. This “stalking” behavior inevitably causes extreme sleep deprivation, as victims are frequently disturbed by SCP-513-1’s presence in their quarters. Victims able to fall asleep before SCP-513-1's appearance report being physically assaulted by it. Upon the victim's awakening, SCP-513-1 flees as usual (see Experiment Log 513). This sleep deprivation, along with the mental stress caused by SCP-513-1's behavior, invariably induces paranoia, aggression, hypervigilance, and depression. All test cases but one have ended with the test subject’s suicide.

Descriptions of SCP-513-1's appearance are largely unreliable. Test subjects are unable to provide complete accounts of sightings due to their exhaustion, degraded mental health, and disruptive hypervigilance. However, all interrogations thus far indicate that SCP-513-1 is a tall, emaciated humanoid with abnormally large hands.
"}

/obj/item/paper/scp/euclid/scp895
	name = "SCP-895"
	info = {"
	<tt><center><b><font color='orange'>EUCLID: SCP-895</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

<b>Item #:</b> SCP-895
<br>
<b>Object Class:</b> Euclid
<br>
<b>Special Containment Procedures:</b> SCP-895 is sealed closed and stored in an isolated underground containment cell at a depth of approximately 100 meters. No cameras, microphones, or other surveillance equipment may be brought within the 10 meter "Red Zone" radius of SCP-895 without express permission from at least two (2) Level 3 personnel.

Any on-site personnel exhibiting unusual behavior or signs of psychological trauma are to be screened immediately, and removed from the site or terminated as the situation warrants.
<br>
<b>Description:</b> SCP-895 is an ornate oak coffin recovered from the ¦¦¦¦¦ ¦¦¦¦¦ Mortuary by SCP personnel on ¦¦/¦/¦¦, following reports of unusual footage captured by surveillance equipment installed at that location. When questioned, mortuary staff were unable to determine the source of SCP-895 and how it was transported to the location. Upon attempting to open SCP-895, agents on location found the object empty; however, observers viewing the live camera feed were -DATA EXPUNGED-. Until further notice, SCP-895 must remain closed at all times.

SCP-895 causes disruptions in video and photographic surveillance equipment within 50 meters similar to vivid, disturbing hallucinations with variable duration and regularity corresponding to the camera's proximity to SCP-895. Within a range of 5 meters from SCP-895, footage captured can cause severe psychological trauma and hysteria in most subjects. These disruptions do not extend to observers physically present within the area.
<br>
<b>Addendum 895-01:</b> Audio excerpt from the SCP-895 Recovery Log (¦¦/¦/¦¦)
<br>
> 03:41L - <b>Command:</b> Team One, Command. All civilians have been detained and evacuated. You are cleared to move in and capture.
<br>
> 03:41L - <b>T1Lead:</b> Command, One Lead. Roger, we are moving in.
<br>
> 03:43L - <b>T1Lead:</b> We are inside the lobby. Video feed check.
<br>
> 03:44L - <b>Command:</b> Team One, Command. We are receiving...-pause-...we are seeing blood on the walls, please confirm.
<br>
> 03:44L - <b>T1Lead:</b> Negative, Command, it's clean in here. Nothing out of the ordinary.
<br>
> 03:45L - <b>Command:</b> ... it's gone. Team One, advise possible memetic properties in effect.
<br>
> 03:45L - <b>T1Lead:</b> Copy, Command. Team One moving into storage area.
<br>
> 03:47L - <b>T1Lead:</b> We are in the storage area, object located.
<br>
> 03:48L - <b>Command:</b> Christ, it's moving... Team One, confirm, object appears to be alive and moving.
<br>
> 03:48L - <b>T1Lead:</b> ... Command, negative, we see no movement. Object appears to be normal.
<br>
> 03:48L - <b>T1Lead:</b> Two, open it up.
<br>
> 03:48L - <i>Sounds of weapons being readied, followed by creaking as object is opened.</i>
<br>
> 03:49L - <b>T1-2:</b> Sir, it's empty.
<br>
> 03:50L - <b>T1Lead:</b> Command, One Lead. The object appears to be empty.
<br>
> 03:51L - <b>T1Lead:</b> Command, do you copy?
<br>
> 03:51L - <b>Command:</b> //Sounds of screaming and retching.//
<br>
> 03:51L - <b>T1Lead:</b> Command, do you copy?!
<br>
> 03:52L - <b>T1Lead:</b> Shit, we're bugging out. Close that thing!
<br>
<b>Addendum 895-02:</b> Following Incident -DATA EXPUNGED- and the loss of 3 personnel, the Red Zone of SCP-895 has been extended from 5 meters to 10 meters, and security personnel shifts have been reduced to 4 hours as a precaution.
"}

// EUCLID ADDENDUMS




/obj/item/paper/scp/euclid/scp096/addendum1

	name = "SCP-096-ADD1"
	info = {"<b>Audio log from Interview 096-1:

Interviewer: Dr. ¦¦¦
Interviewed: Captain (Ret.) ¦¦¦¦¦¦¦¦¦, former commander of retrieval team Zulu 9-A
Retrieval Incident #096-1-A</b>

<b><Begin Log></b>

<b>*¦¦¦¦¦¦¦¦ ¦¦¦¦¦¦¦¦ Time, Research Area ¦¦*</b>

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> It always sucks ass to get Initial Retrieval duty. You have no idea what the damn thing is capable of besides what jacked up information the field techies can scrape up, and you're lucky if they even tell you the whole story. They told us to "bag and tag." Didn't tell us jackshit about not looking at the damn thing.

<b>Dr. ¦¦¦:</b> Could you describe the mission, please?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> Yeah, sorry. We had two choppers, one with my team and one on backup with Zulu 9-B and Dr. ¦¦¦¦¦¦. We spotted the target about two clicks north of our patrol path. I'm guessing he wasn't facing our direction, else he would have taken us out then and there.

<b>Dr. ¦¦¦:</b> Your report says SCP-096 didn't react to the cold? It was -¦¦o C.

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> Actually, it was -¦¦. And yes, it was butt naked and didn't so much as shiver. Anyway, we landed, approached the target, and Corporal ¦¦ got ready to bag it. That's when Dr. ¦¦¦¦¦¦ called. I turned to answer it, and that's what saved me. The target must have turned and my whole squad saw it.

<b>Dr. ¦¦¦:</b> That's when SCP-096 entered an agitated emotional state?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> Yep. *Interviewed now pauses for a second before continuing* Sorry. Got the willies for a second.

<b>Dr. ¦¦¦:</b> That's all right.

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> Yeah. Well, I never saw its face. My squad did, and they paid for it up the ass.

<b>Dr. ¦¦¦:</b> Could you describe it a little more, please?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> *Pauses* Yeah, yeah. It started screaming at us, and crying. Not animal roaring though, sounded exactly like a person. Really fucking creepy. *Pauses again* We started firing when it picked up Corporal ¦¦ and ripped off his leg. God, he was screaming for our help… fuckin 'A… anyway, we were blowing chunks out of the target, round after round. Didn't do jackshit. I almost lost it when it started -DATA EXPUNGED- him.

<b>Dr. ¦¦¦:</b> That's when you ordered the use of an *Papers are heard moving* AT-4 HEDT launcher?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> An anti-tank gun. Started carrying it ever since SCP-¦¦¦ got loose. I've seen those tear through tanks like tissue paper. Did the same thing to the target.

<b>Dr. ¦¦¦:</b> There was significant damage to SCP-096?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> It didn't even fucking flinch. It kept tearing apart my squad, but with half of its torso gone. *He draws a large half-circle across his torso*

<b>Dr. ¦¦¦:</b> But it was taking damage?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> If it was, it wasn't showing it. It must have lost all its organs, all its blood, but it didn't acknowledge any of it. Its bone structure wasn't hurt at all, though. It kept tearing my squad apart.

<b>Dr. ¦¦¦:</b> So no actual structural damage. How many rounds would you say were fired at SCP-096?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> At the least? A thousand. Our door gunner kept his GAU-19 on it for at least twenty seconds. Twenty fucking seconds. That's six hundred .50 caliber rounds pumped into the thing. Might as well been spitting at it.

<b>Dr. ¦¦¦:</b> This is when Zulu 9-B arrived?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> Yeah, and my squad was gone. Zulu 9-B managed to get the bag over its head, and it just sat down. We got it into the chopper and got it here. I don't know how I never saw its face. Maybe God or Buddha or whoever thought I should live. The jackass.

<b>Dr. ¦¦¦:</b> We have obtained an artist's depiction of SCP-096's face. Would you like to view it?

<b>Capt. ¦¦¦¦¦¦¦¦¦:</b> *Pauses* You know, after hearing that thing's screams, and the screams of my men, I don't think I want to put a face to what I heard. No. Just… no.

<b>Dr. ¦¦¦:</b> All right, I believe we are done here. Thank you, Captain.

<b>*Chairs are heard moving, and footsteps leave the room. Captain (Ret.) ¦¦¦¦¦¦¦¦¦ is confirmed to have left Interview Room 22.*</b>

<b>Dr. ¦¦¦:</b> Let this be on record that I am formally requesting SCP-096 be terminated as soon as possible.

<End log>
"}

/obj/item/paper/scp/euclid/scp151/addendum1
	name = "SCP-151-ADD1"
	info = {"
	<tt><center><b><font color='orange'>SCP-151 ADDENDUM 1</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
Addendum: SCP-151 was found in an antique shop in ¦¦¦¦¦¦¦¦¦, ¦¦¦, after the Foundation began investigating a series of unexplained drowning deaths. As ¦¦¦ is landlocked, the Foundation dispatched a team of plainclothes agents after being informed of the nature of the water in the victims' lungs and that the victims had all been discovered on dry land. The agents discovered that the names written on the back belonged to a group of artistically inclined students, all of whom disappeared during a study abroad program in ¦¦¦¦¦¦¦. Investigation into their fate is ongoing, and may provide clues as to the nature and origin of SCP-151.
"}


/obj/item/paper/scp/euclid/scp153/addendum1
	name = "SCP-153-ADD1"
	info = {"
	<tt><center><b><font color='orange'>SCP-153 ADDENDUM 1</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>

You’ve seen it. Now he can hear you.<br>
You’ve touched it. Now he can see you.<br>
<u>Never</u> ring it. If you hear it, he can touch you.
	"}


// KETER

/obj/item/paper/scp/keter/scp106
	name = "SCP-106"
	info = {"
	<tt><center><b><font color='red'>KETER: SCP-106</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-106
<br>
Object Class: Keter
<br>
<b>Special Containment Procedures:</b>
<br>
<b>REVISION 11-8</b>
<br>
No physical interaction with SCP-106 is allowed at any time. All physical interaction must be approved by no less than a two-thirds vote from O5-Command. Any such interaction must be undertaken in AR-II maximum security sites, after a general non-essential staff evacuation. All staff (Research, Security, Class D, etc.) are to remain at least sixty meters away from the containment cell at all times, except in the event of breach events.

SCP-106 is to be contained in a sealed container, comprised of lead-lined steel. The container will be sealed within forty layers of identical material, each layer separated by no less than 36cm of empty space. Support struts between layers are to be randomly spaced. Container is to remain suspended no less than 60cm from any surface by ELO-IID electromagnetic supports.

Secondary containment area is to be comprised of sixteen spherical “cells”, each filled with various fluids and a random assembly of surfaces and supports. Secondary containment is to be fitted with light systems, capable of flooding the entire assembly with no less than 80,000 lumens of light instantly with no direct human involvement. Both containment areas are to remain under 24 hour surveillance.

Any corrosion observed on any containment cell surfaces, staff members, or other site locations within two hundred meters of SCP-106 are to be reported to Site Security immediately. Any objects or personnel lost to SCP-106 are to be deemed missing/KIA. No recovery attempts are to be made under any circumstances.
<br>
Note: Continued research and observation have shown that, when faced with highly complex/random assemblies of structures, SCP-106 can be “confused”, showing a marked delay on entry and exit from said structure. SCP-106 has also shown an aversion to direct, sudden light. This is not manifested in any form of physical damage, but a rapid exit in to the “pocket dimension” generated on solid surfaces.

These observations, along with those of lead-aversion and liquid confusion, have reduced the general escape incidents by 43%. The “primary” cells have also been effective in recovery incidents requiring Recall Protocol ¦¦ -¦¦¦ -¦. Observation is ongoing.
<br>
Description: SCP-106 appears to be an elderly humanoid, with a general appearance of advanced decomposition. This appearance may vary, but the “rotting” quality is observed in all forms. SCP-106 is not exceptionally agile, and will remain motionless for days at a time, waiting for prey. SCP-106 is also capable of scaling any vertical surface and can remain suspended upside down indefinitely. When attacking, SCP-106 will attempt to incapacitate prey by damaging major organs, muscle groups, or tendons, then pull disabled prey into its pocket dimension. SCP-106 appears to prefer human prey items in the 10-25 years of age bracket.

SCP-106 causes a “corrosion” effect in all solid matter it touches, engaging a physical breakdown in materials several seconds after contact. This is observed as rusting, rotting, and cracking of materials, and the creation of a black, mucus-like substance similar to the material coating SCP-106. This effect is particularly detrimental to living tissues, and is assumed to be a “pre-digestion” action. Corrosion continues for six hours after contact, after which the effect appears to “burn out”.

SCP-106 is capable of passing through solid matter, leaving behind a large patch of its corrosive mucus. SCP-106 is able to “vanish” inside solid matter, entering what is assumed to be a form of “pocket dimension”. SCP-106 is then able to exit this dimension from any point connected to the initial entry point (examples: “entering” the inner wall of a room, and “exiting” the outer wall. Entering a wall, and exiting from the ceiling). It is unknown if this is the point of origin for SCP-106, or a simple “lair” created by SCP-106.

Limited observation of this “pocket dimension” has shown it to be comprised mostly of halls and rooms, with -DATA EXPUNGED- entry. This activity can continue for days, with some subjected individuals being released for the express purpose of hunting, recapture, -DATA EXPUNGED-.
"}

/obj/item/paper/scp/keter/scp939
	name = "SCP-939"
	info = {"
	<tt><center><b><font color='red'>KETER: SCP-939</font></b>
	<h3>FOUNDATION RESEARCH DIVISION</h3>
	</center>
<br>
<b>Item #:</b> SCP-939
<br>
<b>Object Class:</b> Keter
<br>
<b>Special Containment Procedures:</b> SCP-939-1, -3, -19, -53, -89, -96, -98, -99, and -109 are kept in Cell 1163-A or 1163-B, 10 m x 10 m x 3 m containment chambers within Armed Bio-Containment Area-14. Both cells are environmentally regulated and negatively pressurized, with walls constructed of reinforced concrete. Access to these cells is regulated by an outer decontamination chamber and inner gas-tight steel security doors. Observation windows are constructed of laminated ballistics glass 10 cm in thickness protected by a 100kV electrified mesh. Humidity is maintained at 100% at a temperature of 16° C. Specimens are monitored at all times via infrared cameras. Level Four authorization is required to access SCP-939, their containment areas, or the observation chambers.

SCP-939-101 is dismembered and stored in Cryogenic Preservation Tanks 939-101A to 939-101M within Bio-Research Area-12. Access to SCP-939-101 requires authorization by two Clearance Level 3 personnel, one of which must be present for all research and testing. The contents of only one (1) 939-101 tank may be accessed at any given time. Core temperature of SCP-939-101 tissues must be monitored while removed from cryogenic preservation; should core temperature exceed 10° C, tissues are to be returned to their corresponding tank and all testing suspended for a period of seventy-two (72) hours. Barring core temperature exceeding 10° C, research of SCP-939-101 tissues may continue as long as its ramblings and pleas for release may be tolerated.

Containment cells should be cleaned biweekly. While this takes place, SCP-939 specimens will be transferred to the adjacent cell. During this time, the cell's door and observation window must be inspected for damage and repaired or replaced accordingly.

Heavy sedation of all SCP-939 is required before any interaction, including transfer between cells and experimentation, may take place. See Document #939-TE4 for transfer and experimentation protocol.

Level C Hazmat gear is to be worn by personnel during interactions with SCP-939 specimens and in any areas which SCP-939 have been known to inhabit. Afterward, standard decontamination procedures are to be observed by all personnel involved to ensure no secondary spread of amnestic agents occurs.

Following Incident ABCA14-939-3, all non Class D personnel interacting with SCP-939 for any length of time are required to wear two (2) water-proof electronic pulse monitors for the duration of such interaction. These pulse monitors will transmit to a wireless monitoring system independent of a facility's main power grid, with at least one backup power system on standby. Should both an individual's pulse monitors flat-line or otherwise malfunction, the wearer will be presumed dead, personnel instructed to disregard all the wearer's subsequent vocalizations, and a breach of containment declared automatically. Security personnel responding to such a breach are likewise required to wear these pulse monitors.

Additionally, all live SCP-939 must be implanted with subdermal tracking devices upon capture.
<br>
Description: SCP-939 are endothermic, pack-based predators which display atrophy of various systems similar to troglobitic organisms. The skins of SCP-939 are highly permeable to moisture and translucent red, owing to a compound chemically similar to hemoglobin. SCP-939 average 2.2 meters tall standing upright and weigh an average of 250 kg, though weight is highly variable. Each of their four limbs end in three-fingered claws with a fourth, opposable digit, and are covered in setae which considerably augment climbing ability. Their heads are elongated, devoid of even vestigial eyes or eye sockets, and contain no brain casing. The jaws of SCP-939 are lined with red, faintly luminescent fang-like teeth, similar to those belonging to specimens of the genus Chauliodus, up to 6 cm in length, and encircled by heat-sensitive pit organs. Eye spots, sensitive to light and dark, run the length of their spined dorsal ridges. These spines may be up to 16 cm long and are believed to be sensitive to changes in air pressure and flow.

SCP-939 do not possess many vital organ systems; central and peripheral nervous systems, circulatory system, and digestive tract are all absent. SCP-939's respiratory system is atrophied and serves no apparent purpose beyond spreading AMN-C227 (see below). SCP-939 have no apparent physiological need to feed, nor any way to digest consumed tissue. Ingested material typically accumulates in the respiratory system of SCP-939 and is regurgitated once the amount is sufficient to markedly inhibit its function. Despite the absence of many vital organ systems, SCP-939 are capable of bearing live young. See Addendum 10-16-1991.

SCP-939's primary method of luring prey is the imitation of human speech in the voices of prior victims, though imitation of other species and active nocturnal hunts have been documented. SCP-939 vocalizations often imply significant distress; whether SCP-939 understand their vocalizations or are repeating previously heard phrases is the subject of ongoing study. How SCP-939 acquire voices is not currently understood; specimens have been documented imitating victims despite never hearing the victim speak. Analysis of SCP-939 vocalizations cannot distinguish between SCP-939 and samples of known victims' voices. The use of biometric voice-recognition security or identification systems at any installation housing SCP-939 is strongly discouraged for this reason. Prey is usually killed with a single bite to the cranium or neck; bite forces have been measured in excess of 35 MPa.

SCP-939 exhale minute traces of an aerosolized Class C amnestic, designated AMN-C227. AMN-C227 causes temporary anterograde amnesia, inhibiting memory formation for the duration of exposure, plus an average of thirty (30) minutes. It is colorless, odorless, and tasteless with an estimated ECt50 for inhalation of 0.0015mg•min/m3. In well-ventilated or open air environments, risk of exposure to ECt50 is greatly reduced but not negligible. AMN-C227 is typically undetectable in the bloodstream sixty (60) minutes following cessation of exposure. Reported sensations of disorientation and mild hallucinations immediately following removal from environments saturated with the agent are similar to recreational use of numerous psychoactive substances and easily mistaken as such.
"}


// MISC.

/obj/item/paper/dcell/assignment
	name = "READ THIS FIRST!"
	info = {"
	<tt><center><b>
	<h3>FOUNDATION SECURITY DIVISION</h3></b>
	</center>
<br>
Congratulations, you're in charge of assignments today!
<br>
<b>Before assigning work detail to anyone, make sure to coordinate with your fellow cell guards and Lieutenant to see if all work places have at least one cell guard overlooking it!</b>
<br>
<br>
<b>As an additional note, there is a maximum of work assignments, which is 6x mining and manual labor, 4 x botany, 3x kitchen, 4x janitorial and 6x mining, making for 17 work places at current time.</b>
<br>
<b>DO NOT EXCEED THE MAXIMUM ALLOWED OF WORKSPACES UNDER THREAT OF IMMEDIATE EMPLOYMENT TERMINATION.</b>
<br>
<br>
<b>Cell guards must not assign access other than the D-Class Work Zones. Doing this will result in immediate employment termination.</b>
<br>
Steps to assign someone to work duty;
<br>
0. Remind all guards that work duty assignment requires them to update their access as well. Ask the Lieutenant to hand out assignments ASAP. Guard assignments go first. D-Cells may be unlocked after.
<br>
1. D-Class are allowed to cite their preference. This does not mean you have to grant them at you.
<br>
2. Ask for the ID Card of the D-Class, and assign the appropriate access. Only one work assignment per D-Class.
<br>
3. Return ID Card to D-Class, and give them instructions on how to get to their area.
<br>
4. Inform guards at work stations of the D-Number that is coming their way, so they do not let in random people.
<br>
<br>
<b>Once you are done with assigning D-Class, or the work assignments are full, close down the shutters and secure the Mastercard in the locker supplied next to your desk. The safe code is 15954. Failure to do this will result in immediate termination.</b>
<br>
<br>
<b>Assigning additional access to yourself besides the Class D work assignments is noted, and logged in the secure logging system of this terminal. Termination will be instant.</b>
<br>
<br>
Good luck on your shift! For further questions, please defer to your Cell Lieutenant. Return this piece of paper to the Guard Lieutenant, or stash it in the safe if one is not around.
"}
