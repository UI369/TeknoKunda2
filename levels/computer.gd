extends Area2D

var computer_texture_hilite = preload("res://art/TeknoKundaAssets/sprites/computer_hilite.png")
var computer_texture;

signal active_element_signal(element)
signal inactive_element_signal(element)

# Called when the node enters the scene tree for the first time.
func _ready():
	computer_texture = $computer_sprite.texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	$computer_sprite.texture = computer_texture_hilite;
	emit_signal("active_element_signal", self)

func _on_body_exited(body):
	$computer_sprite.texture = computer_texture;
	emit_signal("inactive_element_signal", self)
	
func _do_active_action(tek):
	print(tek)
