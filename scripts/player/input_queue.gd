extends Node3D

var command_queue = ["neutral","neutral","neutral","neutral","neutral"]

# TODO: find a way to set match expressions to array
#var command_sequence_dash = [
	#"forward",
	#"neutral",
	#"forward",
#]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("instantiating input queue")

var status_manager = null;

func attach_status_manager(_manager):
	print("I am given a manager")
	print(_manager)
	status_manager = _manager
# # p_state "player state"
# # t_state "technical state"
# # 	is the "named state" parsed from player's input
# func equals(t_state, p_state) -> bool:
# 	for key in t_state:
# 		if key in p_state:
# 			#print("the " + key + " exists")
# 			#print("tstate:" + str(t_state[key]) + "pstate:" + str(p_state[key]))
# 			if t_state[key] != p_state[key]:
# 				pass
# 				#print("matching at: " + key)
# 			else:
# 				#print("doesn't match at: " + key)
# 				return false
# 	return true

# TODO: change all these strings to ENUM

func dash(event):
	if event.type == Input.is_anything_pressed():
		print("pressed a key")

func add_command(command, state):
	if command_queue[0] != command || command == "jump":
		command_queue.push_front(parse_cmd(command, state))
	if command_queue.size() > 5:
		command_queue.pop_back()

	#print(command_queue)
	command_queue = parse_command_sequence(command_queue)


func parse_cmd(command, state):
	match command:
		"forward":
			return self.forward(state)
		"neutral":
			return self.neutral(state)
		"crouch":
			return self.crouch(state)
		"jump":
			return self.jump(state)
		"backward":
			return self.backward(state)

# TODO: make this more legible/optimized/etc
func parse_command_sequence(queue):
	# a bunch of commands to test
	match queue:
		["forward", "neutral", "forward", _, _]:
			print("dash")
			status_manager.give_stance("dash")
			queue = ["dash", "neutral", "neutral", "neutral", "neutral"]
		["forward-crouch", "crouch", "neutral", "forward", _]:
			print("crouch dash")
			queue = ["crouch dash", "neutral", "neutral", "neutral", "neutral"]
		["forward-crouch", "crouch", "neutral", "dash", _]:
			print("far crouch dash")
			queue = ["crouch dash", "neutral", "neutral", "neutral", "neutral"]
		["jump", "forward", "neutral", "forward", _]:
			print("dash jump")
		["jump", "dash", _, _, _]:
			print("test dash jump")
		["crouch-jump", "crouch dash", _, _, _]:
			print("cdj")
		["forward-crouch", "crouch", "neutral", "backward", _]:
			print("sway")
		_:
			pass
	print(queue)
	return queue

func forward(state):
	if state.is_crouching:
		return "forward-crouch"
	else:
		return "forward"

func neutral(state):
	# print("neutral")
	pass
	return "neutral"

func crouch(state):
	if state.is_grounded:
		return "crouch"
	else:
		return "ground slam"
		
func jump(state):
	if state.is_grounded:
		if state.is_crouching:
			return "crouch-jump"
		else:
			return "jump"
	else: 
		return "air jump"

func backward(state):
	return "backward"
