extends HBoxContainer

@onready var healthLabel = $HealthContainer/Health
@onready var armorLabel = $ArmorContainer/Armor
@onready var ammoLabel = $AmmoContainer/Ammo
@onready var devilTriggerLabel = $DevilTriggerContainer/DevilTrigger

@onready var values = $"../UI_Values"

#Updates labels with values from UI_Values 

func _process(_delta):
	healthLabel.set_text("%s" % values.health)
	armorLabel.set_text("%s" % values.armor)
	ammoLabel.set_text("%s" % values.ammo)
	devilTriggerLabel.set_text("%s%%" % values.devilTrigger)
