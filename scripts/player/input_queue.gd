extends Node3D

# enqueue ->									-> outqueue
var queue = ["stop", "stop", "stop", "stop", "stop"]

var action_sequence_dash = [
	"move",
	"stop",
	"move"
]

var is_moving:bool
var is_crouching:bool
var is_grounded:bool

const state_forward = {
	"is_moving"  : true,
	"is_crouching" : false
}

const state_downforward = {
	"is_moving"  : true,
	"is_crouching" : true
}

const state_down = {
	"is_moving"  : false,
	"is_crouching" : true
}

const state_neutral = {
	"is_moving"  : false,
	"is_crouching" : false
}

# Called when the node enters the scene tree for the first time.
func _ready():
	print("instantiating input queue")
	pass  # Replace with function body.

# p_state "player state"
# t_state "technical state"
# 	is the "named state" parsed from player's input
func equals(t_state, p_state) -> bool:
	for key in t_state:
		if key in p_state:
			#print("the " + key + " exists")
			#print("tstate:" + str(t_state[key]) + "pstate:" + str(p_state[key]))
			if t_state[key] == p_state[key]:
				pass
				#print("matching at: " + key)
			else:
				#print("doesn't match at: " + key)
				return false
	return true

func dash(event):
	if event.type == Input.is_anything_pressed():
		print("pressed a key")

func receive_state(input_state):
	is_crouching = input_state.is_crouching
	is_moving = input_state.is_moving
	is_grounded = input_state.is_grounded
	parse_state(input_state)

func shift(queue: Array):
	pass

# giga refactor this
func parse_state(input_state):
	if equals(state_forward, input_state):
		self.forward()
	if equals(state_downforward, input_state):
		self.downforward()
	if equals(state_down, input_state):
		self.down()
	if equals(state_neutral, input_state):
		self.neutral()


func add_input(input):
	print("queue: ")
	
	if queue.size() > 5:
		queue.pop_back()
	print(queue)


func clear_queue():
	print("clearing queue")

func forward():
	print("forward")

func neutral():
	print("neutral")

func down():
	print("down")

func downforward():
	print("df")
