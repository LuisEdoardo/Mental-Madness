extends Button

var mainScene = load("res://MainGame/Main-T.tscn")

func _ready():
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene_to(mainScene)


func _on_Button2_pressed():
	if OS.has_feature("JavaScript"):
		JavaScript.eval("window.close()")
	else:
		get_tree().quit()
