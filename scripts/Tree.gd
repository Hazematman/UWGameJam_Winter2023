extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func grow(image):
	$Sprite.texture = image
	visible = true

func kill():
	visible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
