# Vignette

Dark gradient hud overlay for a immersive experience. By default it will add
a single overlay to a players screen at the beginning of the game.

Vignette also has an api for other mods to leverage.

## Api

> Exposes an api on the vignette namespace with functions `add` and `edit`.
> These function can be used by other mods in the following manner.


```lua
vignette.set({

  -- player is a required field
  player = player,

  -- a number between 0 or 5, you can do more but that might result in
  -- a frame-rate drop
  darkness = 4

});

vignette.add({

  -- same as the first example
  player = player,

  -- instead of setting it adds the darkness to the current player's screen it
  -- is allows to pass negative values also. If the darkness results in a
  -- negative value it is defaulted to 0
  darkness = 1

})
```
