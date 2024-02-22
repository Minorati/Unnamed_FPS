extends Node3D

@onready var kill_floor_collider = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	kill_floor_collider.monitoring = true
	print("killfloor instantiated")
	pass # Replace with function body.

func _on_area_3d_body_entered(body):
	print("Collided with kill floor")
	print(body)
	print(body.get_class())
	if body.get_class() == "CharacterBody3D":
		body.receive_damage(999, "true_dmg")

# TODO: add code to restart scene

