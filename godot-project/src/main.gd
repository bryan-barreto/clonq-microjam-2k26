extends Node2D

@export var difficulty = 0
@export var max_difficulty = 255
@export var min_difficulty = 0
@export var split_amount = 0
@export var meteor_speed = 0.0
@export var meteor_health = 0
@export var meteor_level_cap = 0
@export var damage_taken_per_hit = 0
@export var mini_spawn_interval = 0
@export var mini_spawn_amount = 0

var meteor_fab = preload("res://prefab/ball.tscn")
var origin_meteor_pos = Vector2(20, 135)

@onready var meteor_node = get_node("Meteors")
@onready var drill = get_node("Drill")

func _enter_tree():
	%Difficulty.text = "Difficulty: %d" % difficulty

func _ready():
	var first_meteor = meteor_fab.instantiate()
	first_meteor.global_position = origin_meteor_pos
	first_meteor.health = meteor_health
	first_meteor.damage_taken_per_hit = damage_taken_per_hit
	first_meteor.speed = meteor_speed
	first_meteor.mini_spawn_amount = mini_spawn_amount
	first_meteor.mini_spawn_interval = mini_spawn_interval
	first_meteor.linear_velocity = Vector2(1,-1)
	meteor_node.add_child(first_meteor)
	
	first_meteor.spawn_meteors.connect(_on_spawn_meteors)

func _on_win_pressed():
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_lose_pressed():
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func set_difficulty(request_diff: float):
	self.difficulty = clampf(request_diff, min_difficulty, max_difficulty)

func _on_spawn_meteors(meteor, level):
	var new_list = []
	for x in range(split_amount):
		var new_meteor = meteor_fab.instantiate()
		#var meteor_size = new_meteor.get_node("DrillableCollision/CollisionShape2D")
		new_meteor.global_position = meteor.global_position
		new_meteor.linear_velocity = (meteor.global_position - drill.global_position).normalized()
		new_meteor.health = meteor_health
		new_meteor.damage_taken_per_hit = damage_taken_per_hit
		new_meteor.speed = meteor_speed
		new_meteor.mini_spawn_amount = mini_spawn_amount
		new_meteor.mini_spawn_interval = mini_spawn_interval
		new_meteor.scale = meteor.scale * 0.5
		new_list.append(new_meteor)
	meteor.visible = false
	meteor.disable_mode = PROCESS_MODE_DISABLED
	meteor.queue_free()
	for x in range(new_list.size()):
		meteor_node.add_child(new_list[x])
		new_list[x].spawn_meteors.connect(_on_spawn_meteors)
