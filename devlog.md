### 2024-11-28 - credits
* to alkakrab for the music
* chatGPT for the square and triangle

### 2024-11-23 - 3 hr: Spike randomization, secondary spike generation
* Procedural spike generation is now implemented.
  * Spikes are now dynamically incremented as the player progresses.

### 2024-11-18 - 2 hr: Secondary spike generation algorithm
* Began creating the secondary spike generation algorithm, which will generate smaller chains than the main spike on each obstacle.

### 2024-11-10 - 5 hr: Amplitude adjusting
* Adjusted amplitude to allow for smoother transitions between platforms.

### 2024-11-09 - 4 hr: Spike generation, player movement, Killzone
* Fixed bugs in spike generation.
* Dialed in jump height and speed of the player.
* Added a kill zone to the spikes.

### 2024-11-08 - 3 hr: Spike generation
* Moved spike generation into the platform generator; spikes are now generating correctly on top of each platform.

### 2024-11-08 - 7 hr: Spike generation
* Finished implementing spike generation in the world generation algorithm.
* Note: May need to restructure where the spike scene is implemented and generated.
  * Possibly move it out of world generation and into the platform generator.

### 2024-11-05 - 3 hr: Spike generation
* Began implementing spike generation in the world generation algorithm.

### 2024-10-29 - 5 hr: Spike generation
* Tweaked spike generation to be more random.
* Created spike groupings (1, 2, 3, and 4 spike rows).

### 2024-10-28 - 3 hr: Spike generation, External Playtest
* Worked on spike generation and positioning.
* Conducted an external playtest with a friend.

### 2024-10-26 - 4 hr: Testing, debugging, spike generation
* Focused on creating testing scenarios for the game.
* Worked on a stuttering bug.
* Created a spike scene.
* Built tests for spike generation.

### 2024-10-23 - 3 hr: Level generation algorithm, player movement
* Tweaked the level generation algorithm to create more interesting levels.

### 2024-10-22 - 3 hr: Level generation algorithm, jumping animation
* Tweaked the level generation algorithm to create more interesting levels.
* Adjusted amplitude to allow for smoother transitions between platforms.
* Added a jumping animation to the player.

### 2024-10-21 - 8 hr: Bugs, level generation, player movement, world bounds, collision shapes
* Fixed a bug where the player would fall through the platform.
* Fixed a bug where platforms would generate on top of each other.
* Optimized platform spacing for the player to jump from one to another.
* Added world bounds to the player script; when the player falls off, they are respawned at the same spot.

### 2024-10-15 - 7 hr: Level generation algorithm tweaking
* Tweaked the level generation algorithm to create more interesting levels.
* Adjusted the bounds of the level generation algorithm.

### 2024-10-06 - 3 hr: Level generation and platform scene
* Began implementing the level generation algorithm.
* Attached the platform scene to the level generation algorithm.

### 2024-10-02 - 4 hr: Camera follow, algorithm, level hierarchy
* Added camera follow to the player.
* Created a level hierarchy and added a new level.
* Wrote an algorithm for level generation using simplex noise.

### 2024-09-24 - 3 hr: Collision shapes, gravity, and jump
* Added collision shapes to the player and platform.
* Added gravity to the player and jump functionality.

### 2024-09-20 - 3 hr: Player sprite and test platform
* Added a sprite to the player scene.
* Created a test platform for the player to move on.

### 2024-09-18 - 4 hr: Player movement and camera
* Attached jumping and directional movement to the player scene.
