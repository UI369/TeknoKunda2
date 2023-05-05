extends CharacterBody2D


@export var speed : float = 100.0
@export var acceleration : float = 10
@export var jump_velocity = -5.0
var direction : Vector2 = Vector2.ZERO
var looking_up : bool = false;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite : Sprite2D = $Sprite2D

var tek_side = preload("res://art/TeknoKundaAssets/sprites/tek_side.png")
var tek_back = preload("res://art/TeknoKundaAssets/sprites/tek_back.png")
var tek_front = preload("res://art/TeknoKundaAssets/sprites/tek_front.png")

var active_object : Area2D; 

signal player_up_signal()

# Have Tek look up, down, left, right
func switch_texture():	
	if(direction.x == -1):
		sprite.set_texture(tek_side)
		sprite.flip_h = true
	if(direction.x == 1):
		sprite.set_texture(tek_side)
		sprite.flip_h = false
	elif(direction.y == -1 && sprite.texture != tek_back):
		sprite.flip_h = false
		sprite.set_texture(tek_back)
		emit_signal("player_up_signal")
	elif(direction.y == 1 && sprite.texture != tek_front):
		sprite.flip_h = false
		sprite.set_texture(tek_front)


func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration*3)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	switch_texture()
	move_and_slide()

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	if direction.x < 0:
		sprite.flip_h = true
