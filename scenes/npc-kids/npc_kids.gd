extends CharacterBody2D

@onready var interact_icon = $InteractIcon
@onready var npc = $AnimatedSprite2D
@onready var shadow = $Shadow

var player_near := false

func _ready() -> void:
	interact_icon.hide()
	npc.play('default')
	shadow.play('default')

func _on_interact_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true
		if GameManager.is_state(GameManager.StoryState.FOUND_WAREHOUSE):
			interact_icon.show()
			interact_icon.play("default")
			print("ENTER")

func _on_interact_area_2d_body_exited(body):
	if body.name == "Player":
		player_near = false
		interact_icon.hide()
		interact_icon.stop()
		print("EXIT")
	

func _process(_delta):
	if player_near \
	and Input.is_action_just_pressed("Interact"):
		if GameManager.is_state(GameManager.StoryState.FOUND_WAREHOUSE):
			DialogueManager.start("investigate")
			GameManager.set_story_state(GameManager.StoryState.INVESTIGATE)
