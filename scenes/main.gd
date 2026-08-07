extends Node2D

func _ready() -> void:
	if GameManager.spawn_point == "warehouse_exit":
		$Characters/Player.global_position = $WarehouseExitSpawn.global_position
		GameManager.spawn_point = ""
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('Interact') and DialogueManager.is_dialog_open:
			DialogueManager.next()
