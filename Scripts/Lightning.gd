extends Area2D

var motion = Vector2.ZERO
const ACC = 20
const MAXSPEED = 300

func _process(delta):
	motion.y = min(motion.y + ACC * delta, MAXSPEED)
	global_position += motion
	
	if position.y >= 2020: queue_free()


func _on_Lightning_body_entered(body):
	if body.name == "Player":
		body.hitAndKnock(position)
