# Player Management System

Welcome to the Player Management System! This project provides a comprehensive solution for managing player stats, injuries, and recovery in your sports simulation game. Below you'll find an overview of the key components and how they work.

## 📋 Overview

This system is designed to handle player attributes, injuries, and recovery processes. It includes:
- **Super Training For Injuring People (SPTJP)**: A general recovery program.
- **Lost Statistics Recovery Training (LSRT)**: A specialized program for improving lost stats.

## 🚀 Features

### Super Training For Injuring People (SPTJP)

The **SPTJP** system helps players recover from injuries through a general training program. Here's how it works:
- **Injury Impact**: Reduces player's attributes based on injury severity.
- **Recovery**: Gradually improves player quality and overall stats through consistent training.

### Lost Statistics Recovery Training (LSRT)

The **LSRT** system is specifically designed to recover lost statistics such as power and speed:
- **Focused Training**: Targets specific attributes like power and speed.
- **Intensity & Duration**: Customizable settings for training intensity and duration to accelerate recovery.

## ⚙️ How It Works

1. **Setup**: Initialize your player with necessary attributes and link the `Sprite2D` and `AnimatedSprite` for visual representation.
2. **Apply Injury**: Use the `apply_injury` function to simulate injuries and reduce player stats.
3. **Start Training**:
   - **SPTJP**: Begin general recovery training to improve overall stats.
   - **LSRT**: Initiate focused training to regain lost power and speed.
4. **Update Time**: Track the current day and time to manage animations and training schedules.
5. **Animate Player**: Use different animations based on the time of day to enhance visual feedback.

## 📜 Example Code

Here’s a brief example of how to use the system:

```gdscript
extends Node

class_name Player

var name : String
var quality : int
var power : int
var speed : int
var injury_severity : int
var training_type : String
var recovery_progress : float
var lsrt_intensity : int
var lsrt_duration : int

var sprite : Sprite2D
var animated_sprite : AnimatedSprite

func _ready():
    setup()
    apply_injury(4, 30)
    start_super_training(30)
    start_lsrt(15)
    update_time()

func setup():
    sprite = $Sprite2D
    animated_sprite = $AnimatedSprite

func apply_injury(severity: int, duration: int):
    self.injury_severity = severity
    self.power -= calculate_injury_impact(severity)
    self.speed -= calculate_injury_impact(severity)

func calculate_injury_impact(severity: int) -> int:
    return severity * 2

func start_super_training(duration: int):
    for day in range(duration):
        recovery_progress += 0.05
        recovery_progress = min(recovery_progress, 1.0)
        quality += int(2 * recovery_progress)

func start_lsrt(duration: int):
    for day in range(duration):
        power += int(1 + lsrt_intensity / 10.0)
        speed += int(1 + lsrt_intensity / 10.0)

func update_time():
    current_day = OS.get_system_time_dict()["day"]
    current_time = OS.get_system_time_dict()["hour"] + OS.get_system_time_dict()["minute"] / 60.0

func animate_player():
    if current_time < 12:
        animated_sprite.play("run")
    else:
        animated_sprite.play("idle")

func get_recovery_status() -> String:
    if recovery_progress >= 1.0:
        return "General Recovery Completed"
    else:
        return "In General Recovery"
```
