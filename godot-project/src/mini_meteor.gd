extends RigidBody2D

@onready var drill = get_node("../../Drill")

var speed = 0

var previous_vel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (linear_velocity == Vector2(0,0)):
		print((self.global_position - drill.global_position).normalized())
		linear_velocity = (self.global_position - drill.global_position).normalized()
	#if (linear_velocity.x == 0):
		#var new_dir = (self.global_position - drill.global_position).normalized()
		#linear_velocity.x = new_dir.x
	#if (linear_velocity.y == 0):
		#var new_dir = (self.global_position - drill.global_position).normalized()
		#linear_velocity.y = new_dir.y
	#previous_vel = linear_velocity
	if (linear_velocity.length() != speed):
		linear_velocity = linear_velocity.normalized() * speed
