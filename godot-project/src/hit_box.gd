extends CharacterBody2D

@onready var drill = $FollowNode

@export var max_player_speed = 0.0

@export var rotation_speed = 0.0

signal body_hit

func _process(delta):
	_look_at_mouse(delta)
	_move_toward_mouse(delta)

func _move_toward_mouse(delta: float) -> void:
	var dir_to_mouse: Vector2 = get_global_mouse_position() - drill.global_position
	#var new_vel = dir_to_mouse.normalized() * max_player_speed * delta
	var collided := move_and_collide(dir_to_mouse)
	if (collided):
		collided.get_collider().apply_impulse(Vector2(0,-1).rotated(rotation))

func _look_at_mouse(delta: float) -> void:
	var target_angle = ((get_global_mouse_position() - global_position).angle() + deg_to_rad(90))
	var target_angle_diff = abs(angle_difference(self.rotation, target_angle))
	if (target_angle_diff >= rotation_speed * delta):
		rotation = rotate_toward(rotation, target_angle, rotation_speed * delta)
	else:
		rotation = target_angle


func _on_hit_box_body_entered(body):
	if (body.name != "DrillBox"):
		body_hit.emit()
