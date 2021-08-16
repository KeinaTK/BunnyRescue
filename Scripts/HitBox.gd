extends Area2D

onready var parent = get_parent()


func _on_HitBox_body_entered(body):
	if body.name == "Player":
		body.hitAndKnock(parent.position)
