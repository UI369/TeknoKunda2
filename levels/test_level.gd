extends Node2D

var active_element : Node;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tek_player_up_signal():
	active_element._do_active_action($Tek)


func _on_computer_active_element_signal(element):
	print("_on_computer_active_element_signal")
	active_element = element;

func _on_computer_inactive_element_signal(element):
	print("_on_computer_inactive_element_signal")
	if(active_element == element):
		active_element = null;
