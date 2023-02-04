extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var impulse = Vector2(200,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bot.apply_impulse(Vector2(0,0), impulse)
