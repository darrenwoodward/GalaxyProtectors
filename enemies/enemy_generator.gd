extends Node2D

@export var greenEnemyScene: PackedScene
@export var yellowEnemyScene : PackedScene
@export var pinkEnemyScene : PackedScene

@export var game_stats : GameStats

const MARGIN = 8
const Y_MARGIN = -16
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@onready var spawner_component: = $SpawnerComponent as SpawnerComponent
@onready var green_enemy_spawn_timer = $GreenEnemySpawnTimer
@onready var yellow_enemy_spawn_timer = $YellowEnemySpawnTimer
@onready var pink_enemy_spawn_timer = $PinkEnemySpawnTimer

func _ready():
	green_enemy_spawn_timer.timeout.connect(handle_spawn.bind(greenEnemyScene, green_enemy_spawn_timer))
	yellow_enemy_spawn_timer.timeout.connect(handle_spawn.bind(yellowEnemyScene, yellow_enemy_spawn_timer, 5.0))
	pink_enemy_spawn_timer.timeout.connect(handle_spawn.bind(pinkEnemyScene, pink_enemy_spawn_timer, 10.0))
	
	game_stats.score_changed.connect(func(new_score:int):
		if new_score > 10:
			yellow_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
		if new_score > 50:
			pink_enemy_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)

func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0 ):
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(MARGIN, screen_width - MARGIN), Y_MARGIN))
	var spawnRate = time_offset / (0.5 + game_stats.score * 0.03)
	
	timer.start(spawnRate + randf_range(0.25, 0.5))
