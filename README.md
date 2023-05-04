# Pretense User Manual

---
:warning: **The mission is not released yet and the manual is still work in progress**

---

## 1. The Battlefield

These are some general rules on how the mission functions.

### 1.1 Zones

Zones define points of interest that can be controlled by one of the coalitions.
They provide a staging point for friendly forces, and in some cases they generate resources to be used by the coalition.

They can build structures, deploy defenses, and launch AI missions against the enemy.

A coalition looses control of a zone once all of its structures are destroyed, and can be captured by an AI supply mission, or by players deploying a capture squad at them.

Zones function in a variaty of modes, that are set automatically by the game based on their distance from the frontline, and in some cases, the purpose of the zone.

Modes:
- Normal
    - zone functions at its full capacity using its resources to build structures, deploy/repair defenses, and launch AI missions
    - reserved for zones directly on the frontline where the action is happening
    
- Supply
    - zone functions like normal, except it no longer launches AI missions, except those that transfer resources to other zones
    - reserved for zones close to the frontline but not directly neighboring enemy zones
    - these zones focus on supplying the front, but are still somewhat defensive

- Export
    - zone will sell all defenses and focus on pushing resources towards the front
    - reserved for zones far from the frontline where not much action happens
    - zones will still attempt to build structures

- Override
    - these zones always function as if they were in Normal mode, regardless of where they are located
    - reserved for zones that hold SAM sites and Airfields

### 1.2 Resources

Zones use a resource called "supply" to either build structures, deploy defenses, resupply other zones or launch missions against the enemy.

There is a maximum ammount of supply that a zone can hold, any further deliveries are lost.

Everything a zone builds consumes supply, but each structure, defensive group, or AI mission has different costs.

Build time depends on the cost of whatever the zone is currently building, but is also occasionally influenced by the game to provide a limited pushback oportunity by either of the coalitions.

Zones that are below a certain treshold of resources will gain a "low supply" trait, which restricts what they can build, but also makes them more likely to get resupplied by other friendly zones.

### 1.3 Production

Production is handled automatically by the zone, and not under control of the players.

What a zone can build depends on a so called "tech tree". 
The root of this tree is a list of structures, each one, when built will unlock new build options for the zone.

There is no hard rules on what each building can do, but there are some general ones:

- Tents & Barracks
    - usually the first structure built(for free) once a zone is captured.
    - allows the zone to deploy infantry and armor to defend itself

- Fuel storage buildings
    - allow the zone to transfer resources to other zones in need

- Ammo storage buildings
    - allow the zone to launch ground based assault missions against enemy zones

- Command centers
    - allow the zone to deploy air defenses and launch aircraft in missions against enemy zones

Again, these rules are not set in stone and there are some exceptions if you look hard enough.

### 1.4 AI Mission types

- Supply 
    - Moves resources between two zones
    - Captures neutral zones
    - Supply convoys: slow, move on roads, will only supply connected zones
    - Supply helicopters: fast, will supply zones up to 2 connections away
- Patrol
    - Patrols the area around the frontline and engages enemy aircraft
- CAS
    - Engages enemy defenses at zones near the frontline
    - Two types: Fixed wing and Helicopters
- BAI
    - Engages enemy convoys
- Strike
    - Bombs enemy structures near the frontline
- SEAD
    - Engages air defenses at zones near the frontline
- AWACS
    - Orbits the airbase it is deployed at
    - Anounces frequency on takeoff
- Tanker
    - NOT IMPLEMENTED :warning:unfinished
- Assault
    - Ground convoy, move on roads, attack connected enemy zones
    - While inside an enemy zone, will trigger an explosion at a random enemy structure inside the zone
    - If the zone turns neutral, they will capture it and despawn

## 2. Logistics
This section covers only player logistics. For AI logistics see the supply AI mission in section 1.4

### 2.1 Supplies

Supplies can be transported by players between zones using transport aircraft.

Players can load as much supply as they want from any friendly zone, as long as the zone has resources to spare, and the players are confortable with flying with the added weight.

To load and unload supply you need to be stationary on the ground, within the limits of a friendly zone, and have at least one cargo door open on your aircraft.

Each unit of supply weighs 1kg.

