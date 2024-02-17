extends Node3D

@export var ACCELERATION_MULT: float = 2.0
@export var ACCELERATION_CURRENT: float = 0.0

const SPEED: float = 7.0
const JUMP_VELOCITY: float = 4.5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func jump(delta, state, parent) -> void:
	if parent.is_on_floor():
		if state.is_grounded == false:
			# print("landing")
			state.is_grounded = true

	if state.is_grounded == true:
		# print("jumping")
		state.is_grounded = false
	parent.velocity.y = JUMP_VELOCITY

# TODO: once stability is established, remove debug prints
func move(delta, state, direction, parent) -> void:
	if state.is_moving == false:
		# print("moving")
		pass
	state.is_moving = true
	ACCELERATION_CURRENT += delta * ACCELERATION_MULT
	if ACCELERATION_CURRENT > 1:
		ACCELERATION_CURRENT = 1
	parent.velocity.x = ACCELERATION_CURRENT * (direction.x * SPEED)
	parent.velocity.z = ACCELERATION_CURRENT * (direction.z * SPEED)

func stop(delta, state, direction, parent) -> void:
	if state.is_moving == true:
		# print("stopping")
		pass
	state.is_moving = false
	ACCELERATION_CURRENT = 0
	parent.velocity.x = move_toward(parent.velocity.x, 0, SPEED)
	parent.velocity.z = move_toward(parent.velocity.z, 0, SPEED)

# TODO: needs some optimization
func crouch(delta, state, parent) -> void:
	var stand_collider = parent.stand_collider
	var crouch_collider = parent.crouch_collider
	var can_stand_collider = parent.can_stand_collider

	if state.is_crouching == false:
		# print("crouching")
		pass
	state.is_crouching = true
	stand_collider.disabled = true
	crouch_collider.disabled = false

func stand(delta, state, parent) -> void:
	var stand_collider = parent.stand_collider
	var crouch_collider = parent.crouch_collider
	var can_stand_collider = parent.can_stand_collider

	if state.is_crouching == true:
		# print("standing")
		pass
		state.is_crouching = false

	if can_stand_collider.get_overlapping_bodies():
		print(can_stand_collider)
	else:
		stand_collider.disabled = false
		crouch_collider.disabled = true
