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
@export var mini_spread_range = 0

var meteor_fab = preload("res://prefab/ball.tscn")
var mini_fab = preload("res://prefab/mini_meteor.tscn")
var origin_meteor_pos = Vector2(20, 135)
var num_of_meteors = 0

@onready var meteor_node = get_node("Meteors")
@onready var mini_node = get_node("MiniMeteors")
@onready var drill = get_node("Drill")

func _enter_tree():
	%Difficulty.text = "Difficulty: %d" % difficulty

func _ready():
	num_of_meteors += 1
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
	first_meteor.spawn_minis.connect(_spawn_minis)

func _process(delta):
	if (num_of_meteors <= 0):
		_on_win()

func _on_win():
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_lose_pressed():
	get_tree().change_scene_to_file("res://scenes/lose.tscn")

func set_difficulty(request_diff: float):
	self.difficulty = clampf(request_diff, min_difficulty, max_difficulty)

func _on_spawn_meteors(meteor):
	num_of_meteors -= 1
	if (meteor.level >= meteor_level_cap):
		meteor.visible = false
		meteor.disable_mode = PROCESS_MODE_DISABLED
		meteor.queue_free()
		return
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
		new_meteor.level = meteor.level + 1
		new_list.append(new_meteor)
	meteor.visible = false
	meteor.disable_mode = PROCESS_MODE_DISABLED
	meteor.queue_free()
	for x in range(new_list.size()):
		num_of_meteors += 1
		meteor_node.add_child(new_list[x])
		new_list[x].spawn_meteors.connect(_on_spawn_meteors)
		new_list[x].spawn_minis.connect(_spawn_minis)

func _spawn_minis(meteor):
	const DIST_APART = 8
	var mini_count = 0
	var drill_meteor_angle = drill.global_position.angle_to_point(meteor.global_position)
	var mini_spawn_lower_angle = drill_meteor_angle - (mini_spread_range/2)
	var mini_spawn_upper_angle = drill_meteor_angle + (mini_spread_range/2)
	for x in range(mini_spawn_lower_angle,mini_spawn_upper_angle, mini_spread_range/mini_spawn_amount):
		var new_mini = mini_fab.instantiate()
		var dist_apart = (mini_count - mini_spawn_amount/2) * DIST_APART
		new_mini.global_position = Vector2(meteor.global_position.x + dist_apart, meteor.global_position.y)
		#new_mini.linear_velocity = (meteor.global_position - drill.global_position).normalized()
		new_mini.linear_velocity = Vector2.RIGHT.rotated(x)
		new_mini.speed = meteor_speed * 2
		mini_count+=1
		mini_node.add_child(new_mini)
