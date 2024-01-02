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
	desc = "SOP in Site 53."
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

/obj/item/paper/reactor
	name = "Reactor Startup Procedure"
	info = {"
	First, connect up each of the yellow wires. In the image of the R-UST above, you will see red wires connecting the yellow wires from the PACMAN-generator to the SMES, and from the SMES to the fusion core. These are the wires you need to add.<br>
	The fusion core and gyrotron have a heavy power drain when operational. You will need to use the PACMAN to provide this until the fusion process becomes self-sustaining. Insert some tritium ingots from the radioactive crate and turn on the PACMAN with between 0.1MW and 0.15MW of power.<br>
	Create five deuterium and one tritium fuel rod using the fuel compressor and insert these into the fuel injectors, one per injector.<br>
	Return to the control room and raise the chamber containment shutters and ensure that the chamber observation is only down if you are wearing radiation protection gear.<br>
	Set the gyrotron to fire delay 2, power 50. There can be an initial burst in instability when turning the reactor on - If you have allowed fuel to build up. So we set the gyrotron to a high-power mode for the initial startup. Do not walk infront of the gyrotron while it is active.<br>
	Turn on the fusion core and adjust the field strength to 20 tesla.<br>
	Turn on all the fusion fuel injectors.<br>
	Watch the temperature and power rise on the fusion core console. Make sure that the instability is being managed by the gyrotron (less than 1%).<br>
	Once the power output is 250kW or higher, return to the R-UST room and turn off the PACMAN-generator. It may explode if you leave it running for too long.<br>
	You can now adjust the gyrotron power to a lower setting, such as fire delay 3, power output 3. Check that the instability is staying low after adjusting the gyrotron.
	"}

/obj/item/paper/sec_ctp
	name = "Checkpoint Testing Procedures"
	info = {"<center><h1>Checkpoint Testing Procedures</h1></center><br>
	<center><b><font size="1">Site 53</font></b></center><br>
	<center><img src = sec.png></center><br>
	<center><b>Secure. Contain. Protect.</b></center><br>
	<hr>
	STEP ONE: Check what the current site-wise security level is:<br>
	<ul><li>CODE GREEN: Testing is to be conducted as normal.<br>
	<li>CODE YELLOW: Testing can be refused by the checkpoint officer if there is an imminent threat to staff within the respective zone of the checkpoint. <br>
	<li>CODE ORANGE and RED: No tests are to be conducted. Currently active tests may be ended at the discretion of the Zone Commander and above.<br>
	<li>CODE BLACK and PITCHBLACK: No tests are to be conducted. All currently active tests are to be ended as soon as possible.</ul>
	STEP TWO: Check the legitimacy of given paperwork and credentials. If paper is incorrect or forged, detain all involved personnel and report to your zone's Sargeant.<br>
	Paperwork must clearly state the SCP(s) and materials involved in the test and the testing plan. If it does not, directly contact the Reaserch Director and do not allow entry.<br>
	You do not have the right to either authorize or not authorize a test. Regular researchers and up may test on Safe SCPs at their discretion and do not need explicit approval. Senior researchers and up may test on Euclid SCPs at their own discretion and do not require explicit approval. Any researcher may test on any SCP with the permission of the RD, barring restricted SCPs, which are SCP-106 and SCP-096, which require Site Director approval. You may, however, deny a test depending on the site's security level or if the individuals are suspicious. <br>
	If a test conflicts with the special containment procedures of an SCP, you are to notify the RD. If the RD still approves the test, you may allow entry. Otherwise, the research staff must be held at the checkpoint until sufficient modifications are made.<br>
	STEP THREE: Notify the Site Director and the Research Director through email of any attempts to pass through checkpoints for research. State the test and target SCP and whether or not they have been cleared to enter by checkpoint personnel. If you denied their entry, state the reason as to why in your email.<br>
	If all paperwork is acceptable and no objections have been raised by either the Research Director or Site Director, you may allow the personnel to pass the checkpoint.<br>
	STEP FOUR: If the test is on a Euclid level SCP or higher, or the research has a class D present with them, ensure they are escorted throughout the zone. If the test is on a Keter SCP, an officer should be present at the test as well.<br>
	When returning, all personnel and material must be searched again before transferring through the checkpoint.
	<hr>"}

/obj/item/paper/d_class_guide
	name = "D-CLASS ONLY"
	info = "D-1839 here with a memo to you all, found a way to make some 'homemade' tools with some spare rods and duct tape<br>\
	Just grab some duct tape and put it on a rod as a handle (make sure you do it to ONE ROD ONLY, moron), and you got a good base for a tool<br>\
	Slap a second rod on for some wirecutters, a piece of steel for a good crowbar, or a spoon or a fork for a shovel or a pickaxe<br>\
	Didn't use it when I escaped, but I betya if you use those wirecutters to file down the rod, or that crowbar to pry the rod open, you could make some screwdrivers and wrenches.<br>\
	<br>\
	Well I'm outta here, seeya on the other side"

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
