extends RigidBody2D

@export var speed = 0.0

var magnitude

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if (linear_velocity.length() != speed):
		linear_velocity = linear_velocity.normalized() * speed

func _on_drillable_collision_body_entered(body):
	print("enter")
	pass # Replace with function body.
