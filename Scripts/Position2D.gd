extends Position2D

export(NodePath) var camera_path
onready var camera = get_node(camera_path)

func _ready():
	position = Vector2.ZERO

func _process(delta):
	position.y = min(position.y, camera.position.y) - 1200
