extends CharacterBody2D


@export var speed : float = 100.0
@export var acceleration : float = 10
@export var jump_velocity = -5.0
var direction : Vector2 = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite : Sprite2D = $Sprite2D

var tek1 = preload("res://art/TeknoKundaAssets/sprites/tek_side.png")
var tek2 = preload("res://art/TeknoKundaAssets/sprites/tek_back.png")
var tek_side = true

func switch_texture():
	print(tek_side)
		
	if(tek_side):
		sprite.set_texture(tek1)
	else:
		sprite.set_texture(tek2)
	
	tek_side = !tek_side


func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration*3)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("up"):
		switch_texture()

	

	move_and_slide()
	update_facing_direction()


func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	if direction.x < 0:
		sprite.flip_h = true
