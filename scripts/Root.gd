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
	Root.FILTER : 0.005,
	Root.EATER : 0.0
}

const root_grow_rate = {
	Root.BASIC : 0.001,
	Root.FILTER : 0.0,
	Root.EATER : 0.01,
}

const root_cost = {
	Root.BASIC : 0.1,
	Root.FILTER : 0.2,
	Root.EATER : 0.3,
}

const root_lifespan = {
	Root.BASIC : 15,
	Root.FILTER : 10,
	Root.EATER : 5,
}

var mouse_over = false
var root = null
var current_root = null
var life = 0

# Use more complicated logic on the card path because we want it to
# be null when we use roots in the tutorial
export(NodePath) var card_path = null
onready var card_selector = get_node(card_path) if card_path != null else null

export(NodePath) var player_path
onready var player = get_node(player_path)

export(NodePath) var tree_path
onready var tree = get_node(tree_path)

export(bool) var can_click = true

const root_asset = {
	Root.BASIC : preload("res://scenes/RootBasic.tscn"),
	Root.FILTER : preload("res://scenes/RootFilter.tscn"),
	Root.EATER : preload("res://scenes/RootEater.tscn"),
}

const root_tree_graphics = {
	Root.BASIC : preload("res://assets/tree_clipped.png"),
	Root.FILTER : preload("res://assets/filter_tree.png"),
	Root.EATER : preload("res://assets/carn_tree.png"),
}

const audio_insuffcient = preload("res://audio/Not enough nutrients.ogg")
const audio_grow = preload("res://audio/Nutrient Grow.ogg")

func grow_root(type):
	assert(root == null, "Can't grow root when one already exists")
	if player.create_root(root_cost[type]):
		current_root = type
		root = root_asset[current_root].instance()
		add_child(root)
		root.connect("clicked", self, "_on_root_click")
		life = root_lifespan[type]
		tree.grow(root_tree_graphics[current_root])
		
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.stream = audio_grow
		$AudioStreamPlayer.play()
	else:
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer.stream = audio_insuffcient
		$AudioStreamPlayer.play()
	
func kill_root():
	if root != null:
		remove_child(root)
		root.queue_free()
		root = null
		current_root = null
		tree.kill()

# Called when the node enters the scene tree for the first time.
func _ready():
	player.register_root(self)

func _input(event):
	if can_click and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if mouse_over and root == null:
			card_selector.set_root(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_root != null:
		life -= delta
		if life <= 0.0:
			kill_root()
			

func _on_root_click():
	kill_root()

func _on_RootCollider_mouse_entered():
	mouse_over = true

func _on_RootCollider_mouse_exited():
	mouse_over = false