Managing supplies onboard your aircraft is done using the `Other->Logistics->Load/Unload supplies` options in the radio menu. This is only available to aircraft that are allowed to carry supplies. A list of compatible aircraft is provided in [section 2.3](#23-compatible-aircraft)

Loading supplies removes them from the zone.
Unloading them adds them to the zone.

Dying or abandoning your aircraft with supplies on board will cause the supplies to be lost.

### 2.2 Infantry

Some aircraft are capable of deploying infantry squads with various roles to the battlefield. Every squad has a specific purpose, and once they accomplish their mission, can be extracted back to a friendly zone.

Managing squads onboard your aircraft is done using the `Other->Logistics->Infantry` options in the radio menu. This is only available to aircraft that are allowed to carry infantry. A list of compatible aircraft is provided in [section 2.3](#23-compatible-aircraft)

Loading a squad costs a certain amount of resources from the zone. This is dependant on the type of squad you are trying to load.
The zone will refuse your request if it is low on resources.

Only a single squad can be loaded at one time. Unloading a squad at the same zone its been loaded at will unload the squad and refund the resources to the zone.

Once a squad is deployed, it will take a certain amount of time until they complete their mission, after which they can be extracted to a friendly zone to recover some resources. 

Once they are ready to extract they will deploy blue smoke. If not extracted before a set time limit the squad will be lost.

Loading a squad that is ready to extract is done by landing near them and using the `Other->Logistics->Infantry->Extract squad` option from the radio menu.

Available infrantry squads:

| Squad | Description |
|:-----:|:------------|
|Capture| If deployed at a neutral zone, will capture the zone to their side |
|Sabotage| If deployed to an enemy zone, will trigger an explosion at a random structure within the zone, which in turn destroys a random ammount of resources as well in that zone |
|Ambush| Squad armed with rifles and RPGs that can be deployed anywhere on the battlefield. Can be used to intercept enemy convoys.|
|Engineers| If deployed at a friendly zone, they will boost production speed in that while reducing costs for anything built at the zone for a limited time.|
|MANPADS| Squad armed with rifles for self protection and MANPADS, that can be deployed anywhere on the battlefield. Can be used to provide some protection from enemy aircraft or intercept enemy supply helicopters|


Squad stats

| Squad | Weight | Supply cost | Mission duration | Extraction Time limit |
|:-----:|:------:|:-----------:|:----------------:|:---------------------:|
|Capture|700kg|200|1 minute|30 minutes*|
|Sabotage|800kg|500|5 minutes|30 minutes|
|Ambush|900kg|300|20 minutes|30 minutes|
|Engineers|200kg|1000|1 minute|30 minutes*|
|MANPADS|900kg|500|20 minutes|30 minutes|

>*Note that Capture and Engineer squads do not require extraction if they were deployed in accordance with their mission 

### 2.3 Compatible aircraft
By default the following aircraft can participate in logistics
| Aircraft | Can carry supplies | Can carry infantry |
|:---:|:---:|:---:|
|Mi-24P|Yes|Yes|
|Mi-8MT|Yes|Yes|
|UH-1H|Yes|Yes|
|SA342|No|Yes|

Although community mods are not available in the mission by default, the following mods are suported if you choose to add them.

| Aircraft | Can carry supplies | Can carry infantry |
|:---:|:---:|:---:|
|Hercules*|Yes|Yes|
|UH-60L|Yes|Yes|

>*Note that the Hercules cargo drop is not suported at this time, logistics can only be done using the radio menu

## 3. Missions

>Note: a lot of the functions related to missions use map markers(the little circle icon at the top of the map), and their text boxes for inputing commands. These are used due to limitations with the radio menu, specifically updating the text of the commands and identifying specific players that used these commands. A reminder on the commands can be accessed using the `Other->Missions->Help` option in the radio, or by creating a map marker anywhere and settings its text to `help`

These are assignments that can be taken by players and completed for an XP reward.

Missions are generated based on the state of the battlefield. Not all types of missions are available at all times.

### 3.1 The mission board

Currently available missions can be viewed on the `mission board` by accesing `Other->Missions->List Missions` in the radio menu or by creating a marker on the map and settings its text to `list`.

Each mission on the list has a short description, and most importantly a `4 digit code` that is unique to that mission. The next section will describe how to use this code to accept a mission.

Missions expire after a few minutes if not taken by anyone, or, if due to changes on the battlefield, they are no longer valid.

### 3.2 Accepting, joining and leaving a mission

Before being able to complete a mission you will need to accept it. This can only be done while landed and stationary at a friendly zone.

To accept a mission, create a marker anywhere on the map and set its text to `accept:code` where code will be your `4 digit code` as written on the mission board. *ex. accept:1234*

If the code was for a valid mission, this mission will now be assigned to you, and it will be removed from the mission board. The mission will now enter the `prepping` phase.

In this phase the mission has not started yet, and is only visible to you using the `Other->Missions->Active Mission` option in the radio, or by creating a marker on the map and settings its text to `active`.

You will notice that the `4 digit code` has been replaced by a new one.
This new code is only visible to you. If you so wish you can share it with a friend, who can use it to join you on your mission.

To do so he has to create a marker anywhere on the map and set its text to `join:code` where code will be the `4 digit code` that you shared with him. *ex. accept:1234*

Any number of players can join the same mission, and the displayed rewards will be awarded to every player individually, no splitting.

Missions can only be joined by players who are on the ground inside a friendly zone, and as long as all current members are still on the ground and the mission is still in the `prepping` phase.

Leaving a mission in progress can be done by, you guessed it, creating a marker anywhere on the map and settings its text to `leave`.

### 3.3 Starting and completing a mission

Once you have accepted a mission, and all your friends joined, you can start the mission by simply taking off.

Once any member of the mission takes off the mission will change into the `commencing` phase.
The mission can not be joined in this phase. This is a transitory state that lasts until all players have taken off. While still in this phase, the airborne players can still land to turn the mission back into the `prepping` phase, should you wish to add someone else to your mission.

Once every member has taken off the mission turns `active` and the objectives can now be completed.
These vary based on the mission you have accepted and can be checked by accessing your active mission details mentioned in [the section 3.2](#32-accepting-joining-and-leaving-a-mission).

Some missions require you to complete all objectives listed, some only require that you complete any one of them. This is specified in the mission description.

Some objectives are not meant to be completed, but will increase the final reward for the mission. In such cases theres always an additional objective that you can complete to finish the mission when you've had enough.

Some missions will provide guiding information for your objectives, be it bearing & distance, accurate coordinates, or just names of zones.

Some objectives can be completed by any of the players (ex. destroy X ammount of ground units), some
need to be completed at the same time by all players (ex. fly over a specific zone), and some can be accomplished faster if more players are doing the activity together (ex. helicopter recon).

Once the objectives are completed the missions is considered complete, and rewards are distributed to each player into their temporary accounts. Anything in the temporary account will be lost if the player dies or abandones their aircraft. To claim these rewards permanently, the player must land at a friendly zone.

### 3.4 Failed missions

Missions can also be failed if the objectives are deemed no longer possible to complete. In this case all members will get a message, and will be unassigned from the mission, the rewards lost. This can happen in any phase of the mission up until the mission is completed.

Any member who dies or abandones their aircraft will be unassigned from the mission and no longer able to join it, even after respawning.

### 3.5 Mission Types

:warning: unfinished section :warning:

## 4. Player XP and Ranks

You gain XP by completing missions, killing enemies and delivering resources.
After a certain ammount of XP you will rank up.

XP and ranks do not have a gameplay purpose at the moment. They are just theres for tracking your contributions to the mission and bragging rights.

## 5. Persistence
This mission comes with persistance, which allows the mission to remember its state when you exist the mission and continue from there once you start it up again.

To enable persistance you have to allow the mission environment inside DCS to read and write to and from your file system. To do this you will need to edit `\Scripts\MissionScripting.lua` inside your DCS or DCS server installation folder.

Change the following section:
```
do
    sanitizeModule('os')
    sanitizeModule('io')
    sanitizeModule('lfs')
    _G['require'] = nil
    _G['loadlib'] = nil
    _G['package'] = nil
end
```
To look like this:
```
do
    sanitizeModule('os')
    --sanitizeModule('io')
    --sanitizeModule('lfs')
    _G['require'] = nil
    _G['loadlib'] = nil
    _G['package'] = nil
end
```

**:warning:Be aware that by doing this you are allowing full access to your file system to scripts running within DCS. Only run missions you trust after doing this change.**

To reset progress and start the mission from the beginning you can delete the save file. 

This can be found in `C:\Users\<windows_username>\Saved Games\DCS.openbeta\Missions\Saves\`, and its called `pretense_<version>.js`

## 6. Running the mission on a server

### 6.1 Slotblock

For players to be prevented from spawning at enemy zones, the included `slotblock.lua` file must be placed in your servers `C:\Users\<windows_username>\Saved Games\DCS.openbeta\Scripts\Hooks` folder, and the server restarted, in case it was already running at the time.


### 6.2 Stats file

In addition to the save file the mission also writes to a file called `player_stats.js` in `C:\Users\<windows_username>\Saved Games\DCS.openbeta\Missions\Saves\`

This is a JSON file containing the information about the currently running mission, and is updated once per minute.

Information in the file includes players who have played the mission and their XP, what aircraft players are currently flying, and the name of the zones broken down into 3 lists for red, blue, and neutral coalitions.

You can use the information in this file to export a mission status to a discord server or to a website, or whatever other use you can come up with for it.