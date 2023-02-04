extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var impulse = Vector2(200,0)

signal clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bot.apply_impulse(Vector2(0,0), impulse)


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		emit_signal("clicked")
