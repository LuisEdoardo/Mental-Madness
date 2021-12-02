extends KinematicBody2D

const SPEED = 400
const FLOOR = Vector2(0, -1)
const GRAVITY = 16
const JUMP_HEIGHT = 600
onready var motion = Vector2.ZERO
var is_attacking = false 
const HEARTATTACK = preload("res://HeartAttack/Heart.tscn")

func _process(_delta):
	motion_ctrl()
	if Input.is_key_pressed(KEY_F) && get_axis().x != 0:
		$AnimationPlayer.play("Run-s")
	
	if (get_slide_count() >= 0):
		for i in range(get_slide_count()):
			if "O" in get_slide_collision(i).collider.name:
				touched()
	
	
	
		


func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis
	

func motion_ctrl():
	motion.y += GRAVITY
	
	if get_axis().x == 1:
		$Sprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif get_axis().x == -1:
		$Sprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	if get_axis().x != 0:
		motion.x =  get_axis().x * SPEED
	else:
		motion.x = 0
		
	if is_on_floor():
		if get_axis().x != 0:
			$AnimationPlayer.play("Run")
		elif(get_axis().x == 0 && is_attacking == false):
			$AnimationPlayer.play("Idle")
		if Input.is_action_just_pressed("ui_up"):
			motion.y -= JUMP_HEIGHT
		if Input.is_key_pressed(KEY_S) && get_axis().x == 0 && is_attacking == false:
			is_attacking = true
			$AnimationPlayer.play("Shoot")
			var heartattack = HEARTATTACK.instance()
			if sign($Position2D.position.x) == 1:
				heartattack.set_direction(1)
			else:
				heartattack.set_direction(-1)
			get_parent().add_child(heartattack)
			heartattack.position = $Position2D.global_position
		if Input.is_action_pressed("ui_down") && get_axis().x == 0 :
			$AnimationPlayer.play("Crouch")
	else:
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
			
	motion = move_and_slide(motion, FLOOR)


func _on_AnimationPlayer_animation_finished(Shoot):
	is_attacking = false


func touched():
	if ($Dead.playing == false):
		$Dead.play()
	hide()
	$CollisionShape2D.disabled = true
	PlayerScore.deaths += 1
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()
	get_tree().change_scene("res://GameOver/GameOver.tscn")


func _on_Portal_body_entered(body):
	if "Player" in body.name:
		hide()
		$YES.play()
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://End/End.tscn")
