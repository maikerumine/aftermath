# API

## Register pathogens
```lua
pathogen.register_pathogen("pathogenia", {
  description = "An example disease",
  symptoms = 12,
  latent_period = 240,
  infection_period = 740,
  on_infect = function( infection )
    minetest.sound_play( "pathogen_cough", { pos = pos, gain = 0.3 } )
  end,
  on_symptom = function( infection )
    minetest.sound_play( "pathogen_cough", { pos = pos, gain = 0.3 } )
  end
  on_death = function( infection )
  end
})
```

## Pathogen definition
|key|type|description|
|---|----|-----------|
|symptom|number|the amount of times symptoms are shown|
|latent_period|number|seconds before the symptoms start showing|
|infection_period|number|seconds from infection till last symptom|
|on_infect( infection )|function|actions to perform when infected ( this happens as soon as the infection takes place )|
|on_symptom( infection )|function|happens as many times as the defined symptom amount|
|on_death( infection )|function|called when the player dies while having the pathogen|

### infection
All function in the pathogen definition give an infection table as callback.
The infection table includes.

|key|type|description|
|---|----|-----------|
|symptom|number|an integer that represents the index of current symptom|
|player|string|the name of the player|
|immune|bool|when true the infection has stopped. For now it does not mean that the player cant be reinfected|
|pathogen|string|the name of the pathogen|

# API Functions

```lua
-----------
--PATHOGENS
-----------

pathogen.register_pathogen = function( pathogen_name, definition )
  --checks if pathogen is registererd and registers if not
  ----

pathogen.get_pathogen = function( pathogen_name )
  --get the table of a particular pathogen
  ----

pathogen.get_pathogens = function()
  --gives all the pathogens that are registered
  ----

--------------
--CONTAMINENTS
--------------

pathogen.spawn_fluid = function( name, pos, pathogen_name )
  --spawn the infectious juices
  ----

pathogen.register_fluid = function( name )
  --registering a fluid(juice). This assumes that all fluids are flat on the
  --floor
  ------

pathogen.contaminate = function( pos, pathogen_name )
  --contaminates a node which when dug infects the player that dug the node
  ----

pathogen.decontaminate = function( pos )
  --remove the contamination from the node
  ----

pathogen.get_contaminant = function( pos )
  --used to check if the node is infected and to get the name of the pathogen
  --with which it is infected
  ------
------------
--INFECTIONS
------------
pathogen.infect = function( _pathogen, player_name )
  --infects the player with a pathogen. If not able returns false
  ----
    --return false if pathogen does not exist or player is immune
    --consider making an is_immune function
    ----
    --The table containing all the data that a infection cinsists out of. See
    --the README.md for a more extensive explanation
    -----

    --store the infection in a table for later use. This table is also saved and
    --loaded if the persistent option is set
    ------
    --check if on_infect has been registered in pathogen
    ----
    --perform the on_infect command that is defined in the regsiter function
    --this is not the same as the on_symptoms. It is called only once at the
    --beginning of the infection
    --------
    --latent perios is the time till the first symptom shows
    ----
      --show the first symptom
      ----

pathogen.perform_symptom = function( infection, symptom )
  --An infection can also be initiated without having to perform the on_infect.
  --you can can cut straight to a particular symptom by using this function
  --notice the symptom_n argument. This is a number that determines the state of
  --the infection.
  --
  --only keep showing symptoms if there is no immunity against the pathogen
  ----
    --only show symptoms if not all symptoms have occured.
    ----
      --set the time till the next symptom and then perfrom it again
    ----
    --survives and is now immunized, immunization lasts till the server is
    --restarted

pathogen.immunize = function( infection )
  --immunize a player so the next symptom won't show. It also disables the
  --abilty to reinfect the player. Use pathogen.disinfect to also remove
  --the immunization It will also trigger the on_cured when the next symptom
  --would have triggered.
  ----
    --do not immunize if alread y immunized, return false
    --else immunize the player and return true

pathogen.disinfect = function( infection )
  --removes the immunization and the infection all together
  ----
    --only is the is infected does it do this, return true
    -- else it will only return false

pathogen.get_infection = function( player_name,  pathogen_name )
  --get an infection of a certain player
  ----
    --only if the infection is registered
    --otherwise return nil

pathogen.get_infections = function( )
  --gives all the infections of all the players. If not infections are defined
  --it returns an empty table. That's it.

pathogen.get_player_infections = function( player_name )
  --helper function for getting the infections of a certain player
  ----
    --gets and loops through the infections
    ----
      --and adds the infection to the output of matches the player_name

-------------
--PERSISTENCE
-------------

pathogen.save = function( )
  --TODO save the infections so it won"t get lost between server reloads

pathogen.load = function( )
  --TODO reinfect the players when they rejoin the server. it remembers the
  --infection fase thus the infection continues and does not get reset.

---------
--HELPERS
---------

pathogen.get_players_in_radius = function( pos, radius )
  --helper to get players within the radius.
  ----
    --loops threw all objects in within a radius
    ----
      --and check if the object is a player

pathogen.on_dieplayer = function( player )
  --when dying while having a pathogen it will trigger the on_death of the
  --pathogen and it will remove all player infections
  ----
    --loops through the player infections
    ----
      --checks if it is a valid and still registered pathogen
      ----
        --it then triggers the on_death if the on_death is defined

pathogen.on_dignode = function( pos, digger )
  --infects players that dig a node that is infected with a pathogen
  ----
```

