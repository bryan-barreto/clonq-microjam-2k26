extends RigidBody2D

@onready var drill = get_node("../../Drill")
const VIEW_WIDTH = 240
const VIEW_HEIGHT = 160

var speed = 0

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
		linear_velocity = linear_velocity.normalized() * (speed*0.5)
	
	var radius = get_node("CollisionShape2D").shape.radius
	if (global_position.x > VIEW_WIDTH + radius and linear_velocity.x > 0):
		global_position.x = -radius
	if (global_position.x < 0 - radius and linear_velocity.x < 0):
		global_position.x = VIEW_WIDTH+radius
	if (global_position.y > VIEW_HEIGHT + radius and linear_velocity.y > 0):
		global_position.y = -radius
	if (global_position.y < 0 - radius and linear_velocity.y < 0):
		global_position.y = VIEW_HEIGHT+radius


func _on_body_entered(body):
	if (body.name == "DrillBox"):
		queue_free()
