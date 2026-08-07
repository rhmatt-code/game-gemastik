extends Node2D

@onready var icon = $InteractIcon

var player_near := false
var is_open := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractIcon.hide()
	QuestManager.quest_completed.connect(_on_quest_completed)
	if QuestManager.get_status("chapter1_berita") == "locked":
		QuestManager.start_quest("chapter1_berita")
		DialogueManager.start("warehouse_intro")

func _on_quest_completed(id):
	if id != "chapter1_berita":
		return
	DialogueManager.start("newspaper_complete")
	var puzzle = preload("res://scenes/puzzle/NewspaperPuzzle.tscn").instantiate()
	add_child(puzzle)
	puzzle.show()
func _on_interact_area_body_entered(body):
	if body.name != "Player":
		return
	player_near = true
	$InteractIcon.show()
	icon.play("enter")
	
func _on_interact_area_body_exited(body):
	if body.name != "Player":
		return
	player_near = false
	$InteractIcon.hide()
	

func exit_warehouse():
	GameManager.spawn_point = "warehouse_exit"
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _process(_delta):

	if !player_near:
		return

	if Input.is_action_just_pressed("Interact"):
		exit_warehouse()
