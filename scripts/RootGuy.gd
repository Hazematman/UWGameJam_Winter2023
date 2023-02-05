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
	
func create_root(root_cost):
	if nutrient - root_cost > 0.0:
		nutrient -= root_cost
		return true
	return false
	
func game_over():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/GameOver.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.score = 0.0
	pass # Replace with function body.

func run_root_logic():
	var drain = 0
	var grow = 0
	for root in roots:
		if root.current_root != null:
			# Basic roots are useless in ocean
			if biome.current_biome == Biome.Biome.OCEAN and root.current_root == Root.Root.BASIC:
				continue
			else:
				drain -= Root.root_gain[root.current_root]
				
			grow += Root.root_grow_rate[root.current_root]
		
	drain += Biome.biome_drain_rate[biome.current_biome]
	
	water -= drain
	
	if water >= 1.0:
		water = 1.0
	elif water <= 0.0:
		water = 0.0
		game_over()
		
	nutrient += grow
	if nutrient >= 1.0:
		nutrient = 1.0
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
var counter = 0
func _process(delta):
	counter += delta
	
	if counter >= (1.0 / 20.0):
		run_root_logic()
		counter = 0
		
	Global.score += delta

