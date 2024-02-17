extends Node3D

# enqueue ->									-> outqueue
var queue = ["stop", "stop", "stop", "stop", "stop"]


# Called when the node enters the scene tree for the first time.
func _ready():
	print("instantiating input queue")
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func receive_input(input):
	# print(input)
	# print(!(input in queue))
	if input != queue.front(): 
		queue.push_front(input)
	add_input(input)


func shift(queue: Array):
	pass


func add_input(input):
	print("queue: ")
	
	if queue.size() > 5:
		queue.pop_back()
	print(queue)


func clear_queue():
	print("clearing queue")
