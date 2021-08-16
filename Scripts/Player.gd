extends KinematicBody2D

export var MAXSPEED = 1200
export var ACC = 2400
export var GRAV = 100
export var JUMP = -1600
export var FRIC = 0.2
export var DEVMODE = true
export var KNOCKFORCE = Vector2(10, 25) * 2/3

export var MAXJETBOOST = 2400
var jet_boost = 0

var motion = Vector2.ZERO

var jumped = false
onready var anim = $PlayerSprite/AnimationPlayer
var WIDTH = ProjectSettings.get("display/window/size/width")

var knocked = false
var lives = 6

signal lifeChange(value)
signal pickCoin(value)

func _ready():
	emit_signal("lifeChange", lives)	

func _physics_process(delta):
	
	if position.x > WIDTH:
		position.x = 0
		
	elif position.x < 0: position.x = WIDTH
	
	if position.y >= 2020:
		get_tree().reload_current_scene()

	if not knocked:
		if is_on_floor():
			
			if jumped:
				jumped = false
				$Feet/SmokeParticles.emitting = true
				
			if Input.is_action_pressed("move_jump"):
				jumped = true
				motion.y = JUMP
				anim.play("Jump")

		else: fall()
		
		if jet_boost > 0:
			motion.y = -jet_boost
			jet_boost -= 0.4 * MAXJETBOOST * delta
			if jet_boost < 0.5: setJet(false) 
		
		else:
			var inp = 	Input.get_action_strength("move_right") -\
						Input.get_action_strength("move_left")
			
			if inp: motion.x += inp * ACC * delta
			
			if sign(inp) != sign(motion.x): motion.x = lerp(motion.x, 0, FRIC)
			
			if not jumped:
				if abs(motion.x) > 4:
					$PlayerSprite.scale.x = sign(motion.x)
					anim.playback_speed = abs(motion.x) / MAXSPEED * 2
					anim.play("Walk")
				
				else:
					motion.x = 0
					anim.playback_speed = 0.35
					anim.play("Idle")
				
	elif is_on_floor():
		knocked = false
		
	else:
		fall()
		anim.play("Hurt")
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	motion = move_and_slide(motion, Vector2.UP)
	
	
func hitAndKnock(pos):
	knocked = true
	var diff = (position - pos)
	motion = diff * KNOCKFORCE
	
	if $Bubble.visible:
		$Bubble.visible = false
		
	else:
		lives -= 1
		emit_signal("lifeChange", lives)
		
		if lives <= 0:
			get_tree().reload_current_scene()

func fall():
	if Input.is_action_pressed("move_jump"):
		motion.y += GRAV / 2

	else: motion.y += GRAV
	
	
func pickUp(type):
	match type:
		"jetpack":
			setJet(true)
			
		"bubble":
			$Bubble.visible = true


func setJet(enabled):
	collision_layer = int(not enabled)
	collision_mask = collision_layer
	$JetPack/Sprite.visible = enabled
	$JetPack/FlameParticles.emitting = enabled
	$JetPack/FlameParticles/SmokeParticles.emitting = enabled
	jet_boost = MAXJETBOOST * int(enabled)
	motion.x = 0


func _on_CoinPick_pickCoin(value):
	
	# Propagate
	emit_signal("pickCoin", value)
