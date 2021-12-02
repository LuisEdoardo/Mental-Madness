extends KinematicBody2D
const GRAVITY = 10
const SPEED = 200
const FLOOR = Vector2(0, -1)
var velocity = Vector2()
var direction = 1
var is_happy = false

func happy():
	is_happy = true 
	$AnimatedSprite.play("Happy")
	$AnimationPlayer.play("Idle")
	$CollisionShape2D.set_deferred("disabled", true)
	if ($Thanks.playing == false):
		$Thanks.play()
	
	

func _ready():
	pass 

func _physics_process(delta):
	if is_happy == false:
		velocity.x = SPEED * direction
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		$AnimationPlayer.play("Walk")
		$AnimatedSprite.play("Sad")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		#$RayCast2D.position *= -1
	
	#if $RayCast2D.is_colliding() == false:
		#direction = direction * -1
	
	if (get_slide_count() > 0):
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.touched()
