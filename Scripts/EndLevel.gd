extends Area2D

export(String, FILE, "*.tscn") var next_level

func _on_EndLevel_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_level)
