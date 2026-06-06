extends CharacterBody2D

@onready var drill = $Drill

@export var max_player_speed = 0.0

@export var rotation_speed = 0.0

func _process(delta):
	_look_at_mouse(delta)
	_move_toward_mouse(delta)

func _move_toward_mouse(delta: float) -> void:
	var dir_to_mouse: Vector2 = get_global_mouse_position() - drill.global_position
	var max_velocity_this_update: float = max_player_speed * delta
	var max_velocity_this_update_squared := max_velocity_this_update ** 2
	if dir_to_mouse.length_squared() > max_velocity_this_update_squared:
		dir_to_mouse = dir_to_mouse.normalized() * max_velocity_this_update
	velocity = dir_to_mouse / delta
	var _collided := move_and_slide()

func _look_at_mouse(delta: float) -> void:
	var target_angle = ((get_global_mouse_position() - global_position).angle() + deg_to_rad(90))
	var target_angle_diff = abs(angle_difference(self.rotation, target_angle))
	if (target_angle_diff >= rotation_speed * delta):
		rotation = rotate_toward(rotation, target_angle, rotation_speed * delta)
	else:
		rotation = target_angle
