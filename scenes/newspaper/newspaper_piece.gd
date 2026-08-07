extends Node2D

@export var piece_id: int = 1

@onready var icon = $InteractIcon

var player_near := false
var collected := false
var waiting_collect := false

func _ready():
	icon.hide()
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

func _on_dialogue_finished():
	
	print("Dialog selesai:", piece_id)

	if !waiting_collect:
		return
	waiting_collect = false
	QuestManager.add_progress("chapter1_berita")
	queue_free()

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		return

	player_near = true
	icon.show()
	icon.play("default")

func _on_area_2d_body_exited(body):
	if body.name != "Player":
		return

	player_near = false
	icon.hide()

func _process(_delta):

	if collected:
		return

	if !player_near:
		return

	if DialogueManager.is_dialog_open:
		return

	if Input.is_action_just_pressed("Interact"):
		collected = true
		player_near = false
		waiting_collect = true
		$Area2D.monitoring = false

		DialogueManager.start("newspaper_found")
