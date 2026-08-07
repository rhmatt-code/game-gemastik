extends CharacterBody2D

@onready var npc = $AnimatedSprite2D

var player_near := false

func _ready() -> void:
	npc.play('default')
