extends Node3D

var is_crouching = false
var is_grounded =true
var is_moving =false

@export var state = {
	"is_crouching" = false,
	"is_grounded" =true,
	"is_moving" =false}

func attach_player(player):
	print("attached player to status manager")

func give_stance(stance):
	print("given stance: ")
	print(stance)
	if stance == "dash":
		pass
		# stance_timer(player.speed, 5, 1000)

# a helper function to more comprehendably provide a stat change and its duration yada yada
func stance_timer(stat, strength, duration):
	pass