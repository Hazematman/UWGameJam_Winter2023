extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var node_path
onready var source_node = get_node(node_path)

onready var bar = get_node("Bar")
onready var mover = get_node("Mover")

var start_position = 0
var end_position = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	start_position = bar.rect_global_position.x
	end_position = bar.rect_global_position.x + bar.rect_size.x - mover.texture.get_width()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var progress = source_node.progress
	
	mover.position.x = lerp(start_position, end_position, progress)
