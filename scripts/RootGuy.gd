extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 1.0
var nutrient = 1.0
var progress = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var track = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Code here right now is to simulate health bars
	track += delta
	health = health - 0.01
	if health < 0:
		health = 1.0
		
	if track > 0.5:
		nutrient = nutrient - 0.01
		if nutrient < 0:
			nutrient = 1.0
			
	progress += 0.001
	if progress > 1.0:
		progress = 0
