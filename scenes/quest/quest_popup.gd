extends CanvasLayer

@onready var title = $PanelContainer/VBoxContainer/Title
@onready var description = $PanelContainer/VBoxContainer/Description
@onready var progress = $PanelContainer/VBoxContainer/Progress

func _ready():
	hide()
	
func show_popup(t, d, current := -1, target := -1):

	title.text = t
	description.text = d

	if current >= 0:
		progress.show()
		progress.text = str(current) + " / " + str(target)
	else:
		progress.hide()

	show()

	await get_tree().create_timer(3).timeout

	hide()
