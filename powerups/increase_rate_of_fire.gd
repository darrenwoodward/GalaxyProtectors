extends Node2D

# Export the damage amount this hitbox deals
@export var rateOfFireIncrease = 1

@onready var hitbox_component: = $HitboxComponent as HitboxComponent
@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D
@onready var scale_component: = $ScaleComponent as ScaleComponent

func _ready():
	scale_component.tween_scale()
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)

