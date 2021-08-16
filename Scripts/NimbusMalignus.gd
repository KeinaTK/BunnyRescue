extends Control

onready var lightning = preload("res://Scripts/Lightning.tscn")
onready var parent = get_parent()
onready var root = parent.get_parent()

export(NodePath) var camera_path
onready var camera = get_node(camera_path)

var miny = -1200

func _ready():
	$AnimationPlayer.play("Go")

func _on_Timer_timeout():
	var l = lightning.instance()
	
	l.position = $Sprite.global_position +\
				Vector2(0, camera.global_position.y - 1920/2 + 50)
	root.add_child(l)
