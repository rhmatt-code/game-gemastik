extends Node

var tracker

func _ready():

	tracker = preload("res://scenes/ui/ObjectiveTracker.tscn").instantiate()

	add_child(tracker)

	QuestManager.quest_started.connect(_on_started)
	QuestManager.quest_progress.connect(_on_progress)
	QuestManager.quest_completed.connect(_on_completed)

func _on_started(id):

	var q = QuestManager.quests[id]

	if q.has("target"):
		tracker.show_objective(
			q["title"],
			q["current"],
			q["target"]
		)

func _on_progress(id, current, target):

	tracker.update_progress(current, target)

func _on_completed(id):

	tracker.complete()
