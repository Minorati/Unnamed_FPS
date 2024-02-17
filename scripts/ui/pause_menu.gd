extends Control


# Called when the node enters the scene tree for the first time.

func _ready():
	resume()
	pass # Replace with function body.

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
	pass # Replace with function body.

func _on_restart_pressed():
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.

func _process(delta):
	open_pause_menu()
