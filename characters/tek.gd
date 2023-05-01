extends CharacterBody2D


@export var speed : float = 200.0
@export var acceleration : float = 10
@export var jump_velocity = -5.0
var direction : Vector2 = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite : Sprite2D = $Sprite2D


func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration*3)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_facing_direction()


func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	if direction.x < 0:
		sprite.flip_h = true
