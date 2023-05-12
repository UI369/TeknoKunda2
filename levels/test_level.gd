extends Node2D

var active_element : Node;
# Called when the node enters the scene tree for the first time.

@export var node_paths: Array[NodePath] = []
@onready var nodes: Array = node_paths.map(func(path: NodePath) -> Node: return get_node(path))

func _ready():
	$Tek.player_up_signal.connect(_on_tek_player_up_signal)
	
	for i in range(nodes.size()):
		nodes[i].active_element_signal.connect(_on_game_element_active_element_signal)
		nodes[i].inactive_element_signal.connect(_on_game_element_inactive_element_signal)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tek_player_up_signal():
	print("player up signal")
	if(active_element):
		print(active_element)
		active_element._do_active_action($Tek, ElementManager.array[active_element.id])

func _on_game_element_active_element_signal(element):
	print("_on_game_element_active_element_signal")
	active_element = element;

func _on_game_element_inactive_element_signal(element):
	print("_on_game_element_inactive_element_signal")
	if(active_element == element):
		active_element = null;
