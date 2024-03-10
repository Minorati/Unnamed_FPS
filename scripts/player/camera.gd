extends Camera3D
@export var BOB_FREQ: float = 2.2
@export var BOB_AMP: float = 0.08
var t_bob: float = 0.0


@export var HEAD_ROLL: float = 0
@export var HEAD_ROLL_STRENGTH: float = 0.015

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_and_bob(dir, delta, parent):
	bob(dir, delta, parent)
	roll(dir, delta, parent)

# REFACTOR:
func bob(dir, delta, parent) -> void:
	var pos = Vector3.ZERO
	t_bob += delta * parent.velocity.length() * float(parent.is_on_floor())
	pos.y = sin(t_bob * BOB_FREQ) * BOB_AMP
	transform.origin = pos


# REFACTOR:
func roll(dir, delta, parent) -> void:
	HEAD_ROLL = -dir.x * HEAD_ROLL_STRENGTH
	parent.global_rotation.z = HEAD_ROLL
	HEAD_ROLL = 0
	

