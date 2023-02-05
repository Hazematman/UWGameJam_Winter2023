extends Node2D

const Root = preload("res://scripts/Root.gd")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_root = null
var currently_visible = false


func set_root(root):
	if current_root == null:
		current_root = root
		currently_visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	visible = currently_visible


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed \
		and current_root != null:
		current_root.grow_root(Root.Root.BASIC)
		currently_visible = false
		current_root = null


func _on_Area2D2_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed \
		and current_root != null:
		current_root.grow_root(Root.Root.FILTER)
		currently_visible = false
		current_root = null

func _on_Area2D3_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed \
		and current_root != null:
		current_root.grow_root(Root.Root.EATER)
		currently_visible = false
		current_root = null
