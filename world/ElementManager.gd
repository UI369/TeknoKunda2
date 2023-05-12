extends Node

@onready var array : Array[Callable] = [
	bed,
	func() -> void: print("computer"),
	func() -> void: print("couch")
]

func bed():
	print('root_scene')
	print("bed")
