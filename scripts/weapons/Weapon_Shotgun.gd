extends MeshInstance3D


@onready var raycast = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("mb1"):
		#print("click")
	pass

# move interaction raycast onto a melee func
func attack():
	print("attacked")
	if raycast.is_colliding():
		var ray: Object = raycast.get_collider()
		if "level_select_panel" in ray.name:
			print("lsp")
			ray.change_level()
		else:
			print(ray.name)
