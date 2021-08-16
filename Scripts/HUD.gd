extends Control

onready var bronze 	= $MarginContainer/HBoxContainer/HBoxContainer/Bronze/Count
onready var silver 	= $MarginContainer/HBoxContainer/HBoxContainer/Silver/Count
onready var gold 	= $MarginContainer/HBoxContainer/HBoxContainer/Gold/Count

onready var lives 	= $MarginContainer/HBoxContainer/HSplitContainer/Label

var coins = 0

func _ready():
	bronze.text = "0"
	silver.text = "0"
	gold.text = "0"


func increment(amount):
	coins += amount
	var tmp = coins
	
	gold.text = str(round(tmp / 100))
	tmp = int(tmp) % 100
	
	silver.text = str(round(tmp / 10))
	tmp = int(tmp) % 10
	
	bronze.text = str(tmp)


func _on_Player_pickCoin(value):
	increment(value)


func _on_Player_lifeChange(value):
	lives.text = str(value)
