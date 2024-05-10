extends Node2D

@onready var left_muzzle = $LeftMuzzle
@onready var right_muzzle = $RightMuzzle
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_rate_timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent as ScaleComponent
@onready var animated_sprite_2d = $Anchor/AnimatedSprite2D
@onready var flame_animated_sprite = $Anchor/FlameAnimatedSprite
@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var stats_component = $StatsComponent as StatsComponent


func _ready():
	fire_rate_timer.timeout.connect(fire_lasers)
	stats_component.rateOfFire_changed.connect(update_rate_of_fire)

func fire_lasers():
	spawner_component.spawn(left_muzzle.global_position)
	spawner_component.spawn(right_muzzle.global_position)
	scale_component.tween_scale()
	
func update_rate_of_fire():
	fire_rate_timer.stop()
	fire_rate_timer.wait_time = stats_component.rateOfFire
	fire_rate_timer.start()

func _process(delta):
	animate_the_ship()
	
func animate_the_ship():
	if move_component.velocity.x < 0:
		animated_sprite_2d.play("bank_left")
		flame_animated_sprite.play("bank_left")
	elif move_component.velocity.x > 0:
		animated_sprite_2d.play("bank_right")
		flame_animated_sprite.play("bank_right")
	else:
		animated_sprite_2d.play("center")
		flame_animated_sprite.play("center")

func updateFireRate():
	pass
