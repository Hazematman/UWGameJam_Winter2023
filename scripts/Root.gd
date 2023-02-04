extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Root {
	BASIC,
	FILTER,
	EATER,
}

const root_gain = {
	Root.BASIC : 0.001,
	Root.FILTER : 0.001,
	Root.EATER : -0.001,
}

const root_cost = {
	Root.BASIC : 0.1,
	Root.FILTER : 0.2,
	Root.EATER : 0.3,
}

var mouse_over = false
var root = null
var current_root = null

export(NodePath) var card_path
onready var card_selector = get_node(card_path)

export(NodePath) var player_path
onready var player = get_node(player_path)

const root_basic = preload("res://scenes/RootBasic.tscn")

func grow_root(type):
	assert(root == null, "Can't grow root when one already exists")
	if player.create_root(root_cost[type]):
		current_root = type
		root = root_basic.instance()
		add_child(root)
		root.get_node("Area2D").connect("input_event", self, "_on_root_click")
	
func kill_root():
	remove_child(root)
	root.queue_free()
	root = null
	current_root = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player.register_root(self)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if mouse_over and root == null:
			card_selector.set_root(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
			

func _on_root_click(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		kill_root()


func _on_RootCollider_mouse_entered():
	mouse_over = true

func _on_RootCollider_mouse_exited():
	mouse_over = false
