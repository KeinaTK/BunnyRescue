extends Area2D

export(String, "jetpack", "bubble") var type

func _ready():
	$Sprite.queue_free()
	print(type)
	add_child(load("res://Prefabs/powerup_" + type + ".tscn").instance())

func _on_JetPick_body_entered(body):
	if body.name == "Player":
		body.pickUp(type)
		queue_free()
