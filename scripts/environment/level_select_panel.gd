extends CSGBox3D



@onready var label = $Label3D
@export var level_name = ""

func _ready():
	label.text = level_name + ".tscn"
	pass

func change_level():
	get_tree().change_scene_to_file("res://assets/scenes/levels/" + label.text)
