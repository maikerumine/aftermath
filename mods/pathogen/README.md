# PATHOGEN

A minetest mod that enables users to get a pathogen.

# Features

- Easily define a new pathogen using the pathogen API
- Demo pathogens that are infectious and sometimes deadly.

# Diseases

## Gravititus
Occurs when ascending too quickly. Symptons include hiccups and random sense of
gravity. There is no known cure yet. ( any suggestions? stone soup anyone? )

## Influencia
Highly contagious as it is airborne. Being around someone that has the diseases
increases the chances of getting the virus drastically. It is advised to eat well
and keep your distance from players that are coughing. Death is very unlikely.

## Panola
Contagious through body fluids. It is ok to be near someone that has the disease.
Make sure that when cleaning up after someone that has expelled fluids, to
decontaminate the fluids first. This can be done with the Decontaminator
![Decontaminator](pathogen/textures/pathogen_decontaminator.png).

## Gosirea
Symptons include gas and burps. Occasionaly a shard.
Carrier contaminates nearby surfaces when symptoms show. These can intern infect
players that dig the infected nodes. Not deadly for those that have good health.

# Items
- Comes with nodes like vomit, blood and feces that are infectious when dug.
- A bio hazard warning fence, in case a quarantine is required.
- A decontaminater for removing infectious fluids.

# Crafts

```lua
pathogen.recipes['xpanes:fence_warning'] =  {
  {'group:stick', 'wool:red', 'group:stick'},
  {'group:stick', 'wool:red', 'group:stick'},
  {'group:stick', 'wool:red', 'group:stick'}
}

pathogen.recipes['pathogen:decontaminator'] = {
  {'xpanes:bar','',''},
  {'','default:steelblock',''},
  {'','',''}
}
```

# Commands

Infections can be initiated by using commands. It requires the "pathogen"
privilege. /grant <playername> pathogen.

```lua

/pathogens
--list all pathogens and their descriptions

/infect <player name> <pathogen name>
--infect the player

/immunize <player name> <pathogen name>
--make player immune to particular pathogen

```

# Roadmap

- saving infections for persistence between server restarts
- more pathogens and cures
- make the API more flexible, consistent and forgiving
- register immunization with pathogen in seconds

# Reference

- https://en.wikipedia.org/wiki/Incubation_period#mediaviewer/File:Concept_of_incubation_period.svg
- https://www.freesound.org

# License

- Code	WTFPL
- Images	WTFPL
- Sounds	CC
