extends RigidBody2D

@export var speed = 0.0
@export var health = 0
@export var damage_taken_per_hit = 0
@export var mini_spawn_interval = 0
@export var mini_spawn_amount = 0
var mini_spawn_next
var drilling = false
var level = 0
var level_cap = 3

signal spawn_meteors(split_meteor)
signal spawn_minis(meteor)

@onready var drill = get_node("../../Drill")
const VIEW_WIDTH = 240
const VIEW_HEIGHT = 160

# Called when the node enters the scene tree for the first time.
func _ready():
	mini_spawn_next = health - mini_spawn_interval

func _process(delta):
	if (linear_velocity == Vector2(0,0)):
		var drill_pos = drill.global_position
		linear_velocity = (self.global_position - drill_pos).normalized()

	if (linear_velocity.length() != speed):
		linear_velocity = linear_velocity.normalized() * speed
	
	if (drilling):
		health -= damage_taken_per_hit * delta
	
	if (health <= mini_spawn_next):
		spawn_minis.emit(self)
		mini_spawn_next -= mini_spawn_interval
	
	if (health <= 0):
		split()
	
	var radius = get_node("DrillableCollision/CollisionShape2D").shape.radius
	if (global_position.x > VIEW_WIDTH + radius and linear_velocity.x > 0):
		global_position.x = -radius
	if (global_position.x < 0 - radius and linear_velocity.x < 0):
		global_position.x = VIEW_WIDTH+radius
	if (global_position.y > VIEW_HEIGHT + radius and linear_velocity.y > 0):
		global_position.y = -radius
	if (global_position.y < 0 - radius and linear_velocity.y < 0):
		global_position.y = VIEW_HEIGHT+radius

func _on_drillable_collision_body_entered(body):
	if (body.name == "DrillBox"):
		drilling = true

func _on_drillable_collision_body_exited(body):
	if (body.name == "DrillBox"):
		drilling = false

func split():
	spawn_meteors.emit(self)
