extends CanvasLayer

@onready var name_label = $PanelContainer/MarginContainer/VBoxContainer/NameLabel
@onready var text_label = $PanelContainer/MarginContainer/VBoxContainer/TextLabel
@onready var continue_label = $PanelContainer/MarginContainer/VBoxContainer/ContinueLabel

var current_dialog = []
var current_index = 0
var current_name = ""

func _ready():
	hide()

func start_dialog(dialog:Array):
	current_dialog = dialog
	current_index = 0
	
	name_label.text = current_dialog[0]["speaker"]
	text_label.text = current_dialog[0]["text"]

	show()

func next_dialog():

	current_index += 1

	if current_index >= current_dialog.size():
		DialogueManager.end_dialog()
		return
	
	var line = current_dialog[current_index]

	name_label.text = line["speaker"]
	text_label.text = line["text"]

func hide_dialog():
	hide()
