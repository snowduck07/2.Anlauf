extends CharacterBody2D

var enemy_in_range = false
var enemy_cooldown = true
var health = 100 
var attack_ip = false

const SPEED = 380.0
const JUMP_VELOCITY = -450.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	if Input.is_action_just_pressed("jump") and is_on_floor() and Global.player_attack == false:
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("walk_left", "walk_right")

	if direction and Global.player_attack == false:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if attack_ip == false:
			$AnimatedSprite2D.play("idle")


	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")

	move_and_slide()
	enemy_attack()
	player_attack()

	if health <= 0:
		health = 0
		get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")
		Global.alive = false

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false

func enemy_attack():
	if enemy_in_range and enemy_cooldown:
		health = health - 20
		enemy_cooldown = false
		$enemy_cooldown.start()
		print(health)

func _on_cooldown_timeout():
	enemy_cooldown = true

func player_attack():
	var current_direction = "right"
	
	if Input.is_action_just_pressed("walk_left"):
		current_direction = "left"
	elif Input.is_action_just_pressed("walk_right"):
		current_direction = "right"
	
	if Input.is_action_just_pressed("attack"):
		Global.player_attack = true
		attack_ip = true
		if current_direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("attack")
			$player_cooldown.start()
		if current_direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("attack")
			$player_cooldown.start()

func _on_player_cooldown_timeout():
	$player_cooldown.stop()
	Global.player_attack = false
	attack_ip = false



func player():
	pass


