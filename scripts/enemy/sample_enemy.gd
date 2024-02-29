extends RigidBody3D
class_name enemy

func receive_damage(damage):
	print("took damage: " + str(damage))
	receive_knockback(0, 4)
	
# get coordinates of source, calculate with coordinates of enemy
# multiply vector by strength
func receive_knockback(source, strength):
	linear_velocity.y += strength
		
