extends Area2D

const SPEED = 600
var velocity = Vector2()
var direction = 1
func _ready():
	pass 

func set_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)

		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Heart_body_entered(body):
	if "O" in body.name:
		body.happy()
	queue_free()