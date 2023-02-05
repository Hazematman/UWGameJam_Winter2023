extends Node2D

const Root = preload("res://scripts/Root.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum Biome {
	FOREST,
	DESERT,
	OCEAN,
}

const biome_drain_rate = {
	Biome.FOREST : 1.9 * Root.root_gain[Root.Root.BASIC],
	Biome.DESERT : 2.5 * Root.root_gain[Root.Root.FILTER],
	Biome.OCEAN : 1.9 * Root.root_gain[Root.Root.FILTER],
}

const biome_colors = {
	Biome.FOREST : Color.chartreuse,
	Biome.DESERT : Color.sandybrown,
	Biome.OCEAN : Color.aqua,
}

const biome_sounds = {
	Biome.FOREST : preload("res://audio/Forest Theme.ogg"),
	Biome.DESERT : preload("res://audio/Desert Theme.ogg"),
	Biome.OCEAN : preload("res://audio/Ocean Theme.ogg"),
}

const biome_graphics = {
	Biome.FOREST : preload("res://scenes/Forest.tscn"),
	Biome.DESERT : preload("res://scenes/Desert.tscn"),
	Biome.OCEAN : preload("res://scenes/Ocean.tscn"),
}

var progress = 0.0
var current_biome = Biome.FOREST

export(float) var progression_rate = 1.0 / 8.0

export(NodePath) var node_path
onready var character = get_node(node_path)

var biome_gfx = []


func set_biome_graphic():
	#$ColorRect.color = biome_colors[current_biome]
	for gfx in biome_gfx:
		gfx.queue_free()
	biome_gfx = []
	
	var new_gfx = biome_graphics[current_biome].instance()
	for child in new_gfx.get_children():
		new_gfx.remove_child(child)
		$ForegroundParallax.add_child(child)
		biome_gfx.append(child)

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
	change_biome(current_biome)
	#$ParallaxBackground.scroll_offset = Vector2(0, 0) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress += delta*progression_rate
	if progress >= 1.0:
		change_biome()
		progress = 0.0
		
	$ParallaxBackground.scroll_offset.x = -1000*progress
	$ForegroundParallax.scroll_offset.x = -1000*progress
