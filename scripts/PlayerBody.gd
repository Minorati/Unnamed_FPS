extends CharacterBody3D

const SPEED: float = 6.0
const JUMP_VELOCITY: float = 4.5
const SENSITIVITY: float = 0.001

@export var BOB_FREQUENCY: float = 2.2
@export var BOB_AMPLITUDE: float = 0.08
var t_bob: float = 0.0

@export var HEAD_ROLL: float = 0
@export var HEAD_ROLL_MULT: float = 0.5
var t_roll: float = 0.0

@export var ACCELERATION_MULT: float = 2.0
@export var ACCELERATION_CURRENT: float = 0.0

# Child of this node is named 'Head'
@onready var head = $Head
@onready var camera = $Head/Camera
@onready var body = $Player
@onready var guncamera = $Head/Camera/SubViewportContainer/SubViewport/GunCamera

# Get the gravity from the project settings to be synced with RigidBody nodes.
# TODO: maybe separate player from npc gravity?
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)


func _process(delta):
	# TODO: move this to _ready, and attach viewmodel camera to main camera
	# instead of repositioning camera after every update
	guncamera.global_transform = camera.global_transform


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		# sudo:
		# max velocity is direction.x * SPEED
		# over time, I want to multiply max velocity by an accel multiplier (ranges from 0 to 1)
		ACCELERATION_CURRENT += delta * ACCELERATION_MULT
		if ACCELERATION_CURRENT > 1:
			ACCELERATION_CURRENT = 1
		velocity.x = ACCELERATION_CURRENT * (direction.x * SPEED)
		velocity.z = ACCELERATION_CURRENT * (direction.z * SPEED)

		print(input_dir)

		_headroll(input_dir, delta)
		_headbob(input_dir, delta)
	else:
		ACCELERATION_CURRENT = 0
		camera.global_rotation.z = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		# TODO: is this too sudden of a change?
		t_bob = 0
		HEAD_ROLL = 0
		# camera.transform.origin = _headbob(t_bob)

	move_and_slide()


func _headbob(dir, delta) -> void:
	# REFACTOR:
	var pos = Vector3.ZERO
	t_bob += delta * velocity.length() * float(is_on_floor())
	pos.y = sin(t_bob * BOB_FREQUENCY) * BOB_AMPLITUDE
	camera.transform.origin = pos

func _headroll(dir, delta) -> void:
	# REFACTOR:
	const roll_max = 0.03
	HEAD_ROLL = HEAD_ROLL_MULT * -dir.x * roll_max
	camera.global_rotation.z = HEAD_ROLL
	HEAD_ROLL = 0
