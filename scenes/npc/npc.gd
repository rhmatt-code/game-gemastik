extends CharacterBody2D

@onready var interact_icon = $InteractIcon
@onready var npc = $AnimatedSprite2D

var player_near := false

func _ready() -> void:
	interact_icon.hide()
	npc.play('default')
	print("QUEST: ",QuestManager.get_status("chapter1_ketua_desa"))
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

func _on_interact_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true
		
	var show_icon_states = [
		GameManager.StoryState.EXPLORE,
		GameManager.StoryState.INVESTIGATE,
		GameManager.StoryState.FIND_CAT,
		GameManager.StoryState.WAREHOUSE_UNLOCKED
	]

	if GameManager.story_state in show_icon_states:
		interact_icon.show()
		interact_icon.play("default")
	else:
		interact_icon.hide()

func _on_interact_area_2d_body_exited(body):
	if body.name == "Player":
		player_near = false
		interact_icon.hide()
		interact_icon.stop()
		print("EXIT")
	
func _on_dialogue_finished():
	if DialogueManager.current_dialog_id != "find_cat":
		return
	EventManager.trigger("warehouse_open")
	GameManager.set_story_state(GameManager.StoryState.WAREHOUSE_UNLOCKED)

func _process(_delta):
	if player_near \
	and Input.is_action_just_pressed("Interact"):
		match GameManager.story_state:
			GameManager.StoryState.EXPLORE:
				DialogueManager.start("saling_sapa")
			GameManager.StoryState.INVESTIGATE:
				DialogueManager.start("after_investigate")
				QuestManager.start_quest("chapter1_find_cat")
			GameManager.StoryState.FIND_CAT:
				DialogueManager.start("find_cat")
				QuestManager.complete_quest("chapter1_find_cat")
			GameManager.StoryState.WAREHOUSE_UNLOCKED:
				DialogueManager.start("kepala_desa_reward")
