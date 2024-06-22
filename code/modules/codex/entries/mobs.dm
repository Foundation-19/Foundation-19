/datum/codex_entry/maint_drone
	display_name = "maintenance drone"
	associated_paths = list(/mob/living/silicon/robot/drone)
	entry_text = "Drones are player-controlled synthetics which are lawed to maintain their assigned vessel and not interfere with anyone else, except for other drones.<br>\
	They hold a wide array of tools to build, repair, maintain, and clean.<br>\
	Drones function similarly to other synthetics, in that they require recharging regularly, have laws, and are resilient to many hazards, such as fire, radiation, vacuum, and more.<br>\
	Ghosts can join the round as a maintenance drone by using the appropriate verb in the 'ghost' tab.<br>\
	An inactive drone can be rebooted by swiping an ID card on it with engineering or robotics access, and an active drone can be shut down in the same manner.<br>\
	Maintenance drone presence can be requested to specific areas from any maintenance drone control console.<br>\
	If a <l>cryptographic sequencer</l> is used on a drone, it will be reprogrammed and show full allegience to the subverter."

/datum/codex_entry/uncertified_module
	associated_paths = list(/obj/item/borg/upgrade/uncertified)
	entry_text = "This special chip will forcibly change a robot's module to a new one. In most cases, this is the only way for the robot to obtain these modules. Once you've unlocked the robot's maintenance hatch with an ID card and opened it with a crowbar, click the bot to install this chip."
