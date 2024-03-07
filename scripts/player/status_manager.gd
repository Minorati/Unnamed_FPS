extends Node3D

var is_crouching = false
var is_grounded =true
var is_moving =false

# @onready var timer = $Timer
@onready var player = null
@onready var modified_stats = []
var test_obj = preload("res://assets/prefabs/player/stancebuff.tscn")

@export var state = {
	"is_crouching" = false,
	"is_grounded" =true,
	"is_moving" =false}

func attach_player(_player):
	self.player = _player
	print("attached player to status manager")

func give_stance(stance):
	print("given stance: ")
	print(stance)
	if stance == "dash":
		stance_timer(self.player, 50, 0.5)

# a helper function to more comprehendably provide a stat change and its duration yada yada
func stance_timer(player, strength, duration):
	print("timer start")
	# print(player)

	# modified_stats.push_back(stat)
	# timer.set_base(stat)
	# timer.start(duration)
	# stat += strength
	# print(stat)
	var my_test_obj = test_obj.instantiate()
	self.add_child(my_test_obj)
	my_test_obj.set_base_stat(player)
	my_test_obj.modify_stat(strength, duration)
