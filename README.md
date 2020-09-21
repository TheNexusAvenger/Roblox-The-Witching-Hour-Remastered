# The Witching Hour Remastered
[The Witching Hour Remastered](https://www.roblox.com/games/5713359229/The-Witching-Hour-Remastered)
if a remaster of the closed-source Roblox game
[Halloween 2013: The Witching Hour](https://www.roblox.com/games/130815926/Halloween-2013-The-Witching-Hour). The game was created using a combination of [collected asset ids](https://pastebin.com/p3fvdwLf), leaked models, and reference videos of the original game. Unlike
other recreations, this version embraces the
newer technologies avaliable on Roblox.

# Building
This project uses [Rojo](https://github.com/rojo-rbx/rojo)
for managing files. After downloading the repository
**and submodules**, a place file can be generated using:
```
rojo builder --output the-witching-hour-remastered.rbxlx
```

Rojo live syncing can also be used, but is only
recommneded for development because of the use
of `MeshPart`s. If Roblox allows Rojo to have
feature parity with live syncing as building, this
can be ignored.

# Possible Improvements
While this remaster is feature complete, it has
room for improvement.
- Improved mobile support: Mobile works, but the
  experience isn't great.
- Controller support: The UI isn't easy to make work
  with controllers, and thus wasn't supported. If
  implementing this, make sure to make combat easier
  with controllers.
- Localization: No localization has been done for the game.
  Machine-learning translaction can cover the dialogs, but
  some components of the UI have text baked in.
- Sounds: The game currently uses almost no sound. Sounds
  should be added for the attacks, dialogs, and monsters.
- Better Monsters: The models for the monsters are very
  basic and should be replaced with better quality ones.
  Additionally, the scripts that control them could be
  made more advanced.
- More Houses: There are currently 2 models of houses
  with various permutations. The original had more types
  of houses, and more should be added to the remaster
  to make the selection more diverse.
- Pet Textures: Some pet skins and costume item textures
  haven't been re-found. They should be found or remade.
- Item Meshes: The UI was changed from a 2D UI to a 3D UI,
  but the quest items were not updated. 3D versions should be made.
- More pets: Textures exist for Horses, Dragons, and Pigs,
  but the meshes haven't been found. They could be
  re-added even though they weren't used in the original.
- More automated tests: The only logic-heavy components
  with automated tests are those under
  `src/ReplicatedStorage/State`. Services and UI components
  could also use automatation tests.
- [Petting companions.](https://twitter.com/CanYouPetTheDog)

## Contributing
Contributions are accepted for this project. However,
arbitrary features (ex: new Easter eggs, new
microtransactions, new attacks) most likely won't get
accepted. The list above covers features that would
be accepted if they are implemented properly.

If a pull request is approved, make sure to
specify your Roblox usernmame so you can be listed
under the credits, or explicitly say that
you don't want to be on the in-game credits
list. If other video references by people not
already in the creidts listed, please include them
so they can be credited as well.

# Republishing
This game can be republished on Roblox as-is without
permission under the condition that credits are maintained.
You are free to add to them as needed, but users should
not removed.