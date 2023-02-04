extends Node2D

const Root = preload("res://scripts/Root.gd")
const Biome = preload("res://scripts/BiomeController.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var water = 1.0
var nutrient = 1.0

var roots = []
var biome = null

func register_root(root):
	roots.append(root)
	
func register_biome(biome_node):
	biome = biome_node
	
func game_over():
	print("GAME OVER")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


var track = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Code here right now is to simulate health bars
	track += delta
	
	nutrient = nutrient - 0.01
	if nutrient < 0:
		nutrient = 1.0
	
	var drain = 0
	for root in roots:
		if root.current_root != null:
			drain -= Root.root_drain[root.current_root]
		
	drain += Biome.biome_drain_rate[biome.current_biome]
	
	water -= drain
	
	if water >= 1.0:
		water = 1.0
	elif water <= 0.0:
		game_over()
