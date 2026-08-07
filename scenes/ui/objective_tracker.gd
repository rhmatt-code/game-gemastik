extends CanvasLayer

@onready var title = $PanelContainer/VBoxContainer/Title
@onready var progress = $PanelContainer/VBoxContainer/Progress

func _ready():
	hide()

func show_objective(t, current, target):

	title.text = t
	progress.text = "%d / %d" % [current, target]

	show()

func update_progress(current, target):

	progress.text = "%d / %d" % [current, target]

func complete():

	title.text = "✔ OBJECTIVE COMPLETE"

	await get_tree().create_timer(1.5).timeout

	hide()
