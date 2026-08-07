extends Node

signal dialogue_finished
var dialog_box
var dialog_data
var is_dialog_open = false
var current_dialog_id = ""
var waiting_release = false
var input_locked = false
var can_interact := true

func _ready():

	dialog_box = preload("res://scenes/ui/DialogBox.tscn").instantiate()
	get_tree().current_scene.add_child(dialog_box)

	var file = FileAccess.open(
		"res://assets/dialog/dialog.json",
		FileAccess.READ
	)

	dialog_data = JSON.parse_string(file.get_as_text())


func start(id):
	create_dialog_box()
	if !dialog_data.has(id):
		return
	if !can_interact:
		return
	can_interact = false
	input_locked = true
	current_dialog_id = id
	var npc = dialog_data[id]
	is_dialog_open = true
	dialog_box.start_dialog(
		npc.dialog
	)
	
func create_dialog_box():
	if is_instance_valid(dialog_box):
		return
	dialog_box = preload("res://scenes/ui/DialogBox.tscn").instantiate()
	get_tree().current_scene.add_child(dialog_box)

func next():
	print("NEXT DITEKAN")
	dialog_box.next_dialog()

func end_dialog():
	is_dialog_open = false

	dialog_box.hide_dialog()

	dialogue_finished.emit()

	current_dialog_id = ""

	can_interact = true
	input_locked = false

func _process(_delta):

	if DialogueManager.is_dialog_open:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.next()
		return

func _input(event):

	if !is_dialog_open:
		return
	if event.is_action_pressed("Interact"):
		next()
	get_viewport().set_input_as_handled()
