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
		if QuestManager.is_completed("chapter1_ketua_desa"):
			DialogueManager.start("pak_tani_selesai")
		elif QuestManager.is_active("chapter1_ketua_desa"):
			DialogueManager.start("pak_tani_progress")
		else:
			player_near = false
			DialogueManager.start("ibu_desa")
