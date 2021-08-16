extends KinematicBody2D

const SPEED = 80
const GRAV = 100

var motion = Vector2.ZERO
var direction = Vector2.RIGHT

onready var spr = $AnimatedSprite

func _physics_process(delta):
	motion.x = direction.x * SPEED
	motion.y = GRAV
	
	spr.play("Walk")
	spr.scale.x = direction.x
	
	motion = move_and_slide(motion, Vector2.UP)


func sensor(body):
	if body is TileMap: direction *= -1


func _on_FeetSensors_body_exited(body):
	sensor(body)


func _on_RightSensor_body_exited(body):
	sensor(body)
