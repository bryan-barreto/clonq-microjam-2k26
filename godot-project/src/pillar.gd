extends RigidBody2D

@export var thrust = 0.0
@export var angularFricton = 0.0
@export var linearFriction = 0.0

@onready var leftThrust := $LeftThrust
@onready var rightThrust := $RightThrust

func _integrate_forces(state):
	var leftThrust_offset: Vector2 = leftThrust.global_position - self.global_position
	var rightThrust_offset: Vector2 = rightThrust.global_position - self.global_position
	
	#if Input.is_action_pressed("LeftThruster"):
		#state.apply_force(Vector2(0, thrust).rotated(self.rotation), leftThrust_offset)
		#
	#if Input.is_action_pressed("RightThruster"):
		#state.apply_force(Vector2(0, thrust).rotated(self.rotation), rightThrust_offset)
	#
	#state.angular_velocity *= 1.0 - angularFricton
	#state.linear_velocity *= 1.0 - linearFriction
	#
	#if (self.global_rotation < -60 || self.global_rotation > 60):
		#state.angular_velocity *= 1.0 - angularFricton - 0.5
	
	# var drill_offset: Vector2 = drill.global_position - self.global_position
	# print(drill_offset)
	# var mousePos: Vector2 = get_global_mouse_position()
	# print(mousePos)
	# var to_target: Vector2 = drill_offset.direction_to(mousePos)
	# print(to_target)
	# state.apply_force(to_target*thrust, drill_offset)
