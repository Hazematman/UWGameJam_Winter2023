extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Biome {
	FOREST,
	DESERT,
	OCEAN,
}

var biome_drain_rate = {
	Biome.FOREST : 0.001,
	Biome.DESERT : 0.1,
	Biome.OCEAN : 0.01,
}

var biome_colors = {
	Biome.FOREST : Color.chartreuse,
	Biome.DESERT : Color.sandybrown,
	Biome.OCEAN : Color.aqua,
}

var progress = 0.0
var current_biome = Biome.FOREST

export(float) var progression_rate = 0.001

export(NodePath) var node_path
onready var character = get_node(node_path)

func set_biome_graphic():
	$ColorRect.color = biome_colors[current_biome]

func change_biome():
	current_biome = Biome.values()[randi() % Biome.size()]
	set_biome_graphic()


# Called when the node enters the scene tree for the first time.
func _ready():
	set_biome_graphic()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += progression_rate
	if progress >= 1.0:
		change_biome()
		progress = 0.0
		
	character.water -= biome_drain_rate[current_biome]
