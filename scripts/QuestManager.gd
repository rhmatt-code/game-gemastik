extends Node

var quests = {}
var active_quest = ""

signal quest_started(id)
signal quest_completed(id)
signal quest_progress(id, current, target)


func _ready() -> void:
	var file = FileAccess.open(
		"res://assets/quest/quests.json", FileAccess.READ
	)
	quests = JSON.parse_string(file.get_as_text())	

func start_quest(id:String):
	if !quests.has(id):
		push_error("Quest tidak ditemukan: " + id)
		return
	
	if quests[id]["status"] == "active":
		return
	
	if quests[id]["status"] == "completed":
		return
		
	quests[id]["status"] = "active"
	active_quest = id
	quest_started.emit(id)
	
func complete_quest(id:String):
	if !quests.has(id):
		return
	
	quests[id]["status"] = "completed"
	active_quest = ""
	quest_completed.emit(id)
func add_progress(id):

	if !quests.has(id):
		return

	if quests[id]["status"] != "active":
		return

	quests[id]["current"] += 1

	print(
		quests[id]["current"],
		"/",
		quests[id]["target"]
	)

	quest_progress.emit(
		id,
		quests[id]["current"],
		quests[id]["target"]
	)

	if quests[id]["current"] >= quests[id]["target"]:
		complete_quest(id)
		
func is_completed(id: String) -> bool:
	return get_status(id) == "completed"
	
func get_active():
	if active_quest == "":
		return null
	return quests[active_quest]
	
func get_status(id: String) -> String:
	if quests.has(id):
		return quests[id]["status"]

	return "locked"
	
func is_active(id: String) -> bool:
	return get_status(id) == "active"
