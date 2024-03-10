extends Control

# Called when the node enters the scene tree for the first time.

@onready var level_dropdown = $PanelContainer/VBoxContainer/LevelSelector
@onready var levels_array = ["main", "obstacle_course", "pickup_testing_world", "utm"]


func _ready():
	self.resume()
	for i in levels_array:
		level_dropdown.add_item(i)


func resume():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false


func pause():
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	visible = true


func open_pause_menu():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()


func _on_resume_pressed():
	resume()
	pass  # Replace with function body.


func _on_restart_pressed():
	get_tree().reload_current_scene()
	pass  # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass  # Replace with function body.


func _process(delta):
	open_pause_menu()


func _on_level_selector_item_selected(index):
	var _path = "res://assets/scenes/levels/%s.tscn"
	var path = _path % levels_array[index]
	get_tree().change_scene_to_file(path)
