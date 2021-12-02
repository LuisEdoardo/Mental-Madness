extends CanvasLayer

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused


func _on_Button_pressed():
	get_tree().paused = false
	set_visible(false)
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible


func _on_Button2_pressed():
	PlayerScore.score = 0
	PlayerScore.deaths = 0
	get_tree().change_scene("res://MainGame/Main-T.tscn")
	get_tree().paused = false
	set_visible(false)


func _on_Button3_pressed():
	get_tree().change_scene("res://MainMenu/Main.tscn")
	get_tree().paused = false
	set_visible(false)
