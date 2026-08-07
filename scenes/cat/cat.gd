extends CharacterBody2D


@onready var icon = $InteractIcon
@onready var cat = $Sprite2D

var player_near := false
var collected := false

func _ready() -> void:
	print(GameManager.print_state())
	icon.hide()
	cat.play('default')
	DialogueManager.dialogue_finished.connect(_on_dialog_finished)

func _on_dialog_finished():
	if DialogueManager.current_dialog_id != "cat_found":
		return
	GameManager.set_story_state(GameManager.StoryState.FIND_CAT)
	queue_free()
func _on_area_2d_body_entered(body):
	if body.name != "Player":
		return
	
	player_near = true
	if GameManager.is_state(GameManager.StoryState.INVESTIGATE):
		icon.show()
		icon.play("default")
	
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_near = false
		icon.hide()
	
func _process(_delta):
	if collected:
		return
	if !player_near:
		return
	if DialogueManager.is_dialog_open:
		return
	if Input.is_action_just_pressed("Interact") and QuestManager.is_active("chapter1_find_cat"):
		collected = true
		DialogueManager.start("cat_found")
		GameManager.set_story_state(GameManager.StoryState.FIND_CAT)
