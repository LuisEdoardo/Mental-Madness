extends Area2D

export var score = 1

func _ready():
	pass 




func _on_Face_body_entered(body):
	if "Player" in body.name:
		picked()


func picked():
	PlayerScore.score += score
	$Laugh.play()
	hide()
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()

