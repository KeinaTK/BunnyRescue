extends Node2D

func _process(delta):
	if visible: scale.y = rand_range(0.65, 1)
