extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(NodePath) var node_path
export(String) var tracking_property
onready var source_node = get_node(node_path)

var size = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	size = rect_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rect_size.y = size.y * (source_node[tracking_property])
