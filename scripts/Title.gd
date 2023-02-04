extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("Score"):
		$Score.text = "Score: %.1f" % Global.score


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/TestScene.tscn")
