extends CharacterBody2D

@onready var animator = $AnimatedSprite2D
@onready var shadow = $Shadow
@export var speed := 300.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1

func _physics_process(delta: float) -> void:

	var direction = Input.get_axis("ui_left", "ui_right")

	velocity.x = direction * speed

	if direction > 0:
		animator.play("walk_right")
		shadow.play("walk_right")
		last_direction = 1
	elif direction < 0:
		last_direction = -1
		animator.play("walk_left")
		shadow.play("walk_left")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if last_direction == 1:
			animator.play("idle_right")
			shadow.play("idle_right")
		else:
			animator.play("idle_left")
			shadow.play("idle_left")

	move_and_slide()
