# CONTRIBUTING

1. [Reporting Issues](#reporting-issues)
2. [Introduction](#introduction)
3. [Getting Started](#getting-started)
4. [Meet the Team](#meet-the-team)
	1. [Headcoder](#headcoder)
	2. [Maintainers](#maintainers)
	3. [Issue Managers](#issue-managers)
5. [Specifications](#specifications)
6. [Pull Request Process](#pull-request-process)
7. [Porting features/sprites/sounds/tools from other codebases](#porting-featuresspritessoundstools-from-other-codebases)
8. [Banned content](#banned-content)
9. [A word on Git](#a-word-on-git)

## Reporting Issues
If you ever encounter a bug in-game, the best way to let a coder know about it is with our [GitHub Issue Tracker](https://github.com/Foundation-19/Foundation-19/issues). Please make sure you use the supplied issue template, and include the round ID for the server.

(If you don't have an account, making a new one takes only one minute.)

If you have difficulty, ask for help in the #coding-general channel on our discord.

## Introduction

Hello and welcome to Foundation 19's contributing page. You are here because you are curious or interested in contributing - thank you! Everyone is free to contribute to this project as long as they follow the simple guidelines and specifications below; at Foundation 19, we strive to maintain code stability and maintainability, and to do that, we need all pull requests to hold up to those specifications. It's in everyone's best interests - including yours! - if the same bug doesn't have to be fixed twice because of duplicated code.

First things first, we want to make it clear how you can contribute (if you've never contributed before), as well as the kinds of powers the team has over your additions, to avoid any unpleasant surprises if your pull request is closed for a reason you didn't foresee.

## Getting Started

Foundation 19 doesn't have a list of goals and features to add; we instead allow freedom for contributors to suggest and create their ideas for the game. That doesn't mean we aren't determined to squash bugs, which unfortunately pop up a lot due to the deep complexity of the game. Here are some useful starting guides, if you want to contribute or if you want to know what challenges you can tackle with zero knowledge about the game's code structure.

If you want to contribute the first thing you'll need to do is [set up Git](http://tgstation13.org/wiki/Setting_up_git) so you can download the source code.

We have a [list of guides on the wiki](https://wiki.tegu.cupcore.net/view/Guides#Development_and_Contribution_Guides) that will help you get started contributing to Foundation 19 with Git and Dream Maker. For beginners, it is recommended you work on small projects like bugfixes at first. If you need help learning to program in BYOND, check out this [repository of resources](http://www.byond.com/developer/articles/resources).

There is an open list of approachable issues for [your inspiration here](https://github.com/Foundation-19/Foundation-19/issues?q=is%3Aopen+is%3Aissue+label%3A%22Good+First+Issue%22).

You can of course, as always, ask for help on the Discord channels or the forums. We're just here to have fun and help out, so please don't expect professional support.

## Meet the Team

### Headcoder

The Headcoder is responsible for controlling, adding, and removing maintainers from the project. In addition to filling the role of a normal maintainer, they have sole authority on who becomes a maintainer, as well as who remains a maintainer and who does not.

### Maintainers

Maintainers are quality control. If a proposed pull request doesn't meet the following specifications, they can request you to change it, or simply just close the pull request. Maintainers are required to give a reason for closing the pull request.

Maintainers can revert your changes if they feel they are not worth maintaining or if they did not live up to the quality specifications.

<details>
<summary>Maintainer Guidelines</summary>

These are the few directives we have for project maintainers.

- Do not merge PRs you create, unless it is a follow-up fix to the previous one.
- Do not merge PRs until 24 hours have passed since it was opened. Exceptions include:
  - Emergency or follow-up fixes.
    - Try to get secondary maintainer approval before merging if you are able to.
  - Under explicit permission from Head Coder.
- Do not merge PRs that contain content from the [banned content list](./CONTRIBUTING.md#banned-content).

These are not steadfast rules as maintainers are expected to use their best judgement when operating.
</details>

### Developers

Essentially experienced contributors and/or people that strive to become Maintainers. Their primary task on repository is helping other contributors and setting up the labels on Pull Requests and Issues.

Our team is entirely voluntary, as such we extend our thanks to maintainers, developers, and contributors alike for helping keep the project alive.


## Specifications

As mentioned before, you are expected to follow these specifications in order to make everyone's lives easier. It'll save both your time and ours, by making sure you don't have to make any changes and we don't have to ask you to. Thank you for reading this section!

### Object Oriented Code
As BYOND's Dream Maker (henceforth "DM") is an object-oriented language, code must be object-oriented when possible in order to be more flexible when adding content to it. If you don't know what "object-oriented" means, we highly recommend you do some light research to grasp the basics.

### All BYOND paths must contain the full path
(i.e. absolute pathing)

DM will allow you nest almost any type keyword into a block, such as:

```DM
// Not our style!
datum
	datum1
		var
			varname1 = 1
			varname2
			static
				varname3
				varname4
		proc
			proc1()
				code
			proc2()
				code

		datum2
			varname1 = 0
			proc
				proc3()
					code
			proc2()
				. = ..()
				code
```

The use of this is not allowed in this project as it makes finding definitions via full text searching next to impossible. The only exception is the variables of an object may be nested to the object, but must not nest further.

The previous code made compliant:

```DM
// Matches Tegu Station style.
/datum/datum_1
	var/var_name_1
	var/var_name_2
	var/static/var_name_3
	var/static/var_name_4

/datum/datum1/proc/Proc1()
	code

/datum/datum1/proc/Proc2()
	code

/datum/datum1/datum2
	var_name_1 = 0

/datum/datum1/datum2/proc/Proc3()
	code

/datum/datum1/datum2/Proc2()
	. = ..()
	code
```

### All `Process` procs need to make use of delta-time and be frame independent

In a lot of our older code, `Process()` is frame dependent. Here's some example mob code:

```DM
/mob/testmob
	var/health = 100
	var/health_loss = 4 //We want to lose 2 health per second, so 4 per SSmobs process

/mob/testmob/Process(delta_time) //SSmobs runs once every 2 seconds
	health -= health_loss
```

As the mobs subsystem runs once every 2 seconds, the mob now loses 4 health every process, or 2 health per second. This is called frame dependent programming.

Why is this an issue? If someone decides to make it so the mobs subsystem processes once every second (2 times as fast), your effects in process() will also be two times as fast. Resulting in 4 health loss per second rather than 2.

How do we solve this? By using delta-time. Delta-time is the amount of seconds you would theoretically have between 2 process() calls. In the case of the mobs subsystem, this would be 2 (As there is 2 seconds between every call in `process()`). Here is a new example using delta-time:

```DM
/mob/testmob
	var/health = 100
	var/health_loss = 2 //Health loss every second

/mob/testmob/process(delta_time) //SSmobs runs once every 2 seconds
	health -= health_loss * delta_time
```

In the above example, we made our health_loss variable a per second value rather than per process. In the actual process() proc we then make use of deltatime. Because SSmobs runs once every  2 seconds. Delta_time would have a value of 2. This means that by doing health_loss * delta_time, you end up with the correct amount of health_loss per process, but if for some reason the SSmobs subsystem gets changed to be faster or slower in a PR, your health_loss variable will work the same.

For example, if SSmobs is set to run once every 4 seconds, it would call process once every 4 seconds and multiply your health_loss var by 4 before subtracting it. Ensuring that your code is frame independent.

### No overriding type safety checks
The use of the : operator to override type safety checks is not allowed. You must cast the variable to the proper type.

### Type paths must begin with a `/`
eg: `/datum/thing`, not `datum/thing`

### Type paths must be snake case
eg: `/datum/blue_bird`, not `/datum/BLUEBIRD` or `/datum/BlueBird` or `/datum/Bluebird` or `/datum/blueBird`

### Datum type paths must begin with "datum"
In DM, this is optional, but omitting it makes finding definitions harder.

### Do not use text/string based type paths
It is rarely allowed to put type paths in a text format, as there are no compile errors if the type path no longer exists. Here is an example:

```DM
//Good
var/path_type = /obj/item/baseball_bat

//Bad
var/path_type = "/obj/item/baseball_bat"
```

### Use `var/name` format when declaring variables
While DM allows other ways of declaring variables, this one should be used for consistency.

### Variables paths must be snake case
Same as above for type paths: `var/health_loss`, not `var/HealthLoss` or `var/healthLoss`

### Procs(Functions) must be in CamelCase
eg: `/mob/proc/StartAbility()`, not `mob/proc/start_ability()`

### Tabs, not spaces
You must use tabs to indent your code, NOT SPACES.

You may use spaces to align something, but you should tab to the block level first, then add the remaining spaces.

### No hacky code
Hacky code, such as adding specific checks, is highly discouraged and only allowed when there is ***no*** other option. (Protip: "I couldn't immediately think of a proper way so thus there must be no other option" is not gonna cut it here! If you can't think of anything else, say that outright and admit that you need help with it. Maintainers and Developers exist for exactly that reason.)

You can avoid hacky code by using object-oriented methodologies, such as overriding a function (called "procs" in DM) or sectioning code into functions and then overriding them as required.

### No duplicated code
Copying code from one place to another may be suitable for small, short-time projects, but Foundation 19 is a long-term project and highly discourages this.

Instead you can use object orientation, or simply placing repeated code in a function, to obey this specification easily.

### Startup/Runtime tradeoffs with lists and the "hidden" init proc
First, read the comments in [this BYOND thread](http://www.byond.com/forum/?post=2086980&page=2#comment19776775), starting where the link takes you.

There are two key points here:

1) Defining a list in the variable's definition calls a hidden proc - init. If you have to define a list at startup, do so in New() (or preferably Initialize()) and avoid the overhead of a second call (Init() and then New())

2) It also consumes more memory to the point where the list is actually required, even if the object in question may never use it!

Remember: although this tradeoff makes sense in many cases, it doesn't cover them all. Think carefully about your addition before deciding if you need to use it.

### Prefer `Initialize()` over `New()` for atoms
Our game controller is pretty good at handling long operations and lag, but it can't control what happens when the map is loaded, which calls `New` for all atoms on the map. If you're creating a new atom, use the `Initialize` proc to do what you would normally do in `New`. This cuts down on the number of proc calls needed when the world is loaded.
While we normally encourage (and in some cases, even require) bringing out of date code up to date when you make unrelated changes near the out of date code, that is not the case for `New` -> `Initialize` conversions. These systems are generally more dependant on parent and children procs so unrelated random conversions of existing things can cause bugs that take months to figure out.

### No magic numbers or strings
This means stuff like having a "mode" variable for an object set to "1" or "2" with no clear indicator of what that means. Make these #defines with a name that more clearly states what it's for. For instance:
````DM
/datum/proc/do_the_thing(thing_to_do)
	switch(thing_to_do)
		if(1)
			(...)
		if(2)
			(...)
````
There's no indication of what "1" and "2" mean! Instead, you'd do something like this:
````DM
#define DO_THE_THING_REALLY_HARD 1
#define DO_THE_THING_EFFICIENTLY 2
/datum/proc/do_the_thing(thing_to_do)
	switch(thing_to_do)
		if(DO_THE_THING_REALLY_HARD)
			(...)
		if(DO_THE_THING_EFFICIENTLY)
			(...)
````
This is clearer and enhances readability of your code! Get used to doing it!

### Control statements
(if, while, for, etc)

* No control statement may contain code on the same line as the statement (`if (blah) return`)
* All control statements comparing a variable to a number should use the formula of `thing` `operator` `number`, not the reverse (eg: `if (count <= 10)` not `if (10 >= count)`)

### Spaces after control statements
DO NOT put spaces after control statements:
This is bad:
````DM
	if (thing1 != thing2)
		return
````
This is good:
````DM
	if(thing1 != thing2)
		return
````

### Use early return
Do not enclose a proc in an if-block when returning on a condition is more feasible
This is bad:
````DM
/datum/datum1/proc/Proc1()
	if(thing_1)
		if(!thing_2)
			if(thing_3 == 30)
				do stuff
````
This is good:
````DM
/datum/datum1/proc/Proc1()
	if(!thing_1)
		return
	if(thing_2)
		return
	if(thing_3 != 30)
		return
	do stuff
````
This prevents nesting levels from getting deeper then they need to be.

### Use our time defines

The codebase contains some defines which will automatically multiply a number by the correct amount to get a number in deciseconds. Using these is preffered over using a literal amount in deciseconds.

The defines are as follows:
* SECONDS
* MINUTES
* HOURS

This is bad:
````DM
/datum/datum1/proc/Proc1()
	if(do_after(mob, 15))
		mob.DoThing()
````

This is good:
````DM
/datum/datum1/proc/Proc1()
	if(do_after(mob, 1.5 SECONDS))
		mob.DoThing()
````

### Getters and setters

* Avoid getter procs. They are useful tools in languages with that properly enforce variable privacy and encapsulation, but DM is not one of them. The upfront cost in proc overhead is met with no benefits, and it may tempt to develop worse code.

This is bad:
```DM
/datum/datum1/proc/SimpleGetter()
	return gotten_variable
```
Prefer to either access the variable directly or use a macro/define.


* Make usage of variables or traits, set up through condition setters, for a more maintainable alternative to compex and redefined getters.

These are bad:
```DM
/datum/datum1/proc/ComplexGetter()
	return condition ? VALUE_A : VALUE_B

/datum/datum1/child_datum/ComplexGetter()
	return condition ? VALUE_C : VALUE_D
```

This is good:
```DM
/datum/datum1
	var/getter_turned_into_variable

/datum/datum1/proc/SetCondition(new_value)
	if(condition == new_value)
		return
	condition = new_value
	OnConditionChange()

/datum/datum1/proc/OnConditionChange()
	getter_turned_into_variable = condition ? VALUE_A : VALUE_B

/datum/datum1/child_datum/OnConditionChange()
	getter_turned_into_variable = condition ? VALUE_C : VALUE_D
```

### Develop Secure Code

* Player input must always be escaped safely, we recommend you use stripped_input in all cases where you would use input. Essentially, just always treat input from players as inherently malicious and design with that use case in mind

* Calls to the database must be escaped properly - use sanitizeSQL to escape text based database entries from players or admins, and isnum() for number based database entries from players or admins.

* All calls to topics must be checked for correctness. Topic href calls can be easily faked by clients, so you should ensure that the call is valid for the state the item is in. Do not rely on the UI code to provide only valid topic calls, because it won't.

* Information that players could use to metagame (that is, to identify round information and/or antagonist type via information that would not be available to them in character) should be kept as administrator only.

* It is recommended as well you do not expose information about the players - even something as simple as the number of people who have readied up at the start of the round can and has been used to try to identify the round type.

* Where you have code that can cause large-scale modification and *FUN*, make sure you start it out locked behind one of the default admin roles - use common sense to determine which role fits the level of damage a function could do.

### Files
* Because runtime errors do not give the full path, try to avoid having files with the same name across folders.

* File names should not be mixed case, or contain spaces or any character that would require escaping in a uri.

* Files and path accessed and referenced by code above simply being #included should be strictly lowercase to avoid issues on filesystems where case matters.

### SQL
* Do not use the shorthand sql insert format (where no column names are specified) because it unnecessarily breaks all queries on minor column changes and prevents using these tables for tracking outside related info such as in a connected site/forum.

* All changes to the database's layout(schema) must be specified in the database changelog in SQL, as well as reflected in the schema files

* Any time the schema is changed the `schema_revision` table and `DB_MAJOR_VERSION` or `DB_MINOR_VERSION` defines must be incremented.

* Queries must never specify the database, be it in code, or in text files in the repo.

* Primary keys are inherently immutable and you must never do anything to change the primary key of a row or entity. This includes preserving auto increment numbers of rows when copying data to a table in a conversion script. No amount of bitching about gaps in ids or out of order ids will save you from this policy.

* The ttl for data from the database is 10 seconds. You must have a compelling reason to store and reuse data for longer then this.

* Do not write stored and transformed data to the database, instead, apply the transformation to the data in the database directly.
	* ie: SELECTing a number from the database, doubling it, then updating the database with the doubled number. If the data in the database changed between step 1 and 3, you'll get an incorrect result. Instead, directly double it in the update query. `UPDATE table SET num = num*2` instead of `UPDATE table SET num = [num]`.
	* if the transformation is user provided (such as allowing a user to edit a string), you should confirm the value being updated did not change in the database in the intervening time before writing the new user provided data by checking the old value with the current value in the database, and if it has changed, allow the user to decide what to do next.

### Mapping Standards
* Adding, Removing, or Replacing Station Maps
	* All pull requests adding, removing, or replacing station maps must receive prior approval from a maptainer, or they will be closed without additional warning.

* TGM Format & Map Merge
	* All new maps submitted to the repo through a pull request must be in TGM format (unless there is a valid reason present to have it in the default BYOND format). This is done using the [Map Merge](https://tgstation13.org/wiki/Map_Merger) utility included in the repo to convert the file to TGM format.
	* Likewise, you MUST run Map Merge prior to opening your PR when updating existing maps to minimize the change differences (even when using third party mapping programs such as FastDMM.)
		* Failure to run Map Merge on a map after using third party mapping programs (such as FastDMM) greatly increases the risk of the map's key dictionary becoming corrupted by future edits after running map merge. Resolving the corruption issue involves rebuilding the map's key dictionary; id est rewriting all the keys contained within the map by reconverting it from BYOND to TGM format - which creates very large differences that ultimately delay the PR process and is extremely likely to cause merge conflicts with other pull requests.

* Variable Editing (Var-edits)
	* While var-editing an item within the editor is perfectly fine, it is preferred that when you are changing the base behavior of an item (how it functions) that you make a new subtype of that item within the code, especially if you plan to use the item in multiple locations on the same map, or across multiple maps. This makes it easier to make corrections as needed to all instances of the item at one time as opposed to having to find each instance of it and change them all individually.
		* Subtypes only intended to be used on away mission or ruin maps should be contained within a .dm file with a name corresponding to that map within `code\modules\awaymissions` or `code\modules\ruins` respectively. This is so in the event that the map is removed, that subtype will be removed at the same time as well to minimize leftover/unused data within the repo.
	* Please attempt to clean out any dirty variables that may be contained within items you alter through var-editing. For example, due to how DM functions, changing the `pixel_x` variable from 23 to 0 will leave a dirty record in the map's code of `pixel_x = 0`. Likewise this can happen when changing an item's icon to something else and then back. This can lead to some issues where an item's icon has changed within the code, but becomes broken on the map due to it still attempting to use the old entry.
	* Areas should not be var-edited on a map to change it's name or attributes. All areas of a single type and it's altered instances are considered the same area within the code, and editing their variables on a map can lead to issues with powernets and event subsystems which are difficult to debug.

### Signal Handlers
All procs that are registered to listen for signals using `RegisterSignal()` must contain at the start of the proc `SIGNAL_HANDLER` eg;
```
/type/path/proc/SignalCallback()
	SIGNAL_HANDLER
	// rest of the code
```
This is to ensure that it is clear the proc handles signals and turns on a lint to ensure it does not sleep.

There exists `SIGNAL_HANDLER_DOES_SLEEP`, but this is only for legacy signal handlers that still sleep, new/changed code should not use this.

### Enforcing parent calling
When adding new signals to root level procs, eg;
```
/atom/proc/SetDir(newdir)
	SHOULD_CALL_PARENT(TRUE)
	SEND_SIGNAL(src, COMSIG_ATOM_DIR_CHANGE, dir, newdir)
	dir = newdir
```
The `SHOULD_CALL_PARENT(TRUE)` lint should be added to ensure that overrides/child procs call the parent chain and ensure the signal is sent.

### Other Notes
* Code should be modular where possible; if you are working on a new addition, then strongly consider putting it in its own file unless it makes sense to put it with similar ones (i.e. a new tool would go in the "tools.dm" file)

* Bloated code may be necessary to add a certain feature, which means there has to be a judgement over whether the feature is worth having or not. You can help make this decision easier by making sure your code is modular.

* You are expected to help maintain the code that you add, meaning that if there is a problem then you are likely to be approached in order to fix any issues, runtimes, or bugs.

* Do not divide when you can easily convert it to multiplication. (ie `4/2` should be done as `4*0.5`)

* If you used regex to replace code during development of your code, post the regex in your PR for the benefit of future developers and downstream users.

* Changes to the `/config` tree must be made in a way that allows for updating server deployments while preserving previous behaviour. This is due to the fact that the config tree is to be considered owned by the user and not necessarily updated alongside the remainder of the code. The code to preserve previous behaviour may be removed at some point in the future given the OK by maintainers.

#### Enforced not enforced
The following coding styles are not only not enforced at all, but are generally frowned upon to change for little to no reason:

* English/British spelling on var/proc names
	* Color/Colour - both are fine, but keep in mind that BYOND uses `color` as a base variable

### Operators
#### Spacing
(this is not strictly enforced, but more a guideline for readability's sake)

* Operators that should be separated by spaces
	* Boolean and logic operators like &&, || <, >, ==, etc (but not !)
	* Bitwise AND &
	* Argument separator operators like , (and ; when used in a forloop)
	* Assignment operators like = or += or the like
* Operators that should not be separated by spaces
	* Bitwise OR |
	* Access operators like . and :
	* Parentheses ()
	* logical not !

Math operators like +, -, /, *, etc are up in the air, just choose which version looks more readable.

#### Use
* Bitwise AND - '&'
	* Should be written as `variable & CONSTANT` NEVER `CONSTANT & variable`. Both are valid, but the latter is confusing and nonstandard.
* Associated lists declarations must have their key value quoted if it's a string
	* WRONG: `list(a = "b")`
	* RIGHT: `list("a" = "b")`

### Dream Maker Quirks/Tricks
Like all languages, Dream Maker has its quirks, some of them are beneficial to us, like these

#### In-To for-loops
`for(var/i = 1, i <= some_value, i++)` is a fairly standard way to write an incremental for loop in most languages (especially those in the C family), but DM's `for(var/i in 1 to some_value)` syntax is oddly faster than its implementation of the former syntax; where possible, it's advised to use DM's syntax. (Note, the `to` keyword is inclusive, so it automatically defaults to replacing `<=`; if you want `<` then you should write it as `1 to some_value-1`).

HOWEVER, if either `some_value` or `i` changes within the body of the for (underneath the `for(...)` header) or if you are looping over a list AND changing the length of the list then you can NOT use this type of for-loop!

#### `for(var/A in list)` versus `for(var/i in 1 to list.len)`
The former is faster than the latter, as shown by the following profile results:
https://file.house/zy7H.png
Code used for the test in a readable format:
https://pastebin.com/w50uERkG


#### For loops without `istype`
A name for a differing syntax for writing for-each style loops in DM. It's NOT DM's standard syntax, hence why this is considered a quirk. Take a look at this:
```DM
var/list/bag_of_items = list(sword, apple, coinpouch, sword, sword)
var/obj/item/sword/best_sword
for(var/obj/item/sword/S in bag_of_items)
	if(!best_sword || S.damage > best_sword.damage)
		best_sword = S
```
The above is a simple proc for checking all swords in a container and returning the one with the highest damage, and it uses DM's standard syntax for a for-loop by specifying a type in the variable of the for's header that DM interprets as a type to filter by. It performs this filter using `istype()` (or some internal-magic similar to `istype()` - this is BYOND, after all). This is fine in its current state for `bag_of_items`, but if `bag_of_items` contained ONLY swords, or only SUBTYPES of swords, then the above is inefficient. For example:
```DM
var/list/bag_of_swords = list(sword, sword, sword, sword)
var/obj/item/sword/best_sword
for(var/obj/item/sword/S in bag_of_swords)
	if(!best_sword || S.damage > best_sword.damage)
		best_sword = S
```
specifies a type for DM to filter by.

With the previous example that's perfectly fine, we only want swords, but here the bag only contains swords? Is DM still going to try to filter because we gave it a type to filter by? YES, and here comes the inefficiency. Wherever a list (or other container, such as an atom (in which case you're technically accessing their special contents list, but that's irrelevant)) contains datums of the same datatype or subtypes of the datatype you require for your loop's body,
you can circumvent DM's filtering and automatic `istype()` checks by writing the loop as such:
```DM
var/list/bag_of_swords = list(sword, sword, sword, sword)
var/obj/item/sword/best_sword
for(var/s in bag_of_swords)
	var/obj/item/sword/S = s
	if(!best_sword || S.damage > best_sword.damage)
		best_sword = S
```
Of course, if the list contains data of a mixed type then the above optimisation is DANGEROUS, as it will blindly typecast all data in the list as the specified type, even if it isn't really that type, causing runtime errors.

#### Dot variable
Like other languages in the C family, DM has a `.` or "Dot" operator, used for accessing variables/members/functions of an object instance.
eg:
```DM
var/mob/living/carbon/human/H = YOU_THE_READER
H.gib()
```
However, DM also has a dot variable, accessed just as `.` on its own, defaulting to a value of null. Now, what's special about the dot operator is that it is automatically returned (as in the `return` statement) at the end of a proc, provided the proc does not already manually return (`return count` for example.) Why is this special?

With `.` being everpresent in every proc, can we use it as a temporary variable? Of course we can! However, the `.` operator cannot replace a typecasted variable - it can hold data any other var in DM can, it just can't be accessed as one, although the `.` operator is compatible with a few operators that look weird but work perfectly fine, such as: `.++` for incrementing `.'s` value, or `.[1]` for accessing the first element of `.`, provided that it's a list.

### Globals versus static

DM has a var keyword, called global. This var keyword is for vars inside of types. For instance:

```DM
/mob
	var/global/thing = TRUE
```
This does NOT mean that you can access it everywhere like a global var. Instead, it means that that var will only exist once for all instances of its type, in this case that var will only exist once for all mobs - it's shared across everything in its type. (Much more like the keyword `static` in other languages like PHP/C++/C#/Java)

Isn't that confusing?

There is also an undocumented keyword called `static` that has the same behaviour as global but more correctly describes BYOND's behaviour. Therefore, we always use static instead of global where we need it, as it reduces suprise when reading BYOND code.

## Pull Request Process

There is no strict process when it comes to merging pull requests. Pull requests will sometimes take a while before they are looked at by a maintainer; the bigger the change, the more time it will take before they are accepted into the code. Every team member is a volunteer who is giving up their own time to help maintain and contribute, so please be courteous and respectful. Here are some helpful ways to make it easier for you and for the maintainers when making a pull request.

* Make sure your pull request complies to the requirements outlined here

* You are expected to have tested your pull requests if it is anything that would warrant testing. Text only changes, single number balance changes, and similar generally don't need testing, but anything else does. This means by extension web edits are disallowed for larger changes.

* You are going to be expected to document all your changes in the pull request. Failing to do so will mean delaying it as we will have to question why you made the change. On the other hand, you can speed up the process by making the pull request readable and easy to understand, with diagrams or before/after data. Should you be optimizing a routine you must provide proof by way of profiling that your changes are faster.

* We ask that you use the changelog system to document your player facing changes, which prevents our players from being caught unaware by said changes - you can find more information about this [on this wiki page](http://tgstation13.org/wiki/Guide_to_Changelogs).

* If you are proposing multiple changes, which change many different aspects of the code, you are expected to section them off into different pull requests in order to make it easier to review them and to deny/accept the changes that are deemed acceptable.

* If your pull request is accepted, the code you add no longer belongs exclusively to you but to everyone; everyone is free to work on it, but you are also free to support or object to any changes being made, which will likely hold more weight, as you're the one who added the feature. It is a shame this has to be explicitly said, but there have been cases where this would've saved some trouble.

* Please explain why you are submitting the pull request, and how you think your change will be beneficial to the game. Failure to do so will be grounds for rejecting the PR.

* If your pull request is not finished, you may open it as a draft for potential review. If you open it as a full-fledged PR make sure it is at least testable in a live environment. Pull requests that do not at least meet this requirement will be closed. You may request a maintainer reopen the pull request when you're ready, or make a new one.

* While we have no issue helping contributors (and especially new contributors) bring reasonably sized contributions up to standards via the pull request review process, larger contributions are expected to pass a higher bar of completeness and code quality *before* you open a pull request. Maintainers may close such pull requests that are deemed to be substantially flawed. You should take some time to discuss with maintainers or other contributors on how to improve the changes.

* After leaving reviews on an open pull request, maintainers may convert it to a draft. Once you have addressed all their comments to the best of your ability, feel free to mark the pull as `Ready for Review` again.

* After you consider your pull request to be ready - make sure to squash commits and ask a Maintainer to review it for approval or additionaly requests.

## Porting features/sprites/sounds/tools from other codebases

If you are porting features/tools from other codebases, you must give them credit where it's due. Typically, crediting them in your pull request and the changelog is the recommended way of doing it. Ideally you should link the original PR, if it is applicable. Take note of what license they use though, porting stuff from AGPLv3 and GPLv3 codebases is allowed.

Regarding sprites & sounds, you must credit the artist and possibly the codebase. All Foundation 19 assets including icons and sound are under a [Creative Commons 3.0 BY-SA license](https://creativecommons.org/licenses/by-sa/3.0/) unless otherwise indicated.

## Banned content
Do not add any of the following in a Pull Request or risk getting the PR closed:
* Any references to real-life political scenarios/equipment/figures: This includes things like content related to National Socialist Party of Germany, Union of Soviet Socialist Republics, United States of America, content related to currently relevant events, celebrities, political figures and so on.
* Code where one line of code is split across mutiple lines (except for multiple, separate strings and comments; in those cases, existing longer lines must not be split up)
* Code adding, removing, or updating the availability of alien races/species/human mutants without prior approval from relevant Species Maintainer and Head Coder. Pull requests attempting to add or remove features from said races/species/mutants require prior approval as well.
* Code which violates GitHub's [terms of service](https://github.com/site/terms).

Just because something isn't on this list doesn't mean that it's acceptable. Use common sense above all else.

## A word on Git
This repository uses `LF` line endings for all code as specified in the **.gitattributes** and **.editorconfig** files.

Unless overridden or a non standard git binary is used the line ending settings should be applied to your clone automatically.

Note: VSC requires an [extension](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) to take advantage of editorconfig.
