extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if has_node("Score"):
		$Score.text = "Score: %.1f" % Global.score
	else:
		OS.set_window_maximized(true)


func _on_Button_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/TestScene.tscn")


func _on_Tutorial_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/Tutorial.tscn")
