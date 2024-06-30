extends CharacterBody2D

var speed = 200
var chase = false
var player = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta - 15

	if chase:
		position += (player.position - position).normalized() * speed * delta
		move_and_slide() 



func _on_detection_area_body_entered(body):
	player = body
	chase = true

func _on_detection_area_body_exited(body):
	player = null
	chase = false

func enemy():
	pass
