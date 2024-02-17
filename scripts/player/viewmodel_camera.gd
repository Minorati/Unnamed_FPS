extends Camera3D
@onready var t_bob = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func bob(weapon, delta, parent):
	var original_pos = 0.18
	# transform.origin.xyz is the position relative to its parent
	var amp = 0.02
	var freq = 0.6
	t_bob += delta * parent.velocity.length()
	var new_pos = amp * sin(t_bob  * freq) + original_pos
	weapon.transform.origin.x = new_pos
