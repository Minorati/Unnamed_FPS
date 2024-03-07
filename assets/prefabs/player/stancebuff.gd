extends Node3D


@onready var base_speed = null
@onready var timer = $Timer
@onready var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("created timer")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_base_stat(_player):
	self.player = _player
	print(self.player)
	#print(player.BASE_SPEED)
	
func modify_stat(strength, duration):
	self.player.SPEED += strength
	timer.start(duration)

func _on_timer_timeout():
	print("timed out")
	player.SPEED = player.BASE_SPEED

	#self.queue_free()
