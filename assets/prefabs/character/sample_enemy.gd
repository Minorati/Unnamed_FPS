extends RigidBody3D
class_name enemy

func receive_damage(damage):
	print("took damage: " + str(damage))
