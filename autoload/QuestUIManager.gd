extends Node

var popup

func _ready():
	QuestManager.quest_started.connect(_on_started)
	QuestManager.quest_completed.connect(_on_progress)



func _on_progress(id, current, target):

	var q = QuestManager.quests[id]

	popup.show_popup(
		q["title"],
		q["description"],
		current,
		target
	)
	
func create_popup():
	if is_instance_valid(popup):
		return

	popup = preload("res://scenes/quest/QuestPopup.tscn").instantiate()
	get_tree().current_scene.add_child(popup)

func _on_started(id):
	create_popup()

	var q = QuestManager.quests[id]

	popup.show_popup(
		q["title"],
		q["description"],
	)
	
func _on_completed(id):

	create_popup()

	var q = QuestManager.quests[id]

	popup.show_complete(
		q["title"]
	)
