extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var node_path
export(String) var tracking_property
onready var source_node = get_node(node_path)

var start_pos = Vector2(0, 0)
var size = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = $Light2D.position
	size = $Light2D.scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Light2D.position.y = start_pos.y + size.y * (1.0 - source_node[tracking_property])
