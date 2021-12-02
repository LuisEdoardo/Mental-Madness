extends CanvasLayer

func _ready():
	pass 




func _on_Button_pressed():
	PlayerScore.score = 0
	PlayerScore.deaths = 0
	get_tree().change_scene("res://MainMenu/Main.tscn")
