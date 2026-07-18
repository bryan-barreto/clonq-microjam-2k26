extends RigidBody2D

@export var speed = 0.0

signal on_hit


@onready var drill = get_node("../../Drill")

# Called when the node enters the scene tree for the first time.


func _process(delta):
	if (linear_velocity == Vector2(0,0)):
		var drill_pos = drill.global_position
		linear_velocity = (self.global_position - drill_pos).normalized()
	
	if (linear_velocity.length() != speed):
		linear_velocity = linear_velocity.normalized() * speed

func _on_drillable_collision_body_entered(body):
	if (body.name == "DrillBox"):
		on_hit.emit()
