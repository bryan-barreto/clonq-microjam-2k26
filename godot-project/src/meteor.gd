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

signal spawn_meteors(location, level)

# Called when the node enters the scene tree for the first time.
func _ready():
	mini_spawn_next = health - mini_spawn_interval

func _process(delta):
	if (linear_velocity == Vector2(0,0)):
		var drill_pos = get_node("../../Drill").global_position
		print((self.global_position - drill_pos).normalized())
		linear_velocity = (self.global_position - drill_pos).normalized()

	if (linear_velocity.length() != speed):
		linear_velocity = linear_velocity.normalized() * speed
	
	if (drilling):
		health -= damage_taken_per_hit * delta
		print(health)
	
	if (health <= mini_spawn_next):
		print("Spawn Mini")
		mini_spawn_next -= mini_spawn_interval
	
	if (health <= 0):
		split()

func _on_drillable_collision_body_entered(body):
	if (body.name == "DrillBox"):
		drilling = true

func _on_drillable_collision_body_exited(body):
	if (body.name == "DrillBox"):
		drilling = false

func split():
	spawn_meteors.emit(self, level)
