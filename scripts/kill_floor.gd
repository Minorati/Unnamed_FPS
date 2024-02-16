extends Node3D

@onready var kill_floor_collider = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	kill_floor_collider.monitoring = true
	pass # Replace with function body.

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if kill_floor_collider.get_overlapping_bodies():
		print("collided with:")
		print(kill_floor_collider.get_overlapping_bodies())

