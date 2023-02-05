extends Node2D

const Root = preload("res://scripts/Root.gd")
const Biome = preload("res://scripts/BiomeController.gd")

var slide = 0

var text = [
	"Hello, I am a magic turtle migrating through the world",
	"I grow magical roots to survive",
	"Depending on the climate I need to use different roots",
	"My basic roots will provide me with water and nutrients",
	"My filtering roots will provide me with lots of water\nbut no nutrients",
	"My carnivorous roots will eat everything in sight,\ngiving me lots of nutrients but no water",
	"You can left click on my belly to grow roots\nthis will cost me nutrients",
	"Without nutrients, I will not be able\nto grow any roots",
	"You can right click on my roots to remove them\nand give me back some nutrients",
	"If you wait, my roots will wither away",
	"The forest is safe, my basic roots will work there",
	"The ocean is more dangerous, you will need to\ncombine filtering roots and carnivorous roots",
	"The desert is very dangerous, only filtering\nroots can provide water there",
	"If I run out of water I will die",
	"Please help me complete my journey safely",
	"Are you ready? Click anywhere to begin",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer5/RichTextLabel.text = text[0]
	$CanvasLayer5/Node2D2.visible = false
	$CanvasLayer5/Node2D3.visible = false
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		slide += 1
		if slide >= len(text):
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/TestScene.tscn")
			return
		elif slide == 3:
			$CanvasLayer2/RootGuy/Root.grow_root(Root.Root.BASIC)
			$CanvasLayer2/RootGuy/Root2.grow_root(Root.Root.BASIC)
			$CanvasLayer2/RootGuy/Root3.grow_root(Root.Root.BASIC)
		elif slide == 4:
			$CanvasLayer2/RootGuy/Root.kill_root()
			$CanvasLayer2/RootGuy/Root2.kill_root()
			$CanvasLayer2/RootGuy/Root3.kill_root()
			
			$CanvasLayer2/RootGuy/Root.grow_root(Root.Root.FILTER)
			$CanvasLayer2/RootGuy/Root2.grow_root(Root.Root.FILTER)
			$CanvasLayer2/RootGuy/Root3.grow_root(Root.Root.FILTER)
		elif slide == 5:
			$CanvasLayer2/RootGuy/Root.kill_root()
			$CanvasLayer2/RootGuy/Root2.kill_root()
			$CanvasLayer2/RootGuy/Root3.kill_root()
			
			$CanvasLayer2/RootGuy/Root.grow_root(Root.Root.EATER)
			$CanvasLayer2/RootGuy/Root2.grow_root(Root.Root.EATER)
			$CanvasLayer2/RootGuy/Root3.grow_root(Root.Root.EATER)
		elif slide == 6:
			$CanvasLayer2/RootGuy/Root.kill_root()
			$CanvasLayer2/RootGuy/Root2.kill_root()
			$CanvasLayer2/RootGuy/Root3.kill_root()
			$CanvasLayer5/Node2D3.visible = true
		elif slide == 11:
			$CanvasLayer/BiomeController.change_biome(Biome.Biome.OCEAN)
		elif slide == 12:
			$CanvasLayer/BiomeController.change_biome(Biome.Biome.DESERT)
		elif slide == 13:
			$CanvasLayer5/Node2D2.visible = true
			
		$CanvasLayer5/RichTextLabel.text = text[slide]
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$CanvasLayer2/RootGuy.water = 1.0
	$CanvasLayer2/RootGuy.nutrient = 1.0
