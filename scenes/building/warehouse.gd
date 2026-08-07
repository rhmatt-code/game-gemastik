extends Node2D


@onready var sprite = $Sprite2D
@onready var icon = $InteractIcon

var closed_texture = preload("res://assets/building/warehouse_closed.png")
var open_texture = preload("res://assets/building/warehouse_open.png")

var player_near := false
var is_open := false

func _ready() -> void:
	
	is_open = false
	sprite.texture = closed_texture
	$InteractIcon.hide()
	close_door()

	
		
func open_door():
	is_open = true
	sprite.texture = open_texture
	print("is_open", is_open)
	if player_near:
		$InteractIcon.show()
	
func close_door():
	is_open = false
	sprite.texture = closed_texture

func _on_interact_area_body_entered(body):
	if body.name != "Player":
		return
	player_near = true
	$InteractIcon.show()
	
	
	if is_open:
		icon.play("enter")
	else:
		print("WOI")
		icon.play("locked")

func _on_interact_area_body_exited(body):
	if body.name != "Player":
		return
	player_near = false
	$InteractIcon.hide()
	

func enter_warehouse():
	get_tree().change_scene_to_file("res://scenes/building/WarehouseInterior.tscn")

func _process(_delta):

	if !player_near:
		return
	if !DialogueManager.can_interact:
		return
	if !Input.is_action_just_pressed("Interact"):
		return
	if is_open:
		enter_warehouse()
		return
	if EventManager.has_event("warehouse_open"):
		DialogueManager.start("warehouse_unlock")
		open_door()
		return

	if GameManager.is_state(GameManager.StoryState.EXPLORE):
		DialogueManager.start("interact_gudang")
		GameManager.set_story_state(GameManager.StoryState.FOUND_WAREHOUSE)
		return
		
	DialogueManager.start("warehouse_locked")
	
