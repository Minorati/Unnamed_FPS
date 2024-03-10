extends Area3D


# Called when the node enters the scene tree for the first time.
func can_stand() -> bool:
	if get_overlapping_bodies():
		return false
	return true
