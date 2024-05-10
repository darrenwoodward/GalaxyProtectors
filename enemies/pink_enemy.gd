class_name PinkEnemy
extends Enemy

@onready var states = $States

@onready var move_down_state: = %MoveDownState as TimedStateComponent
@onready var move_side_state: = %MoveSideState as TimedStateComponent
@onready var pause_state: = %PauseState as TimedStateComponent
@onready var move_side_component: = %MoveSideComponent as MoveComponent
@onready var fire_state: = %FireState as StateComponent
@onready var projectile_spawner_component: = %ProjectileSpawnerComponent as SpawnerComponent

@onready var increaseRateOfFireDrop = preload("res://powerups/increase_rate_of_fire.tscn")


func _ready():
	super()
	
	stats_component.no_health.connect(func():
		drop_item()
	)
	
	
	for state: StateComponent in states.get_children():
		state.disable()
	
	move_side_component.velocity.x = [-20,20].pick_random()
	
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(func():
		fire_state.enable()
		scale_component.tween_scale()
		projectile_spawner_component.spawn(global_position)
		fire_state.disable()
		fire_state.state_finished.emit()
	)
	fire_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_down_state.enable)
	
	move_down_state.enable()

func drop_item():
	var item = increaseRateOfFireDrop.instantiate()
	item.global_position = global_position
	get_tree().get_root().add_child(item)
