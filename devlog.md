# Fall 2024 - Intro to Game Design @ SUNY New Paltz
* Name: Bryan Vasquez
* [Trello Board](https://trello.com/b/3Cmn97f0)
* [Proposal](Proposal.pdf)
* [Other docs](todo)

### 2024-09-18 - 4hr: Player movement and camera
* Attached jumping, and directional movement to the player scene.

### 2024-9-20 - 3 hr: Player sprite and test platform
* Added a sprite to the player scene and created a test platform for the player to move on.

### 2024-09-24 - 3 hr: Collision shapes, gravity, and jump
* Added collision shapes to the player and platform.
* Added gravity to the player and jump functionality.

### 2024-10-2 - 4 hr: camera follow, algorithm, level hierarchy
* Added camera follow to the player.
* Created a level hierarchy and added a new level.
* wrote an algorithm for level generation using simplex noise

### 2024-10-6 - 3 hr: Level generation and platform scene
* began impelementing the level generation algorithm 
* attached the platform scene to the level generation algorithm

### 2024-10-15 - 7 hr: Level generation algorithm tweaking
* Tweaked the level generation algorithm to create more interesting levels
* adjusted the bounds of the level generation algorithm

### 2024-10-21 - 8 hr: Bugs, level generation, player movement, world bounds, collision shapes
* Fixed a bug where the player would fall through the platform
* Fixed a bug where the platforms would generate on top of each other
* optomized platform spacing for the player to jump from one to the other
* added world bounds to the player script, when player falls off they are spawned back at the same spot

### 2024-10-22 - 3 hr: Level generation algorithm, jumping animation
* Tweaked the level generation algorithm to create more interesting levels
* Adjusted amplitude to allow for more smooth transitions between platforms
* Added a jumping animation to the player

### 2024-10-23 - 3 hr: Level generation algorithm, player movement
* Tweaked the level generation algorithm to create more interesting levels

### 2024-100-26 - 4 hr: Testing, debugging, spike generation
* Focused on creating testing scenarios for the game
* worked on stuttering bug
* created spike scene
* built test for spike generation

### 2024-10-28 - 3 hr: Spike generation, External Playtest
* Worked on spike generation and positioning
* did a external playtest with a friend

### 2024-10-29 - 5 hr: Spike generation
* Tweaked spike generation to be more random
* spike groupings created (1, 2, 3, 4 spike rows)

### 2024-11-5 - 3 hr: Spike generation
* Began implementing spike generation in world generation algorithm

### 2024-11-8 - 7 hr: Spike generation
* Finished implementing spike generation in world generation algorithm
* note - may have to restructure where spike scene is implemented and generated
*           - possibly going to take it out of world gneration and put in platform gnerator

### 2024-11-8 - 3 hr: Spike generation
* spike generation moved into platform generator and are now generating correctly on top of each platform

### 2024-11-9 - 4 hr: Spike generation, player movement, Killzone
* spike generation bugs fixed
* dialed in jump height and speed of player
* added killzone to the spikes