extends CharacterBody2D

var enemy_in_range = false
var enemy_cooldown = true
var health = 100 
var alive = true
var attack_ip = false

const SPEED = 380.0
const JUMP_VELOCITY = -450.0


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):


	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("walk_left", "walk_right")

	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("run")
		if direction == -1:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")

	move_and_slide()
	enemy_attack()

	if health <= 0:
		health = 0
		get_tree().change_scene_to_file("res://scenes/deathscreen.tscn")

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
		$cooldown.start()
		print(health)

func _on_cooldown_timeout():
	enemy_cooldown = true

func player():
	pass
