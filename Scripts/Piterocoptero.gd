extends KinematicBody2D

const SPEED = 6000
var motion = Vector2.UP
var pos
const max_translate = 150

const AnimTrans = {
	Vector2.UP: "Up",
	Vector2.DOWN: "Down"
}

func _ready():
	pos = global_position


func _physics_process(delta):
	
	if (global_position - pos).length() > max_translate:
		motion *= -1
		$AnimatedSprite.animation = AnimTrans[motion]
		
	move_and_slide(motion * SPEED * delta, Vector2.UP)
