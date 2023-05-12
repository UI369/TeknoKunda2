extends Area2D
class_name GameElement

@export var texture_hilite : Texture;
@export var texture: Texture;

@export_enum ("bed", "computer", "couch") var id = 0

signal active_element_signal(element)
signal inactive_element_signal(element)
signal game_element_entered(element)

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	$element_sprite.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	print("body entered")
	$element_sprite.texture = texture_hilite;
	active_element_signal.emit(self)

func _on_body_exited(body):
	print("body exited")
	$element_sprite.texture = texture;
	inactive_element_signal.emit(self)
	
func _do_active_action(tek, action):
	action.call()


func _on_active_element_signal(element):
	#_do_active_action()
	pass # Replace with function body.
