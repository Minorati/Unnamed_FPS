extends CharacterBody3D

const SPEED: float = 6.0
const JUMP_VELOCITY: float = 4.5
const SENSITIVITY: float = 0.001

# Player states
@export var IS_CROUCHING = false
@export var IS_GROUNDED = true
@export var IS_MOVING = false
const STATE_TRANSITION_WINDOW = 1.0

var PLAYER_STATE = {
	"is_crouching": IS_CROUCHING, "is_grounded": IS_GROUNDED, "is_moving": IS_MOVING
}
var PREV_STATE = PLAYER_STATE

# Camera bobbing
@export var BOB_FREQ: float = 2.2
@export var BOB_AMP: float = 0.08
var t_bob: float = 0.0

# Camera rolling
@export var HEAD_ROLL: float = 0
@export var HEAD_ROLL_STRENGTH: float = 0.015

# Movement acceleration
@export var ACCELERATION_MULT: float = 2.0
@export var ACCELERATION_CURRENT: float = 0.0

@onready var head = $Head
@onready var camera = $Head/Camera
@onready var guncamera = $Head/Camera/SubViewportContainer/SubViewport/GunCamera

@onready var stand_collider = $Stand_Collider
@onready var crouch_collider = $Crouch_Collider
@onready var can_stand_collider = $Can_Stand

# Get the gravity from the project settings to be synced with RigidBody nodes.
# TODO: maybe separate player from npc gravity?
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var Action_Queue = []


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	can_stand_collider.monitoring = true


func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		var y_rotation = -event.relative.x * SENSITIVITY
		var x_rotation = -event.relative.y * SENSITIVITY

		head.rotate_y(y_rotation)
		camera.rotate_x(x_rotation)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _process(delta) -> void:
	guncamera.global_transform = camera.global_transform


func action_jump(delta, state) -> void:
	if is_on_floor():
		if state.is_grounded == false:
			print("landing")
			state.is_grounded = true

	if Input.is_action_just_pressed("jump") and state.is_grounded:
		if state.is_grounded == true:
			print("jumping")
			state.is_grounded = false
		velocity.y = JUMP_VELOCITY


func action_crouch(delta, state) -> void:
	if Input.is_action_pressed("crouch"):
		if state.is_crouching == false:
			print("crouching")
		state.is_crouching = true
		stand_collider.disabled = true
		crouch_collider.disabled = false
	else:
		if state.is_crouching == true:
			print("standing")
			state.is_crouching = false

		if can_stand_collider.get_overlapping_bodies():
			print(can_stand_collider)
		else:
			stand_collider.disabled = false
			crouch_collider.disabled = true
		#collider.transform.scale.y = standing_height

	
func action_move(delta, state, direction) -> void:
	if direction:
		if state.is_moving == false:
			print("moving")
		state.is_moving = true
		ACCELERATION_CURRENT += delta * ACCELERATION_MULT
		if ACCELERATION_CURRENT > 1:
			ACCELERATION_CURRENT = 1
		velocity.x = ACCELERATION_CURRENT * (direction.x * SPEED)
		velocity.z = ACCELERATION_CURRENT * (direction.z * SPEED)
	else:
		if state.is_moving == true:
			print("stopping")
		state.is_moving = false
		ACCELERATION_CURRENT = 0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _physics_process(delta) -> void:
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var state = PLAYER_STATE
	print(can_stand_collider.get_overlapping_bodies())

	# Handle jump.
	action_jump(delta, state)

	# Handle movement
	action_move(delta, state, direction)

	# Handle crouching
	action_crouch(delta, state)

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Camera effects
	camera_headroll(input_dir, delta)
	camera_headbob(input_dir, delta)

	# Move player and calculate collision
	move_and_slide()


# REFACTOR:
func camera_headbob(dir, delta) -> void:
	var pos = Vector3.ZERO
	t_bob += delta * velocity.length() * float(is_on_floor())
	pos.y = sin(t_bob * BOB_FREQ) * BOB_AMP
	camera.transform.origin = pos


# REFACTOR:
func camera_headroll(dir, delta) -> void:
	HEAD_ROLL = -dir.x * HEAD_ROLL_STRENGTH
	head.global_rotation.z = HEAD_ROLL
	HEAD_ROLL = 0
