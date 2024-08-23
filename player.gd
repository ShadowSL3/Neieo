extends Node

class_name Player

enum CardType {
    BRONZE,
    SILVER,
    GOLD,
    PLATINUM
}

enum League {
    UEFA_CHAMPIONS_LEAGUE,
    UEFA_EUROPA_LEAGUE,
    SERIE_A
}

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
var current_day : int
var current_time : float

var card_type : CardType
var league : League

func _ready():
    setup()
    apply_injury(4, 30)
    start_super_training(30)
    start_lsrt(15)
    update_time()

func setup():
    sprite = $Sprite2D
    animated_sprite = $AnimatedSprite
    # Set default animations
    animated_sprite.add_animation("run")
    animated_sprite.add_animation("idle")

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
        print("Day", day, "Power:", power, "Speed:", speed)

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
