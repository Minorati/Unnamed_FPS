extends Node3D

@onready var collisionArea = $Area3D
@onready var timer = $Recharge

#How much HP is added/subtracted
@export var value = 25
#In seconds
@export var rechargeTimer = 5

func _ready():
	timer.wait_time = rechargeTimer
	timer.timeout.connect(_recharge_pickup)

func _on_area_3d_body_entered(body):
	body.health += value
	print(body.health)
	collisionArea.set_deferred("monitoring", false)
	visible = false
	
	timer.start()
	print("Pickup timer started!")

func _recharge_pickup():
	print("Pickup timer ended!")
	collisionArea.set_deferred("monitoring", true)
	visible = true
