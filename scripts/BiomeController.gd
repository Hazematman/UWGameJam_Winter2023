extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Biome {
	FOREST,
	DESERT,
	OCEAN,
}

const biome_drain_rate = {
	Biome.FOREST : 0.001,
	Biome.DESERT : 0.01,
	Biome.OCEAN : 0.005,
}

const biome_colors = {
	Biome.FOREST : Color.chartreuse,
	Biome.DESERT : Color.sandybrown,
	Biome.OCEAN : Color.aqua,
}

const biome_sounds = {
	Biome.FOREST : preload("res://audio/Forest Theme.ogg"),
	Biome.DESERT : preload("res://audio/Forest Theme.ogg"),
	Biome.OCEAN : preload("res://audio/Forest Theme.ogg"),
}

var progress = 0.0
var current_biome = Biome.FOREST

export(float) var progression_rate = 0.001

export(NodePath) var node_path
onready var character = get_node(node_path)

func set_biome_graphic():
	$ColorRect.color = biome_colors[current_biome]

func change_biome(biome_type=null):
	if biome_type == null:
		var new_biome = null
		while new_biome == null or new_biome == current_biome:
			new_biome = Biome.values()[randi() % Biome.size()]
		current_biome = new_biome
	else:
		current_biome = biome_type
	set_biome_graphic()
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = biome_sounds[current_biome]
	$AudioStreamPlayer.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	character.register_biome(self)
	change_biome(Biome.FOREST)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += progression_rate
	if progress >= 1.0:
		change_biome()
		progress = 0.0
