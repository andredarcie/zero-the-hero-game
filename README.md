# Zero the Hero

Zero the Hero is a top-down 2D action-adventure game built with Godot 4.6. The project uses pixel art, melee combat, collectible items, level portals, and a linear stage progression.

## Overview

- Engine: Godot 4.6
- Base resolution: `480x240`
- Window size: `1440x720`
- Main scene: `engine/Screens/TitleScreen.tscn`
- Language: GDScript

## How to Open

1. Open Godot 4.6.
2. Import the project using [project.godot](/C:/repos/zero-the-hero-game/project.godot).
3. Run the main scene or launch the full project.

## Main Flow

The main game flow follows this order:

`TitleScreen -> Level 1 -> Level 2 -> Level 3 -> ... -> Level 10`

The levels are under [`levels/`](/C:/repos/zero-the-hero-game/levels) and the start screen is under [`engine/Screens/`](/C:/repos/zero-the-hero-game/engine/Screens).

## Controls

- Move: `WASD`, arrow keys, or gamepad
- Attack / use item: `X`, left click, or the primary gamepad button
- Swap item: `Z`, right click, or the secondary gamepad button
- Pause: `Esc` or `Space`

The input actions are defined in [`project.godot`](/C:/repos/zero-the-hero-game/project.godot).

## Structure

- [`engine/`](/C:/repos/zero-the-hero-game/engine): screens, core systems, audio, camera, and global state
- [`levels/`](/C:/repos/zero-the-hero-game/levels): main stages and shared level bases
- [`player/`](/C:/repos/zero-the-hero-game/player): player scene and logic
- [`enemies/`](/C:/repos/zero-the-hero-game/enemies): enemies and behavior
- [`items/`](/C:/repos/zero-the-hero-game/items): weapons and equippable items
- [`pickups/`](/C:/repos/zero-the-hero-game/pickups): portal, bomb, hearts, coins, and collectible objects
- [`tiles/`](/C:/repos/zero-the-hero-game/tiles): tilesets, tilemaps, and environment art
- [`ui/`](/C:/repos/zero-the-hero-game/ui): HUD, mini-map, and mobile interface
- [`sounds/`](/C:/repos/zero-the-hero-game/sounds): sound effects and music

## Singletons

The main autoload singletons registered in the project are:

- `GameState`: persistent player state, inventory, health, bombs, coins, and per-object saved state
- `LevelManager`: stage transitions and spawn control
- `Hud`: hearts, mini-map, and item slot display
- `BackgroundMusic`: background music
- `SoundEffects`: sound effects

## Development

There is no build pipeline, linter, or automated test suite in this repository. The normal workflow is:

1. Open the project in the Godot editor.
2. Edit scenes and scripts.
3. Run the project or a specific scene.
4. Validate behavior visually and through gameplay.
