extends Node2D

const Root = preload("res://scripts/Root.gd")

var slide = 0

var text = [
	"Hello, I am a magic turtle migrating through the world",
	"I grow magical roots to survive",
	"Depending on the climate I need to use different roots",
	"My basic roots will provide me with water and nutrients",
	"My filtering roots will provide me with lots of water\n but no nutrients",
	"My carnivorous roots will eat everything in sight,\n giving me lots of nutrients but no water",
	"If I run out of water I will die",
	"Please help me complete my journey safely",
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer5/RichTextLabel.text = text[0]
	$CanvasLayer5/Node2D2.visible = false
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		slide += 1
		if slide >= len(text):
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/TestScene.tscn")
			return
		elif slide == 3:
			$CanvasLayer2/Root.grow_root(Root.Root.BASIC)
			$CanvasLayer2/Root2.grow_root(Root.Root.BASIC)
			$CanvasLayer2/Root3.grow_root(Root.Root.BASIC)
		elif slide == 4:
			$CanvasLayer2/Root.kill_root()
			$CanvasLayer2/Root2.kill_root()
			$CanvasLayer2/Root3.kill_root()
			
			$CanvasLayer2/Root.grow_root(Root.Root.FILTER)
			$CanvasLayer2/Root2.grow_root(Root.Root.FILTER)
			$CanvasLayer2/Root3.grow_root(Root.Root.FILTER)
		elif slide == 5:
			$CanvasLayer2/Root.kill_root()
			$CanvasLayer2/Root2.kill_root()
			$CanvasLayer2/Root3.kill_root()
			
			$CanvasLayer2/Root.grow_root(Root.Root.EATER)
			$CanvasLayer2/Root2.grow_root(Root.Root.EATER)
			$CanvasLayer2/Root3.grow_root(Root.Root.EATER)
		elif slide == 6:
			$CanvasLayer2/Root.kill_root()
			$CanvasLayer2/Root2.kill_root()
			$CanvasLayer2/Root3.kill_root()
			$CanvasLayer5/Node2D2.visible = true
			
		$CanvasLayer5/RichTextLabel.text = text[slide]
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$CanvasLayer2/RootGuy.water = 1.0
	$CanvasLayer2/RootGuy.nutrient = 1.0
